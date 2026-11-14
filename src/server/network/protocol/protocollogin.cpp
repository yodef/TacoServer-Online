/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019–present OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "server/network/protocol/protocollogin.hpp"

#include "config/configmanager.hpp"
#include "server/network/message/outputmessage.hpp"
#include "server/network/protocol/protocol_port_utils.hpp"
#include "server/network/protocol/protocol_session_hint.hpp"
#include "server/network/protocol/transport_codec.hpp"
#include "game/scheduling/dispatcher.hpp"
#include "account/account.hpp"
#include "database/database.hpp"
#include "creatures/players/livestream/livestream.hpp"
#include "creatures/players/player.hpp"
#include "io/iologindata.hpp"
#include "creatures/players/management/ban.hpp"
#include "game/game.hpp"
#include "core.hpp"
#include "enums/account_errors.hpp"

#ifndef USE_PRECOMPILED_HEADERS
	#include <array>
#endif

void ProtocolLogin::disconnectClient(const std::string &message) const {
	const auto output = OutputMessagePool::getOutputMessage();

	output->addByte(0x0B);
	output->addString(message);
	send(output);

	disconnect();
}

void ProtocolLogin::getCharacterList(const std::string &accountDescriptor, const std::string &password) const {
	Account account(accountDescriptor);
	account.setProtocolCompat(oldProtocol);

	if (oldProtocol && !g_configManager().getBoolean(OLD_PROTOCOL)) {
		disconnectClient(ProtocolProfileRegistry::getUnsupportedClientProtocolMessage(false));
		return;
	} else if (!oldProtocol) {
		disconnectClient(ProtocolProfileRegistry::getUnsupportedClientProtocolMessage(g_configManager().getBoolean(OLD_PROTOCOL)));
		return;
	}

	if (account.load() != AccountErrors_t::Ok || !account.authenticate(password)) {
		std::ostringstream ss;
		ss << (oldProtocol ? "Username" : "Email") << " or password is not correct.";
		disconnectClient(ss.str());
		return;
	}

	auto output = OutputMessagePool::getOutputMessage();
	const std::string sessionKey = accountDescriptor + "\n" + password;
	const std::string &motd = g_configManager().getString(SERVER_MOTD);
	if (!motd.empty()) {
		// Add MOTD
		output->addByte(0x14);

		std::ostringstream ss;
		ss << g_game().getMotdNum() << "\n"
		   << motd;
		output->addString(ss.str());
	}

	// Add char list
	auto [players, result] = account.getAccountPlayers();
	if (AccountErrors_t::Ok != result) {
		g_logger().warn("Account[{}] failed to load players!", account.getID());
	}

	const auto* loginLayout = protocolProfile ? ProtocolProfileRegistry::resolveAccountLoginLayout(protocolProfile->id) : nullptr;
	const auto characterListLayout = loginLayout ? loginLayout->characterListLayout : AccountCharacterListLayout::WorldListWithSessionKey;
	if (loginLayout && loginLayout->sendsSessionKey) {
		// Add session key
		output->addByte(0x28);
		output->addString(sessionKey);
	}

	output->addByte(0x64);

	struct CharWorldEntry {
		std::string name;
		uint8_t worldId;
	};
	std::vector<CharWorldEntry> charEntries;
	if (auto res = g_database().storeQuery(fmt::format("SELECT `name`, `world_id` FROM `canary`.`players` WHERE `account_id` = {} AND `deletion` = 0 ORDER BY `name` ASC", account.getID()))) {
		do {
			charEntries.push_back({
				res->getString("name"),
				static_cast<uint8_t>(res->getNumber<uint32_t>("world_id") == 1 ? 1 : 0)
			});
		} while (res->next());
	} else {
		for (const auto &[name, deletion] : players) {
			charEntries.push_back({ name, 0 });
		}
	}

	const uint16_t currentGamePort = protocolProfile ? protocol_port_utils::getGamePortForProfile(*protocolProfile) : protocol_port_utils::getModernGamePort();
	const uint16_t portOffset = (currentGamePort >= 7176) ? (currentGamePort - 7176) : (currentGamePort - 7172);
	const uint16_t world0Port = 7172 + portOffset;
	const uint16_t world1Port = 7176 + portOffset;

	if (characterListLayout == AccountCharacterListLayout::LegacyCharacterList) {
		const auto configuredWorldIp = g_configManager().getString(IP);
		const auto worldIp = protocol_port_utils::legacyIpStringToNumber(configuredWorldIp);
		if (worldIp == 0) {
			g_logger().warn("Legacy character list cannot encode configured IP '{}'; old clients require a numeric IPv4 address.", configuredWorldIp);
			disconnectClient("Legacy 8.60 clients require the server IP to be a numeric IPv4 address.");
			return;
		}

		uint8_t size = std::min<size_t>(std::numeric_limits<uint8_t>::max(), charEntries.size());
		output->addByte(size);

		std::vector<std::string> characterNames;
		characterNames.reserve(size);
		for (size_t i = 0; i < size; ++i) {
			const auto &entry = charEntries[i];
			output->addString(entry.name);
			output->addString(entry.worldId == 1 ? "TacoServer Rebirth" : "TacoServer");
			output->add<uint32_t>(worldIp);
			output->add<uint16_t>(entry.worldId == 1 ? world1Port : world0Port);
			characterNames.emplace_back(entry.name);
		}

		output->add<uint16_t>(std::min<uint32_t>(std::numeric_limits<uint16_t>::max(), account.getPremiumRemainingDays()));

		send(output);

		if (protocolProfile) {
			ProtocolSessionHintStore::getInstance().registerHint(getIP(), protocolProfile->id, sessionKey, characterNames);
		}

		disconnect();
		return;
	}

	output->addByte(2); // number of worlds

	// World 0: TacoServer
	output->addByte(0); // world id 0
	output->addString("TacoServer");
	output->addString(g_configManager().getString(IP));
	output->add<uint16_t>(world0Port);
	output->addByte(0);

	// World 1: TacoServer Rebirth
	output->addByte(1); // world id 1
	output->addString("TacoServer Rebirth");
	output->addString(g_configManager().getString(IP));
	output->add<uint16_t>(world1Port);
	output->addByte(0);

	uint8_t size = std::min<size_t>(std::numeric_limits<uint8_t>::max(), charEntries.size());
	output->addByte(size);
	std::vector<std::string> characterNames;
	characterNames.reserve(size);
	for (size_t i = 0; i < size; ++i) {
		const auto &entry = charEntries[i];
		output->addByte(entry.worldId);
		output->addString(entry.name);
		characterNames.emplace_back(entry.name);
	}

	// Get premium days, check is premium and get lastday
	output->addByte(account.getPremiumRemainingDays());
	output->addByte(account.getPremiumLastDay() > getTimeNow());
	output->add<uint32_t>(account.getPremiumLastDay());

	send(output);

	if (protocolProfile) {
		ProtocolSessionHintStore::getInstance().registerHint(getIP(), protocolProfile->id, sessionKey, characterNames);
	}

	disconnect();
}

const AccountLoginLayout* ProtocolLogin::resolveLoginLayout(NetworkMessage &msg, uint16_t version) {
	const auto* loginLayout = ProtocolProfileRegistry::resolveAccountLoginLayout(version);
	if (!loginLayout) {
		disconnectClient(fmt::format("Unsupported client protocol version {}.", version));
		return nullptr;
	}

	protocolProfile = ProtocolProfileRegistry::getProfile(loginLayout->profileId);
	if (!protocolProfile || !ProtocolProfileRegistry::isProfileAllowed(protocolProfile->id)) {
		disconnectClient(fmt::format("Unsupported client protocol version {}.", version));
		return nullptr;
	}

	if (!loginLayout->hasAssetSignaturesBeforeRsa) {
		msg.skipBytes(loginLayout->bytesToSkipBeforeRsa);
		return loginLayout;
	}

	if (!msg.canRead(sizeof(uint32_t) * 3)) {
		disconnectClient(fmt::format("Invalid login packet for protocol version {}.", version));
		return nullptr;
	}

	const ClientAssetSignatures assetSignatures {
		.dat = msg.get<uint32_t>(),
		.spr = msg.get<uint32_t>(),
		.pic = msg.get<uint32_t>(),
	};

	protocolProfile = ProtocolProfileRegistry::resolveByClientVersionAndAssets(version, assetSignatures);
	if (!protocolProfile || !ProtocolProfileRegistry::isProfileAllowed(protocolProfile->id)) {
		disconnectClient(fmt::format("Unsupported client protocol version {}.", version));
		return nullptr;
	}

	loginLayout = ProtocolProfileRegistry::resolveAccountLoginLayout(protocolProfile->id);
	if (!loginLayout) {
		disconnectClient(fmt::format("Unsupported client protocol version {}.", version));
		return nullptr;
	}

	return loginLayout;
}

void ProtocolLogin::onRecvFirstMessage(NetworkMessage &msg) {
	if (g_game().getGameState() == GAME_STATE_SHUTDOWN) {
		disconnect();
		return;
	}

	msg.skipBytes(2); // client OS

	auto version = msg.get<uint16_t>();
	const auto* loginLayout = resolveLoginLayout(msg, version);
	if (!loginLayout) {
		return;
	}

	if (const auto connection = getConnection()) {
		connection->setTransportCodec(TransportCodecs::get(loginLayout->responseTransport), InitialTransportState::ResolvedFromPrelude);
	}

	// Old protocol support
	oldProtocol = protocolProfile->hasFeature(ProtocolFeature::OldProtocolCompat);
	/*
	 - Current/11.00 skips the remaining pre-RSA metadata:
	   4 bytes client version, 12 bytes dat/spr/pic signatures, 1 preview byte.
	 - 8.60 layouts read the dat/spr/pic signatures before RSA so the profile can
	   be resolved from the actual asset contract instead of the protocol number only.
	 */

	if (!Protocol::RSA_decrypt(msg)) {
		g_logger().warn("[ProtocolLogin::onRecvFirstMessage] - RSA Decrypt Failed");
		disconnect();
		return;
	}

	std::array<uint32_t, 4> key = { msg.get<uint32_t>(), msg.get<uint32_t>(), msg.get<uint32_t>(), msg.get<uint32_t>() };
	enableXTEAEncryption();
	setXTEAKey(key.data());

	setChecksumMethod(CHECKSUM_METHOD_ADLER32);

	if (g_game().getGameState() == GAME_STATE_STARTUP) {
		disconnectClient("Gameworld is starting up. Please wait.");
		return;
	}

	if (g_game().getGameState() == GAME_STATE_MAINTAIN) {
		disconnectClient("Gameworld is under maintenance.\nPlease re-connect in a while.");
		return;
	}

	BanInfo banInfo;
	auto curConnection = getConnection();
	if (!curConnection) {
		return;
	}

	if (IOBan::isIpBanned(curConnection->getIP(), banInfo)) {
		if (banInfo.reason.empty()) {
			banInfo.reason = "(none)";
		}

		std::ostringstream ss;
		ss << "Your IP has been banned until " << formatDateShort(banInfo.expiresAt) << " by " << banInfo.bannedBy << ".\n\nReason specified:\n"
		   << banInfo.reason;
		disconnectClient(ss.str());
		return;
	}

	std::string accountDescriptor = msg.getString();
	if (accountDescriptor.empty()) {
		std::ostringstream ss;
		ss << "Invalid " << (oldProtocol ? "username" : "email") << ".";
		disconnectClient(ss.str());
		return;
	}

	std::string password = msg.getString();
	if (accountDescriptor == "@livestream" || accountDescriptor == "@cast") {
		if (oldProtocol && !g_configManager().getBoolean(OLD_PROTOCOL)) {
			disconnectClient(ProtocolProfileRegistry::getUnsupportedClientProtocolMessage(false));
			return;
		} else if (!oldProtocol) {
			disconnectClient(ProtocolProfileRegistry::getUnsupportedClientProtocolMessage(g_configManager().getBoolean(OLD_PROTOCOL)));
			return;
		}

		g_dispatcher().addEvent(
			[self = std::static_pointer_cast<ProtocolLogin>(shared_from_this()), password] {
				self->getLivestreamCharacterList(password);
			},
			"ProtocolLogin::getLivestreamCharacterList"
		);
		return;
	}

	if (password.empty()) {
		disconnectClient("Invalid password.");
		return;
	}

	g_dispatcher().addEvent(
		[self = std::static_pointer_cast<ProtocolLogin>(shared_from_this()), accountDescriptor, password] {
			self->getCharacterList(accountDescriptor, password);
		},
		__FUNCTION__
	);
}

void ProtocolLogin::getLivestreamCharacterList(const std::string &password) const {
	const auto casters = g_livestream().getBroadcastingCasters(password);
	if (casters.empty()) {
		disconnectClient("There are no players with the livestream on.");
		return;
	}

	auto output = OutputMessagePool::getOutputMessage();
	output->addByte(0x14);
	output->addString("Welcome to Livestream System!");

	output->addByte(0x28);
	output->addString(fmt::format("@livestream\n{}", password));

	output->addByte(0x64);
	output->addByte(0x01); // worlds
	output->addByte(0x00);
	output->addString(g_configManager().getString(SERVER_NAME));
	output->addString(g_configManager().getString(IP));
	output->add<uint16_t>(g_configManager().getNumber(GAME_PORT));
	output->addByte(0x00);

	const auto casterCount = static_cast<uint8_t>(std::min<size_t>(std::numeric_limits<uint8_t>::max(), casters.size()));
	output->addByte(casterCount);
	for (size_t index = 0; index < casterCount; ++index) {
		const auto &caster = casters[index];
		output->addByte(0x00);
		output->addString(caster->getName());
	}

	output->addByte(0x00);
	output->addByte(0x00);
	output->add<uint32_t>(0x00);

	send(output);
	disconnect();
}

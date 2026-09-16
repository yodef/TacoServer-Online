-- Stance System Core Library (Tibia 15.25 Vocation Rebalancing)
StanceSystem = StanceSystem or {}

-- Sub IDs for attributes conditions
StanceSystem.SUBID_KNIGHT   = AttrSubId_BloodRageProtector or 9
StanceSystem.SUBID_PALADIN  = AttrSubId_Sharpshooter or 10
StanceSystem.SUBID_SORCERER = 1200
StanceSystem.SUBID_DRUID    = 1300

-- Storage for active stance
StanceSystem.STORAGE = 14050

local function createCondition(subId, params)
	local cond = Condition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, subId)
	cond:setParameter(CONDITION_PARAM_SUBID, subId)
	cond:setParameter(CONDITION_PARAM_TICKS, -1)
	cond:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
	for param, value in pairs(params) do
		cond:setParameter(param, value)
	end
	return cond
end

StanceSystem.Definitions = {
	["blood-rage"] = {
		name = "Blood Rage",
		vocation = "knight",
		subId = StanceSystem.SUBID_KNIGHT,
		params = {
			[CONDITION_PARAM_SKILL_MELEEPERCENT] = 130,
			[CONDITION_PARAM_BUFF_DAMAGERECEIVED] = 115,
			[CONDITION_PARAM_DISABLE_DEFENSE] = true,
		},
		desc = "+30% Melee Skill, +15% Damage Taken, Defense Disabled"
	},
	["protector"] = {
		name = "Protector",
		vocation = "knight",
		subId = StanceSystem.SUBID_KNIGHT,
		params = {
			[CONDITION_PARAM_SKILL_SHIELDPERCENT] = 130,
			[CONDITION_PARAM_BUFF_DAMAGEDEALT] = 85,
			[CONDITION_PARAM_BUFF_DAMAGERECEIVED] = 85,
		},
		desc = "+30% Shielding, -15% Damage Taken, -15% Damage Dealt"
	},
	["sniper"] = {
		name = "Sniper",
		vocation = "paladin",
		subId = StanceSystem.SUBID_PALADIN,
		params = {
			[CONDITION_PARAM_SKILL_DISTANCEPERCENT] = 135,
			[CONDITION_PARAM_BUFF_HEALINGRECEIVED] = 85,
		},
		desc = "+35% Distance Skill, -15% Self Healing"
	},
	["radiant-evasion"] = {
		name = "Radiant Evasion",
		vocation = "paladin",
		subId = StanceSystem.SUBID_PALADIN,
		params = {
			[CONDITION_PARAM_BUFF_DAMAGERECEIVED] = 95,
		},
		desc = "-5% Damage Taken"
	},
	["flames"] = {
		name = "Master of Flames",
		vocation = "sorcerer",
		subId = StanceSystem.SUBID_SORCERER,
		params = {
			[CONDITION_PARAM_INCREASE_FIREPERCENT] = 8,
		},
		desc = "+8% Fire Damage"
	},
	["thunder"] = {
		name = "Master of Thunder",
		vocation = "sorcerer",
		subId = StanceSystem.SUBID_SORCERER,
		params = {
			[CONDITION_PARAM_INCREASE_ENERGYPERCENT] = 8,
		},
		desc = "+8% Energy Damage"
	},
	["decay"] = {
		name = "Master of Decay",
		vocation = "sorcerer",
		subId = StanceSystem.SUBID_SORCERER,
		params = {
			[CONDITION_PARAM_INCREASE_DEATHPERCENT] = 8,
		},
		desc = "+8% Death Damage"
	},
	["synthesis"] = {
		name = "Elemental Synthesis",
		vocation = "druid",
		subId = StanceSystem.SUBID_DRUID,
		params = {
			[CONDITION_PARAM_INCREASE_ICEPERCENT] = 7,
			[CONDITION_PARAM_INCREASE_EARTHPERCENT] = 7,
		},
		desc = "+7% Ice & Earth Damage"
	},
	["conservation"] = {
		name = "Shared Conservation",
		vocation = "druid",
		subId = StanceSystem.SUBID_DRUID,
		params = {
			[CONDITION_PARAM_BUFF_HEALINGDEALT] = 110,
		},
		desc = "+10% Healing Output"
	}
}

-- Pre-build conditions table
StanceSystem.Conditions = {}
for key, def in pairs(StanceSystem.Definitions) do
	StanceSystem.Conditions[key] = createCondition(def.subId, def.params)
end

function StanceSystem.getActiveStance(player)
	if not player then return nil end
	local fromKv = player:kv():get("active-stance")
	if fromKv and StanceSystem.Definitions[fromKv] then
		return fromKv
	end
	return nil
end

function StanceSystem.removeCurrentStance(player)
	if not player then return end
	local current = StanceSystem.getActiveStance(player)
	if current then
		local curDef = StanceSystem.Definitions[current]
		if curDef then
			player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, curDef.subId)
		end
	end
	-- Also ensure all subIds are cleared
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, StanceSystem.SUBID_KNIGHT)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, StanceSystem.SUBID_PALADIN)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, StanceSystem.SUBID_SORCERER)
	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, StanceSystem.SUBID_DRUID)
	player:kv():remove("active-stance")
end

function StanceSystem.toggle(player, stanceKey, effect)
	if not player then return false end
	local def = StanceSystem.Definitions[stanceKey]
	if not def then return false end

	local current = StanceSystem.getActiveStance(player)
	if current == stanceKey then
		StanceSystem.removeCurrentStance(player)
		player:sendTextMessage(MESSAGE_LOOK, string.format("You deactivated %s Stance and returned to Neutral.", def.name))
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	-- Deactivate any other stance first
	StanceSystem.removeCurrentStance(player)

	-- Apply fresh condition
	local cond = createCondition(def.subId, def.params)
	player:addCondition(cond)
	player:kv():set("active-stance", stanceKey)

	player:sendTextMessage(MESSAGE_LOOK, string.format("%s Stance activated (%s).", def.name, def.desc))
	if effect then
		player:getPosition():sendMagicEffect(effect)
	end
	return true
end

function StanceSystem.onLogin(player)
	if not player then return end
	local current = StanceSystem.getActiveStance(player)
	if current then
		local def = StanceSystem.Definitions[current]
		if def then
			player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, def.subId)
			local cond = createCondition(def.subId, def.params)
			player:addCondition(cond)
			player:sendTextMessage(MESSAGE_LOOK, string.format("Active Stance: %s (%s).", def.name, def.desc))
		end
	end
end


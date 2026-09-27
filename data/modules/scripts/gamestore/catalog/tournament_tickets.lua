return {
	icons = { "Category_Tickets.png" },
	parent = "Tournament",
	name = "Tickets",
	rookgaard = true,
	offers = {
		{
			icons = { "Tournament_Restricted.png" },
			name = "Restricted Tournament Ticket",
			price = 500,
			type = GameStore.OfferTypes.OFFER_TYPE_NONE,
			disabled = true,
			disabledReason = "Tournament tickets are currently unavailable.",
		},
	},
}

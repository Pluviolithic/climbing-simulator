return {
	Name = "wipedata",
	Aliases = { "wd" },
	Description = "Wipe a player's data.",
	Group = "DefaultAdmin",
	Args = {
		{
			Type = "player",
			Name = "TargetPlayer",
			Description = "The player whose data will be wiped.",
		},
	},
}

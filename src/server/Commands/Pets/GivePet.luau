return {
	Name = "givepet",
	Aliases = { "gp" },
	Description = "Gives a pet to a player.",
	Group = "DefaultAdmin",
	Args = {
		{
			Type = "player",
			Name = "TargetPlayer",
			Description = "The player who will receive the pet.",
		},
		{
			Type = "string",
			Name = "Name",
			Description = "The name of the pet to be given.",
		},
	},
}

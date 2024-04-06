return {
	Stats = {
		Wins = 0,
		Rebirths = 0,
		Strength = game:GetService("ReplicatedStorage").Config.Workout.Strength.Value,

		Luck = 0,
		Gems = 0,
		Rank = 1,
		RebirthTokens = 0,
		MissionAreasCompleted = 0,

		LogInCount = 0,
		TimePlayed = 0,

		VIPChestAwardIndex = 1,
		GroupChestAwardIndex = 1,

		LastLogOn = -1,
		LastLogOff = -1,

		LastClaimedAGiftTimestamp = -1,
		GiftCycleBeganTimestamp = -1,

		MaxPetCount = 30,
		CurrentPetCount = 0,
		MaxPetEquipCount = 3,
		CurrentPetEquipCount = 0,
	},

	MultiplierData = {
		StrengthMultiplier = 0,
		GemsMultiplier = 0,

		ActiveFriendsWhoJoined = {},
	},

	PetData = {},

	DumbellData = {
		OwnedDumbells = {
			["-"] = true,
		},
		EquippedDumbell = "-",
	},

	PurchaseData = {
		AwardedGamepasses = {},
		PurchasedTeleporters = {},
		PurchasedBoosts = {},
		ActiveBoosts = {},
		RedeemedCodes = {},
		RebirthUpgrades = {
			EquipMorePets = 0,
			Evolver = 0,
			ExtraPetStorage = 0,
			FasterHatch = 0,
			Lucky = 0,
			MoreGems = 0,
			MoreStrength = 0,
			Sprint = 0,
			WorkoutSpeed = 0,
			KeepLegendaries = 0,
		},
	},

	MissionData = {},

	AudioData = {
		PrimarySoundRegion = nil,
		OccupiedSoundRegions = {},
		BackgroundTracks = {},
	},

	SavedSettings = {
		Tips = true,
		VipChatTag = false,
		VipNameTag = false,
	},

	TempSettings = {
		BackgroundMusic = true,
		["2xSpeed"] = true,
		ShowMyPets = true,
		SoundEffects = true,
		ShowOtherPets = true,
		AutoClicker = true,
	},

	ChestTimers = {
		VIPChest = -1,
		GroupChest = -1,
	},

	TutorialData = {
		CurrentStep = 1,
	},

	MilestonesData = {
		["100MStrength"] = false,
		["TopRebirths"] = false,
	},

	GiftData = {
		ClaimedGifts = {},
		SkippedAll = false,
	},
}

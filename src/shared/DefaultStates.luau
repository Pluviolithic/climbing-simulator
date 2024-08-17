local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Dictionary = require(ReplicatedStorage.Common.lib.Sift).Dictionary

local profileDataTemplate = {
	Timestamps = {
		LastLogOn = -1,
		LastLogOff = -1,

		LastClaimedAGift = -1,
		GiftCycleBegan = -1,
	},

	Stats = {
		Wins = 0,
		Rebirths = 0,
		Strength = 0,

		Luck = 0,
		Gems = 0,
		Rank = 1,
		RebirthTokens = 0,
		MissionAreasCompleted = 0,

		LogInCount = 0,
		TimePlayed = 0,

		VIPChestAwardIndex = 1,
		GroupChestAwardIndex = 1,

		MaxPetCount = 30,
		MaxPetEquipCount = 3,
	},

	MultiplierData = {
		StrengthMultiplier = 0,
		GemsMultiplier = 0,
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
			MoreDamage = 0,
			MoreFear = 0,
			MoreGems = 0,
			MoreStrength = 0,
			Sprint = 0,
			WorkoutSpeed = 0,
			KeepLegendaries = 0,
		},
	},

	Pets = {},

	DumbellData = {
		OwnedDumbells = {
			["-"] = true,
		},
		EquippedDumbell = "-",
	},

	MissionData = {},

	SavedSettings = {
		Tips = true,
		VipChatTag = false,
		VipNameTag = false,
	},

	ChestTimers = {
		VIPChest = -1,
		GroupChest = -1,
	},

	TutorialData = {
		CurrentStep = 1,
	},

	MilestonesData = {},

	GiftData = {
		ClaimedGifts = {},
		SkippedAll = false,
	},
}

local allDataTemplate = Dictionary.mergeDeep(profileDataTemplate, {})

return {
	ProfileDataTemplate = profileDataTemplate,
	AllDataTemplate = allDataTemplate,
}

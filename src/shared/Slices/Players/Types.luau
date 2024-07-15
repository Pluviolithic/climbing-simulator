export type PlayerData = {
	Stats: PlayerStats,
	Timestamps: PlayerTimestamps,
}

export type PlayerStats = {
	["Wins"]: number,
	["Rebirths"]: number,
	["Strength"]: number,

	["Luck"]: number,
	["Gems"]: number,
	["Rank"]: number,
	["RebirthTokens"]: number,
	["MissionAreasCompleted"]: number,

	["LogInCount"]: number,
	["TimePlayed"]: number,

	["VIPChestAwardIndex"]: number,
	["GroupChestAwardIndex"]: number,

	["MaxPetCount"]: number,
	["CurrentPetCount"]: number,
	["MaxPetEquipCount"]: number,
	["CurrentPetEquipCount"]: number,
}

export type PlayerTimestamps = {
	["LastClaimedAGift"]: number,
	["GiftCycleBegan"]: number,
	["LastLogOn"]: number,
	["LastLogOff"]: number,
}

return nil

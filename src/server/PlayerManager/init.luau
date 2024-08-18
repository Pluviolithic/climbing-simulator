local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local ProfileService = require(ServerScriptService.Server.lib.ProfileService)
local profileTemplate = require(ReplicatedStorage.Common.DefaultStates).ProfileDataTemplate
local profiles = require(ServerScriptService.Server.PlayerManager.Profiles)
-- local PlayerStatusUI = require(ServerScriptService.Server.PlayerManager.PlayerStatusUI)
local producer = require(ServerScriptService.Server.Producer)
local leaderboardsHandler = require(script.LeaderboardsHandler)

local profileStore = ProfileService.GetProfileStore("PlayerData", profileTemplate)

local function onPlayerAdded(player: Player)
	local profile = profileStore:LoadProfileAsync("Player_" .. player.UserId)
	if not profile then
		player:Kick "Data failed to load correctly."
		return
	end
	profile:AddUserId(player.UserId)
	profile:Reconcile()
	profile:ListenToRelease(function()
		profiles[player.Name] = nil
		player:Kick()
		return
	end)

	leaderboardsHandler.initializeRobloxLeaderboard(player, profile.Data)
	-- PlayerStatusUI.new(player):enable()

	if player:IsDescendantOf(Players) then
		profiles[player.Name] = profile
		producer.addPlayerData(player.Name, profile.Data)

		-- if os.time() - profile.Data.Stats.LastLogOff > 24 * 60 * 60 then
		-- 	--store:dispatch(actions.resetGifts(player.Name))
		-- end

		-- store:dispatch(actions.setPlayerStat(player.Name, "GiftCycleBeganTimestamp", os.time()))
		-- store:dispatch(actions.incrementPlayerStat(player.Name, "LogInCount"))
		-- store:dispatch(actions.setPlayerStat(player.Name, "LastLogOn", os.time()))
	end

	-- for _, existingPlayer in Players:GetPlayers() do
	-- 	if existingPlayer == player then
	-- 		continue
	-- 	end
	--
	-- 	task.spawn(function()
	-- 		if existingPlayer:IsFriendsWith(player.UserId) then
	-- 			store:dispatch(actions.addFriend(existingPlayer.Name, player.Name))
	-- 			store:dispatch(actions.addFriend(player.Name, existingPlayer.Name))
	-- 		end
	-- 	end)
	-- end
end

for _, player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

Players.PlayerRemoving:Connect(function(player)
	local profile = profiles[player.Name]
	-- store:dispatch(actions.setPlayerStat(player.Name, "LastLogOff", os.time()))
	-- store:dispatch(
	-- 	actions.incrementPlayerStat(
	-- 		player.Name,
	-- 		"TimePlayed",
	-- 		os.time() - selectors.getStat(store:getState(), player.Name, "LastLogOn")
	-- 	)
	-- )
	if profile ~= nil then
		profile:Release()
	end
	-- store:dispatch(actions.removePlayer(player.Name))

	-- for _, existingPlayer in Players:GetPlayers() do
	-- 	if existingPlayer == player then
	-- 		continue
	-- 	end
	--
	-- 	task.spawn(function()
	-- 		if existingPlayer:IsFriendsWith(player.UserId) then
	-- 			store:dispatch(actions.removeFriend(existingPlayer.Name, player.Name))
	-- 		end
	-- 	end)
	-- end
end)

--require(script.GlobalLeaderboards)
--require(script.SoftShutdown)
--require(script.Settings)
--require(script.Tutorial)
--require(script.Gifts)

require(script.Pets)
require(script.Badges)
require(script.DataSaver)
require(script.ReflexBroadcaster)

return 0

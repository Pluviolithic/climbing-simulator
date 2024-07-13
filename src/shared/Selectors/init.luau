local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Sift = require(ReplicatedStorage.Common.lib.Sift)
local stats = require(script.Stats)
local players = require(script.Players)

return Sift.Dictionary.merge(stats, players) :: typeof(stats) & typeof(players)

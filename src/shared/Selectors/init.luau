local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Sift = require(ReplicatedStorage.Common.lib.Sift)
local players = require(script.Players)

return Sift.Dictionary.merge(players) :: typeof(players)

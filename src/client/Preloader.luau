local ContentProvider = game:GetService "ContentProvider"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local animations = {}
for _, animation in ipairs(ReplicatedStorage.ClimbAnimations:GetChildren()) do
	table.insert(animations, animation)
end

for _, animation in ipairs(ReplicatedStorage.Animations:GetChildren()) do
	table.insert(animations, animation)
end

task.spawn(ContentProvider.PreloadAsync, ContentProvider, animations)

return 0

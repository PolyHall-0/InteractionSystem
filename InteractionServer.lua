--// | POLYHALL INTERACTION SYSTEM V1
--// | SERVER CODE FOR INTERACTION SYSTEM (DO NOT TOUCH THIS UNLESS YOU KNOW WHAT YOURE DOING!)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InteractionSettings = require(ReplicatedStorage:WaitForChild("InteractionSystem"):WaitForChild("InteractionSettings"))
local InteractionRemote = ReplicatedStorage:WaitForChild("InteractionSystem"):WaitForChild("InteractRemote")

--//
InteractionRemote.OnServerEvent:Connect(function(Player, ScriptParent)
	--//
	if InteractionSettings.InteractionSystemDisabled then return end
	if ScriptParent == nil then warn("Parent is nill.") end
	
	--//
	local Module = require(ScriptParent:FindFirstChildOfClass("ModuleScript"))
	if not Module then warn("Module not found") end
	
	--//
	Module:Subscribe()
end)

--// | POLYHALL INTERACTION SYSTEM V1
--// | CLIENT HANDLER FOR THE INTERACTION SYSTEM (DO NOT TOUCH THIS UNLESS YOU KNOW WHAT YOURE DOING!)

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

local InteractionSettings = require(ReplicatedStorage:WaitForChild("InteractionSystem"):WaitForChild("InteractionSettings"))
local InteractRemote = ReplicatedStorage:WaitForChild("InteractionSystem"):WaitForChild("InteractRemote")

local Interacting = false
local UIHandler = require(ReplicatedStorage:WaitForChild("InteractionSystem"):WaitForChild("InteractionSettings").UIHandler)

--//
local function Init()
	--//
	if InteractionSettings.UseCustomCrosshairs then
		UserInputService.MouseIconEnabled = false
	end
end

local function IsInteractable()
	--//
	if Mouse.Target and Mouse.Target ~= nil then

		--//
		local Target = Mouse.Target
		local Distance = (HumanoidRootPart.Position - Target.Position).Magnitude

		--//
		if CollectionService:HasTag(Target, "Interactable") and Distance <= 8 then
			return true
		else
			return false
		end

	end
end

local function GetInteractionMessage()
	--//
	if Mouse.Target and Mouse.Target ~= nil then

		--//
		local Target = Mouse.Target
		local Distance = (HumanoidRootPart.Position - Target.Position).Magnitude

		--//
		if CollectionService:HasTag(Target, "Interactable") and Distance <= 8 then

			--//
			local InteractableFunction = require(Target:FindFirstChildOfClass("ModuleScript"))

			--//
			return InteractableFunction.InteractMessage

		end

	end
end

local function Interact()
	--//
	if Mouse.Target and Mouse.Target ~= nil then

		--//
		local Target = Mouse.Target
		local Distance = (HumanoidRootPart.Position - Target.Position).Magnitude

		--//
		if CollectionService:HasTag(Target, "Interactable") and Distance <= 8 then

			--//
			local InteractableFunction = require(Target:FindFirstChildOfClass("ModuleScript"))
			local LiteralModuleScript = Target:FindFirstChildOfClass("ModuleScript")

			--//
			if InteractableFunction.ServerSided == false then
				InteractableFunction:Subscribe()
			else
				InteractRemote:FireServer(LiteralModuleScript.Parent)
			end

			--//
			UIHandler:OnInteracted()
		end

	end
end

RunService.RenderStepped:Connect(function()
	
	if IsInteractable() and InteractionSettings.UseInteractGui then

		if InteractionSettings.UseCustomCrosshairs then
			UIHandler:UpdateCrosshairType("Interact")
		end
		
		UIHandler:SetInteractMessageVisibility(true)
		UIHandler:UpdateInteractMessage(GetInteractionMessage())

	else

		UIHandler:UpdateCrosshairType("Crosshair")
		UIHandler:SetInteractMessageVisibility(false)

	end
	
end)

UserInputService.InputBegan:Connect(function(Key, Chat)
	if Chat then return end
	
	if Key.KeyCode == InteractionSettings.InteractKey then
		Interact()
	end
	
end)

Player.CharacterAdded:Connect(function(_Character)
	Character = _Character
	Humanoid = _Character:WaitForChild("Humanoid")
	HumanoidRootPart = _Character:WaitForChild("HumanoidRootPart")
end)

Init()

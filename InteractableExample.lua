--// You can use basically any variable you want to, the system is highly expandable
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Interactable = {}

--// Interactable's setup
Interactable.ServerSided = true; --// Determines if Interactable:Subscribe() is ran on server or client.
Interactable.InteractMessage = "Open door" --// The message that pops up when hovering over the object (if you have this enabeled [In Settings])


function Interactable:Subscribe() -- This is the function that is ran when interacted, you can make this function do ANYTHING you want it to do!
	--[[
	
	EXAMPLES -->
	script.Parent.BrickColor = BrickColor.Random()
	ReplicatedStorage.Audio:Play()
	
	]]--
end


return Interactable

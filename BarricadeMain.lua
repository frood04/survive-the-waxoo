local barricade = script.Parent
local health = barricade.Health
local planks = barricade:FindFirstChild("Planks")

local debounce = true
local function onTouch(otherPart)
	if debounce then
		debounce = false
		if otherPart.Parent.Name == "Waxoo" then
			health.Value = health.Value - 50
			print("took damage!")
			wait(3) -- Defines 3 seconds per bounce
		else
			print("Other part is not named Waxoo")
		end
		debounce = true
	end
end

local plankConnections = {} -- Stores the connections between planks and the onTouch function

local function resetPlanks()
	for _, plank in pairs(planks:GetChildren()) do
		plank.Transparency = 1 -- Makes planks invisible
		plank.CanCollide = false -- Makes planks noncollidable
		local connection = plankConnections[plank]
		if connection then
			connection:Disconnect() -- Disconnect the stored connection
			plankConnections[plank] = nil -- Remove the connection from the table
		end
	end
	barricade.Prompt.ProximityPrompt.Enabled = true -- Reallows enabling of the barricade after x seconds
	print("barricade successfully broken!")
end

barricade.Prompt.ProximityPrompt.Triggered:Connect(function()
	barricade.Prompt.ProximityPrompt.Enabled = false -- Disables the prompt until the planks are broken

	print("ProximityPrompt triggered")
	barricade.Construct:Play()
	for _, plank in pairs(planks:GetChildren()) do
		if plank.Name == "Plank1" then
			plank.Transparency = 0 -- Sets planks visible
			plank.CanCollide = true -- Sets planks collidable
			print("Plank1 barricaded!")
		end
		local connection = plank.Touched:Connect(onTouch)
		plankConnections[plank] = connection -- Store the connection in the table
	end

	health.Changed:Connect(function()
		print("Health changed")
		if health.Value <= 0 then
			barricade.Crash:Play()
			print("barricade break sound played!")
			resetPlanks()
			health.Value = 150 -- Reset health value back to x
		elseif health.Value > 0 and health.Value ~= 150 then
			barricade.Crack:Play()
			print("barricade crack sound played!")
		end
	end)
end)

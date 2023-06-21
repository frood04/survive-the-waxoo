local Spawner = script.Parent
local Zombies = game.ReplicatedStorage.Assets.Waxoo
local CanSpawn = script.Parent.SpawnEnabled.Value
local MaxZombies = script.Parent.MaxZombie.Value
local WaitTime = script.Parent.WaitTime.Value

local ZombieCount = 0

local function spawnZombie()
	local Waxoo = Zombies:Clone()
	Waxoo.Parent = script.Parent
	local CFrame = CFrame.new(Spawner.Position)
	Waxoo.HumanoidRootPart.CFrame = CFrame

	ZombieCount += 1

	if ZombieCount >= MaxZombies then
		CanSpawn = false
	end
end

while CanSpawn == true do
	wait(WaitTime)
	spawnZombie()
end

if ZombieCount <= 0 then
	CanSpawn = true
end

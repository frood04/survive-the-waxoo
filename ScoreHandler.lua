local storage = game.ReplicatedStorage.Data

game.Players.PlayerAdded:Connect(function(plr)
	print("player detected! assigning value...")
	
	local folder = Instance.new("Folder")
	folder.Name = plr.Name
	folder.Parent = storage
	
	local score = Instance.new("IntValue")
	score.Name = "Score"
	score.Parent = storage:FindFirstChild(plr.Name)
	score.Value = 0
	print("value assigned!")

end)

game.Players.PlayerRemoving:Connect(function(plr)
	storage:FindFirstChild(plr.Name):Destroy()
end)

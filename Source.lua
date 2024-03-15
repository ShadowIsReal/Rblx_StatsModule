local module = {}

--// [[ PREREQUISITES ]] \\--

local StatTypes = { -- table to hold different types of stats
	["number"] = function()
		return Instance.new("IntValue")
	end,
	["string"] = function()
		return Instance.new("StringValue")
	end
}

--// [[ INTERNAL FUNCTIONS ]] \\--

local function ProcessStat(StatsFolder : Folder, StatName : string, StatValue) -- function to retrieve stat type and create object with provided name and value
	if not StatName or not StatValue then
		warn("Invalid stat provided: ", StatName, StatValue)
	end
	
	local Stat = StatTypes[typeof(StatValue)]()
	Stat.Name = StatName
	Stat.Value = StatValue
	
	Stat.Parent = StatsFolder
end

--// [[ MODULE FUNCTIONS ]] \\--

function module:CreateStats(Player : Player, Stats : {}) -- function to create leaderstats and add the provided stats to it
	if Player:FindFirstChild("leaderstats") then
		warn("Leaderstats already exists!")
		return
	end
	
	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	
	for StatName,StatValue in Stats do
		ProcessStat(Leaderstats, StatName, StatValue)
	end
	
	Leaderstats.Parent = Player
end

function module:CreateHiddenStats(Player : Player, Stats : {}) -- function to create hiddenstats and add the provided stats to it
	if Player:FindFirstChild("hiddenstats") then
		warn("Hiddenstats alreadyed exists!")
	end
	
	local Hiddenstats = Instance.new("Folder")
	Hiddenstats.Name = "hiddenstats"
	
	for i=1, #Stats do
		ProcessStat(Hiddenstats, Stats[i])
	end
	
	Hiddenstats.Parent = Player
end

function module:AddStat(Player : Player, StatName : string, StatValue) -- function to create a new stat and add it to leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")
	
	if Leaderstats then
		ProcessStat(Leaderstats, StatName, StatValue)
		return
	end
	
	warn("Leaderstats not found!")
end

function module:AddHiddenStat(Player : Player, StatName : string, StatValue) -- function to create a new stat and add it to hiddenstats
	local Hiddenstats = Player:FindFirstChild("hiddenstats")
	
	if Hiddenstats then
		ProcessStat(Hiddenstats, StatName, StatValue)
		return
	end
	
	warn("Hiddenstats was not found!")
end

function module:RemoveStat(Player : Player, StatName : string) -- function to remove a stat from leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")
	local Hiddenstats = Player:FindFirstChild("hiddenstats")
	
	if Leaderstats or Hiddenstats then
		local Stat = (Leaderstats:FindFirstChild(StatName) or Hiddenstats:FindFirstChild(StatName))
		
		if Stat then
			Stat:Destroy()
			return
		end
		
		warn(string.format("Unable to find stat named \"%s\" in leaderstats or hiddenstats!", StatName))
		return
	end
	
	warn("Leaderstats and hiddenstats were not found!")
end
	
function module:GetStatValue(Player : Player, StatName : string) -- function to retrieve a stat value from a stat in leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")
	local Hiddenstats = Player:FindFirstChild("hiddenstats")
	
	if Leaderstats or Hiddenstats then
		local Stat = (Leaderstats:FindFirstChild(StatName) or Hiddenstats:FindFirstChild(StatName))
		
		if Stat then
			return Stat.Value
		end
		
		warn("Unable to find stat named %s in leaderstats or hiddenstats!", StatName)
		return
	end
	
	warn("Leaderstats and hiddenstats were not found!")
end

function module:SetStatValue(Player : Player, StatName : string, NewValue : any) -- function to set the value of a stat in leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")
	local Hiddenstats = Player:FindFirstChild("hiddenstats")

	if Leaderstats or Hiddenstats then
		local Stat = (Leaderstats:FindFirstChild(StatName) or Hiddenstats:FindFirstChild(StatName))

		if Stat then
			Stat.Value = NewValue
			return
		end

		warn("Unable to find stat named %s in leaderstats or hiddenstats!", StatName)
		return
	end

	warn("Leaderstats and hiddenstats were not found!")
end

function module:GetAllStats(Player : Player) -- function to retrieve all stats from leaderstats and convert them to a table
	local Leaderstats = Player:FindFirstChild("leaderstats")
	local Hiddenstats = Player:FindFirstChild("hiddenstats")
	local Stats = {}
	
	if Leaderstats then
		for _,Stat in Leaderstats:GetChildren() do
			Stats[Stat.Name] = Stat.Value
		end
	end
	
	if Hiddenstats then
		for _,Stat in Hiddenstats:GetChildren() do
			Stats[Stat.Name] = Stat.Value
		end
	end
	
	return Stats
end

return module

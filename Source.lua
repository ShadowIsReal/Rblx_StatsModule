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

local function ProcessStat(StatsFolder : Folder, StatTable : {}) -- function to retrieve stat type and create object with provided name and value
	if #StatTable ~= 2 or typeof(StatTable[1]) ~= "string" then
		warn("Invalid StatTable provided: ", StatTable)
	end
	
	local Stat = StatTypes[typeof(StatTable[1])]()
	Stat.Name = StatTable[1]
	Stat.Value = StatTable[2]
	
	Stat.Parent = StatsFolder
end

local function ConvertToStatTable(Object) -- function to convert stat object to table
	local StatTable = {}
	table.insert(StatTable, Object.Name)
	table.insert(StatTable, Object.Value)
	
	return StatTable
end

--// [[ MODULE FUNCTIONS ]] \\--

function module:CreateStats(Player : Player, Stats : {}) -- function to create leaderstats and add the provided stats to it
	if Player:FindFirstChild("leaderstats") then
		warn("Leaderstats already exists!")
		return
	end
	
	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	
	for i=1, #Stats do
		ProcessStat(Leaderstats, Stats[i])
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

function module:AddStat(Player : Player, StatTable : {}) -- function to create a new stat and add it to leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")
	
	if Leaderstats then
		ProcessStat(Leaderstats, StatTable)
		return
	end
	
	warn("Leaderstats not found!")
end

function module:AddHiddenStat(Player : Player, StatTable : {}) -- function to create a new stat and add it to hiddenstats
	local Hiddenstats = Player:FindFirstChild("hiddenstats")
	
	if Hiddenstats then
		ProcessStat(Hiddenstats, StatTable)
		return
	end
	
	warn("Hiddenstats was not found!")
end

function module:RemoveStat(Player : Player, StatName : string) -- function to remove a stat from leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")
	
	if Leaderstats then
		local Stat = Leaderstats:FindFirstChild(StatName)
		
		if Stat then
			Stat:Destroy()
			return
		end
		
		warn(string.format("Unable to find stat named \"%s\" in leaderstats!", StatName))
		return
	end
	
	warn("Leaderstats was not found!")
end
	
function module:RemoveHiddenStat(Player : Player, StatName : string) -- function to remove a stat from hiddenstats
	local Hiddenstats = Player:FindFirstChild("hiddenstats")
	
	if Hiddenstats then
		local Stat = Hiddenstats:FindFirstChild(StatName)
		
		if Stat then
			Stat:Destroy()
			return
		end
		
		warn(string.format("Unable to find stat named \"%s\" in hiddenstats!", StatName))
	end
end
	
function module:GetStat(Player : Player, StatName : string) -- function to retrieve a stat value from a stat in leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")
	
	if Leaderstats then
		local Stat = Leaderstats:FindFirstChild(StatName)
		
		if Stat then
			return Stat.Value
		end
		
		warn("Unable to find stat named %s in leaderstats!", StatName)
		return
	end
	
	warn("Leaderstats was not found!")
end
		
function module:GetHiddenStat(Player : Player, StatName : string) -- function to retrieve a stat value from a stat in hiddenstats
	local Hiddenstats = Player:FindFirstChild("hiddenstats")

	if Hiddenstats then
		local Stat = Hiddenstats:FindFirstChild(StatName)

		if Stat then
			return Stat.Value
		end

		warn(string.format("Unable to find stat named %s in hiddenstats!", StatName))
	end
end

function module:SetStat(Player : Player, StatName : string, NewValue : any) -- function to set the value of a stat in leaderstats
	local Leaderstats = Player:FindFirstChild("leaderstats")

	if Leaderstats then
		local Stat = Leaderstats:FindFirstChild(StatName)

		if Stat then
			Stat.Value = NewValue
			return
		end

		warn("Unable to find stat named %s in leaderstats!", StatName)
		return
	end

	warn("Leaderstats was not found!")
end

function module:SetHiddenStat(Player : Player, StatName : string, NewValue : any) -- function to set the value of a stat in hiddenstats
	local Hiddenstats = Player:FindFirstChild("hiddenstats")

	if Hiddenstats then
		local Stat = Hiddenstats:FindFirstChild(StatName)

		if Stat then
			Stat.Value = NewValue
			return
		end

		warn(string.format("Unable to find stat named %s in hiddenstats!", StatName))
	end
end

function module:GetAllStats(Player : Player) -- function to retrieve all stats from leaderstats and convert them to a table
	local Leaderstats = Player:FindFirstChild("leaderstats")
	local Stats = {}
	
	if Leaderstats then
		for _,Stat in Leaderstats:GetChildren() do
			table.insert(Stats, ConvertToStatTable(Stat))
		end
		
		return Stats
	end
	
	warn("Leaderstats was not found!")
end

function module:GetAllHidenStats(Player : Player) -- function to retrieve all stats from hiddenstats and convert them to a table
	local Hiddenstats = Player:FindFirstChild("hiddenstats")
	local Stats = {}

	if Hiddenstats then
		for _,Stat in Hiddenstats:GetChildren() do
			table.insert(Stats, ConvertToStatTable(Stat))
		end

		return Stats
	end

	warn("Hiddenstats was not found!")
end

return module

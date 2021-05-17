-- MOD CONFIG MENU Compatibility
local ModConfigLoaded, ModConfig = pcall(require, "scripts.modconfig")
FHPP.ModConfigLoaded = ModConfigLoaded

if ModConfigLoaded then
	function AnIndexOf(t, val)
		for k, v in ipairs(t) do
			if v == val then
				return k
			end
		end
		return 1
	end

	---------------------------------------------------------------------------
	-----------------------------------Info------------------------------------
	ModConfig.AddSpace("Found Hud++", "Info")
	ModConfig.AddText("Found Hud++", "Info", function() return "Found Hud++" end)
	ModConfig.AddSpace("Found Hud++", "Info")
	ModConfig.AddText("Found Hud++", "Info", function() return "Version "..FHPP.Config.Version end)
	ModConfig.AddSpace("Found Hud++", "Info")
	ModConfig.AddText("Found Hud++", "Info", function() return "by Gyoo" end)

	---------------------------------------------------------------------------
	---------------------------------General-----------------------------------
  
	-- Show Challenge Name
	ModConfig.AddSetting(
		"Found Hud++",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return FHPP.Config["ShowChallengeName"]
			end,
			Display = function()
				local onOff = "False"
				if FHPP.Config["ShowChallengeName"] then
					onOff = "True"
				end
				return 'Display Challenge Name: ' .. onOff
			end,
			OnChange = function(currentBool)
				FHPP.Config["ShowChallengeName"] = currentBool
			end
		}
	)
  
	-- Show Character Name
	ModConfig.AddSetting(
		"Found Hud++",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return FHPP.Config["ShowCharacterName"]
			end,
			Display = function()
				local onOff = "False"
				if FHPP.Config["ShowCharacterName"] then
					onOff = "True"
				end
				return 'Display Character Name: ' .. onOff
			end,
			OnChange = function(currentBool)
				FHPP.Config["ShowCharacterName"] = currentBool
			end
		}
	)
  
	-- Show Level Name
	ModConfig.AddSetting(
		"Found Hud++",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return FHPP.Config["ShowLevelName"]
			end,
			Display = function()
				local onOff = "False"
				if FHPP.Config["ShowLevelName"] then
					onOff = "True"
				end
				return 'Display Level Name: ' .. onOff
			end,
			OnChange = function(currentBool)
				FHPP.Config["ShowLevelName"] = currentBool
			end
		}
	)
  
	-- Show Time
	ModConfig.AddSetting(
		"Found Hud++",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return FHPP.Config["ShowTime"]
			end,
			Display = function()
				local onOff = "False"
				if FHPP.Config["ShowTime"] then
					onOff = "True"
				end
				return 'Display Time: ' .. onOff
			end,
			OnChange = function(currentBool)
				FHPP.Config["ShowTime"] = currentBool
			end
		}
	)
  
	-- Show Challenge Name
	ModConfig.AddSetting(
		"Found Hud++",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return FHPP.Config["ShowSeed"]
			end,
			Display = function()
				local onOff = "False"
				if FHPP.Config["ShowSeed"] then
					onOff = "True"
				end
				return 'Display Seed: ' .. onOff
			end,
			OnChange = function(currentBool)
				FHPP.Config["ShowSeed"] = currentBool
			end
		}
	)

	--Show Info Title
	local indicators = {"None", "Short", "Full"}
	ModConfig.AddSetting(
		"Found Hud++",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(indicators, FHPP.Config["ShowTitles"])
			end,
			Minimum = 1,
			Maximum = 3,
			Display = function()
				return "Display information titles: " .. FHPP.Config["ShowTitles"]
			end,
			OnChange = function(currentNum)
				FHPP.Config["ShowTitles"] = indicators[currentNum]
			end
		}
	)
  
  ---------------------------------------------------------------------------
	---------------------------------Visuals-----------------------------------
  
	-- Type of display
	local display = {"Vertical", "Horizontal"}
	ModConfig.AddSetting(
		"Found Hud++",
		"Visuals",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(display, FHPP.Config["Display"])
			end,
			Minimum = 1,
			Maximum = #display,
			Display = function()
				return "Horizontal/Vertical display: " .. FHPP.Config["Display"]
			end,
			OnChange = function(currentNum)
				FHPP.Config["Display"] = display[currentNum]
			end
		}
	)
  
  -- SCALE
	local textScales = {0.5, 0.75, 1, 1.25, 1.5, 2}
	ModConfig.AddSetting(
		"Found Hud++",
		"Visuals",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(textScales, FHPP.Config["Scale"])
			end,
			Minimum = 1,
			Maximum = 6,
			Display = function()
				return "Text Size: " .. FHPP.Config["Scale"]
			end,
			OnChange = function(currentNum)
				FHPP.Config["Scale"] = textScales[currentNum]
			end
		}
	)

	-- Transparency
	local transparencies = {0.1, 0.175, 0.25, 0.3, 0.4, 0.5, 0.6, 0.75, 0.8, 0.9, 1}
	ModConfig.AddSetting(
		"Found Hud++",
		"Visuals",
		{
			Type = ModConfigMenu.OptionType.SCROLL,
			CurrentSetting = function()
				return AnIndexOf(transparencies, FHPP.Config["Transparency"]) - 1
			end,
			Display = function()
				return "Transparency: $scroll" ..
					AnIndexOf(transparencies, FHPP.Config["Transparency"]) - 1 .. " " .. FHPP.Config["Transparency"]
			end,
			OnChange = function(currentNum)
				FHPP.Config["Transparency"] = transparencies[currentNum + 1]
			end
		}
	)

	--Line Height
	ModConfig.AddSetting(
		"Found Hud++",
		"Visuals",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return FHPP.Config["LineHeight"]
			end,
			Minimum = 5,
			Maximum = 20,
			Display = function()
				return "Line Height: " .. FHPP.Config["LineHeight"]
			end,
			OnChange = function(currentNum)
				FHPP.Config["LineHeight"] = currentNum
			end
		}
	)

	--X Position
	ModConfig.AddSetting(
		"Found Hud++",
		"Visuals",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return FHPP.Config["XPosition"]
			end,
			Minimum = 1,
			Maximum = 500,
			Display = function()
				return "X Position: " .. FHPP.Config["XPosition"]
			end,
			OnChange = function(currentNum)
				FHPP.Config["XPosition"] = currentNum
			end
		}
	)

	--Y Position
	ModConfig.AddSetting(
		"Found Hud++",
		"Visuals",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return FHPP.Config["YPosition"]
			end,
			Minimum = 1,
			Maximum = 350,
			Display = function()
				return "Y Position: " .. FHPP.Config["YPosition"]
			end,
			OnChange = function(currentNum)
				FHPP.Config["YPosition"] = currentNum
			end
		}
	)
  
end
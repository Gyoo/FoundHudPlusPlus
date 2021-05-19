local mod = RegisterMod( "Found HUD++", 1);

FHPP = FHPP or {}

require("fhpp_data")
require("fhpp_config")
FHPP.Config = FHPP.DefaultConfig
FHPP.Config.Version = "1.0.1"

require("fhpp_mod_config_menu")

--TODO might wanna refactor some duplicated bits
function FHPP:PrintExtraStatVertical(Texts)
  local file = io.open("fhpp.txt", "w")
  for index, value in ipairs(Texts) do
    local finalText = ""
    if(value[1] ~= nil) then
      if(FHPP.Config["ShowTitles"] == "Full") then finalText = FHPP.Titles[value[1]][1]..": "
      elseif(FHPP.Config["ShowTitles"] == "Short") then finalText = FHPP.Titles[value[1]][2]..": "
      end
    end
    finalText = finalText .. value[2]
    if(FHPP.Config["Output"] == "File") then
      file:write(finalText, "\n")
    elseif(FHPP.Config["Output"] == "HUD") then 
      Isaac.RenderScaledText(finalText, FHPP.Config["XPosition"], FHPP.Config["YPosition"] + FHPP.Config["LineHeight"] * (index-1), FHPP.Config["Scale"], FHPP.Config["Scale"], 1, 1, 1, FHPP.Config["Transparency"])
    end
  end
  file:close()
end

function FHPP:PrintExtraStatHorizontal(Texts)
  local finalText = ""
  for index, value in ipairs(Texts) do
    local stat = ""
    if(value[1] ~= nil) then
      if(FHPP.Config["ShowTitles"] == "Full") then stat = FHPP.Titles[value[1]][1]..": "
      elseif(FHPP.Config["ShowTitles"] == "Short") then stat = FHPP.Titles[value[1]][2]..": "
      end
    end
    stat = stat .. value[2] .. " | "
    finalText = finalText .. stat
  end
  finalText = finalText:sub(1, #finalText - 3)
  if(FHPP.Config["Output"] == "File") then
    local file = io.open("fhpp.txt", "w")
    file:write(finalText)
    file:close()
  elseif(FHPP.Config["Output"] == "HUD") then 
    Isaac.RenderScaledText(finalText, FHPP.Config["XPosition"], FHPP.Config["YPosition"], FHPP.Config["Scale"], FHPP.Config["Scale"], 1, 1, 1, FHPP.Config["Transparency"])
  end
end

function FHPP:PrintTime()
  local curTime = Game():GetFrameCount()
  local msecs= curTime%30 * (10/3) -- turns the millisecond value range from [0 to 30] to [0 to 100]
  local secs= math.floor(curTime/30)%60
  local mins= math.floor(curTime/30/60)%60
  local hours= math.floor(curTime/30/60/60)%60
  return string.format("%02d", hours) .. ":" .. string.format("%02d", mins) .. ":" .. string.format("%02d", secs)
end

local function onRender(t)
    local strings = {}
    
    if(FHPP.Config["ShowChallengeName"]) then
      local challengeId = Isaac.GetChallenge()
      if(challengeId ~= 0) then table.insert(strings, {"CHALLENGE", FHPP.Challenges[challengeId]})
      end
    end
    
    if(FHPP.Config["ShowCharacterName"]) then 
      local tainted = ""
      if(Isaac.GetPlayer(0).SubType >= 21) then tainted = "Tainted " end
      table.insert(strings, {"CHARACTER", tainted .. Isaac.GetPlayer(0):GetName()}) 
    end
    
    if(FHPP.Config["ShowFloorName"]) then table.insert(strings, {"FLOOR", Game():GetLevel():GetName(Game():GetLevel():GetStage(), Game():GetLevel():GetStageType(), Game():GetLevel():GetCurses(), 0, false)}) end
    
    if(FHPP.Config["ShowTime"]) then table.insert(strings, {"TIME", FHPP:PrintTime()}) end
    
    if(FHPP.Config["ShowShield"]) then 
      local shield = ""
      if(Isaac.GetPlayer(0):GetEffects():HasCollectibleEffect(313)) then shield = "Active"
      else shield = "Inactive"
      end
      table.insert(strings, {"SHIELD", shield}) 
    end
    
    if(FHPP.Config["ShowSeed"]) then table.insert(strings, {"SEED", Game():GetSeeds():GetStartSeedString()}) end
    
    if(FHPP.Config["Display"] == "Vertical") then
      FHPP:PrintExtraStatVertical(strings)
    else
      FHPP:PrintExtraStatHorizontal(strings)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, onRender)

-- only save and load configs when using ModConfig. Otherwise Config file changes arent calid
if FHPP.ModConfigLoaded then
	local json = require("json")
	--------------------------------
	--------Handle Savedata---------
	--------------------------------
	function OnGameStart(isSave)
		--Loading Moddata--
		if mod:HasData() then
			local savedFHPPConfig = json.decode(Isaac.LoadModData(mod))
			-- Only copy Saved config entries that exist in the save
			if savedFHPPConfig.Version == FHPP.Config.Version then
				for key, value in pairs(FHPP.Config) do
					if savedFHPPConfig[key] ~= nil then
						FHPP.Config[key] = savedFHPPConfig[key]
					end
				end
			end
		end
	end
	mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, OnGameStart)

	--Saving Moddata--
	function SaveGame()
		mod.SaveData(mod, json.encode(FHPP.Config))
	end
	mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, SaveGame)
end
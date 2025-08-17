-- SafeGuard: Initialize SavedVariables with default values if not present
if _HunterGunSounds == nil then
    _HunterGunSounds = { enabled = "on", volume = "normal", echoEnabled = false, petSoundEnabled = true, petSoundType = "cat" }
end

-- Centralized SavedVariables initialization function
local function InitializeSavedVariables()
    if _HunterGunSounds == nil then
        _HunterGunSounds = { enabled = "on", volume = "normal", echoEnabled = false, petSoundEnabled = true, petSoundType = "cat" }
    elseif type(_HunterGunSounds) == "string" then
        -- Migration logic for older versions
        local oldEnabled = _HunterGunSounds
        _HunterGunSounds = { enabled = oldEnabled, volume = "normal", echoEnabled = false, petSoundEnabled = true, petSoundType = "cat" }
    end
    
    -- Ensure all required fields exist
    if _HunterGunSounds.enabled == nil then
        _HunterGunSounds.enabled = "on"
    end
    if _HunterGunSounds.volume == nil then
        _HunterGunSounds.volume = "normal"
    end
    if _HunterGunSounds.echoEnabled == nil then
        _HunterGunSounds.echoEnabled = false
    end
    if _HunterGunSounds.petSoundEnabled == nil then
        _HunterGunSounds.petSoundEnabled = true
    end
    if _HunterGunSounds.petSoundType == nil then
        _HunterGunSounds.petSoundType = "cat"
    end
end

local MutedSounds = {
--DON'T TOUCH THE FOLLOWING 17 LINES if u don't understand what are u doing!!!
922086, --	sound/spells/spell_hu_bowrelease_01.ogg
922088, --	sound/spells/spell_hu_bowrelease_02.ogg
922090, --	sound/spells/spell_hu_bowrelease_03.ogg
922092, --	sound/spells/spell_hu_bowrelease_04.ogg
922094, --	sound/spells/spell_hu_bowrelease_05.ogg
925549, --	sound/spells/spell_hu_crossbowshoot_01.ogg
925551, --	sound/spells/spell_hu_crossbowshoot_02.ogg
925553, --	sound/spells/spell_hu_crossbowshoot_03.ogg
925555, --	sound/spells/spell_hu_crossbowshoot_04.ogg
925557, --	sound/spells/spell_hu_crossbowshoot_05.ogg
925559, --	sound/spells/spell_hu_crossbowshoot_06.ogg
921248, --	sound/spells/spell_hu_blunderbuss_weaponfire_01.ogg
921250, --	sound/spells/spell_hu_blunderbuss_weaponfire_02.ogg
921252, --	sound/spells/spell_hu_blunderbuss_weaponfire_03.ogg
921254, --	sound/spells/spell_hu_blunderbuss_weaponfire_04.ogg
921256, --	sound/spells/spell_hu_blunderbuss_weaponfire_05.ogg
921258, --	sound/spells/spell_hu_blunderbuss_weaponfire_06.ogg
--U can delete the following lines, if u don't want the addon to mute the sounds. Add another ones u want to mute. Use this database https://wow.tools/files/
1591768, --	sound/spells/spell_hu_arcaneshot_impact_01.ogg
1591769, --	sound/spells/spell_hu_arcaneshot_impact_02.ogg
1591770, --	sound/spells/spell_hu_arcaneshot_impact_03.ogg
1591771, --	sound/spells/spell_hu_arcaneshot_impact_04.ogg
1591772, --	sound/spells/spell_hu_arcaneshot_impact_05.ogg
1595634, --	sound/spells/spell_hu_barrage_impact_01.ogg
1595635, --	sound/spells/spell_hu_barrage_impact_02.ogg
1595636, --	sound/spells/spell_hu_barrage_impact_03.ogg
1595637, --	sound/spells/spell_hu_barrage_impact_04.ogg
1595638, --	sound/spells/spell_hu_barrage_impact_05.ogg
1595639, --	sound/spells/spell_hu_barrage_impact_06.ogg
1595640, --	sound/spells/spell_hu_barrage_missle_loop_01.ogg
1595641, --	sound/spells/spell_hu_barrage_missle_loop_02.ogg
1603120, --	sound/spells/spell_hu_barrage_cast_01.ogg
1603121, --	sound/spells/spell_hu_barrage_cast_02.ogg
1603122, --	sound/spells/spell_hu_barrage_cast_03.ogg
1603123, --	sound/spells/spell_hu_barrage_cast_04.ogg
569707, --	sound/spells/spell_hu_cobrashot_impact_01.ogg
568665, --	sound/spells/spell_hu_cobrashot_impact_02.ogg
568498, --	sound/spells/spell_hu_cobrashot_impact_03.ogg
569505, --	sound/spells/spell_hu_cobrashot_impact_04.ogg
568259, --	sound/spells/spell_hu_cobrashot_impact_05.ogg
1589899, --	sound/spells/spell_hu_cobrashot_impact_06.ogg
1303796, --	sound/spells/spell_hu_killcommand_cast.ogg
569021, --	sound/spells/spell_hu_killcommand_impact.ogg
1591066, --	sound/spells/spell_hu_kill_command_cast_01.ogg
1591067, --	sound/spells/spell_hu_kill_command_cast_02.ogg
1591068, --	sound/spells/spell_hu_kill_command_cast_03.ogg
1318266, --	sound/spells/spell_hu_multishot_impact01.ogg
1318267, --	sound/spells/spell_hu_multishot_impact02.ogg
1318268, --	sound/spells/spell_hu_multishot_impact03.ogg
1360714, --	sound/spells/spell_ro_pistolshot_cast_01.ogg
1360715, --	sound/spells/spell_ro_pistolshot_cast_02.ogg
1360716, --	sound/spells/spell_ro_pistolshot_cast_03.ogg
1360717, --	sound/spells/spell_ro_pistolshot_cast_04.ogg
1360718 --	sound/spells/spell_ro_pistolshot_cast_05.ogg
}

local HunterGunSound = CreateFrame("Frame", "HunterGunSound01", nil)
local Triggert, Triggernew = nil, nil
local ReloadS=999999999
local Bow, CBow, Gun = nil, nil, nil
local Bowname, CBowname, Gunname = "Bows", "Crossbows", "Guns"
local filen, filer = nil, nil
local timedelay, timereset = 0.6, 0.7
local mini, maxi = 0, 18
local eltimer=0
local loginp=0
local TransmogLocationMixin={}
local transmogLocation = CreateFromMixins(TransmogLocationMixin)
transmogLocation.slotID=16
transmogLocation.type=0
transmogLocation.modification=0

-- Helper function to get sound file name with volume suffix
local function GetSoundFileName(baseFileName)
	-- Ensure SavedVariables is initialized before use
	if _HunterGunSounds == nil then
		InitializeSavedVariables()
	end

	if _HunterGunSounds.volume == "quiet" then
		return baseFileName .. "_min.ogg"
	elseif _HunterGunSounds.volume == "loud" then
		return baseFileName .. "_max.ogg"
	else
		return baseFileName .. ".ogg"
	end
end


-- Function to get Kill Command sound file
local function GetKillCommandSoundFile()
	-- Ensure SavedVariables is initialized before use
	if _HunterGunSounds == nil then
		InitializeSavedVariables()
	end
	
	-- Check if pet sound replacement is enabled
	if not _HunterGunSounds.petSoundEnabled then
		return nil -- Return nil to use default game sound
	end
	
	-- Return sound based on selected pet sound type
	if _HunterGunSounds.petSoundType == "bird" then
		return GetSoundFileName("Interface\\AddOns\\HunterGunSound\\sounds\\bird-kill-command")
	else
		return GetSoundFileName("Interface\\AddOns\\HunterGunSound\\sounds\\cat-kill-command-loud")
	end
end





local function MuteUnmute()
	-- Ensure SavedVariables is initialized before use
	if _HunterGunSounds == nil then
		InitializeSavedVariables()
	end
	
	if Bow then
		mini=0
		maxi=6
	elseif CBow then
		mini=5
		maxi=12
	elseif Gun then
		mini=11
		maxi=18
	else
		mini=0
		maxi=18
	end
	if _HunterGunSounds.enabled == "on" then
		for k, fileid in pairs(MutedSounds) do
			if (k<maxi and k>mini) or k>17 then
				MuteSoundFile(fileid)
			else 
				UnmuteSoundFile(fileid)
			end
		end
	else
		for _, fileid in pairs(MutedSounds) do
			UnmuteSoundFile(fileid)
		end
	end
end

local function ChWeapon()
	Bow, CBow, Gun = IsEquippedItemType(Bowname), IsEquippedItemType(CBowname), IsEquippedItemType(Gunname)

	if Bow or CBow or Gun then
		local tosh=select(3,C_Transmog.GetSlotVisualInfo(transmogLocation))
		local tname=nil
		if tosh~=0 then
			for k, v in pairs(C_TransmogCollection.GetSourceInfo(tosh)) do
				if k=="itemID" then
					tname=select(7,GetItemInfo(v))
					Bow, CBow, Gun = tname==Bowname, tname==CBowname, tname==Gunname
				end
			end
		end
	end

	if Bow then
		filen="Interface\\AddOns\\HunterGunSound\\sounds\\spell_hu_bowrelease_0"
		filer="Interface\\AddOns\\HunterGunSound\\sounds\\spell_hu_bowpullback_0"
		timedelay=0.7
		timereset=0.8
	elseif CBow then
		filen="Interface\\AddOns\\HunterGunSound\\sounds\\spell_hu_crossbowshoot_0"
		filer="Interface\\AddOns\\HunterGunSound\\sounds\\spell_hu_crossbowload_0"
		timedelay=0.6
		timereset=0.7
	else
		filen="Interface\\AddOns\\HunterGunSound\\sounds\\spell_hu_blunderbuss_weaponfire_0"
		filer="Interface\\AddOns\\HunterGunSound\\sounds\\spell_hu_blunderbuss_reload_0"
		timedelay=0.6
		timereset=0.7
	end
end

local function onEvent(self, event, ...)
	local arg1, arg2, arg3 = ...
	
	-- Early safety check for SavedVariables access events
	if (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED") and _HunterGunSounds == nil then
		InitializeSavedVariables()
	end
	
	if (event == "PLAYER_CONTROL_LOST") or (event == "PLAYER_DEAD") then
		ReloadS=999999999
	elseif (event == "PLAYER_EQUIPMENT_CHANGED") or (event == "TRANSMOGRIFY_SUCCESS") or (event == "PLAYER_ENTERING_WORLD") then
		loginp=0
	elseif _HunterGunSounds.enabled == "on" and (event == "UNIT_SPELLCAST_START") and (arg1 == "player") then
		if (arg3==56641 or arg3==19434) then
			ReloadS=999999998
			if Bow then
				PlaySoundFile(GetSoundFileName(filer .. math.random(3)))
			end
		else
			ReloadS=999999999
		end
	elseif (event == "ADDON_LOADED" and arg1 == "HunterGunSound") then
		-- Use centralized initialization function
		InitializeSavedVariables()
		local cloc = GetLocale()
		if cloc == "frFR" then
			Bowname, CBowname, Gunname = "Arcs", "Arbal\195\168tes", "Fusils"
		elseif cloc == "deDE" then
			Bowname, CBowname, Gunname = "Bogen", "Armbr\195\188ste", "Schusswaffen"
		elseif cloc == "esES" or cloc == "esMX" then
			Bowname, CBowname, Gunname = "Arcos", "Ballestas", "Armas de fuego"
		elseif cloc == "itIT" then
			Bowname, CBowname, Gunname = "Archi", "Balestre", "Armi da fuoco"
		elseif cloc == "ptBR" then
			Bowname, CBowname, Gunname = "Arcos", "Bestas", "Armas de Fogo"
		elseif cloc == "ruRU" then
			Bowname, CBowname, Gunname = "\208\155\209\131\208\186\208\184", "\208\144\209\128\208\177\208\176\208\187\208\181\209\130\209\139", "\208\158\208\179\208\189\208\181\209\129\209\130\209\128\208\181\208\187\209\140\208\189\208\190\208\181"
		elseif cloc == "koKR" then
			Bowname, CBowname, Gunname = "\237\153\156\235\165\152", "\236\132\157\234\182\129\235\165\152", "\236\180\157\234\184\176\235\165\152"
		elseif cloc == "zhCN" then
			Bowname, CBowname, Gunname = "\229\188\147", "\229\188\169", "\230\158\170\230\162\176"
		elseif cloc == "zhTW" then
			Bowname, CBowname, Gunname = "\229\188\147", "\229\188\169", "\230\167\141\230\162\176"
		end
	elseif (event == "PLAYER_LOGIN") then
		print(L.LoadedMessage)
		print(L.CommandMessage)
	elseif _HunterGunSounds.enabled == "on" and (event == "UNIT_SPELLCAST_SUCCEEDED") and (arg1 == "player") then
		
		if arg3==75 or arg3==193455 or arg3==53209 or arg3==2643 or arg3==257620 or arg3==212431 or arg3==198670 or arg3==56641 or arg3==271788 or arg3==120361 or arg3==217200 or arg3==5116 or arg3==147362 or arg3==185358 or arg3==19434 then
			if ReloadS~=999999998 or arg3==56641 or arg3==19434 then
				ReloadS=GetTime()
			end
			Triggert=1
			local soundFile = GetSoundFileName(filen .. math.random(3))
			PlaySoundFile(soundFile, 0, 0.5)
			
			-- Play echo effect if enabled
			if _HunterGunSounds.echoEnabled then
				C_Timer.After(0.5, function()
					PlaySoundFile(soundFile, 0, 0.3)
				end)
			end
		elseif arg3==58984 or arg3==5384 or arg3==257044 then
			ReloadS=999999999
		elseif arg3==19577 or arg3==259489 then
			ReloadS=999999999
			local soundFile = GetKillCommandSoundFile()
			if soundFile then
				PlaySoundFile(soundFile)
			end
		elseif arg3==34026 then
			ReloadS=GetTime()
			Triggert=1
			local soundFile = GetKillCommandSoundFile()
			if soundFile then
				PlaySoundFile(soundFile)
			end
		elseif arg3==185763 then
		PlaySoundFile(GetSoundFileName("Interface\\AddOns\\HunterGunSound\\sounds\\spell_ro_pistolshot_cast_0" .. math.random(3)))
		elseif 	ReloadS~=999999999 or ReloadS~=999999998 then
			ReloadS=GetTime()
		end

--		print(arg3)
	end
end

local function onUp(self, elapsed)
	-- Ensure SavedVariables is initialized before use
	if _HunterGunSounds == nil then
		InitializeSavedVariables()
	end
	
	if eltimer>0.015 then 
		eltimer=0
		if loginp==20 or loginp==250 then 
			ChWeapon()
			MuteUnmute()
		end
		loginp = loginp + 1
		if _HunterGunSounds.enabled == "on" and UnitCanAttack("player","target") and Triggert then
			if GetTime()-ReloadS > timedelay then 
				ReloadS=999999999
				Triggert=nil
				PlaySoundFile(GetSoundFileName(filer .. math.random(6)))
			elseif GetTime()-ReloadS > timereset then
				ReloadS=999999999
			end
		end
	else
		eltimer=eltimer+elapsed
	end
end


SlashCmdList["HUNTERGUNSOUNDS"] = function(msg)
    -- Ensure SavedVariables is initialized before using GUI
    if _HunterGunSounds == nil then
        InitializeSavedVariables()
    end
    
    if HunterGunSoundFrame:IsShown() then
        HunterGunSoundFrame:Hide()
    else
        HunterGunSoundFrame:Show()
    end
end
SLASH_HUNTERGUNSOUNDS1 = "/hgs"

-- Toggle sound command
SlashCmdList["HUNTERGUNSOUNDSTOGGLE"] = function(msg)
    -- Ensure SavedVariables is initialized before using GUI
    if _HunterGunSounds == nil then
        InitializeSavedVariables()
    end
    
    if _HunterGunSounds.enabled == "on" then
        _HunterGunSounds.enabled = "off"
        print(L.OffText)
    else
        _HunterGunSounds.enabled = "on"
        print(L.OnText)
    end
    MuteUnmute()
end
SLASH_HUNTERGUNSOUNDSTOGGLE1 = "/ogs"
HunterGunSound:RegisterEvent("ADDON_LOADED")
HunterGunSound:RegisterEvent("PLAYER_ENTERING_WORLD")
HunterGunSound:RegisterEvent("PLAYER_LOGIN")
HunterGunSound:RegisterEvent("PLAYER_CONTROL_LOST")
HunterGunSound:RegisterEvent("PLAYER_DEAD")
HunterGunSound:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
HunterGunSound:RegisterEvent("TRANSMOGRIFY_SUCCESS")
HunterGunSound:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
HunterGunSound:RegisterEvent("UNIT_SPELLCAST_START")
HunterGunSound:SetScript("OnEvent", onEvent)
HunterGunSound:SetScript("OnUpdate", onUp)

-- Enhanced Localization System
local L = {}
local locale = GetLocale()

-- Korean (한국어)
if locale == "koKR" then
    L.Title = "HunterGunSound 설정 - |cFFFF69B4낭만냥꾼|r Edition"
    L.CheckboxText = "대체 사운드 활성화"
    L.EchoCheckboxText = "추가 효과음 (에코)"
    L.PetSoundCheckboxText = "펫 소리 대체"
    L.PetSoundCat = "고양이 소리"
    L.PetSoundBird = "조류 소리"
    L.VolumeSettings = "볼륨 설정"
    L.VolumeQuiet = "작게"
    L.VolumeNormal = "일반"
    L.VolumeLoud = "크게"
    L.OnText = "|cFFFFDF00대체 사운드가 활성화되었습니다.|r"
    L.OffText = "|cFFFFDF00대체 사운드가 비활성화되었습니다.|r"
    L.EchoOnText = "|cFFFFDF00추가 효과음이 활성화되었습니다.|r"
    L.EchoOffText = "|cFFFFDF00추가 효과음이 비활성화되었습니다.|r"
    L.PetSoundOnText = "|cFFFFDF00펫 소리 대체가 활성화되었습니다.|r"
    L.PetSoundOffText = "|cFFFFDF00펫 소리 대체가 비활성화되었습니다.|r"
    L.PetSoundChanged = "|cFFFFDF00펫 사운드가 |cFF00FF00%s|r|cFFFFDF00로 설정되었습니다.|r"
    L.VolumeChanged = "|cFFFFDF00볼륨이 |cFF00FF00%s|r|cFFFFDF00로 설정되었습니다.|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound 로드됨! 제작: |cFFFF69B4-낭만냥꾼-|r"
    L.CommandMessage = "|cFFFFDF00|cFF003FFF/hgs|cFFFFDF00 명령어로 설정 창을 열거나 |cFF003FFF/ogs|cFFFFDF00 명령어로 사운드를 켜고 끌 수 있습니다.|r"
    L.Credits = "개선: |cFFFF69B4-낭만냥꾼-|r"
    
-- French (Français)
elseif locale == "frFR" then
    L.Title = "HunterGunSound Paramètres - |cFFFF69B4Chasseur Romantique|r Edition"
    L.CheckboxText = "Activer les Sons Alternatifs"
    L.EchoCheckboxText = "Effet d'Écho"
    L.PetSoundCheckboxText = "Remplacement Sons de Familier"
    L.PetSoundCat = "Son de Chat"
    L.PetSoundBird = "Son d'Oiseau"
    L.VolumeSettings = "Paramètres de Volume"
    L.VolumeQuiet = "Silencieux"
    L.VolumeNormal = "Normal"
    L.VolumeLoud = "Fort"
    L.OnText = "|cFFFFDF00Sons de Chasseur ACTIVÉS|r"
    L.OffText = "|cFFFFDF00Sons de Chasseur DÉSACTIVÉS|r"
    L.EchoOnText = "|cFFFFDF00Effet d'écho activé|r"
    L.EchoOffText = "|cFFFFDF00Effet d'écho désactivé|r"
    L.PetSoundOnText = "|cFFFFDF00Remplacement sons de familier activé|r"
    L.PetSoundOffText = "|cFFFFDF00Remplacement sons de familier désactivé|r"
    L.PetSoundChanged = "|cFFFFDF00Son de familier défini sur |cFF00FF00%s|r"
    L.VolumeChanged = "|cFFFFDF00Volume défini sur |cFF00FF00%s|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound chargé! Modifié par |cFFFF69B4-Chasseur Romantique-|r"
    L.CommandMessage = "|cFFFFDF00Tapez |cFF003FFF/hgs|cFFFFDF00 pour ouvrir les paramètres ou |cFF003FFF/ogs|cFFFFDF00 pour basculer les sons|r"
    L.Credits = "Modifié par |cFFFF69B4-Chasseur Romantique-|r"
    
-- German (Deutsch)
elseif locale == "deDE" then
    L.Title = "HunterGunSound Einstellungen - |cFFFF69B4Romantischer Jäger|r Edition"
    L.CheckboxText = "Alternative Sounds Aktivieren"
    L.EchoCheckboxText = "Echo-Effekt"
    L.PetSoundCheckboxText = "Begleiter-Sound Ersetzung"
    L.PetSoundCat = "Katzen-Sound"
    L.PetSoundBird = "Vogel-Sound"
    L.VolumeSettings = "Lautstärke-Einstellungen"
    L.VolumeQuiet = "Leise"
    L.VolumeNormal = "Normal"
    L.VolumeLoud = "Laut"
    L.OnText = "|cFFFFDF00Jäger-Sounds sind AN|r"
    L.OffText = "|cFFFFDF00Jäger-Sounds sind AUS|r"
    L.EchoOnText = "|cFFFFDF00Echo-Effekt aktiviert|r"
    L.EchoOffText = "|cFFFFDF00Echo-Effekt deaktiviert|r"
    L.PetSoundOnText = "|cFFFFDF00Begleiter-Sound Ersetzung aktiviert|r"
    L.PetSoundOffText = "|cFFFFDF00Begleiter-Sound Ersetzung deaktiviert|r"
    L.PetSoundChanged = "|cFFFFDF00Begleiter-Sound auf |cFF00FF00%s|r gesetzt"
    L.VolumeChanged = "|cFFFFDF00Lautstärke auf |cFF00FF00%s|r gesetzt"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound geladen! Modifiziert von |cFFFF69B4-Romantischer Jäger-|r"
    L.CommandMessage = "|cFFFFDF00|cFF003FFF/hgs|cFFFFDF00 für Einstellungen oder |cFF003FFF/ogs|cFFFFDF00 zum An-/Ausschalten|r"
    L.Credits = "Modifiziert von |cFFFF69B4-Romantischer Jäger-|r"
    
-- Spanish (Español)
elseif locale == "esES" or locale == "esMX" then
    L.Title = "HunterGunSound Configuración - |cFFFF69B4Cazador Romántico|r Edition"
    L.CheckboxText = "Activar Sonidos Alternativos"
    L.EchoCheckboxText = "Efecto de Eco"
    L.PetSoundCheckboxText = "Reemplazo de Sonidos de Mascotas"
    L.PetSoundCat = "Sonido de Gato"
    L.PetSoundBird = "Sonido de Pájaro"
    L.VolumeSettings = "Configuración de Volumen"
    L.VolumeQuiet = "Silencioso"
    L.VolumeNormal = "Normal"
    L.VolumeLoud = "Alto"
    L.OnText = "|cFFFFDF00Sonidos de Cazador ACTIVADOS|r"
    L.OffText = "|cFFFFDF00Sonidos de Cazador DESACTIVADOS|r"
    L.EchoOnText = "|cFFFFDF00Efecto de eco activado|r"
    L.EchoOffText = "|cFFFFDF00Efecto de eco desactivado|r"
    L.PetSoundOnText = "|cFFFFDF00Reemplazo de sonidos de mascotas activado|r"
    L.PetSoundOffText = "|cFFFFDF00Reemplazo de sonidos de mascotas desactivado|r"
    L.PetSoundChanged = "|cFFFFDF00Sonido de mascota establecido en |cFF00FF00%s|r"
    L.VolumeChanged = "|cFFFFDF00Volumen establecido en |cFF00FF00%s|r"
    L.LoadedMessage = "|cFFFFDF00¡HunterGunSound cargado! Modificado por |cFFFF69B4-Cazador Romántico-|r"
    L.CommandMessage = "|cFFFFDF00Escribe |cFF003FFF/hgs|cFFFFDF00 para configuración o |cFF003FFF/ogs|cFFFFDF00 para alternar sonidos|r"
    L.Credits = "Modificado por |cFFFF69B4-Cazador Romántico-|r"
    
-- Chinese Simplified (简体中文)
elseif locale == "zhCN" then
    L.Title = "HunterGunSound 设置 - |cFFFF69B4浪漫猎手|r 版"
    L.CheckboxText = "启用替代音效"
    L.EchoCheckboxText = "回声效果"
    L.PetSoundCheckboxText = "宠物音效替换"
    L.PetSoundCat = "猫咪音效"
    L.PetSoundBird = "鸟类音效"
    L.VolumeSettings = "音量设置"
    L.VolumeQuiet = "安静"
    L.VolumeNormal = "普通"
    L.VolumeLoud = "响亮"
    L.OnText = "|cFFFFDF00猎人枪声音效已开启|r"
    L.OffText = "|cFFFFDF00猎人枪声音效已关闭|r"
    L.EchoOnText = "|cFFFFDF00回声效果已启用|r"
    L.EchoOffText = "|cFFFFDF00回声效果已禁用|r"
    L.PetSoundOnText = "|cFFFFDF00宠物音效替换已启用|r"
    L.PetSoundOffText = "|cFFFFDF00宠物音效替换已禁用|r"
    L.PetSoundChanged = "|cFFFFDF00宠物音效设置为 |cFF00FF00%s|r"
    L.VolumeChanged = "|cFFFFDF00音量设置为 |cFF00FF00%s|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound 已加载！修改者：|cFFFF69B4-浪漫猎手-|r"
    L.CommandMessage = "|cFFFFDF00输入 |cFF003FFF/hgs|cFFFFDF00 打开设置或 |cFF003FFF/ogs|cFFFFDF00 切换音效|r"
    L.Credits = "修改者：|cFFFF69B4-浪漫猎手-|r"
    
-- Chinese Traditional (繁體中文)
elseif locale == "zhTW" then
    L.Title = "HunterGunSound 設定 - |cFFFF69B4浪漫獵手|r 版"
    L.CheckboxText = "啟用替代音效"
    L.EchoCheckboxText = "回音效果"
    L.PetSoundCheckboxText = "寵物音效替換"
    L.PetSoundCat = "貓咪音效"
    L.PetSoundBird = "鳥類音效"
    L.VolumeSettings = "音量設定"
    L.VolumeQuiet = "安靜"
    L.VolumeNormal = "普通"
    L.VolumeLoud = "響亮"
    L.OnText = "|cFFFFDF00獵人槍聲音效已開啟|r"
    L.OffText = "|cFFFFDF00獵人槍聲音效已關閉|r"
    L.EchoOnText = "|cFFFFDF00回音效果已啟用|r"
    L.EchoOffText = "|cFFFFDF00回音效果已停用|r"
    L.PetSoundOnText = "|cFFFFDF00寵物音效替換已啟用|r"
    L.PetSoundOffText = "|cFFFFDF00寵物音效替換已停用|r"
    L.PetSoundChanged = "|cFFFFDF00寵物音效設定為 |cFF00FF00%s|r"
    L.VolumeChanged = "|cFFFFDF00音量設定為 |cFF00FF00%s|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound 已載入！修改者：|cFFFF69B4-浪漫獵手-|r"
    L.CommandMessage = "|cFFFFDF00輸入 |cFF003FFF/hgs|cFFFFDF00 開啟設定或 |cFF003FFF/ogs|cFFFFDF00 切換音效|r"
    L.Credits = "修改者：|cFFFF69B4-浪漫獵手-|r"
    
-- Russian (Русский)
elseif locale == "ruRU" then
    L.Title = "HunterGunSound Настройки - |cFFFF69B4Романтичный Охотник|r Издание"
    L.CheckboxText = "Включить Альтернативные Звуки"
    L.EchoCheckboxText = "Эффект Эха"
    L.PetSoundCheckboxText = "Замена Звуков Питомца"
    L.PetSoundCat = "Звук Кота"
    L.PetSoundBird = "Звук Птицы"
    L.VolumeSettings = "Настройки Громкости"
    L.VolumeQuiet = "Тихо"
    L.VolumeNormal = "Нормально"
    L.VolumeLoud = "Громко"
    L.OnText = "|cFFFFDF00Звуки Охотника ВКЛЮЧЕНЫ|r"
    L.OffText = "|cFFFFDF00Звуки Охотника ОТКЛЮЧЕНЫ|r"
    L.EchoOnText = "|cFFFFDF00Эффект эха включен|r"
    L.EchoOffText = "|cFFFFDF00Эффект эха отключен|r"
    L.PetSoundOnText = "|cFFFFDF00Замена звуков питомца включена|r"
    L.PetSoundOffText = "|cFFFFDF00Замена звуков питомца отключена|r"
    L.PetSoundChanged = "|cFFFFDF00Звук питомца установлен на |cFF00FF00%s|r"
    L.VolumeChanged = "|cFFFFDF00Громкость установлена на |cFF00FF00%s|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound загружен! Изменено |cFFFF69B4-Романтичный Охотник-|r"
    L.CommandMessage = "|cFFFFDF00Введите |cFF003FFF/hgs|cFFFFDF00 для настроек или |cFF003FFF/ogs|cFFFFDF00 для переключения звуков|r"
    L.Credits = "Изменено |cFFFF69B4-Романтичный Охотник-|r"
    
-- English (Default) - English, Portuguese, Italian, Japanese and other languages
else
    L.Title = "HunterGunSound Settings - |cFFFF69B4Enhanced|r Edition"
    L.CheckboxText = "Enable Alternative Sounds"
    L.EchoCheckboxText = "Echo Effect"
    L.PetSoundCheckboxText = "Pet Sound Replacement"
    L.PetSoundCat = "Cat Sound"
    L.PetSoundBird = "Bird Sound"
    L.VolumeSettings = "Volume Settings"
    L.VolumeQuiet = "Quiet"
    L.VolumeNormal = "Normal"
    L.VolumeLoud = "Loud"
    L.OnText = "|cFFFFDF00Hunter Gun Sounds are ON|r"
    L.OffText = "|cFFFFDF00Hunter Gun Sounds are OFF|r"
    L.EchoOnText = "|cFFFFDF00Echo effect enabled|r"
    L.EchoOffText = "|cFFFFDF00Echo effect disabled|r"
    L.PetSoundOnText = "|cFFFFDF00Pet sound replacement enabled|r"
    L.PetSoundOffText = "|cFFFFDF00Pet sound replacement disabled|r"
    L.PetSoundChanged = "|cFFFFDF00Pet sound set to |cFF00FF00%s|r"
    L.VolumeChanged = "|cFFFFDF00Volume set to |cFF00FF00%s|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound loaded! Enhanced by |cFFFF69B4godeater9678|r"
    L.CommandMessage = "|cFFFFDF00Type |cFF003FFF/hgs|cFFFFDF00 to open settings or |cFF003FFF/ogs|cFFFFDF00 to toggle sounds|r"
    L.Credits = "Enhanced by |cFFFF69B4godeater9678|r"
end

-- Create the GUI
local HunterGunSoundFrame = CreateFrame("Frame", "HunterGunSoundFrame", UIParent, "BasicFrameTemplate")
HunterGunSoundFrame:SetSize(300, 380)
HunterGunSoundFrame:SetPoint("CENTER")
HunterGunSoundFrame.title = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
HunterGunSoundFrame.title:SetPoint("TOP", 0, -5)
HunterGunSoundFrame.title:SetText(L.Title)

HunterGunSoundFrame:SetMovable(true)
HunterGunSoundFrame:EnableMouse(true)
HunterGunSoundFrame:RegisterForDrag("LeftButton")
HunterGunSoundFrame:SetScript("OnDragStart", HunterGunSoundFrame.StartMoving)
HunterGunSoundFrame:SetScript("OnDragStop", HunterGunSoundFrame.StopMovingOrSizing)

-- Sound On/Off Checkbox
local soundCheckbox = CreateFrame("CheckButton", "HunterGunSoundSoundCheckbox", HunterGunSoundFrame, "UICheckButtonTemplate")
soundCheckbox:SetPoint("TOPLEFT", 20, -40)

local soundCheckboxText = soundCheckbox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
soundCheckboxText:SetPoint("LEFT", soundCheckbox, "RIGHT", 5, 0)
soundCheckboxText:SetText(L.CheckboxText)

soundCheckbox:SetScript("OnClick", function(self)
    if self:GetChecked() then
        _HunterGunSounds.enabled = "on"
        print(L.OnText)
    else
        _HunterGunSounds.enabled = "off"
        print(L.OffText)
    end
    MuteUnmute()
end)

-- Echo Effect Checkbox
local echoCheckbox = CreateFrame("CheckButton", "HunterGunSoundEchoCheckbox", HunterGunSoundFrame, "UICheckButtonTemplate")
echoCheckbox:SetPoint("TOPLEFT", soundCheckbox, "BOTTOMLEFT", 0, -5)

local echoCheckboxText = echoCheckbox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
echoCheckboxText:SetPoint("LEFT", echoCheckbox, "RIGHT", 5, 0)
echoCheckboxText:SetText(L.EchoCheckboxText)

echoCheckbox:SetScript("OnClick", function(self)
    if self:GetChecked() then
        _HunterGunSounds.echoEnabled = true
        print(L.EchoOnText)
    else
        _HunterGunSounds.echoEnabled = false
        print(L.EchoOffText)
    end
end)

-- Pet Sound Replacement Checkbox
local petSoundCheckbox = CreateFrame("CheckButton", "HunterGunSoundPetSoundCheckbox", HunterGunSoundFrame, "UICheckButtonTemplate")
petSoundCheckbox:SetPoint("TOPLEFT", echoCheckbox, "BOTTOMLEFT", 0, -5)

local petSoundCheckboxText = petSoundCheckbox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
petSoundCheckboxText:SetPoint("LEFT", petSoundCheckbox, "RIGHT", 5, 0)
petSoundCheckboxText:SetText(L.PetSoundCheckboxText)

petSoundCheckbox:SetScript("OnClick", function(self)
    if self:GetChecked() then
        _HunterGunSounds.petSoundEnabled = true
        print(L.PetSoundOnText)
    else
        _HunterGunSounds.petSoundEnabled = false
        print(L.PetSoundOffText)
    end
end)

-- Pet Sound Type Radio Buttons
local petSoundRadios = {}
local petSoundValues = {"cat", "bird"}
local petSoundLabels = {L.PetSoundCat, L.PetSoundBird}

local function UpdatePetSoundRadios()
	-- Ensure SavedVariables is initialized before use
	if _HunterGunSounds == nil then
		InitializeSavedVariables()
	end
	
	for i, radio in ipairs(petSoundRadios) do
		radio:SetChecked(petSoundValues[i] == _HunterGunSounds.petSoundType)
	end
end

for i = 1, 2 do
	local radio = CreateFrame("CheckButton", "PetSoundRadio" .. i, HunterGunSoundFrame, "UIRadioButtonTemplate")
	if i == 1 then
		radio:SetPoint("TOPLEFT", petSoundCheckbox, "BOTTOMLEFT", 20, -5)
	else
		radio:SetPoint("TOPLEFT", petSoundRadios[i-1], "BOTTOMLEFT", 0, -5)
	end
	
	local radioText = radio:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	radioText:SetPoint("LEFT", radio, "RIGHT", 5, 0)
	radioText:SetText(petSoundLabels[i])
	
	radio:SetScript("OnClick", function(self)
		_HunterGunSounds.petSoundType = petSoundValues[i]
		UpdatePetSoundRadios()
		print(string.format(L.PetSoundChanged, petSoundLabels[i]))
	end)
	
	petSoundRadios[i] = radio
end

-- Volume Settings Section
local volumeTitle = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
volumeTitle:SetPoint("TOPLEFT", petSoundRadios[2], "BOTTOMLEFT", -20, -15)
volumeTitle:SetText(L.VolumeSettings)

-- Volume Radio Buttons
local volumeRadios = {}
local volumeValues = {"quiet", "normal", "loud"}
local volumeLabels = {L.VolumeQuiet, L.VolumeNormal, L.VolumeLoud}

local function UpdateVolumeRadios()
	-- Ensure SavedVariables is initialized before use
	if _HunterGunSounds == nil then
		InitializeSavedVariables()
	end
	
	for i, radio in ipairs(volumeRadios) do
		radio:SetChecked(volumeValues[i] == _HunterGunSounds.volume)
	end
end

for i = 1, 3 do
	local radio = CreateFrame("CheckButton", "VolumeRadio" .. i, HunterGunSoundFrame, "UIRadioButtonTemplate")
	if i == 1 then
		radio:SetPoint("TOPLEFT", volumeTitle, "BOTTOMLEFT", 0, -10)
	else
		radio:SetPoint("TOPLEFT", volumeRadios[i-1], "BOTTOMLEFT", 0, -5)
	end
	
	local radioText = radio:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	radioText:SetPoint("LEFT", radio, "RIGHT", 5, 0)
	radioText:SetText(volumeLabels[i])
	
	radio:SetScript("OnClick", function(self)
		_HunterGunSounds.volume = volumeValues[i]
		UpdateVolumeRadios()
		print(string.format(L.VolumeChanged, volumeLabels[i]))
	end)
	
	volumeRadios[i] = radio
end

-- Version info
local versionText = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
versionText:SetPoint("BOTTOM", HunterGunSoundFrame, "BOTTOM", 0, 30)
versionText:SetText("|cFFFFFFFFVersion 1.3 - Pet Sounds: 2025-08-16|r")

-- Credits at bottom
local creditsText = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
creditsText:SetPoint("BOTTOM", HunterGunSoundFrame, "BOTTOM", 0, 10)
creditsText:SetText(L.Credits)

HunterGunSoundFrame:SetScript("OnShow", function(self)
    -- Ensure SavedVariables is initialized before using GUI
    if _HunterGunSounds == nil then
        InitializeSavedVariables()
    end
    
    if _HunterGunSounds.enabled == "on" then
        soundCheckbox:SetChecked(true)
    else
        soundCheckbox:SetChecked(false)
    end
    
    echoCheckbox:SetChecked(_HunterGunSounds.echoEnabled)
    petSoundCheckbox:SetChecked(_HunterGunSounds.petSoundEnabled)
    
    UpdatePetSoundRadios()
    UpdateVolumeRadios()
end)

HunterGunSoundFrame:Hide()

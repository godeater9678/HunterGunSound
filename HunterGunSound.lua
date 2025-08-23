-- SafeGuard: Initialize SavedVariables with default values if not present
if _HunterGunSounds == nil then
    _HunterGunSounds = { enabled = "on", volume = "normal", echoEnabled = false, petSoundEnabled = true, petSoundType = "cat", machineGunEnabled = true, machineGunThreshold = 10 }
end

-- Centralized SavedVariables initialization function
local function InitializeSavedVariables()
    if _HunterGunSounds == nil then
        _HunterGunSounds = { enabled = "on", volume = "normal", echoEnabled = false, petSoundEnabled = true, petSoundType = "cat", machineGunEnabled = true, machineGunThreshold = 10 }
    elseif type(_HunterGunSounds) == "string" then
        -- Migration logic for older versions
        local oldEnabled = _HunterGunSounds
        _HunterGunSounds = { enabled = oldEnabled, volume = "normal", echoEnabled = false, petSoundEnabled = true, petSoundType = "cat", machineGunEnabled = true, machineGunThreshold = 10 }
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
    if _HunterGunSounds.machineGunEnabled == nil then
        _HunterGunSounds.machineGunEnabled = true
    end
    if _HunterGunSounds.machineGunThreshold == nil then
        _HunterGunSounds.machineGunThreshold = 10
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

-- 머신건 사운드를 위한 공격 추적 변수
local attackTimes = {} -- 최근 공격 시간들을 저장하는 테이블
local machineGunActive = false -- 머신건 모드 활성화 여부
local lastMachineGunTime = 0 -- 마지막 머신건 사운드 재생 시간
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
		return GetSoundFileName("Interface\\AddOns\\HunterGunSound\\sounds\\cat-kill-command")
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

-- 머신건 모드 감지 함수 (공격 시간만 추가, 모드는 체크하지 않음)
local function AddAttackTime()
    local currentTime = GetTime()
    
    -- 최근 공격 시간 추가
    table.insert(attackTimes, currentTime)
    
    -- 1초 이전의 공격 시간들 제거
    local i = 1
    while i <= #attackTimes do
        if currentTime - attackTimes[i] > 1.0 then
            table.remove(attackTimes, i)
        else
            i = i + 1
        end
    end
end

-- 머신건 모드 상태 체크 (플레이어 총 공격 시에만 사용)
local function CheckMachineGunMode()
    local threshold = _HunterGunSounds.machineGunThreshold or 10
    -- 1초 안에 설정된 횟수 이상 공격이면 머신건 모드 활성화
    if #attackTimes >= threshold then
        if not machineGunActive then
            machineGunActive = true
            -- print(string.format("|cFFFF4500[MACHINE GUN MODE! Threshold: %d]|r", threshold))
        end
        -- 머신건 모드 사용 후 초기화 (1회만 사용)
        attackTimes = {}
        return true
    else
        if machineGunActive then
            machineGunActive = false
            -- print("|cFF00FF00[NORMAL MODE]|r")
        end
        return false
    end
end

-- 공격 사운드 재생 함수 (머신건 모드 고려)
local function PlayAttackSound()
    local currentTime = GetTime()
    
    -- 머신건 모드가 활성화되어 있을 때만 머신건 모드 체크
    local isMachineGun = false
    if _HunterGunSounds.machineGunEnabled then
        isMachineGun = CheckMachineGunMode()
    end
    
    if isMachineGun and _HunterGunSounds.machineGunEnabled then
        -- 머신건 모드: 볼륨 설정에 따라 적절한 머신건 사운드 재생
        -- 너무 빠른 연속 재생 방지를 위해 최소 0.1초 간격 설정
        if currentTime - lastMachineGunTime > 0.1 then
            PlaySoundFile(GetSoundFileName("Interface\\AddOns\\HunterGunSound\\sounds\\machinegun"), 0, 0.5)
            lastMachineGunTime = currentTime
        end
    else
        -- 일반 모드: 기존 설정에 따라 사운드 재생
        local soundFile = GetSoundFileName(filen .. math.random(3))
        PlaySoundFile(soundFile, 0, 0.5)
        
        -- Play echo effect if enabled
        if _HunterGunSounds.echoEnabled then
            C_Timer.After(0.5, function()
                PlaySoundFile(soundFile, 0, 0.3)
            end)
        end
    end
end

-- 간단한 데미지 추적 함수 (데미지 출력 없이 공격 시간만 추적)
local function ProcessDamageEvent()
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()
    
    -- 내 캐릭터의 GUID 가져오기
    local playerGUID = UnitGUID("player")
    local petGUID = UnitGUID("pet")
    
    -- 데미지 이벤트만 처리
    if subevent == "SWING_DAMAGE" or subevent == "SPELL_DAMAGE" or subevent == "RANGE_DAMAGE" then
        -- 내 캐릭터나 펫의 공격인지 확인
        if sourceGUID == playerGUID then
            -- 플레이어 공격 시 머신건 모드 체크용 공격 시간 추가
            AddAttackTime()
        elseif petGUID and sourceGUID == petGUID then
            -- 펫 공격 시에는 공격 시간만 추가하고 사운드는 재생하지 않음
            AddAttackTime()
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
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		-- 데미지 추적 처리
		ProcessDamageEvent()
	elseif (event == "PLAYER_LOGIN") then
		print(L.LoadedMessage)
		print(L.CommandMessage)
	elseif _HunterGunSounds.enabled == "on" and (event == "UNIT_SPELLCAST_SUCCEEDED") and (arg1 == "player") then
		
		if arg3==75 or arg3==193455 or arg3==53209 or arg3==2643 or arg3==257620 or arg3==212431 or arg3==198670 or arg3==56641 or arg3==271788 or arg3==120361 or arg3==217200 or arg3==5116 or arg3==147362 or arg3==185358 or arg3==19434 then
			if ReloadS~=999999998 or arg3==56641 or arg3==19434 then
				ReloadS=GetTime()
			end
			Triggert=1
			-- 머신건 모드 지원 사운드 재생
			PlayAttackSound()
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

HunterGunSound:RegisterEvent("ADDON_LOADED")
HunterGunSound:RegisterEvent("PLAYER_ENTERING_WORLD")
HunterGunSound:RegisterEvent("PLAYER_LOGIN")
HunterGunSound:RegisterEvent("PLAYER_CONTROL_LOST")
HunterGunSound:RegisterEvent("PLAYER_DEAD")
HunterGunSound:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
HunterGunSound:RegisterEvent("TRANSMOGRIFY_SUCCESS")
HunterGunSound:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
HunterGunSound:RegisterEvent("UNIT_SPELLCAST_START")
HunterGunSound:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
HunterGunSound:SetScript("OnEvent", onEvent)
HunterGunSound:SetScript("OnUpdate", onUp)

-- Localization System (Korean & English)
local L = {}
local locale = GetLocale()

-- Korean (한국어)
if locale == "koKR" then
    L.Title = "HunterGunSound 설정 - |cFFFF69B4낭만냥꾼|r Edition"
    L.CheckboxText = "대체 사운드 활성화"
    L.EchoCheckboxText = "추가 효과음 (에코)"
    L.PetSoundCheckboxText = "펫 소리 대체"
    L.MachineGunCheckboxText = "머신건 효과음"
    L.MachineGunThresholdSettings = "머신건 발동 조건"
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
    L.MachineGunOnText = "|cFFFFDF00머신건 모드가 활성화되었습니다.|r"
    L.MachineGunOffText = "|cFFFFDF00머신건 모드가 비활성화되었습니다.|r"
    L.MachineGunThresholdChanged = "|cFFFFDF00머신건 발동 조건이 |cFF00FF00%d회|r|cFFFFDF00로 설정되었습니다.|r"
    L.PetSoundChanged = "|cFFFFDF00펫 사운드가 |cFF00FF00%s|r|cFFFFDF00로 설정되었습니다.|r"
    L.VolumeChanged = "|cFFFFDF00볼륨이 |cFF00FF00%s|r|cFFFFDF00로 설정되었습니다.|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound 로드됨! 제작: |cFFFF69B4-낭만냥꾼-|r"
    L.CommandMessage = "|cFFFFDF00|cFF003FFF/hgs|cFFFFDF00 명령어로 설정 창을 열 수 있습니다.|r"
    L.Credits = "개선: |cFFFF69B4-낭만냥꾼-|r"

-- English (Default) - All other languages
else
    L.Title = "HunterGunSound Settings - |cFFFF69B4Enhanced|r Edition"
    L.CheckboxText = "Enable Alternative Sounds"
    L.EchoCheckboxText = "Echo Effect"
    L.PetSoundCheckboxText = "Pet Sound Replacement"
    L.MachineGunCheckboxText = "Machine Gun Effects"
    L.MachineGunThresholdSettings = "Machine Gun Threshold"
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
    L.MachineGunOnText = "|cFFFFDF00Machine gun mode enabled|r"
    L.MachineGunOffText = "|cFFFFDF00Machine gun mode disabled|r"
    L.MachineGunThresholdChanged = "|cFFFFDF00Machine gun threshold set to |cFF00FF00%d attacks|r"
    L.PetSoundChanged = "|cFFFFDF00Pet sound set to |cFF00FF00%s|r"
    L.VolumeChanged = "|cFFFFDF00Volume set to |cFF00FF00%s|r"
    L.LoadedMessage = "|cFFFFDF00HunterGunSound loaded! Enhanced by |cFFFF69B4godeater9678|r"
    L.CommandMessage = "|cFFFFDF00Type |cFF003FFF/hgs|cFFFFDF00 to open settings|r"
    L.Credits = "Enhanced by |cFFFF69B4godeater9678|r"
end

-- Create the GUI
local HunterGunSoundFrame = CreateFrame("Frame", "HunterGunSoundFrame", UIParent, "BasicFrameTemplate")
HunterGunSoundFrame:SetSize(340, 520)
HunterGunSoundFrame:SetPoint("CENTER")
HunterGunSoundFrame.title = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
HunterGunSoundFrame.title:SetPoint("TOP", 0, -8)
HunterGunSoundFrame.title:SetText(L.Title)

HunterGunSoundFrame:SetMovable(true)
HunterGunSoundFrame:EnableMouse(true)
HunterGunSoundFrame:RegisterForDrag("LeftButton")
HunterGunSoundFrame:SetScript("OnDragStart", HunterGunSoundFrame.StartMoving)
HunterGunSoundFrame:SetScript("OnDragStop", HunterGunSoundFrame.StopMovingOrSizing)

-- Sound On/Off Checkbox
local soundCheckbox = CreateFrame("CheckButton", "HunterGunSoundSoundCheckbox", HunterGunSoundFrame, "UICheckButtonTemplate")
soundCheckbox:SetPoint("TOPLEFT", 20, -35)

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
echoCheckbox:SetPoint("TOPLEFT", soundCheckbox, "BOTTOMLEFT", 0, -8)

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

-- Machine Gun Effects Checkbox
local machineGunCheckbox = CreateFrame("CheckButton", "HunterGunSoundMachineGunCheckbox", HunterGunSoundFrame, "UICheckButtonTemplate")
machineGunCheckbox:SetPoint("TOPLEFT", echoCheckbox, "BOTTOMLEFT", 0, -8)

local machineGunCheckboxText = machineGunCheckbox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
machineGunCheckboxText:SetPoint("LEFT", machineGunCheckbox, "RIGHT", 5, 0)
machineGunCheckboxText:SetText(L.MachineGunCheckboxText)

machineGunCheckbox:SetScript("OnClick", function(self)
    if self:GetChecked() then
        _HunterGunSounds.machineGunEnabled = true
        print(L.MachineGunOnText)
    else
        _HunterGunSounds.machineGunEnabled = false
        print(L.MachineGunOffText)
    end
end)

-- Machine Gun Threshold Settings Section
local machineGunThresholdTitle = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
machineGunThresholdTitle:SetPoint("TOPLEFT", machineGunCheckbox, "BOTTOMLEFT", 0, -12)
machineGunThresholdTitle:SetText(L.MachineGunThresholdSettings)

-- Machine Gun Threshold Radio Buttons
local machineGunThresholdRadios = {}
local machineGunThresholdValues = {5, 10, 15}

local function UpdateMachineGunThresholdRadios()
	-- Ensure SavedVariables is initialized before use
	if _HunterGunSounds == nil then
		InitializeSavedVariables()
	end
	
	for i, radio in ipairs(machineGunThresholdRadios) do
		radio:SetChecked(machineGunThresholdValues[i] == _HunterGunSounds.machineGunThreshold)
	end
end

for i = 1, 3 do
	local radio = CreateFrame("CheckButton", "MachineGunThresholdRadio" .. i, HunterGunSoundFrame, "UIRadioButtonTemplate")
	if i == 1 then
		radio:SetPoint("TOPLEFT", machineGunThresholdTitle, "BOTTOMLEFT", 0, -8)
	else
		radio:SetPoint("TOPLEFT", machineGunThresholdRadios[i-1], "BOTTOMLEFT", 0, -6)
	end
	
	local radioText = radio:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	radioText:SetPoint("LEFT", radio, "RIGHT", 5, 0)
	radioText:SetText(string.format("%d Times", machineGunThresholdValues[i]))
	
	radio:SetScript("OnClick", function(self)
		_HunterGunSounds.machineGunThreshold = machineGunThresholdValues[i]
		print(string.format(L.MachineGunThresholdChanged, machineGunThresholdValues[i]))
		UpdateMachineGunThresholdRadios()
	end)
	
	machineGunThresholdRadios[i] = radio
end

-- Pet Sound Replacement Checkbox
local petSoundCheckbox = CreateFrame("CheckButton", "HunterGunSoundPetSoundCheckbox", HunterGunSoundFrame, "UICheckButtonTemplate")
petSoundCheckbox:SetPoint("TOPLEFT", machineGunThresholdRadios[3], "BOTTOMLEFT", 0, -15)

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
		print(string.format(L.PetSoundChanged, petSoundLabels[i]))
		UpdatePetSoundRadios()
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
		print(string.format(L.VolumeChanged, volumeLabels[i]))
		UpdateVolumeRadios()
	end)
	
	volumeRadios[i] = radio
end

-- Version info (동적으로 불러오기)
local versionText = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
versionText:SetPoint("BOTTOM", HunterGunSoundFrame, "BOTTOM", 0, 30)
-- 초기값 설정 (addon_info.lua가 로드되기 전 대비)
versionText:SetText("|cFFFFFFFFVersion 1.3.2 - 2025-08-17|r")

-- Credits at bottom (동적으로 불러오기)
local creditsText = HunterGunSoundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
creditsText:SetPoint("BOTTOM", HunterGunSoundFrame, "BOTTOM", 0, 10)
-- 초기값 설정 (addon_info.lua가 로드되기 전 대비)
creditsText:SetText(L.Credits)

HunterGunSoundFrame:SetScript("OnShow", function(self)
    -- Ensure SavedVariables is initialized before using GUI
    if _HunterGunSounds == nil then
        InitializeSavedVariables()
    end
    
    -- 동적으로 버전 정보와 크레딧 업데이트
    if HunterGunSoundInfo then
        versionText:SetText("|cFFFFFFFF" .. HunterGunSoundInfo:GetVersionString() .. "|r")
        creditsText:SetText(HunterGunSoundInfo:GetCreditsString(GetLocale()))
    end
    
    if _HunterGunSounds.enabled == "on" then
        soundCheckbox:SetChecked(true)
    else
        soundCheckbox:SetChecked(false)
    end
    
    echoCheckbox:SetChecked(_HunterGunSounds.echoEnabled)
    petSoundCheckbox:SetChecked(_HunterGunSounds.petSoundEnabled)
    machineGunCheckbox:SetChecked(_HunterGunSounds.machineGunEnabled)
    
    UpdateMachineGunThresholdRadios()
    UpdatePetSoundRadios()
    UpdateVolumeRadios()
end)

HunterGunSoundFrame:Hide()

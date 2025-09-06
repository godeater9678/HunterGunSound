-- HunterGunSound Addon Information
-- 이 파일에서 애드온의 모든 기본 정보를 관리합니다.
-- 버전 변경 시 이 파일만 수정하면 됩니다.

local addonName, addonTable = ...

-- 애드온 기본 정보
HunterGunSoundInfo = {
    version = "1.4.0",
    versionDate = "2025-08-24",
    enhancedBy = "godeater9678 (낭만냥꾼)",
    enhancedByKR = "-낭만냥꾼-",
    websiteURL = "https://github.com/godeater9678/HunterGunSound",
    category = "Hunter",
    
    -- 지원 언어
    supportedLocales = {
        "koKR", "enUS"
    },
    
    -- 기능 설명
    features = {
        volumeControl = true,
        petBasedKillCommand = true,
        killStreakAnnouncements = true,
        echoEffect = true,
        multiLanguageSupport = true,
        customGunSounds = true
    }
}

-- 버전 정보를 포맷팅해서 반환하는 함수
function HunterGunSoundInfo:GetVersionString()
    return string.format("Version %s - %s", self.version, self.versionDate)
end

-- 전체 크레딧 문자열 반환
function HunterGunSoundInfo:GetCreditsString(locale)
    if locale == "koKR" then
        return string.format("개선: |cFFFF69B4%s|r", self.enhancedByKR)
    else
        return string.format("Enhanced by |cFFFF69B4%s|r", self.enhancedBy)
    end
end

-- 로드 메시지 생성
function HunterGunSoundInfo:GetLoadMessage(locale)
    if locale == "koKR" then
        return string.format("|cFFFFDF00HunterGunSound v%s 로드됨! 제작: |cFFFF69B4%s|r", 
                           self.version, self.enhancedByKR)
    else
        return string.format("|cFFFFDF00HunterGunSound v%s loaded! Enhanced by |cFFFF69B4%s|r", 
                           self.version, self.enhancedBy)
    end
end

-- 애드온 테이블에 정보 저장 (다른 파일에서 접근 가능)
if addonTable then
    addonTable.Info = HunterGunSoundInfo
end

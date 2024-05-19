local addon = {
    name = 'pChat_Gamepad'
}

local function hook_last_KEYBOARD_CHAT_SYSTEM_use()
    local original_pChat_ApplyChatConfig = pChat.ApplyChatConfig
    pChat.ApplyChatConfig = function()
        original_pChat_ApplyChatConfig()
        KEYBOARD_CHAT_SYSTEM:RefreshVisibility()
    end
end

local function OnAddonLoaded(event, name)
    if name ~= pChat.CONSTANTS.ADDON_NAME then return end

    EVENT_MANAGER:UnregisterForEvent(addon.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)

    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.GENERAL_ALERT_ERROR)
    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
    messageParams:SetExpiringCallback(function ()
        CENTER_SCREEN_ANNOUNCE:ReleaseMessageParams(messageParams)
    end)
    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)

    if pChat.CONSTANTS.ADDON_VERSION < '10.0.5.2' then
        messageParams:SetText('|cda8a00pChat_Gamepad|r has been deprecated. Update |cda8a00pChat|r.')

        hook_last_KEYBOARD_CHAT_SYSTEM_use()
    else
        messageParams:SetText('|cda8a00pChat_Gamepad|r has been deprecated. Delete |cda8a00pChat_Gamepad|r.')
    end
end

EVENT_MANAGER:RegisterForEvent(addon.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)

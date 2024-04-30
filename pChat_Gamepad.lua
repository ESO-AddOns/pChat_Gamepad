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

    hook_last_KEYBOARD_CHAT_SYSTEM_use()
end

EVENT_MANAGER:RegisterForEvent(addon.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)

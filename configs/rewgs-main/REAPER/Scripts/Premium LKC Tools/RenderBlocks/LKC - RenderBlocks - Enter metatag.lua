--[[
	Noindex: true
]]     
local sws = reaper.APIExists("CF_GetClipboardBig")
if sws then
    --OS INFO
    platform = reaper.GetOS()
    if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform  == "Other" or platform == "macOS-arm64" then
        separator = [[/]]
    else
        separator = [[\]]     --win
    end

    local info = debug.getinfo(1,'S');
    script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]

    bin="x64"
    if platform == "Win32" or platform == "OSX32" then bin="x86" end

    luac = "53"
    if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end

    EDIT_METATAGS = true
    dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_renderblocks_name_editor.dll]])
else
    reaper.ShowMessageBox("Please install SWS Extension version 2.9.7 or higher from:\nhttps://sws-extension.org/", "NO SWS FOUND", 0)
end

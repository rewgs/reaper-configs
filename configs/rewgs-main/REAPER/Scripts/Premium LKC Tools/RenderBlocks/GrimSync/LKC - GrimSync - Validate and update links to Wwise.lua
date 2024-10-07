--[[
	Noindex: true
]]

local sws = reaper.APIExists("CF_GetClipboardBig")
if not sws then
    reaper.ShowMessageBox("Please install SWS Extension version 2.9.7 or higher from:\nhttps://sws-extension.org/", "NO SWS FOUND", 0)
    return
end

local imgui = reaper.APIExists( "ImGui_CreateContext")
if not imgui then
    reaper.ShowMessageBox("Please install 'ReaImgui: ReaScript binding for Dear ImGui' (v0.6.0+) package from ReaPack. After that restart REAPER and try again.", "No ReaImgui found", 0)
    reaper.ReaPack_BrowsePackages( "ReaImGui: ReaScript binding for Dear ImGui")
    return
end


------------------------------------------------------------------------------------------------------------------------------
--OS INFO
platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform  == "Other" or platform == "macOS-arm64" then
    separator = [[/]]
else
    separator = [[\]]     --win
end

bin="x64"
if platform == "Win32" or platform == "OSX32" then bin="x86" end

luac = "53"
if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end


local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]

dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_grimsync_update_links.dll]])
reaper.ShowConsoleMsg(UPDATE_LINKS.Update())



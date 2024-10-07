--[[
	Noindex: true
]]

local sws = reaper.APIExists("CF_GetClipboardBig")
if sws then
    reaper.Undo_BeginBlock()
    --OS INFO
    platform = reaper.GetOS()
    if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform  == "Other" or platform == "macOS-arm64" then
        separator = [[/]]
    else
        separator = [[\]]	--win
    end

    bin="x64"
    if platform == "Win32" or platform == "OSX32" then bin="x86" end

    luac = "53"
    if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end

    local info = debug.getinfo(1,'S');
    script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
    GENERATE_JUST_NAME_STRING = true
    dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_renderblocks_autonaming.dll]])
    reaper.Undo_EndBlock("LKC - RenderBlocks - AutoName", -1)
else
    reaper.ShowMessageBox("Please install SWS Extension version 2.9.7 or higher from:\nhttps://sws-extension.org/", "NO SWS FOUND", 0)
end


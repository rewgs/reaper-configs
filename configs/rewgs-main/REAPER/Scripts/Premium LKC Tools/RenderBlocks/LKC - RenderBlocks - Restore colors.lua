--[[
 Noindex: true
 ReaScript Name:LKC - RenderBlocks - Restore colors
 Author: LKC
 REAPER: 5+
 Version: 1.1
 About:
  Restores original (pre-render) colors to RenderBlocks.
]]



--[[
 * Changelog:
 * v1.1 (2018-07-12)
	+ Fix RenderBlocks with just one item
 * v1.0 (2018-07-06)
	+ Initial commit
]]

local sws = reaper.APIExists("CF_GetClipboardBig")
if sws then
    platform = reaper.GetOS()
    if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform  == "Other" or platform == "macOS-arm64" then
        separator = [[/]]
    else
        separator = [[\]]	--win
    end

    local info = debug.getinfo(1,'S');
    script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]

    bin="x64"
    if platform == "Win32" or platform == "OSX32" then bin="x86" end

    luac = "53"
    if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end
    ----------------------

    reaper.PreventUIRefresh( 1 )
    reaper.Undo_BeginBlock()

    --RUN THE SCRIPT
    dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_renderblocks_restore_colors.dll]])

    reaper.PreventUIRefresh(-1)
    reaper.Undo_EndBlock("LKC - RenderBlocks - Restore colors", -1)
else
    reaper.ShowMessageBox("Please install SWS Extension version 2.9.7 or higher from:\nhttps://sws-extension.org/", "NO SWS FOUND", 0)
end
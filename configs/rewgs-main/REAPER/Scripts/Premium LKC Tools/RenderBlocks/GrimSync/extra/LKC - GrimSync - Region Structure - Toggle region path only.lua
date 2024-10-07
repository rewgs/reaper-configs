--WWISE ONLY SCRIPT
--[[
	Noindex: true
]]  
reaper.Undo_BeginBlock()
-- window = "tcp" --when commented affect regions, otherwise tracks
path_only = true
disable_doubleclick = true

platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform == "Other" then
	separator = [[/]]
else
	separator = [[\]]     --win
end

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "lkc_grimsync_structure_manager.lua") 
reaper.Undo_EndBlock("LKC - GrimSync - Region Structure - Toggle region path only", -1)

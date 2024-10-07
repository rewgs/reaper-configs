--[[
	Noindex: true
]]  
reaper.Undo_BeginBlock()
-- window = "tcp" -- when commented affects regions, otherwise tracks
mega_ignore = true
disable_doubleclick = true

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "lkc_grimsync_structure_manager.lua") 
reaper.Undo_EndBlock("LKC - GrimSync - Region Structure - Toggle region ignore", -1)
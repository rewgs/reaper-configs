--[[
	Noindex: true
]]  
reaper.Undo_BeginBlock()
container_prefix = ""
container_type = ""
color_id = 6

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "lkc_grimsync_structure_manager.lua") 
reaper.Undo_EndBlock("LKC - GrimSync - Region Structure - Set basic region", -1)
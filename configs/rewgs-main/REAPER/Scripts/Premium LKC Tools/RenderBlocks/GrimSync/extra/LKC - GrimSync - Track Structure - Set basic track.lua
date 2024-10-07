--[[
	Noindex: true
]]  
reaper.Undo_BeginBlock()
window = "tcp"
container_prefix = ""
container_type = ""
remove_track_icon = true
color_id = 6

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "lkc_grimsync_structure_manager.lua") 
reaper.Undo_EndBlock("LKC - GrimSync - Track Structure - Set basic track", -1)
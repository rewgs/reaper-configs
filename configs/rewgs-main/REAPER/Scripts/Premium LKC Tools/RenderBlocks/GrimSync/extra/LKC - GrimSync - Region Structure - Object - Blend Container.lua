--[[
	Noindex: true
]]  
reaper.Undo_BeginBlock()
container_prefix = "[b]"
container_type = "Blend Container"
color_id = 5

platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform == "Other" then
	separator = [[/]]
else
	separator = [[\]]	--win
end

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "lkc_grimsync_structure_manager.lua") 
reaper.Undo_EndBlock("LKC - GrimSync - Region Structure - Object - Blend Container", -1)

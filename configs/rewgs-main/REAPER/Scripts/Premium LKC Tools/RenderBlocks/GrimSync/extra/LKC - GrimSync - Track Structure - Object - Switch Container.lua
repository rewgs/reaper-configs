--[[
	Noindex: true
]]  
reaper.Undo_BeginBlock()
window = "tcp"
container_prefix = "[sw]"
container_type = "Switch Container"
color_id = 1

reaper.PreventUIRefresh(1)
-- reaper.Main_OnCommand(41110,0) -- select track under mouse

platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform == "Other" then
	separator = [[/]]
else
	separator = [[\]]	--win
end

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path .. "lkc_grimsync_structure_manager.lua") 
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
reaper.Undo_EndBlock("LKC - GrimSync - Track Structure - Object - Switch Container", -1)
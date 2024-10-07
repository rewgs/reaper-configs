--[[
	Noindex: true
]]  
function Msg(param)
	reaper.ShowConsoleMsg(tostring(param).."\n")
end

--loadfile changename
--OS INFO
platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform == "Other" then
	separator = [[/]]
else
	separator = [[\]]	--win
end

--SCRIPT PATH
local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
loadfile(script_path.."lkc_grimsync_metaobject_functions.lua")() --UCITAVANJE METAOBJECT TABLE-a

reaper.Undo_BeginBlock()
local cursor_pos = reaper.GetCursorPosition()
local marker_index, region_index = reaper.GetLastMarkerAndCurRegion( 0, cursor_pos )
local retval, isrgn, pos, rgnend, name, markrgnindexnumber, color = reaper.EnumProjectMarkers3( 0, region_index )
if isrgn then
	local final_name = META_OBJECT.change_name(name)
	reaper.SetProjectMarker3( 0, markrgnindexnumber, isrgn, pos, rgnend, final_name,color )
end
reaper.Undo_EndBlock("LKC - GrimSync - Region Structure - Rename region", -1)

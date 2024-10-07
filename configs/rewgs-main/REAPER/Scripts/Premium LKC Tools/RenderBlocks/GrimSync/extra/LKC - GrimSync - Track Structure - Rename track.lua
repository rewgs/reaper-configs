--[[
	Noindex: true
]]  
function Msg(param)
	reaper.ShowConsoleMsg(tostring(param).."\n")
end
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

--DO
reaper.Undo_BeginBlock()
local track = reaper.GetSelectedTrack(0, 0)
if track then
	retval, track_name = reaper.GetTrackName( track, "" )
	new_track_name = META_OBJECT.change_name(track_name)
	-- Msg(new_track_name)
	retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( track, "P_NAME", new_track_name, true ) 
end
reaper.Undo_EndBlock("LKC - GrimSync - Track Structure - Rename track", -1)
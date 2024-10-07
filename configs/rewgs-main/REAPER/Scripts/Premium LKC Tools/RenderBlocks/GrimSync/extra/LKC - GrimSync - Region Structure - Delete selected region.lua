--[[
	Noindex: true
]]  
function Msg(param)
	reaper.ShowConsoleMsg(tostring(param).."\n")
end

reaper.Undo_BeginBlock()
-- window, segment, details = reaper.BR_GetMouseCursorContext() --disabled for now

if window == "arrange" then --do not use mouse cursor for changing region if toolbar is active
	reaper.PreventUIRefresh(1)
	reaper.Main_OnCommand(reaper.NamedCommandLookup("_BR_SAVE_CURSOR_POS_SLOT_1"),0) --SWS/BR: Save edit cursor position, slot1
	reaper.Main_OnCommand(40514,0)--move edit cursor to mouse cursor
end


local cursor_pos = reaper.GetCursorPosition()
local marker_index, region_index = reaper.GetLastMarkerAndCurRegion( 0, cursor_pos )
local retval, isrgn, pos, rgnend, name, markrgnindexnumber, color = reaper.EnumProjectMarkers3( 0, region_index )
if isrgn then
	reaper.DeleteProjectMarker( 0,markrgnindexnumber, true )
end
if window == "arrange" then
	reaper.Main_OnCommand(reaper.NamedCommandLookup("_BR_RESTORE_CURSOR_POS_SLOT_1"),0) --SWS/BR: restore edit cursor position, slot1
	reaper.PreventUIRefresh(-1)
end
reaper.Undo_EndBlock("LKC - GrimSync - Region Structure - Delete selected region", -1)	--mouse cursor context info
--[[
	Noindex: true
]]
reaper.Undo_BeginBlock()
count = reaper.CountSelectedTracks( 0 )
for i = 0, count - 1 do
	local track = reaper.GetSelectedTrack( 0, i)
	if track ~= nil then
		local retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( track, "P_NAME", "", true )
		reaper.Main_OnCommand(40900,0) -- remove icon
	end
end
-- reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWSAUTOCOLOR_APPLY"),0) --SWS: Apply auto coloring
reaper.Undo_EndBlock("LKC - GrimSync - Track Structure - Delete selected track name", -1)
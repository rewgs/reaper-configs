-- (C) 2019, Dominik Martin Drzic

------------------------------------------------------------------------------------------------------------------------
-- Globals -------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local g_ignore_muted_sends   = false -- if set to true this will ignore muted sends    when g_include_sends    = true
local g_ignore_mute_receives = false -- if set to true this will ignore muted receives when g_include_receives = true

------------------------------------------------------------------------------------------------------------------------
-- Globals Internal ----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local g_allSends    = {}
local g_allReceives = {}

local g_include_folder_parents = false
local g_include_receives       = false
local g_include_sends          = false
local g_reset_slot             = false

------------------------------------------------------------------------------------------------------------------------
-- Misc functions ------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local function AreOverlapped (start1, end1, start2, end2)
	if start1 > end1 then start1, end1 = end1, start1 end
	if start2 > end2 then start2, end2 = end2, start2 end
	return (start1 < end2 and start2 < end1)
end

local function GetMediaTrackByGUID (proj, guid)
	for i = 0, reaper.CountTracks(proj)-1 do
		local _, currentGuid = reaper.GetSetMediaTrackInfo_String(reaper.GetTrack(proj, i), "GUID", 0, 0)
		if currentGuid == guid then
			return reaper.GetTrack(proj, i)
		end
	end
	return nil
end

local function SaveSelectedTrackToTable (table)
	for i = 0, reaper.CountSelectedTracks2(0, false)-1 do
		table[i+1] = reaper.GetSelectedTrack2(0, i, false)
	end
end

local function RestoreSelectedTracks (selectedTracksTable)
	for i = 0, reaper.CountTracks(0)-1 do reaper.SetMediaTrackInfo_Value(reaper.GetTrack(0, i), "I_SELECTED", 0) end
	for _, track in ipairs(selectedTracksTable) do
		if reaper.GetMediaTrackInfo_Value(track, "B_SHOWINTCP") > 0 or reaper.GetMediaTrackInfo_Value(track, "B_SHOWINMIXER") > 0 then
			reaper.SetTrackSelected(track, true)
		end
	end
end

local function GetAllTrackSendsRecursivelyInternal (track, ignoreMutedSends)
	for i = 0, reaper.GetTrackNumSends(track, 0)-1 do
		local sendTrack = reaper.BR_GetMediaTrackSendInfo_Track(track, 0, i, 1)
		if ignoreMutedSends == false or (ignoreMutedSends == true and reaper.GetTrackSendInfo_Value(track, 0, i, "B_MUTE") == 0) then
			if g_allSends[sendTrack] == nil then
				g_allSends[sendTrack] = sendTrack
				local thisTrackSends = GetAllTrackSendsRecursivelyInternal(sendTrack, ignoreMutedSends)
				for i, currentTrack in pairs(thisTrackSends) do
					if currentTrack ~= nil then
						g_allSends[currentTrack] = currentTrack
					end
				end
			end
		end
	end
	return g_allSends
end

local function GetAllTrackReceivesRecursivelyInternal (track, ignoreMutedReceives)
	for i = 0, reaper.GetTrackNumSends(track, -1)-1 do
		local receiveTrack = reaper.BR_GetMediaTrackSendInfo_Track(track, -1, i, 0)
		if ignoreMutedReceives == false or (ignoreMutedReceives == true and reaper.GetTrackSendInfo_Value(track, -1, i, "B_MUTE") == 0) then
			if g_allReceives[receiveTrack] == nil then
				g_allReceives[receiveTrack] = receiveTrack
				local thisTrackReceives = GetAllTrackReceivesRecursivelyInternal(receiveTrack, ignoreMutedReceives)
				for i, currentTrack in pairs(thisTrackReceives) do
					if currentTrack ~= nil then
						g_allReceives[currentTrack] = currentTrack
					end
				end
			end
		end
	end
	return g_allReceives
end

local function GetAllTrackSendsRecursively (track, ignoreMutedSends)
	g_allSends = {}
	g_allSends = GetAllTrackSendsRecursivelyInternal(track, ignoreMutedSends)

	local allSends = {}
	for i, currentTrack in pairs(g_allSends) do
		if currentTrack ~= nil then
			allSends[currentTrack] = currentTrack
		end
	end
	g_allSends = {}
	return allSends
end

local function GetAllTrackReceivesRecursively (track, ignoreMutedReceives)
	g_allReceives = {}
	g_allReceives = GetAllTrackReceivesRecursivelyInternal(track, ignoreMutedReceives)

	local allReceives = {}
	for i, currentTrack in pairs(g_allReceives) do
		if currentTrack ~= nil then
			allReceives[currentTrack] = currentTrack
		end
	end
	g_allReceives = {}
	return allReceives
end

------------------------------------------------------------------------------------------------------------------------
-- Track visibility Functions ------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local function ShowTracksHideOthers (undoMsg, doTcp, doMcp, doSelectedTracks, doTracksWithItems, doTracksWithSelectedItems, doTracksWithItemsInTS, doTracksWithSelectedItemsInTS, doTracksWithItemsAtCursor, doTracksWithSelectedItemsAtCursor)

	if reaper.HasExtState("BR_PRIVATE_TRACK_VIS_SHOW__OPTIONS", "SHOW_PARENT_TRACKS")  == true then g_include_folder_parents = true end
	if reaper.HasExtState("BR_PRIVATE_TRACK_VIS_SHOW__OPTIONS", "SHOW_RECEIVE_TRACKS") == true then g_include_receives       = true end
	if reaper.HasExtState("BR_PRIVATE_TRACK_VIS_SHOW__OPTIONS", "SHOW_SEND_TRACKS")    == true then g_include_sends          = true end

	-- Get new visibility status for tracks
	local allTracksNewVisStatus = {}
	for i = 0, reaper.CountTracks(0)-1 do

		-- Hide track by default
		local newVisibility = 0
		local track         = reaper.GetTrack(0, i)

		-- Check if track is selected
		if doSelectedTracks == true and newVisibility == 0 then
			if reaper.GetMediaTrackInfo_Value(track, "I_SELECTED") > 0 then
				newVisibility = 1
			end
		end

		-- Check if track has items
		if doTracksWithItems == true and newVisibility == 0 then
			if reaper.CountTrackMediaItems(track) > 0 then
				newVisibility = 1
			end
		end

		-- Check if track has selected items
		if doTracksWithSelectedItems == true and newVisibility == 0 then
			for i = 0, reaper.CountTrackMediaItems(track)-1 do
				if reaper.GetMediaItemInfo_Value(reaper.GetTrackMediaItem(track, i), "B_UISEL") > 0 then
					newVisibility = 1
					break
				end
			end
		end

		-- Check if track has items in time selection
		if doTracksWithItemsInTS == true and newVisibility == 0 then
			local timeSel = false
			local timeSelStart, timeSelEnd = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
			if timeSelStart ~= timeSelEnd then
				for i = 0, reaper.CountTrackMediaItems(track)-1 do
					local item = reaper.GetTrackMediaItem(track, i)
					local itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
					local itemEnd   = reaper.GetMediaItemInfo_Value(item, "D_LENGTH") + itemStart
					if AreOverlapped(itemStart, itemEnd, timeSelStart, timeSelEnd) then
						newVisibility = 1
						break
					end
				end
			end
		end

		-- Check if track has selected items in time selection
		if doTracksWithSelectedItemsInTS == true and newVisibility == 0 then
			local timeSel = false
			local timeSelStart, timeSelEnd = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
			if timeSelStart ~= timeSelEnd then
				for i = 0, reaper.CountTrackMediaItems(track)-1 do
					local item = reaper.GetTrackMediaItem(track, i)
					if reaper.GetMediaItemInfo_Value(item, "B_UISEL") > 0 then
						local itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
						local itemEnd   = reaper.GetMediaItemInfo_Value(item, "D_LENGTH") + itemStart
						if AreOverlapped(itemStart, itemEnd, timeSelStart, timeSelEnd) then
							newVisibility = 1
							break
						end
					end
				end
			end
		end

		-- Check if track has items at edit cursor
		if doTracksWithItemsAtCursor == true and newVisibility == 0 then
			local editCursor = reaper.GetCursorPosition()
			for i = 0, reaper.CountTrackMediaItems(track)-1 do
				local item = reaper.GetTrackMediaItem(track, i)
				local itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
				local itemEnd   = reaper.GetMediaItemInfo_Value(item, "D_LENGTH") + itemStart
				if editCursor >= itemStart and editCursor < itemEnd then      -- show if edit cursor is exactly at item start, but don't show if exactly at item end!
					newVisibility = 1
					break
				end
			end
		end

		-- Check if track has selected items at edit cursor
		if doTracksWithSelectedItemsAtCursor == true and newVisibility == 0 then
			local editCursor = reaper.GetCursorPosition()
			for i = 0, reaper.CountTrackMediaItems(track)-1 do
				local item = reaper.GetTrackMediaItem(track, i)
				if reaper.GetMediaItemInfo_Value(item, "B_UISEL") > 0 then
					local itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
					local itemEnd   = reaper.GetMediaItemInfo_Value(item, "D_LENGTH") + itemStart
					if editCursor >= itemStart and editCursor < itemEnd  then -- show if edit cursor is exactly at item start, but don't show if exactly at item end!
						newVisibility = 1
						break
					end
				end
			end
		end

		allTracksNewVisStatus[#allTracksNewVisStatus + 1] = {}
		allTracksNewVisStatus[#allTracksNewVisStatus].track         = track
		allTracksNewVisStatus[#allTracksNewVisStatus].tcpVisibility = newVisibility
		allTracksNewVisStatus[#allTracksNewVisStatus].mcpVisibility = newVisibility
	end

	-- Correct sends/receives and folder parents visibility according to option
	if g_include_sends == true or g_include_receives == true or g_include_folder_parents == true then

		if g_include_sends == true then
			for i, track in ipairs(allTracksNewVisStatus) do
				if track.mcpVisibility == 1 then
					local allSends = GetAllTrackSendsRecursively(track.track, g_ignore_muted_sends)
					for i, currentTrack in pairs(allSends) do
						local id = reaper.CSurf_TrackToID(currentTrack, false)
						allTracksNewVisStatus[id].mcpVisibility = 1
						allTracksNewVisStatus[id].tcpVisibility = 1
					end
				end
			end
		end
		if g_include_receives == true then
			for i, track in ipairs(allTracksNewVisStatus) do
				if track.mcpVisibility == 1 then
					local allReceives = GetAllTrackReceivesRecursively(track.track, g_ignore_mute_receives)
					for i, currentTrack in pairs(allReceives) do
						local id = reaper.CSurf_TrackToID(currentTrack, false)
						allTracksNewVisStatus[id].mcpVisibility = 1
						allTracksNewVisStatus[id].tcpVisibility = 1
					end
				end
			end
		end
		if g_include_folder_parents == true then
			for i, track in ipairs(allTracksNewVisStatus) do
				if track.mcpVisibility == 1 then

					if reaper.GetParentTrack(track.track) ~= nil then
						local parentTrack = reaper.GetParentTrack(track.track)
						while parentTrack ~= nil do
							local id = reaper.CSurf_TrackToID(parentTrack, false)
							allTracksNewVisStatus[id].mcpVisibility = 1
							allTracksNewVisStatus[id].tcpVisibility = 1
							parentTrack = reaper.GetParentTrack(parentTrack)
						end
					end
				end
			end
		end
	end

	-- Hide or show tracks
	reaper.PreventUIRefresh(1)

	local doUndo = false
	for i, track in ipairs(allTracksNewVisStatus) do
		if doTcp == true then
			if track.tcpVisibility ~= reaper.GetMediaTrackInfo_Value(track.track, "B_SHOWINTCP") then
				if doUndo == false then
					doUndo = true
					if undoMsg ~= "" and undoMsg ~= nil then
						reaper.Undo_BeginBlock()
					end
				end
				reaper.SetMediaTrackInfo_Value(track.track, "B_SHOWINTCP", track.tcpVisibility)
				if track.tcpVisibility == 0 and reaper.GetMediaTrackInfo_Value(track.track, "I_SELECTED") > 0 then
					reaper.SetMediaTrackInfo_Value(track.track, "I_SELECTED", 0)
				end
			end
		end
		if doMcp == true then
			if track.mcpVisibility ~= reaper.GetMediaTrackInfo_Value(track.track, "B_SHOWINMIXER") then
				if doUndo == false then
					doUndo = true
					if undoMsg ~= "" and undoMsg ~= nil then
						reaper.Undo_BeginBlock()
					end
				end
				reaper.SetMediaTrackInfo_Value(track.track, "B_SHOWINMIXER", track.mcpVisibility)
				if track.mcpVisibility == 0 and reaper.GetMediaTrackInfo_Value(track.track, "I_SELECTED") > 0 then
					reaper.SetMediaTrackInfo_Value(track.track, "I_SELECTED", 0)
				end
			end
		end
	end

	reaper.PreventUIRefresh(-1)
	reaper.TrackList_AdjustWindows(false)
	reaper.Main_OnCommand(reaper.NamedCommandLookup("_RS566d1ae25a9f5dc826f6d5cd61b0d1ef8e69de19"), 0) -- Script: Layout - Set layout actions toggle state (run on project startup).lua
	if doUndo == true then
		if undoMsg ~= "" and undoMsg ~= nil then
			reaper.Undo_EndBlock(undoMsg, -1)
		end
	end
	return doUndo
end

local function ShowAllTracks (undoMsg, doTcp, doMcp)

	-- Get new visibility status for tracks
	local allTracksNewVisStatus = {}
	local doUndo = false
	for i = 0, reaper.CountTracks(0)-1 do

		-- Show track by default
		local tcpVisibility = 1
		local mcpVisibility = 1
		local track         = reaper.GetTrack(0, i)

		allTracksNewVisStatus[#allTracksNewVisStatus + 1] = {}
		allTracksNewVisStatus[#allTracksNewVisStatus].track         = track
		allTracksNewVisStatus[#allTracksNewVisStatus].tcpVisibility = tcpVisibility
		allTracksNewVisStatus[#allTracksNewVisStatus].mcpVisibility = mcpVisibility
	end

	-- Show tracks
	reaper.PreventUIRefresh(1)

	local processed = false
	for i, track in ipairs(allTracksNewVisStatus) do
		if doTcp == true then
			if track.tcpVisibility ~= reaper.GetMediaTrackInfo_Value(track.track, "B_SHOWINTCP") then
				if doUndo == false then
					doUndo = true
					if undoMsg ~= "" and undoMsg ~= nil then
						reaper.Undo_BeginBlock()
					end
				end
				reaper.SetMediaTrackInfo_Value(track.track, "B_SHOWINTCP", track.tcpVisibility)
				if track.tcpVisibility == 0 and reaper.GetMediaTrackInfo_Value(track.track, "I_SELECTED") > 0 then
					reaper.SetMediaTrackInfo_Value(track.track, "I_SELECTED", 0)
				end
			end
		end
		if doMcp == true then
			if track.mcpVisibility ~= reaper.GetMediaTrackInfo_Value(track.track, "B_SHOWINMIXER") then
				if doUndo == false then
					doUndo = true
					if undoMsg ~= "" and undoMsg ~= nil then
						reaper.Undo_BeginBlock()
					end
				end
				reaper.SetMediaTrackInfo_Value(track.track, "B_SHOWINMIXER", track.mcpVisibility)
				if track.mcpVisibility == 0 and reaper.GetMediaTrackInfo_Value(track.track, "I_SELECTED") > 0 then
					reaper.SetMediaTrackInfo_Value(track.track, "I_SELECTED", 0)
				end
			end
		end
	end

	reaper.PreventUIRefresh(-1)
	reaper.TrackList_AdjustWindows(false)
	reaper.Main_OnCommand(reaper.NamedCommandLookup("_RS566d1ae25a9f5dc826f6d5cd61b0d1ef8e69de19"), 0) -- Script: Layout - Set layout actions toggle state (run on project startup).lua
	if doUndo == true then
		if undoMsg ~= "" and undoMsg ~= nil then
			reaper.Undo_EndBlock(undoMsg, -1)
		end
	end
	return doUndo
end

local function SaveAllTracksVisibility (proj, slot)

	local returnValue = -1
	if reaper.CountTracks(0) > 0 and slot > 0 and (proj == 0 or reaper.ValidatePtr(proj, "ReaProject*")) then

		-- Prepare ext state data
		local extNameTcp  = "BR_PRIVATE_TRACK_VIS_TCP_ALL_TRACKS_VIS_" .. string.format("%02d", slot)
		local extNameMcp  = "BR_PRIVATE_TRACK_VIS_MCP_ALL_TRACKS_VIS_" .. string.format("%02d", slot)
		local extNameData = "BR_PRIVATE_TRACK_VIS_DAT_ALL_TRACKS_VIS_" .. string.format("%02d", slot)
		if reaper.HasExtState("BR_PRIVATE_TRACK_VIS_SHOW__OPTIONS", "RESET_ALL_VIS_ON_ALL_VIS_HIDDEN") == true then
			g_reset_slot = true
		end

		reaper.SetProjExtState(proj, extNameTcp,  "", "")
		reaper.SetProjExtState(proj, extNameMcp,  "", "")
		reaper.SetProjExtState(proj, extNameData, "", "")

		-- Go through all tracks and save visible tracks to ext state
		reaper.Undo_BeginBlock()
		local allVisible     = true
		local allHidden      = true
		local visibilitySame = true
		for i = 0, reaper.CountTracks(0)-1 do
			local track = reaper.GetTrack(0, i)
			local trackGuid = reaper.GetTrackGUID(track)

			local tcpVisibility = reaper.GetMediaTrackInfo_Value(track, "B_SHOWINTCP")
			local mcpVisibility = reaper.GetMediaTrackInfo_Value(track, "B_SHOWINMIXER")
			if tcpVisibility == 0 or mcpVisibility == 0 then allVisible = false end
			if tcpVisibility  > 0 or mcpVisibility  > 0 then allHidden  = false	end

			if tcpVisibility > 0 then reaper.SetProjExtState(proj, extNameTcp, tostring(trackGuid), "1") end
			if mcpVisibility > 0 then reaper.SetProjExtState(proj, extNameMcp, tostring(trackGuid), "1") end
			if tcpVisibility ~= mcpVisibility then
				visibilitySame = false
			end
		end

		-- Finish up
		if g_reset_slot == true and (allVisible == true or allHidden == true) then
			reaper.SetProjExtState(proj, extNameTcp,  "", "")
			reaper.SetProjExtState(proj, extNameMcp,  "", "")
			reaper.SetProjExtState(proj, extNameData, "", "")
			reaper.Undo_EndBlock("Reset all tracks visibility, slot " .. string.format("%02d", slot), 1)
			returnValue = 2
		else
			if visibilitySame == true then
				reaper.SetProjExtState(proj, extNameData, "ALL_SAME", "1")
			end
			reaper.Undo_EndBlock("Save all tracks visibility, slot " .. string.format("%02d", slot), 1)
			returnValue = 1
		end
	end
	return returnValue
end

local function RestoreAllTracksVisibility (proj, slot)

	local returnValue = -1
	if slot > 0 and (proj == 0 or reaper.ValidatePtr(proj, "ReaProject*")) then

		-- Prepare ext state data
		local extNameTcp  = "BR_PRIVATE_TRACK_VIS_TCP_ALL_TRACKS_VIS_" .. string.format("%02d", slot)
		local extNameMcp  = "BR_PRIVATE_TRACK_VIS_MCP_ALL_TRACKS_VIS_" .. string.format("%02d", slot)
		local extNameData = "BR_PRIVATE_TRACK_VIS_DAT_ALL_TRACKS_VIS_" .. string.format("%02d", slot)
		local savedTcpVisibility = {}
		local savedMcpVisibility = {}

		-- Build ext state data
		local foundValidExtState = false
		local i = 0
		while true do
			local extStateFound, guid, visibilityState = reaper.EnumProjExtState(proj, extNameTcp, i)
			i = i + 1
			if extStateFound == false then
				break
			else
				local track = GetMediaTrackByGUID(proj, guid)
				if track ~= nil and reaper.ValidatePtr(track, "MediaTrack*") and visibilityState == "1" then
					savedTcpVisibility[track] = true
					foundValidExtState =  true
				end
			end
		end
		local i = 0
		while true do
			local extStateFound, guid, visibilityState = reaper.EnumProjExtState(proj, extNameMcp, i)
			i = i + 1
			if extStateFound == false then
				break
			else
				local track = GetMediaTrackByGUID(proj, guid)
				if track ~= nil and reaper.ValidatePtr(track, "MediaTrack*") and visibilityState == "1" then
					savedMcpVisibility[track] = true
					foundValidExtState =  true
				end
			end
		end

		if foundValidExtState == false then
			reaper.Undo_BeginBlock()
			ShowAllTracks("", true, true)
			reaper.Undo_EndBlock("Restore all tracks visibility, slot " .. string.format("%02d", slot) .. " (show all tracks)", 1)
		else

			-- Begin
			local selectedTracks = {}
			SaveSelectedTrackToTable(selectedTracks)
			reaper.Undo_BeginBlock()
			reaper.PreventUIRefresh(1)

			-- Show/hide tracks
			if ({reaper.GetProjExtState(proj, extNameData, "ALL_SAME")})[2] == true then
				for i = 0, reaper.CountTracks(0)-1 do
					local track = reaper.GetTrack(0, i)
					if savedTcpVisibility[track] == true or savedMcpVisibility[track] == true then
						reaper.SetMediaTrackInfo_Value(track, "I_SELECTED", 1)
					else
						reaper.SetMediaTrackInfo_Value(track, "I_SELECTED", 0)
					end
				end
				ShowTracksHideOthers("", true, true, true, false, false, false, false, false, false)
			else
				for i = 0, reaper.CountTracks(0)-1 do
					local track = reaper.GetTrack(0, i)
					if savedTcpVisibility[track] == true then
						reaper.SetMediaTrackInfo_Value(track, "I_SELECTED", 1)
					else
						reaper.SetMediaTrackInfo_Value(track, "I_SELECTED", 0)
					end
				end
				ShowTracksHideOthers("", true, false, true, false, false, false, false, false, false)

				for i = 0, reaper.CountTracks(0)-1 do
					local track = reaper.GetTrack(0, i)
					if savedMcpVisibility[track] == true then
						reaper.SetMediaTrackInfo_Value(track, "I_SELECTED", 1)
					else
						reaper.SetMediaTrackInfo_Value(track, "I_SELECTED", 0)
					end
				end
				ShowTracksHideOthers("", false, true, true, false, false, false, false, false, false)
			end

			-- Finish up
			RestoreSelectedTracks(selectedTracks)
			reaper.PreventUIRefresh(-1)
			reaper.UpdateArrange()
			reaper.Undo_EndBlock("Restore all tracks visibility, slot " .. string.format("%02d", slot), 1)
		end
	end
	return returnValue
end
------------------------------------------------------------------------------------------------------------------------
-- Module export -------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local moduleExport = {}
moduleExport.ShowTracksHideOthers       = ShowTracksHideOthers
moduleExport.ShowAllTracks              = ShowAllTracks
moduleExport.SaveAllTracksVisibility    = SaveAllTracksVisibility
moduleExport.RestoreAllTracksVisibility = RestoreAllTracksVisibility
return moduleExport
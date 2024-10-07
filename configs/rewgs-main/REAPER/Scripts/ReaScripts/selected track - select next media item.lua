-- select_next_media_item_on_selected_track
-- key binding: w (like vim, moving forward by word)
-- will also do select_previous_media_item_on_selected_track (key binding: b)
-- would also like to do W and B for maybe selected phrases? Somehow?

num_tracks = reaper.GetNumTracks()
-- reaper.ShowConsoleMsg("DEBUG: Number of tracks: "..num_tracks.."\n")

num_selected_tracks = reaper.CountSelectedTracks(0)
-- reaper.ShowConsoleMsg("DEBUG: Number of selected tracks: "..num_selected_tracks.."\n")

if num_selected_tracks > 0 then
    -- Instead of below, try GetSetMediaItemInfo_String() and/or 
    -- GetSetMediaTrackInfo_String()?

    selected_track = reaper.GetSelectedTrack(0, 0)
    num_media_items = reaper.CountTrackMediaItems(selected_track)
    -- reaper.ShowConsoleMsg("DEBUG: number of media items on selected track: "..num_media_items)

    --[[
    TODO: this doesn't work
    --]]
    selected_media_item = reaper.GetSelectedMediaItem(0, 0)
    reaper.ShowConsoleMsg(type(selected_media_item))    -- not sure what to do with `userdata` type
    -- reaper.SetMediaItemSelected(incr(selected_media_item))
end
track = reaper.GetSelectedTrack(0, 0)

number = reaper.GetMediaTrackInfo_Value(track, "I_SOLO")

reaper.Main_OnCommand(40340, 0) -- unsolo all tracks


reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 1)



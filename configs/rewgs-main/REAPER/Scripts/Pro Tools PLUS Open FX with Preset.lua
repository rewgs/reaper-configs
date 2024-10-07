item =  reaper.GetSelectedMediaItem(0,0)

MediaItem_Take = reaper.GetTake(item, 0)
  
reaper.TakeFX_AddByName(MediaItem_Take, "ReaEQ", 1)

reaper.TakeFX_SetPreset(MediaItem_Take, 0, "MyPreset")

reaper.TakeFX_Show(MediaItem_Take, 0, 1)

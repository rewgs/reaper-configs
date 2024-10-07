track = reaper.GetSelectedTrack(0, 0)

reaper.Main_OnCommand(40289, 0) --unselect all

reaper.Main_OnCommand(40528, 0) --select item under mouse cursor

items = reaper.CountSelectedMediaItems(0)

if items > 0 then

reaper.Main_OnCommand(40693, 0) --toggle take volume env

reaper.Main_OnCommand(40513, 0) --move edit cursor to mouse cursor

reaper.Main_OnCommand(40289, 0) --unselect all

else


i=0
govisible=0
reaper.Main_OnCommand(40406, 0) --toggle visible
  
  reaper.Main_OnCommand(40297, 0) --unselect all
    
    reaper.SetTrackSelected(track, true)
    
    --reaper.Main_OnCommand(40913, 0) --zoom in on original track


end


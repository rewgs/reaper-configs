reaper.Undo_BeginBlock()



reaper.Main_OnCommand(40513, 0) --move edit cursor to mouse cursor
    reaper.Main_OnCommand(40528, 0) --select item under mouse cursor

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end

if group==0 then

  reaper.Main_OnCommand(41051, 0) --reserve take
  reaper.Main_OnCommand(40289, 0) --unselect items

else

  
    reaper.Main_OnCommand(40034, 0) -- select all in group
    reaper.Main_OnCommand(41051, 0) --reserve take
    
    reaper.Main_OnCommand(40289, 0) --unselect items
  
 
  
  

end

reaper.Undo_EndBlock("Reserve", 0)

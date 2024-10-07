reaper.Undo_BeginBlock()

startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)

if startOut==endOut then
reaper.Main_OnCommand(40289, 0) --unselect all

reaper.Main_OnCommand(40513, 0) --move edit cursor to mouse cursor

pos = reaper.GetCursorPosition()

reaper.Main_OnCommand(40528, 0) --select item under mouse cursor

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then

group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")

if group==0 then

  x = reaper.CountSelectedMediaItems(0)
  
  if x>0 then
  
    item = reaper.GetSelectedMediaItem(0, 0)
  
    reaper.SplitMediaItem(item, pos)
  
  end

else
  
  reaper.Main_OnCommand(40759, 0) --split and select right
            
  
end

  reaper.Main_OnCommand(40289, 0) --unselect all

end

else
x = reaper.CountSelectedMediaItems(0)
i=0
while i<x do
  item = reaper.GetSelectedMediaItem(0, i)
  startpos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  endpos = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  if startpos > startOut and startpos < endOut then
    if x>0 then
      command = reaper.NamedCommandLookup("_S&M_SPLIT2")
      reaper.Main_OnCommand(command, 0)
    end
    break  
  end
  if (startpos+endpos)<endOut and (startpos+endpos)>startOut then
    if x>0 then
          command = reaper.NamedCommandLookup("_S&M_SPLIT2")
          reaper.Main_OnCommand(command, 0)
        end
        break  
  end
  if startpos < startOut and (startpos+endpos)>endOut then
    if x>0 then
              command = reaper.NamedCommandLookup("_S&M_SPLIT2")
              reaper.Main_OnCommand(command, 0)
            end
            break  
  end
i=i+1
end

reaper.Main_OnCommand(40289, 0) --unselect all
reaper.GetSet_LoopTimeRange(true, true, 0, 0, false)

end

reaper.Undo_EndBlock("B Shortcut", 0)

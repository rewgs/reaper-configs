startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)

if startOut==endOut then

reaper.Main_OnCommand(40289, 0) --unselect all
command = reaper.NamedCommandLookup("_XENAKIOS_SELITEMSUNDEDCURSELTX")
    reaper.Main_OnCommand(command, 0)

x = reaper.CountSelectedMediaItems(0)
if x>0 then
reaper.Main_OnCommand(40757, 0)  --split items at edit cursor
end

reaper.Main_OnCommand(40289, 0) --unselect all

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

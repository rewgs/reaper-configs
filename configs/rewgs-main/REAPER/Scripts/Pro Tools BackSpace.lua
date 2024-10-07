
startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end

if group==0 then

if startOut==endOut then
x = reaper.CountSelectedMediaItems(0)

if x>0 then
  reaper.Main_OnCommand(40006, 0) --delete items
end

  reaper.Main_OnCommand(40289, 0) --unselect all
else
reaper.Undo_BeginBlock()
x = reaper.CountSelectedMediaItems(0)
if x>0 then
  reaper.Main_OnCommand(40312, 0) --remove selected area of items
end
reaper.Main_OnCommand(40289, 0) --unselect all
--reaper.Undo_EndBlock("Ctrl+X Pro Tools Cut", 0)
--reaper.Undo_BeginBlock()
reaper.GetSet_LoopTimeRange(true, true, startOut, endOut, false)
reaper.Undo_EndBlock("Ctrl+X Pro Tools Cut", 0)
reaper.Main_OnCommand(40635, 0)--remove time selection

end

else

if startOut==endOut then

reaper.Main_OnCommand(40034, 0) -- select all in group

reaper.Main_OnCommand(40059, 0) --cut itmes ignoring time selection

reaper.Main_OnCommand(40635, 0) --remove time selection

else
reaper.Undo_BeginBlock()
reaper.Main_OnCommand(40034, 0) -- select all in group
x = reaper.CountSelectedMediaItems(0)
if x>0 then
  reaper.Main_OnCommand(40312, 0) --remove selected area of items
end
--reaper.Main_OnCommand(40032, 0) -- group items
reaper.Main_OnCommand(40289, 0) --unselect all
reaper.GetSet_LoopTimeRange(true, true, startOut, endOut, false)
reaper.Undo_EndBlock("Ctrl+X Pro Tools Cut", 0)
reaper.Main_OnCommand(40635, 0)--remove time selection
end

end


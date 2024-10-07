reaper.Undo_BeginBlock()

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end

if group~=0 then

reaper.Main_OnCommand(40034, 0) -- select all in group

end

reaper.Main_OnCommand(40697, 0) --remove items based on focus
reaper.Main_OnCommand(40289, 0) --unselect all items
reaper.Main_OnCommand(40635, 0) --remove time selection


reaper.Undo_EndBlock("Delete Pro Tools PLLUS", 0)

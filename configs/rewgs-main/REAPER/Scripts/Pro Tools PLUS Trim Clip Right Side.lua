reaper.Undo_BeginBlock()

commandID = reaper.NamedCommandLookup("_WOL_SETVZOOMC_LASTSELTRACK")
                                                         
reaper.Main_OnCommand(40513, 0) --move edit cursor to mouse cursor

reaper.Main_OnCommand(40528, 0) --select item under mouse cursor

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then

group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end
if group==0 then

  reaper.Main_OnCommand(41311, 0) --trim right

  reaper.Main_OnCommand(40289, 0) --unselect all items

else

  cursor = reaper.GetCursorPosition()
  
  reaper.Main_OnCommand(40759, 0) --split and select right
  
  reaper.Main_OnCommand(40697, 0) --delete

end

reaper.Undo_EndBlock("S Shortcut", 0)

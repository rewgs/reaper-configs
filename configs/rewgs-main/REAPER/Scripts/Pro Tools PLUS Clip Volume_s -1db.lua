reaper.Undo_BeginBlock()

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end

if group==0 then

  commandID = reaper.NamedCommandLookup("_XENAKIOS_NUDGEITEMVOLDOWN")
  
  reaper.Main_OnCommand(commandID, 0) --nudge volume +1db

else

  reaper.Main_OnCommand(40034, 0) -- select all in group
  
  commandID = reaper.NamedCommandLookup("_XENAKIOS_NUDGEITEMVOLDOWN")
    
    reaper.Main_OnCommand(commandID, 0) --nudge volume +1db

end

reaper.Undo_EndBlock("Volume -1db", 0)

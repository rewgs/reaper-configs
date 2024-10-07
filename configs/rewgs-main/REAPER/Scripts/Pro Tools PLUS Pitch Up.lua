reaper.Undo_BeginBlock()

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end

if group==0 then

  commandID = reaper.NamedCommandLookup("_XENAKIOS_NUDGEITEMPITCHUP")
      
      reaper.Main_OnCommand(commandID, 0) --pitch nudge down
      
      commandID = reaper.NamedCommandLookup("_SWS_ITEMCUSTCOL5")
            
            reaper.Main_OnCommand(commandID, 0) --color 5
      
      

else

  
    reaper.Main_OnCommand(40034, 0) -- select all in group
    commandID = reaper.NamedCommandLookup("_XENAKIOS_NUDGEITEMPITCHUP")
          
          reaper.Main_OnCommand(commandID, 0) --pitch nudge down
          
          commandID = reaper.NamedCommandLookup("_SWS_ITEMCUSTCOL5")
                
                reaper.Main_OnCommand(commandID, 0) --color 5
  
 
  
  

end

reaper.Undo_EndBlock("Pitch Up Pro Tools PLUS", 0)

reaper.Undo_BeginBlock()

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end

if group==0 then
      
      reaper.Main_OnCommand(40653, 0) --pitch default
            
            reaper.Main_OnCommand(40707, 0) --default color
      
      

else

  
    reaper.Main_OnCommand(40034, 0) -- select all in group
    
  
 reaper.Main_OnCommand(40653, 0) --pitch default
             
             reaper.Main_OnCommand(40707, 0) --default color
  
  

end

reaper.Undo_EndBlock("Pitch Back to Normal Pro Tools PLUS", 0)

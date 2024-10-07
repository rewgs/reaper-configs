state = reaper.HasExtState("playtoggle", "togglevalue")

if state then
  
  value = reaper.GetExtState("playtoggle", "togglevalue")
  
  if value == "1" then
      reaper.Main_OnCommand(40073, 0)  
  else
    state = reaper.HasExtState("playtoggle", "timelinetoggle")
        if state then
          value = reaper.GetExtState("playtoggle", "timelinetoggle")
          if value == "1" then
            startOut = reaper.GetExtState("playtoggle", "start")
            endOut = reaper.GetExtState("playtoggle", "end")
            startOut = tonumber(startOut)
            endOut = tonumber(endOut)
            reaper.GetSet_LoopTimeRange(true, true, startOut, endOut, false)
            reaper.SetEditCurPos(startOut, true, true)
            reaper.Main_OnCommand(40044, 0)
          else
            reaper.Main_OnCommand(40044, 0)  
          end
        else
          reaper.Main_OnCommand(40044, 0)  
        end
  end
else
  reaper.Main_OnCommand(40044, 0) 
  reaper.SetExtState("playtoggle", "togglevalue", "0", true)
end





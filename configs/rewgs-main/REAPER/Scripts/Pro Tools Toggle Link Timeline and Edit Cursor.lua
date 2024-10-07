state = reaper.HasExtState("playtoggle", "timelinetoggle")

if state then
  value = reaper.GetExtState("playtoggle", "timelinetoggle")
  if value == "1" then
    reaper.SetExtState("playtoggle", "timelinetoggle", "0", true)
  else
    startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)
    
    if startOut==nil then
      startOut=0
      endOut=0
    end
    
    if startOut==endOut then
      startOut = reaper.GetCursorPosition()
      endOut = startOut
    end
      startOut = tostring(startOut)
      endOut = tostring(endOut)
    reaper.SetExtState("playtoggle", "start", startOut, true)
    reaper.SetExtState("playtoggle", "end", endOut, true)
    reaper.SetExtState("playtoggle", "timelinetoggle", "1", true)
  end
else
  startOut = reaper.GetCursorPosition()
  startOut = tostring(startOut)
  endOut = startOut
  reaper.SetExtState("playtoggle", "start", startOut, true)
  reaper.SetExtState("playtoggle", "end", endOut, true)
  reaper.SetExtState("playtoggle", "timelinetoggle", "1", true)
end



startOut, endOut = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)

if startOut==endOut then

  reaper.Main_OnCommand(40421, 0)

else

  reaper.Main_OnCommand(40717, 0)

end

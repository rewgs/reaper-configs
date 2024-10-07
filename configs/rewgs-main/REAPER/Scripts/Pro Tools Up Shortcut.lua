play = reaper.GetPlayState()

if play==1 or play==5 then

  startOut, endOut = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  
  if startOut==endOut then
  
    startOut = reaper.GetCursorPosition()
    playpos = reaper.GetPlayPosition()
    reaper.SetEditCurPos(playpos, true, false)
    
    reaper.GetSet_LoopTimeRange(true, true, startOut, playpos, false)
  
  else
  
    playpos = reaper.GetPlayPosition()
    if playpos<startOut then
      reaper.SetEditCurPos(playpos, true, false)
      reaper.GetSet_LoopTimeRange(true, true, playpos, playpos, false)
    else
      reaper.SetEditCurPos(playpos, true, false)
      reaper.GetSet_LoopTimeRange(true, true, startOut, playpos, false)
    end
  end

end

play = reaper.GetPlayState()

if play==1 or play==5 then
  
  playpos = reaper.GetPlayPosition()
  reaper.SetEditCurPos(playpos, true, false)
  reaper.GetSet_LoopTimeRange(true, true, playpos, playpos, false)

end

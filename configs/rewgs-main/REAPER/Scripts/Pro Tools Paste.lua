

position = reaper.GetCursorPosition()

reaper.Main_OnCommand(40058, 0) --paste items/tracks

reaper.SetEditCurPos(position, true, false)


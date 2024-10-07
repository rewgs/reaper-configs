--[[
    Description: Set bar at cursor to X
    Version: 1.0.0
    Author: Thonex

]]--
 function MAIN ()
 
  reaper.PreventUIRefresh(1)
  reaper.ClearConsole() 
  reaper.Undo_BeginBlock()
  
  Cursor_Pos =  reaper.GetCursorPosition()
  retval, retvals_csv = reaper.GetUserInputs( "Bar Offset", 1, "Set bar start at cursor to: ", 1 )
  Bar_X = tonumber(retvals_csv)
  
  if Bar_X == nil or Bar_X ~= math.tointeger(Bar_X) then
    reaper.ShowMessageBox( "Please make sure you enter an integer number.", "Notice", 0 )
    return
  end
  
  retval, measures, cml, fullbeats, cdenom = reaper.TimeMap2_timeToBeats( 0, Cursor_Pos )


  reaper.SNM_SetIntConfigVar( "projmeasoffs", -1-measures+Bar_X) -- offset measures
  
  reaper.UpdateTimeline()
  reaper.PreventUIRefresh(-1) 
  reaper.Undo_EndBlock("Change Bar 1 offset",-1)
  

 end
 
 MAIN()

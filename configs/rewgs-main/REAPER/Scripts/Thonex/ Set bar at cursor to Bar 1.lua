--[[
    Description: Set bar at cursor to Bar 1
    Version: 1.0.0
    Author: Thonex

]]--
 function MAIN ()
  reaper.PreventUIRefresh(1)
  reaper.ClearConsole() 
  reaper.Undo_BeginBlock()
  
  Cursor_Pos =  reaper.GetCursorPosition()
  
  retval, measures, cml, fullbeats, cdenom = reaper.TimeMap2_timeToBeats( 0, Cursor_Pos )

  reaper.SNM_SetIntConfigVar( "projmeasoffs", 0-measures) -- offset measures
  
  reaper.UpdateTimeline()
  reaper.PreventUIRefresh(-1) 
  reaper.Undo_EndBlock("Change Bar 1 offset",-1)
  

 end
 
 MAIN()

--[[
    Description: Reset Bar numbers (bar 1 = first bar of project)
    Version: 1.0.0
    Author: Thonex

]]--
 function MAIN ()
  reaper.PreventUIRefresh(1)
  reaper.ClearConsole() 
  reaper.Undo_BeginBlock()
  
  Cursor_Pos =  reaper.GetCursorPosition()
  
  retval, measures, cml, fullbeats, cdenom = reaper.TimeMap2_timeToBeats( 0, 0 )
  
  reaper.SNM_SetIntConfigVar( "projmeasoffs", 0-measures) -- offset measures
  
  reaper.SetEditCurPos( Cursor_Pos, false, false )
  
  reaper.UpdateTimeline()
  reaper.PreventUIRefresh(-1) 
  reaper.Undo_EndBlock("Reset Bar numbers",-1)
  

 end
 
 MAIN()

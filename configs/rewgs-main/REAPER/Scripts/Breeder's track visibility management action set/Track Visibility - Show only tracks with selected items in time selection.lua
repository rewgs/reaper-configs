-- (C) 2019, Dominik Martin Drzic

-- Import track visibility module --------------------------------------------------------------------------------------
package.path = package.path .. ";" .. string.match(({reaper.get_action_context()})[2], "(.-)([^\\/]-%.?([^%.\\/]*))$") .. "?.lua"
local visTools = require "_trackVisibilityTools"

-- Main ----------------------------------------------------------------------------------------------------------------
function Main ()
	local timeSelStart, timeSelEnd = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
	if timeSelStart ~= timeSelEnd then
		visTools.ShowTracksHideOthers("Track Visibility - Show only tracks with selected items in time selection", true, true, false, false, false, false, true, false, false)
	end
end

Main()
function NoUndoPoint () end -- Makes sure there is no unnecessary undo point created, see more
reaper.defer(NoUndoPoint)   -- here: http://forum.cockos.com/showpost.php?p=1523953&postcount=67


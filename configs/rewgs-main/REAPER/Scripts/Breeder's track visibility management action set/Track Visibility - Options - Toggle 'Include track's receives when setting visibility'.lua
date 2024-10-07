-- (C) 2019, Dominik Martin Drzic

-- Import track visibility module --------------------------------------------------------------------------------------
package.path = package.path .. ";" .. string.match(({reaper.get_action_context()})[2], "(.-)([^\\/]-%.?([^%.\\/]*))$") .. "?.lua"
local visTools = require "_trackVisibilityTools"

-- Globals -------------------------------------------------------------------------------------------------------------
local g_extStateSection   = "BR_PRIVATE_TRACK_VIS_SHOW__OPTIONS"
local g_extStateKey       = "SHOW_RECEIVE_TRACKS"

-- Main ----------------------------------------------------------------------------------------------------------------
function Main ()

	local _, _, thisSection, thisCmd = reaper.get_action_context()

	local newState = 0
	if reaper.HasExtState(g_extStateSection, g_extStateKey) == false then
		newState = 1
		reaper.SetExtState(g_extStateSection, g_extStateKey, "1", true)
	else
		newState = 0
		reaper.DeleteExtState(g_extStateSection, g_extStateKey, true)
	end

	reaper.SetToggleCommandState(thisSection, thisCmd,  newState)
	reaper.RefreshToolbar2(thisSection, thisCmd)
end

Main()
function NoUndoPoint () end -- Makes sure there is no unnecessary undo point created, see more
reaper.defer(NoUndoPoint)   -- here: http://forum.cockos.com/showpost.php?p=1523953&postcount=67
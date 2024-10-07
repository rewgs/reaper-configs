--[[
   * ReaScript Name: Remove Bypassed FX
   * Author: Hector Corcin (HeDa)
   * Author URI: http://reaper.hector-corcin.com
   * Licence: Copyright © 2015-2016, Hector Corcin
   
	Removes all bypassed FX in project.

	Required: Reaper 5.0
	Required: SWS extensions for the remove FX function SNM_MoveOrRemoveTrackFX

--]]

-----------------------------------------------------------------
local OS = reaper.GetOS()
local mode="x64"
if OS == "Win32" or OS == "OSX32" then mode="x32" end
local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
resourcepath=reaper.GetResourcePath()
scripts_path=resourcepath.."/Scripts/"
hedascripts_path=scripts_path.."HeDaScripts/"
dofile(script_path .. "HRBFX" .. mode .. ".dat")
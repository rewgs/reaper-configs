--[[
   * ReaScript Name: Track Inspector
   * Author: Hector Corcin (HeDa)
   * Author URI: http://reaper.hector-corcin.com
   * Licence: Copyright © 2016-2019, Hector Corcin
]]


instance = 4  -- change to another number in a copy of this file to allow another instance
master_track = false -- (true or false) change to true to always start with master track
sectionname="HeDaTrackInspectorFloating"
open_at_mouse=true
open_at_mouse_position="_BR_MOVE_WINDOW_TO_MOUSE_H_R_V_M"

-----------------------------------------------------------------
local OS = reaper.GetOS()
local mode="x64"
if OS == "Win32" or OS == "OSX32" then mode="x32" end
local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
script_path2 = script_path:match("(.*) settings")
if script_path2 then 
	custom_instance=instance
	script_path=script_path2 .. "/"
end
resourcepath=reaper.GetResourcePath()
scripts_path=resourcepath.."/Scripts/"
hedascripts_path=scripts_path.."HeDaScripts/"
dofile(script_path .. "HTI" .. mode .. ".dat")
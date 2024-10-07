--[[
   * ReaScript Name: Track Inspector
   * Author: Hector Corcin (HeDa)
   * Author URI: http://reaper.hector-corcin.com
   * Licence: Copyright © 2016-2017, Hector Corcin
]]


instance = 2  -- change to another number in a copy of this file to allow another instance
master_track = true -- (true or false) change to true to always start with master track
sectionname="HeDaTrackInspectorMaster"

-----------------------------------------------------------------
local OS = reaper.GetOS()
local mode="x64"
if OS == "Win32" or OS == "OSX32" then mode="x32" end
local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
resourcepath=reaper.GetResourcePath()
scripts_path=resourcepath.."/Scripts/"
hedascripts_path=scripts_path.."HeDaScripts/"
dofile(script_path .. "HTI" .. mode .. ".dat")
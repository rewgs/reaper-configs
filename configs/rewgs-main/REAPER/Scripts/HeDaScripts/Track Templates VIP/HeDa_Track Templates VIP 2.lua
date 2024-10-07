--[[
   * ReaScript Name: HeDa Track Templates
   * Author: Hector Corcin (HeDa)
   * Author URI: https://reaper.hector-corcin.com
   * Licence: Copyright © 2017-2019, Hector Corcin
]]

-- OPTIONS
instance = 2  -- change instance to a different number and save it as a new lua file to get a new Track Templates window.
debuglog = 0 -- change to 1 to create a log file

-- Don't need to modify below here:-----------------------------------------------------------------
sectionname="HeDaTrackTemplates"
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
dofile(script_path .. "HTT" .. mode .. ".dat")
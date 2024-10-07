--[[
   * ReaScript Name: Regions & Markers from items
   * Lua script for Cockos REAPER
   * Author: Hector Corcin (HeDa)
   * Author URI: http://reaper.hector-corcin.com
   * Licence: Copyright © 2016, Hector Corcin
]]



local OS = reaper.GetOS()
local mode="x64"
if OS == "Win32" or OS == "OSX32" then mode="x32" end
local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
resourcepath=reaper.GetResourcePath()
scripts_path=resourcepath.."/Scripts/"
hedascripts_path=scripts_path.."HeDaScripts/"
dofile(script_path .. "HRFI" .. mode .. ".dat")
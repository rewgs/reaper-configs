--[[
   * ReaScript Name: Auto Solo Tracks of Selected Items
   * Author: Hector Corcin (HeDa)
   * Author URI: http://reaper.hector-corcin.com
   * Licence: Copyright © 2015-2016, Hector Corcin
]]


local OS = reaper.GetOS()
local mode="x64"
if OS == "Win32" or OS == "OSX32" then mode="x32" end
local info = debug.getinfo(1,'S');

script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
resourcepath=reaper.GetResourcePath()
scripts_path=resourcepath.."/Scripts/"
hedascripts_path=scripts_path.."HeDaScripts/"

script_path_settings=hedascripts_path.."Auto Solo Tracks of Selected Items settings/" 

dofile(script_path .. "HeDa_Auto Solo Tracks of Selected Items " .. mode .. ".dat")
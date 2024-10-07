--[[
   * ReaScript Name: HeDa Mixer
   * Author: Hector Corcin (HeDa)
   * Author URI: https://reaper.hector-corcin.com
   * Licence: Copyright © 2017-2019, Hector Corcin
]]



-- OPTIONS -------------------------------------------------------------------

-- change the instance to a unique string for additional script with its own window position and configuration
instance = "1"














-- Don't need to modify below here:-----------------------------------------------------------------
sectionname="HeDaMixerVIP"
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
dofile(script_path .. "HM" .. mode .. ".dat")
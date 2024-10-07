--[[
   * ReaScript Name: HeDa Region Tracks VIP
   * Author: Hector Corcin (HeDa)
   * Author URI: https://reaper.hector-corcin.com
   * Licence: Copyright © 2017, Hector Corcin
]]



-- OPTIONS -------------------------------------------------------------------

-- If you want to modify this lua file, copy it to the script "Region Tracks settings" folder and add it again to your actions in REAPER. 

















-- Don't need to modify below here:-----------------------------------------------------------------
sectionname="HeDaRegionTracks"
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
dofile(script_path .. "HRT" .. mode .. ".dat")
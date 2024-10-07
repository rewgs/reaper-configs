--[[
   * ReaScript Name: HeDa Render LUFS
   * Author: Hector Corcin (HeDa)
   * Author URI: https://reaper.hector-corcin.com
   * Licence: Copyright © 2017, Hector Corcin
]]



-- OPTIONS -------------------------------------------------------------------

-- If you want to modify this lua file, copy it to the "Render LUFS settings" folder and add it again to your actions in REAPER. 

--[[
 plugincfg you can add more lines for the name of the plugin you want and specify the range of the parameter you intend to use.
 range in dB is the range of the parameter you want to use if for example, it goes from -20 to +20, then it is 40. if it goes from 0 to -30 then it is 30.
 
 format of the line:
 ["name of plugin"] = {range of parameter in dB, direction},
 
 Direction is optional. It can be 1 or -1 but it should be detected automatically. If the script increases volume when it should be decreasing it , then reverse direction for that plugin.
 
--]]

plugincfg={
["JS: Volume/Pan Smoother v5 [Utility/volume_pan_sample_accurate_auto]"] = {72, 1},
["JS: Volume/Pan Smoother [Utility/volume_pan]"] = {72, 1},
["JS: MGA JS Limiter [LOSER/MGA_JSLimiter]"] = {30},
["JS: MGA JS Limiter (Unlinked Stereo) [LOSER/MGA_JSLimiterST]"] = {30},
["JS: Master Limiter [LOSER/masterLimiter]"] = {20},
["JS: Peak Limiter/Maximizer [LOSER/brickwall_maximizer]"] = {30},
["VST: Limiter No6 (Vladislav Goncharov)"] = {24},
}

















-- Don't need to modify below here:-----------------------------------------------------------------
sectionname="HeDaRenderLufs"
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
dofile(script_path .. "HRL" .. mode .. ".dat")
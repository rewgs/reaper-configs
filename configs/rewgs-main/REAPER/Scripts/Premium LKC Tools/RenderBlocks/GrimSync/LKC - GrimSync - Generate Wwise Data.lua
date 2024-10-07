--[[
	Noindex: true
]]  
reaper.Undo_BeginBlock()
-- generate_just_name_string is not defined for this script, but for autoname script it is
--OS INFO
platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform  == "Other" or platform == "macOS-arm64" then
    separator = [[/]]
else
    separator = [[\]]	--win
end

bin="x64"
if platform == "Win32" or platform == "OSX32" then bin="x86" end

luac = "53"
if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_grimsync_generate_data.dll]])
reaper.Undo_EndBlock("LKC - GrimSync - Generate Wwise Data", -1)
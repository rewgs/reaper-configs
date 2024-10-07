--[[
 Noindex: true
]]


--OS INFO
platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform  == "Other" or platform == "macOS-arm64" then
    separator = [[/]]
else
    separator = [[\]]     --win
end

bin="x64"
if platform == "Win32" or platform == "OSX32" then bin="x86" end

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]


luac = "53"
if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end


function Msg(param)
    reaper.ShowConsoleMsg(tostring(param).."\n")
end
reaper.ClearConsole()



-- timeout = 5
function Main() 
    -- GUI.func = nil
    os.remove(script_path .. [[bin\\GrimSync.log]])
    
    UpdateInfo("SYNC STARTED!")

    UpdateInfo("Generating JSON file...")

    script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
    dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_grimsync_generate_data.dll]])
    UpdateInfo("DONE\n\n")
    
    
    import_list  = io.open(script_path .. [[bin\\grim_audio_to_import.json]], "r")
    if import_list then
        UpdateInfo("Starting render proces...")
        -- script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
        -- dofile(script_path .. [[..]] .. separator.. "LKC - RenderBlocks - Render.lua")
        reaper.Main_OnCommand(reaper.NamedCommandLookup("_RSf32da68248e18f77d376da6d25c8e4b1ecb00efa"),0) -- RENDER
        UpdateInfo("DONE\n\n")


        UpdateInfo("Starting Wwise import process...")
        script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
        dofile(script_path .. "LKC - GrimSync - Import and create events.lua")
        
        
    else
        UpdateInfo("NO JSON, PROCESS FAILED!")
    end

end

function UpdateInfo(text)
	--Msg(text)
	-- local current = GUI.Val("TextEditor1")
	-- GUI.Val("TextEditor1", tostring(current).."\n"..text)
end






Main()

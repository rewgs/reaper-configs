--[[
 Noindex: true
]] function Msg(param) reaper.ShowConsoleMsg(tostring(param) .. "\n") end


-- OS INFO
platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform == "Other" or
    platform == "macOS-arm64" then
    separator = [[/]]
else
    separator = [[\]] -- win
end

bin = "x64"
if platform == "Win32" or platform == "OSX32" then bin = "x86" end
local info = debug.getinfo(1, 'S');
script_path = info.source:match [[^@?(.*[\/])[^\/]-$]]

luac = "53"
if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end


reaper.Undo_BeginBlock()
-- LOAD/SAVE SETTINGS MODULE
loadfile(script_path .. [[Data]] .. separator .. luac .. separator .. bin .. separator ..
             "lkc_grimsync_shared_functions.dll")() -- LOAD LIBRARY FOR LOADING AND SAVING SETTINGS

local CUR_SETTINGS, READ_FROM = WSHARED.GetAllSettings()
ALLOWED_HIER_TYPES = {
    WorkUnit = true,
    ActorMixer = true,
    RandomSequenceContainer = true,
    SwitchContainer = true,
    BlendContainer = true,
    Folder = true,
    MusicSwitchContainer = true,
    MusicSegment = true,
    MusicPlaylistContainer = true
}

local AM_COLOR = reaper.ColorToNative(64, 181, 206) | 0x1000000
local IM_COLOR = reaper.ColorToNative(139, 45, 193) | 0x1000000
local EV_COLOR = reaper.ColorToNative(247, 150, 19) | 0x1000000
if reaper.HasExtState(WSHARED.INI_SECTION_NAME, "AM_COLOR") then
    AM_COLOR = tonumber(reaper.GetExtState(WSHARED.INI_SECTION_NAME, "AM_COLOR"))
end
if reaper.HasExtState(WSHARED.INI_SECTION_NAME, "IM_COLOR") then
    IM_COLOR = tonumber(reaper.GetExtState(WSHARED.INI_SECTION_NAME, "IM_COLOR"))
end
if reaper.HasExtState(WSHARED.INI_SECTION_NAME, "EV_COLOR") then
    EV_COLOR = tonumber(reaper.GetExtState(WSHARED.INI_SECTION_NAME, "EV_COLOR"))
end
-- AM_COLOR = reaper.ImGui_ColorConvertNative(AM_COLOR)
-- IM_COLOR = reaper.ImGui_ColorConvertNative(IM_COLOR)
-- EV_COLOR = reaper.ImGui_ColorConvertNative(EV_COLOR)

-- RUN GrimSync GET
function LinkWwiseObjectToTrack(track)
    command = "\"" .. script_path .. "bin\\GrimSync.exe\" --get " ..
                  CUR_SETTINGS.waapi_connection_link
    os.execute(command)

    log = io.open(script_path .. "bin\\GrimSync.log", "r")
    output = log:read("*all")
    output = string.match(output, ">>>(.*)<<<")
    log:close()
    if output then
        -- Msg(output)
        name = string.match(output, "\"name\":\"(.-)\"") -- {"name":"pop"},
        path = string.match(output, "\"path\":\"(.-)\"") -- {"path":"pop"},
        guid = string.match(output, "\"guid\":\"(.-)\"") -- {"guid":"pop"},
        ttype = string.match(output, "\"type\":\"(.-)\"") -- {"type":"pop"}
        originals = ""
        events_subpath = ""

        if CUR_SETTINGS.orig_path_type == 1 then
            originals = string.match(output, "\"originals\":\"(.-)\"")
        end
        if CUR_SETTINGS.event_path_type == 1 then
            events_subpath = string.match(output, "\"events_subpath\":\"(.-)\"")
        end
        -- Msg("NAME:"..name)
        -- Msg("GUID:"..guid)
        -- Msg("PATH:"..path)
        SET = true
        if ALLOWED_HIER_TYPES[ttype] ~= true then
            reaper.ShowMessageBox("Invalid Wwise object type selected: " .. tostring(ttype) ..
                                      "\nPlease choose compatible container and try again.\nSelected: " ..
                                      path, "Error", 0)
            return
        end

        if string.match(path, "^\\Actor%-Mixer Hierarchy") ~= nil then
            -- Msg("CONTAINERS")
            color = AM_COLOR
            region_name = "{CONTAINERS=" .. name .. "}:" .. path .. "," .. guid .. "," ..
                              "[ORIGINALS=" .. originals .. "]" .. "," .. "[EVENTS_SUBPATH=" ..
                              events_subpath .. "],[TYPE=" .. ttype .. "]"
            container_name = name
        elseif string.match(path, "^\\Events") ~= nil then
            -- Msg("EVENTS")
            color = EV_COLOR
            region_name = "{EVENTS=" .. name .. "}:" .. path
        elseif string.match(path, "^\\Interactive Music Hierarchy") ~= nil then
            -- Msg("MUSIC")
            color = IM_COLOR
            region_name = "{CONTAINERS=" .. name .. "}:" .. path .. "," .. guid .. "," ..
                              "[ORIGINALS=" .. originals .. "]" .. "," .. "[EVENTS_SUBPATH=" ..
                              events_subpath .. "],[TYPE=" .. ttype .. "]"
        else
            SET = false
            reaper.ShowMessageBox(
                "Invalid Wwise object type selected!\nChoose either Actor-Mixer, Interactive Music or Events hierarchy!\nSelected: " ..
                    path, "Error", 0)
            return
        end

        retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String(track, "P_NAME", region_name,
                                                                   true)
        reaper.SetTrackColor(track, color)
        -- retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( track, "P_EXT:GRIMSYNC_WWISE_LINK", region_name, true )

    else
        reaper.ShowMessageBox("Can't detect selected Wwise object!", "Error", 0)
    end
end


function Main()
    local track = reaper.GetSelectedTrack(0, 0)
    if track == nil then
        reaper.ShowMessageBox(
            "No selected track found!\nPlease select a folder track in REAPER to link it to Wwise object and try again.",
            "ERROR", 0)
        return
    else

        -- I_FOLDERDEPTH : int * : folder depth change, 0=normal, 1=track is a folder parent, -1=track is the last in the innermost folder, -2=track is the last in the innermost and next-innermost folders, etc
        folder_depth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
        if folder_depth ~= 1 then
            reaper.ShowMessageBox(
                "Selected track must be a folder in order to link it to Wwise object.", "ERROR", 0)
        else
            -- vraca output
            -- vidi se blank cmd
            LinkWwiseObjectToTrack(track)
        end
    end
    reaper.UpdateArrange()
end


Main()
reaper.Undo_EndBlock("LKC - Grim Sync - Create link track", -1)

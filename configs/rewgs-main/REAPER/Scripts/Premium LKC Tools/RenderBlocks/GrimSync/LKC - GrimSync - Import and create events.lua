--[[
 Noindex: true
]] -- OS INFO
platform = reaper.GetOS()
if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform == "Other" then
    separator = [[/]]
else
    separator = [[\]] -- win
end

reaper.Undo_BeginBlock()

local info = debug.getinfo(1, 'S');
script_path = info.source:match [[^@?(.*[\/])[^\/]-$]]

luac = "53"
if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end


json = loadfile(script_path .. "json_lua" .. separator .. "json.lua")() -- LOAD LIBRARY FOR PARSING AND CREATEING JSON

-- LOAD/SAVE SETTINGS MODULE
loadfile(script_path .. [[Data]] .. separator .. luac .. separator .. bin .. separator ..
             "lkc_grimsync_shared_functions.dll")() -- LOAD LIBRARY FOR LOADING AND SAVING SETTINGS
CUR_SETTINGS, READ_FROM = WSHARED.GetAllSettings()

function Msg(param) reaper.ShowConsoleMsg(tostring(param) .. "\n") end


-- reaper.ClearConsole()

-- RUN GrimSync ALL
command = "\"" .. script_path .. "bin\\GrimSync.exe\" --all " .. CUR_SETTINGS.waapi_connection_link
os.execute(command)

-- Msg("LINK BLOCKS:" .. tostring(CUR_SETTINGS.link_blocks))
if CUR_SETTINGS.link_blocks == 1 then
    log = io.open(script_path .. "bin\\grim_audio_guid_table.json", "r")
    output = log:read("*all")
end

if output then

    guid_dictionary = json.decode(output)
    -- for k,v in pairs(guid_dictionary) do
    --     Msg(k.." -- ".. v)
    -- end

    -- HANDLE ORIGINALS TABLE
    local log = io.open(script_path .. "bin\\grim_originals_table.json", "r")
    local out = log:read("*all")
    if out then
        originals_table = json.decode(out)
    else
        originals_table = {}
    end

    reaper.Main_OnCommand(41230, 0) -- save selection set 2
    -- reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_SAVETIME2"), 0) -- save time selection #2

    reaper.PreventUIRefresh(1)

    res_path = reaper.GetResourcePath()

    reaper.Main_OnCommand(40717, 0) -- select all items in current time selection
    item_count = reaper.CountSelectedMediaItems(0)
    label_items = {}
    idx = 0
    for i = 0, item_count - 1 do
        item = reaper.GetSelectedMediaItem(0, i)
        take = reaper.GetActiveTake(item)
        if take == nil then
            -- Msg(item)
            label_items[idx] = item
            idx = idx + 1
        end
    end

    if idx > 0 then
        for x = 0, #label_items do
            -- reaper.ShowConsoleMsg(tostring(label_items[x]))
            -- reaper.ShowConsoleMsg("\n")
            -- PER Render Block: Set GUID info to empty item and set all takes to have WWISE LINK background
            local item = label_items[x]
            local name = reaper.ULT_GetMediaItemNote(item)
            -- Msg(name)
            reaper.Main_OnCommand(40289, 0) -- unselect all items
            reaper.SetMediaItemSelected(item, true)
            reaper.Main_OnCommand(40034, 0) -- select all items in group
            local item_count = reaper.CountSelectedMediaItems(0)
            local set_background_images = false

            for i = 0, item_count - 1 do
                local cur_item = reaper.GetSelectedMediaItem(0, i)
                if cur_item ~= nil then
                    -- Msg(item)
                    local take = reaper.GetActiveTake(cur_item)
                    if take == nil then
                        for audio_filename, properties in pairs(guid_dictionary) do
                            -- reaper.ShowConsoleMsg("IME:" .. name .. "-" .. "OBJEKAT:" .. audio_filename .. "\n")
                            if string.match(name, audio_filename) then -- nadji da li postoji explosion_02 u @explosion_02;mono;[r]boom;
                                -- reaper.ShowConsoleMsg("EVO GA\n")
                                guid_to_set = properties.guid
                                -- reaper.ULT_SetMediaItemNote( item, name .. "\nWWISE_LINK=" .. guid_to_set ) --ako hocu u ime da upisem guid
                                local retval, stringNeedBig =
                                    reaper.GetSetMediaItemInfo_String(cur_item,
                                                                      "P_EXT:LKC-WWISE_OBJECT_GUID",
                                                                      "", false)
                                -- reaper.ShowConsoleMsg(stringNeedBig)
                                if stringNeedBig == "" then
                                    reaper.GetSetMediaItemInfo_String(cur_item,
                                                                      "P_EXT:LKC-WWISE_OBJECT_GUID",
                                                                      guid_to_set, true)
                                    reaper.GetSetMediaItemInfo_String(cur_item,
                                                                      "P_EXT:LKC-WWISE_OBJECT_ORIGS_SUBPATH",
                                                                      originals_table[audio_filename],
                                                                      true)
                                    reaper.GetSetMediaItemInfo_String(cur_item,
                                                                      "P_EXT:LKC-WWISE_OBJECT_LOCATION",
                                                                      properties.path, true)
                                    -- reaper.ShowConsoleMsg("SET GUID NOW:" + stringNeedBig)
                                    set_background_images = true
                                end
                            end
                        end
                    else
                        if set_background_images then
                            -- Msg("IMAGE:"..tostring(cur_item))
                            reaper.BR_SetMediaItemImageResource(cur_item, "", 3) -- first delete current image
                            retval, chunk = reaper.GetItemStateChunk(cur_item, "", false)
                            chunk = string.gsub(chunk, "IMGRESOURCEFLAGS %d", "IMGRESOURCEFLAGS 3")
                            reaper.SetItemStateChunk(cur_item, chunk, false) -- save new chunk
                            reaper.BR_SetMediaItemImageResource(cur_item, res_path ..
                                                                    "\\Data\\track_icons\\wwise_link.png",
                                                                3) -- set new image
                        end
                    end
                end
            end
        end
    end
end

-- reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_RESTTIME2"), 0) -- Load time selection #2
reaper.Main_OnCommand(41240, 0) -- LOAD SELECTION SET #2

reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock("LKC - Grim Sync - Import and create events.lua", -1)

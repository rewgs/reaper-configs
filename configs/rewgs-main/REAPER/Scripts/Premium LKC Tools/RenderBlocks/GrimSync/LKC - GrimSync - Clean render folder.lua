--[[
 Noindex: true
]] function Msg(param) reaper.ShowConsoleMsg(tostring(param) .. "\n") end


json = loadfile(script_path .. "json_lua" .. separator .. "json.lua")() -- LOAD LIBRARY FOR PARSING AND CREATEING JSON

function Main()
   
    -- LOAD JSON
    log = io.open(script_path .. "bin\\grim_files_by_blocks.json", "r")
    if log then
        output = log:read("*all")
        if output then AUDIO_BY_BLOCKS = json.decode(output) end
        -- Msg("OUTPUT:\n" .. output)
    end

    local info

    info =
        "This will delete audio files from the log list.\nThere is no undo. You can only re-render the files.\nAre you sure you want to do this?"

    local count = 0
    for k, v in pairs(AUDIO_BY_BLOCKS) do
        if reaper.file_exists(v) then
            count = count + 1
            Msg(count .. ":" .. v)
        end
    end
    
    if count > 0 then
        Msg("GRIM SYNC CLEAN: You are about to delete " .. count .. " file(s)!")
        local answer = reaper.ShowMessageBox(info, "WARNING", 4)
        if answer == 6 then

            reaper.Main_OnCommand(40289, 0) -- unselect all items
            if AUDIO_BY_BLOCKS ~= nil then
                prog = ""
                for guid, audio_file in pairs(AUDIO_BY_BLOCKS) do
                    if reaper.file_exists(audio_file) then
                        local item = reaper.BR_GetMediaItemByGUID(0, guid)
                        -- Msg('item:'..tostring(item))
                        reaper.SetMediaItemSelected(item, true)

                        prog = prog .. [[del /q "]] .. audio_file .. [[" & ]]
                    end
                end

                reaper.Main_OnCommand(40034, 0) -- select all items in group

                -- dofile(script_path .. [[..]] .. separator .. [[Data]]..separator..bin..separator..[[lkc_renderblocks_restore_colors.dll]])
                reaper.Main_OnCommand(reaper.NamedCommandLookup(
                                          "_RS64eb639cdc43d55f378b3938feffa70b47747ce3"), 0) -- restore colors lkc

                os.execute(prog)
            else
                reaper.ShowMessageBox("Nothing to delete, list was not found", "ERROR", 0)
            end
        end
    else
        reaper.ShowMessageBox("Nothing to delete, files are not yet renderer, or empty selection.", "GrimSync Clean Info", 0)
    end
end


-------------------- MAIN
Main()
reaper.UpdateArrange()

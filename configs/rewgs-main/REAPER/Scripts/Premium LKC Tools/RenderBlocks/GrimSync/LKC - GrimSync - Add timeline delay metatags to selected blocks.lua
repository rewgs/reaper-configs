--[[
 Noindex: true
]]
function Msg(param) reaper.ShowConsoleMsg(tostring(param) .. "\n") end


function Main()
    local count = reaper.CountSelectedMediaItems(0)

    BLOCKS = {}
    SINGLE_ITEMS = {}
    for i = 0, count - 1 do
        local item = reaper.GetSelectedMediaItem(0, i)
        local take = reaper.GetActiveTake(item)
        local group_id = reaper.GetMediaItemInfo_Value(item, "I_GROUPID")
        local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
        if MIN_POS == nil then MIN_POS = pos end
        if MIN_POS > pos then MIN_POS = pos end

        if take == nil then
            if group_id > 0 then
                BLOCKS[item] = pos
            end
        else
            if group_id == 0 then
                SINGLE_ITEMS[item] = pos
            end
        end
    end

    -- SET RELATIVE DELAY VALUES
    for item, pos in pairs(BLOCKS) do
        local note = reaper.ULT_GetMediaItemNote(item)
        note = string.gsub(note,";#InitialDelay=(%d+%.?%d*)","")
        local metatag = "#InitialDelay=" .. tostring(pos - MIN_POS) .. ";"
        if not string.match(note, ";$") then metatag = ";" .. metatag end
        reaper.ULT_SetMediaItemNote(item, note .. metatag)
    end

    -- SET RELATIVE DELAY VALUES
    for item, pos in pairs(SINGLE_ITEMS) do
        local take = reaper.GetActiveTake(item)
        local take_name = reaper.GetTakeName(take)
        take_name = string.gsub(take_name,";#InitialDelay=(%d+%.?%d*)","")
        -- Msg(take_name)
        local metatag = "#InitialDelay=" .. tostring(pos - MIN_POS) .. ";"
        if not string.match(take_name, ";$") then metatag = ";" .. metatag end
        retval, stringNeedBig = reaper.GetSetMediaItemTakeInfo_String( take, "P_NAME", take_name .. metatag, true)
    end

end

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)
Main()
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
reaper.Undo_EndBlock("LKC - GrimSync - Add timeline delay metatags to selected blocks",-1)
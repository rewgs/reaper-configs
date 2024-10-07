--[[
 Noindex: true
 ReaScript Name:LKC - RenderBlocks - Toggle labels and item icons
 Author: LKC
 REAPER: 5+
 Version: 1.0
]]



--[[
 * Changelog:
 * v1.0 (2021-03-31)
    + Initial commit
]]


function Msg(param)
  reaper.ShowConsoleMsg(tostring(param).."\n")
end

reaper.PreventUIRefresh( 1 )

local show_label = reaper.GetToggleCommandState(40651) -- check show label
-- Msg(show_label)

local itemicons_minheight =  reaper.SNM_GetIntConfigVar( "itemicons_minheight", -1)
if itemicons_minheight == 500 then
    if show_label == 0 then 
        reaper.Main_OnCommand(40651,0) -- View: Toggle show/hide item labels
    end
    reaper.SNM_SetIntConfigVar("itemicons_minheight",20)  --don't show
else
    if itemicons_minheight == 20 then
        if show_label == 1 then 
            reaper.Main_OnCommand(40651,0) -- View: Toggle show/hide item labels
        end
        reaper.SNM_SetIntConfigVar("itemicons_minheight",500) -- show
    else
        reaper.SNM_SetIntConfigVar("itemicons_minheight",20) -- hide first time
    end
end


--Msg(itemicons_minheight)
reaper.PreventUIRefresh( -1 )
reaper.UpdateArrange()

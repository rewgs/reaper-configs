-- Generated for ReaImGui v0.8.7.4

local shims = {
  { version=0x00080700, apply=function() -- v0.8.7
    -- dear imgui v1.89.6 breaking change
    reaper.ImGui_ForceDisplayRangeByIndices = reaper.ImGui_IncludeRangeByIndices
  end },
  { version=0x00080500, apply=function() -- v0.8.5
    -- dear imgui v1.89.4 breaking changes
    reaper.PushAllowKeyboardFocus = reaper.PushTabStop
    reaper.PopAllowKeyboardFocus  = reaper.PopTabStop
  end },
  { version=0x00080000, apply=function() -- v0.8
    -- ModFlags and Key_Mod to Mod rename
    -- the new Mod_* values are different than the old ModFlags_*
    reaper.ImGui_ModFlags_None  = function() return 0 end
    reaper.ImGui_ModFlags_Ctrl  = function() return 1 end
    reaper.ImGui_ModFlags_Shift = function() return 2 end
    reaper.ImGui_ModFlags_Alt   = function() return 4 end
    reaper.ImGui_ModFlags_Super = function() return 8 end
    reaper.ImGui_Key_ModCtrl  = reaper.ImGui_Mod_Ctrl
    reaper.ImGui_Key_ModShift = reaper.ImGui_Mod_Shift
    reaper.ImGui_Key_ModAlt   = reaper.ImGui_Mod_Alt
    reaper.ImGui_Key_ModSuper = reaper.ImGui_Mod_Super
    
    local GetKeyMods = reaper.ImGui_GetKeyMods
    function reaper.ImGui_GetKeyMods(ctx)
      local old_mods, new_mods = 0, GetKeyMods(ctx)
      local mods = { 'Ctrl', 'Shift', 'Alt', 'Super' }
      for _, mod in ipairs(mods) do
        if (new_mods & reaper['ImGui_Mod_' .. mod]()) ~= 0 then
          old_mods = old_mods | reaper['ImGui_ModFlags_' .. mod]()
        end
      end
      return old_mods
    end
    
    -- new generic object attachment functions
    reaper.ImGui_AttachFont = reaper.ImGui_Attach
    reaper.ImGui_DetachFont = reaper.ImGui_Detach
    
    -- broken since v0.5
    function reaper.ImGui_IsWindowCollapsed(ctx)
      return false
    end
    
    -- obsoleted window boundary extension via SetCursorPos (ocornut/imgui#5548)
    local function shimWindowEnd(func)
      return function(ctx, ...)
        reaper.ImGui_SameLine(ctx, nil, 0)
        reaper.ImGui_Spacing(ctx)
        return func(ctx, ...)
      end
    end
    reaper.ImGui_End           = shimWindowEnd(reaper.ImGui_End)
    reaper.ImGui_EndChild      = shimWindowEnd(reaper.ImGui_EndChild)
    reaper.ImGui_EndChildFrame = shimWindowEnd(reaper.ImGui_EndChildFrame)
    reaper.ImGui_EndGroup      = shimWindowEnd(reaper.ImGui_EndGroup)
    reaper.ImGui_EndPopup      = shimWindowEnd(reaper.ImGui_EndPopup)
    reaper.ImGui_EndTable      = shimWindowEnd(reaper.ImGui_EndTable)
    reaper.ImGui_EndTooltip    = shimWindowEnd(reaper.ImGui_EndTooltip)
    reaper.ImGui_TableNextColumn = shimWindowEnd(reaper.ImGui_TableNextColumn)
    reaper.ImGui_TableNextRow    = shimWindowEnd(reaper.ImGui_TableNextRow)
    reaper.ImGui_TableSetColumnIndex = shimWindowEnd(reaper.ImGui_TableSetColumnIndex)
  end },
  { version=0x00070000, apply=function() -- v0.7
    -- KeyModFlags to ModFlags rename
    reaper.ImGui_KeyModFlags_None  = reaper.ImGui_ModFlags_None
    reaper.ImGui_KeyModFlags_Ctrl  = reaper.ImGui_ModFlags_Ctrl
    reaper.ImGui_KeyModFlags_Shift = reaper.ImGui_ModFlags_Shift
    reaper.ImGui_KeyModFlags_Alt   = reaper.ImGui_ModFlags_Alt
    reaper.ImGui_KeyModFlags_Super = reaper.ImGui_ModFlags_Super
    
    -- Capture*FromApp to SetNextFrameWantCapture* rename
    reaper.ImGui_CaptureKeyboardFromApp = reaper.ImGui_SetNextFrameWantCaptureKeyboard
    
    -- non-vanilla HSVtoRGB/RGBtoHSV packing and optional alpha parameter
    local function shimColConv(convFunc)
      return function(x, y, z, a)
        local x, y, z = convFunc(x, y, z)
        local rgba = reaper.ImGui_ColorConvertDouble4ToU32(x, y, z, a or 1.0)
        return (rgba & 0xffffffff) >> (a and 0 or 8), a, x, y, z
      end
    end
    reaper.ImGui_ColorConvertHSVtoRGB = shimColConv(reaper.ImGui_ColorConvertHSVtoRGB)
    reaper.ImGui_ColorConvertRGBtoHSV = shimColConv(reaper.ImGui_ColorConvertRGBtoHSV)
    
    -- ConfigVar API
    function reaper.ImGui_GetConfigFlags(ctx)
      return reaper.ImGui_GetConfigVar(ctx, reaper.ImGui_ConfigVar_Flags())
    end
    function reaper.ImGui_SetConfigFlags(ctx, flags)
      return reaper.ImGui_SetConfigVar(ctx, reaper.ImGui_ConfigVar_Flags(), flags)
    end
    
    -- null-terminated combo and list box items
    local Combo, ListBox = reaper.ImGui_Combo, reaper.ImGui_ListBox
    function reaper.ImGui_Combo(ctx, label, current_item, items, popup_max_height_in_items)
      return Combo(ctx, label, current_item, items:gsub('\31', '\0'), popup_max_height_in_items)
    end
    function reaper.ImGui_ListBox(ctx, label, current_item, items, height_in_items)
      return ListBox(ctx, label, current_item, items:gsub('\31', '\0'), height_in_items)
    end
    
    -- Addition of IMGUI_VERSION_NUM to GetVersion
    local GetVersion = reaper.ImGui_GetVersion
    function reaper.ImGui_GetVersion()
      local imgui_version, imgui_version_num, reaimgui_version = GetVersion()
      return imgui_version, reaimgui_version
    end
  end },
}

local function parseVersion(ver)
  local segs, pos, packed = 4, 1, 0
  ver = tostring(ver)
  for i = 1, segs do
    local sep_pos = ver:find('.', pos, true)
    local seg = tonumber(ver:sub(pos, sep_pos and sep_pos - 1 or nil))
    if not seg or (seg & ~0xff) ~= 0 then break end -- invalid
    packed = packed | (seg << 8 * (segs - i))
    if not sep_pos then return packed end
    pos = sep_pos + 1
  end
  error(('invalid version string "%s"'):format(ver))
end

return function(compat_version)
  local version = parseVersion(compat_version)
  assert(version <= 0x00080704,
    ('reaimgui 0.8.7.4 is too old (script requires %s)'):format(compat_version))
  for _, shim in ipairs(shims) do
    if shim.version <= version then break end
    shim.apply()
  end
end

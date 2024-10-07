--[[
 ReaScript Name:Render Blocks - Content Navigator
 Author: LKC
 REAPER: 6
 Extensions: SWS
 Version: 1.07
 Provides:
  Data/Lokasenna_GUI/Class - Button.dat
  Data/Lokasenna_GUI/Class - Label.dat
  Data/Lokasenna_GUI/Class - Listbox2.dat
  Data/Lokasenna_GUI/Class - Menubox.dat
  Data/Lokasenna_GUI/Class - Options.dat
  Data/Lokasenna_GUI/Class - Tabs.dat
  Data/Lokasenna_GUI/Class - Textbox.dat
  Data/Lokasenna_GUI/Core.dat
  Data/save_table.dat
  Data/53/x64/lkc_renderblocks_content_navigator.dll
  Data/53/x64/lkc_render_controller.dll
  Data/53/x64/lkc_render1.dat
  Data/53/x64/lkc_render2.dat
  Data/53/x64/lkc_render3.dat
  Data/53/x86/lkc_renderblocks_content_navigator.dll
  Data/53/x86/lkc_render_controller.dll
  Data/53/x86/lkc_render1.dat
  Data/53/x86/lkc_render2.dat
  Data/53/x86/lkc_render3.dat
  Data/54/x64/lkc_renderblocks_content_navigator.dll
  Data/54/x64/lkc_render_controller.dll
  Data/54/x64/lkc_render1.dat
  Data/54/x64/lkc_render2.dat
  Data/54/x64/lkc_render3.dat
  Data/54/x86/lkc_renderblocks_content_navigator.dll
  Data/54/x86/lkc_render_controller.dll
  Data/54/x86/lkc_render1.dat
  Data/54/x86/lkc_render2.dat
  Data/54/x86/lkc_render3.dat
  [data] LKC - Content Navigator.png > toolbar_icons/LKC - Content Navigator.png
 About:
  # LKC CONTENT NAVIGATOR
  
  ## Seamless and powerful project navigation, folder handling and track solo/mute tool.

--[[
 * Changelog:
    * v1.07 (2023-10-19)
        + REAPER 7 support
    * v1.07beta (2023-10-02)
        + Fixed loading bug
    * v1.06beta (2023-10-02)
        + REAPER 7 and Lua 5.4 support
    * v1.05 (2023-06-04)
        + Font options
        + Indentation options
        + MCP options
        + Quick hide button (^,v)
    * v1.04 (2022-06-18)
        + Fixed multi-unselection bug
        + Refactored license management system
        + Improved license key parsing
    * v1.03 (2022-05-23)
        + Improved anti-crash security for multi-selection
        + Added support for coloring tracks using third-party scripts like ReaNoir or Colour Swatch
        + License management improvement
    * v1.03beta (2022-04-19)
        + Fixed issue with folder selection when using CTRL+Left Click or SHIFT+Left Click
    * v1.02 (2022-02-20)
        + Fixed issue in search box with special characters like (^$()%.[]*+-?)
    * v1.01 (2022-01-23)
        + Added search box (premium feature) with multi term support (comma is a term separator)
        + Added support for always hidden tracks (any track with ## in its name)
        + Added support to rename tracks from Content Navigator (ALT + Double Click)
        + Added 'Solo' in Navigation Options
        + Improved stability of the tool (added crash safety)
    * v1.0 (2022-01-15)
        + Fixed right click jumping behaviour
        + Added toolbar icon: LKC - Content Navigator.png
    * v0.8beta (2022-01-12)
        + Fixed expanding and collapsing when no selection
        + Fixed deselection issues
        + Fixed various unwanted ALT + Right Click results
    * v0.7beta (2022-01-11)
        + Standalone license support
        + Added support for multi selection (using CTRL/SHIFT + Click)
        + Added support for jump modifier (using ALT + Click)
        + Added support for quick expand (using ALT + Right Click)
        + Added support for quick collapse (using ALT + SHIFT + Right Click)
        + Added support for FREE version (up to 3 depth levels and 20 list items)
    * v0.6 (2020-07-09)
        + Small changes and fixes
    * v0.5 (2020-06-27)
        + Added support for vertical zoom
    * v0.4 (2020-06-25)
        + Selection options
        + Renamed some option labels for more clarity
    * v0.3 (2020-06-21)
        + (Un)Docking buton
    * v0.2 (2020-05-24)
        + A lot of improvements
    * v0.1 (2020-05-24)
        + Package created
]]

local sws = reaper.APIExists("CF_GetClipboardBig")
if sws then
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
    dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_renderblocks_content_navigator.dll]])
else
    reaper.ShowMessageBox("Please install SWS Extension version 2.9.7 or higher from:\nhttps://sws-extension.org/", "NO SWS FOUND", 0)
end
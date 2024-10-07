--[[
 Noindex: true
]]

--CALLED FROM REAPER

local info = debug.getinfo(1,'S');
script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]

luac = "53"
if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end


-- LOAD/SAVE SETTINGS MODULE
loadfile(script_path .. [[Data]] .. separator .. luac .. separator .. bin .. separator ..
             "lkc_grimsync_shared_functions.dll")() -- LOAD LIBRARY FOR LOADING AND SAVING SETTINGS
CUR_SETTINGS, READ_FROM = WSHARED.GetAllSettings()

--REAPER HAS A PROBLEM WITH DETECTING PYTHON SCRIPT PATH SO IT NEEDS TO BE DONE WITH ENVIRONMENT VARIABLE
function Msg(param)
	reaper.ShowConsoleMsg(tostring(param).."\n")
end

reaper.PreventUIRefresh(1)
res_path =  reaper.GetResourcePath()
command = "\"" .. script_path .. "bin\\GrimSync.exe\" --get " .. CUR_SETTINGS.waapi_connection_link
os.execute(command)
log = io.open(script_path .. "bin\\GrimSync.log", "r")
output = log:read("*all")
-- Msg(output)
output = string.match(output,">>>(.*)<<<")
if output then
	name = string.match(output,"\"name\":\"(.-)\"")    --{"name":"pop"},
	path = string.match(output,"\"path\":\"(.-)\"")    --{"path":"pop"},
	guid = string.match(output,"\"guid\":\"(.-)\"")    --{"guid":"pop"},
	wav = string.match(output,"\"wav\":\"(.-)\"")    --{"guid":"pop"},

	if wav then
		wav = string.match(wav, ".*\\(.*)%.wav")
		-- Msg(tostring(wav))
		name = wav
	end
	item = reaper.GetSelectedMediaItem( 0, 0 )
	-- reaper.ShowConsoleMsg(name)
	reaper.Main_OnCommand( 40289, 0 ) --unselect all items
	reaper.SetMediaItemSelected( item, true )
	reaper.Main_OnCommand( 40034, 0 ) --select all items in group
	item_count = reaper.CountSelectedMediaItems( 0)
	set_background_images = false
	for i =0,  item_count - 1 do
		local item =  reaper.GetSelectedMediaItem( 0, i )
		local take = reaper.GetActiveTake( item )
		if take == nil then
			reaper.ULT_SetMediaItemNote( item, "@" .. name) 
			retval, stringNeedBig = reaper.GetSetMediaItemInfo_String(item, "P_EXT:LKC-WWISE_OBJECT_GUID", "",false )
			-- reaper.ShowConsoleMsg(stringNeedBig)
			if stringNeedBig == "" then
				reaper.GetSetMediaItemInfo_String(item, "P_EXT:LKC-WWISE_OBJECT_GUID", guid, true )
				-- reaper.ShowConsoleMsg("SET GUID NOW:" + stringNeedBig)
				set_background_images = true
			end
		else
			if set_background_images then
				reaper.BR_SetMediaItemImageResource( item, "", 3 ) --first delete current image
				retval, chunk = reaper.GetItemStateChunk( item, "", false )
				chunk = string.gsub(chunk,"IMGRESOURCEFLAGS %d","IMGRESOURCEFLAGS 3")
				reaper.SetItemStateChunk( item, chunk, false ) --save new chunk
				reaper.BR_SetMediaItemImageResource( item, res_path.."\\Data\\track_icons\\wwise_link.png", 3 ) --set new image
			end
		end
	end
end
reaper.PreventUIRefresh(-1)
--PER Render Block: Set GUID info to empty item and set all takes to have WWISE LINK background

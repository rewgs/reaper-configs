--[[
 Noindex: true
]]

--CALLED FROM REAPER
reaper.PreventUIRefresh(1)
res_path =  reaper.GetResourcePath()
reaper.Main_OnCommand(40034,0) --Item grouping: Select all items in groups
item_count =  reaper.CountSelectedMediaItems( 0 )
for i = 0, item_count - 1 do
	local item = reaper.GetSelectedMediaItem( 0, i )
	retval, stringNeedBig = reaper.GetSetMediaItemInfo_String( item, "P_EXT:LKC-WWISE_OBJECT_GUID", "", true )
	retval, stringNeedBig = reaper.GetSetMediaItemInfo_String( item, "P_EXT:LKC-WWISE_OBJECT_ORIGS_SUBPATH", "", true )
	retval, stringNeedBig = reaper.GetSetMediaItemInfo_String( item, "P_EXT:LKC-WWISE_OBJECT_LOCATION", "", true )
	
	local retval, stringNeedBig = reaper.GetSetMediaItemInfo_String( item, "P_EXT:LKC-CONSTRUCT", "", false ) --get property from item
	if stringNeedBig == "constructed" then
		reaper.BR_SetMediaItemImageResource( item, "", 3 ) --first delete current image
		local retval, chunk = reaper.GetItemStateChunk( item, "", false ) --then get chunk
		chunk = string.gsub(chunk,"IMGRESOURCEFLAGS %d","IMGRESOURCEFLAGS 3") --replace chunk image flag value
		reaper.SetItemStateChunk( item, chunk, false ) --save new chunk
		reaper.BR_SetMediaItemImageResource( item, res_path.."\\Data\\track_icons\\constructed.png", 3 ) --set new image
	else
		reaper.BR_SetMediaItemImageResource( item, "", 1 )
	end
end
reaper.PreventUIRefresh(-1)
	
i=0

array = {}

array[0] = ".L"
array[1] = ".R"
array[2] = ".C"
array[3] = ".LFE"
array[4] = ".LS"
array[5] = ".RS"

item=reaper.GetSelectedMediaItem(0, i)
  tk = reaper.GetMediaItemTake(item, 0)
  retval1, tempname = reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", "nothing", false)
  pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  length = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  endpos = pos+length
  
  reaper.Main_OnCommand(40894, 0) --explode
  
  reaper.GetSet_LoopTimeRange(true, false, pos, endpos, false)
  
  commandID = reaper.NamedCommandLookup("_XENAKIOS_SELNEXTTRACK")
  
  reaper.Main_OnCommand(commandID, 0) --select next track
  
  reaper.Main_OnCommand(40289, 0) --unselect all items
  
  reaper.Main_OnCommand(40287, 0) --select next track
  
  reaper.Main_OnCommand(40287, 0) --select next track
  
  reaper.Main_OnCommand(40287, 0) --select next track
  
  reaper.Main_OnCommand(40287, 0) --select next track
  
  reaper.Main_OnCommand(40287, 0) --select next track
  
  reaper.Main_OnCommand(40718, 0) --select all items in tracks

if retval1==false then
retval, name = reaper.GetUserInputs("Rename", 1, "Enter Item Name", "")
else
retval, name = reaper.GetUserInputs("Rename", 1, "Enter Item Name", tempname)
end


x = reaper.CountSelectedMediaItems(0)
i=0
if retval==false then
elseif name=="" then
else
  while i<x do
  item=reaper.GetSelectedMediaItem(0, i)
  tk = reaper.GetMediaItemTake(item, 0)
  reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name .. array[i], true)
  i=i+1
  end
end



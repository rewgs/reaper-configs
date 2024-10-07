i=0

item=reaper.GetSelectedMediaItem(0, i)
  tk = reaper.GetMediaItemTake(item, 0)
  retval1, tempname = reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", "nothing", false)

if retval1==false then
retval, name = reaper.GetUserInputs("Rename Item", 1, "Enter Item Name", "")
else
retval, name = reaper.GetUserInputs("Rename Item", 1, "Enter Item Name", tempname)
end


x = reaper.CountSelectedMediaItems(0)
i=0
if retval==false then
elseif name=="" then
else
  while i<x do
  item=reaper.GetSelectedMediaItem(0, i)

  tk = reaper.GetActiveTake(item)
  reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name, true)
  i=i+1
  end
end

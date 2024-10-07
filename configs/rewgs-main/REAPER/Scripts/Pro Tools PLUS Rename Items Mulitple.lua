x = reaper.CountSelectedMediaItems(reaper.GetCurrentProjectInLoadSave())

a, b, regions = reaper.CountProjectMarkers(reaper.GetCurrentProjectInLoadSave())

i=0

while (i<x) do

item = reaper.GetSelectedMediaItem(reaper.GetCurrentProjectInLoadSave(), i)

itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
      itemDuration = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
      itemEnd = itemStart + itemDuration
      
f = 0
--while f<itemDuration do
--id1, id2 = reaper.GetLastMarkerAndCurRegion(reaper.GetCurrentProjectInLoadSave(), itemStart)

--retval, isrgnOut, posOut, rgnendOut, nameOut, markrgnindexnumberOut = reaper.EnumProjectMarkers(id2)

--reaper.DeleteProjectMarker(reaper.GetCurrentProjectInLoadSave(), markrgnindexnumberOut, 1)
--itemStart = itemStart+1
--f=f+1
--end
i = i+1

end


reaper.DeleteProjectMarker(NULL, 0, 1)

retval, name2 = reaper.GetUserInputs("RENAME ITEMS MULTIPLE", 2, "Enter Item Name,Start Number", "Name-,01")


name, number = name2:match("([^,]+),([^,]+)")

if name==nil then
  name = name2:match("([^,]+),")
  number = ""
  length = 0
else
  length = string.len(number)
end

array = {}
ar=0
arraytemp = {}
arraynum = 0
i=0
q=0
m=0

while (i<x) do
array[i] = {}
i=i+1
end

i=0

while (i<x) do
  array[ar][0] = i
  array[ar][1] = reaper.GetSelectedMediaItem(reaper.GetCurrentProjectInLoadSave(), i)
  array[ar][2] = reaper.GetMediaItemInfo_Value(array[ar][1], "D_POSITION");

  array[ar][3] = i
  ar=ar+1
  i=i+1
end

i=0
ar=0

while(i<x) do

m=0
arraynum=0
ar=0

while (m<x) do

  if x==1 then
  break
  else
    if m+1==x then
    break
    end
  end
    
  if array[ar][2]<array[ar+1][2] then
  
  elseif array[ar][2]==array[ar+1][2] then
    if array[ar][3]>array[ar+1][3] then
      arraytemp[0] = array[ar]
      array[ar] = array[ar+1]
      array[ar+1] = arraytemp[0]
    end  
  else
    arraytemp[0] = array[ar]
    array[ar] = array[ar+1]
    array[ar+1] = arraytemp[0]
  end
  ar=ar+1
  m=m+1

end

i=i+1

end

arraynum=0
i = 0
ar=0

while (i<x) do

if retval==false then
break
end

if name=="" then
break
end

item = reaper.GetSelectedMediaItem(reaper.GetCurrentProjectInLoadSave(), array[ar][0])

    itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION");
      itemDuration = reaper.GetMediaItemInfo_Value(item, "D_LENGTH");
      itemEnd = itemStart + itemDuration;

if number=="" then

tk = reaper.GetMediaItemTake(item, 0)
reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name, true);
else
  if length<2 then
    
          tk = reaper.GetMediaItemTake(item, 0)
          reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name .. tonumber(number)+i, true)
   
  elseif length<3 then  
    if tonumber(number)+i < 10 then 
      
                  tk = reaper.GetMediaItemTake(item, 0)
                  reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name .. "0" .. tonumber(number)+i, true)
    
    else
     
                 tk = reaper.GetMediaItemTake(item, 0)
                 reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name .. tonumber(number)+i, true)
  
    end  
  else
    if tonumber(number)+i < 10 then 
    
              tk = reaper.GetMediaItemTake(item, 0)
              reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name .. "00" .. tonumber(number)+i, true)
    
    elseif tonumber(number)+i <100 then
   
              tk = reaper.GetMediaItemTake(item, 0)
              reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name .. "0" .. tonumber(number)+i, true)
 
    else
  
             tk = reaper.GetMediaItemTake(item, 0)
             reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", name .. tonumber(number)+i, true)
  
    end
  end
end

i = i+1
regions = regions+1
arraynum=arraynum+1
ar=ar+1
end

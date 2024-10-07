startOut, endOut = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)

cursor = reaper.GetCursorPosition()

if startOut>0 then

if cursor<startOut then

reaper.GetSet_LoopTimeRange(true, false, cursor, cursor, false)
else

reaper.SetEditCurPos(endOut, true, false)
end

elseif startOut==0 and endOut~=0 then

reaper.SetEditCurPos(endOut, true, false)

else


reaper.GetSet_LoopTimeRange(true, false, cursor, cursor, false)

end





cursor = reaper.GetCursorPosition()

selectedtracks = reaper.CountSelectedTracks(0)
array={}
arraytemp = {}
temp=0

i=0
b=0
while i<selectedtracks do

  track = reaper.GetSelectedTrack(0, i)
  itemnum = reaper.CountTrackMediaItems(track)
  a=0
  while a<itemnum do
  
    item = reaper.GetTrackMediaItem(track, a)
    itemstart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    itemend = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    itemend = itemstart+itemend
    if itemstart>cursor then
      array[b]=itemstart
      b=b+1
    break
    elseif itemend>cursor then
      array[b]=itemend
      b=b+1
    break
    end

    a=a+1
  
  end
  i=i+1

end

i=0
ar=0
  
while(i<b) do
  
  m=0
  ar=0
  
  while (m<b) do
  
    if b==1 then
    break
    else
      if m+1==b then
      break
      end
    end
      
    if array[ar]<array[ar+1] then
    elseif array[ar]==array[ar+1] then
        if array[ar]>array[ar+1] then
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

if array[0]~=nil then
reaper.SetEditCurPos(array[0], true, true)
end   
  








cursor = reaper.GetCursorPosition()
startOut, endOut = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
reaper.GetSet_LoopTimeRange(true, false, startOut, cursor, false)

reaper.Main_OnCommand(40718, 0) -- select all items within time selection on track selected


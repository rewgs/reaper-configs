reaper.Undo_BeginBlock()

startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
  group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
  group=0
end

if startOut==endOut then

  if group==0 then
  
    reaper.Main_OnCommand(41295, 0) -- duplicate items
  
    reaper.Main_OnCommand(41173, 0) -- move cursor to start of items
  
  else
  
    reaper.Main_OnCommand(40034, 0) -- select all in troup
  
    reaper.Main_OnCommand(41295, 0) -- duplicate items
  
    reaper.Main_OnCommand(41173, 0) -- move cursor to start of items
  
    reaper.Main_OnCommand(40032, 0) -- group items
  
  end

else

--[[
if group==0 then


x = reaper.CountSelectedMediaItems(0)
i=0
while i<x do
  item = reaper.GetSelectedMediaItem(0, i)
  startpos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  endpos = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  if startpos>endOut and (startpos+endpos)>endOut then
    reaper.GetSet_LoopTimeRange(true, true, 0, 0, false) 
    
    reaper.Main_OnCommand(41295, 0) -- duplicate items
    
    reaper.Main_OnCommand(41173, 0) -- move cursor to start of items 
    break
  end
  if endpos<startOut and (startpos+endpos)<startOut then
      reaper.GetSet_LoopTimeRange(true, true, 0, 0, false) 
      
      reaper.Main_OnCommand(41295, 0) -- duplicate items
      
      reaper.Main_OnCommand(41173, 0) -- move cursor to start of items 
      break
    end
  i=i+1
end

startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)
if startOut~=endOut then
  reaper.Main_OnCommand(41296, 0) -- duplicate selected area of items
end
 
else
  --]]
  
  reaper.Main_OnCommand(40034, 0) -- select all in troup
  
  reaper.Main_OnCommand(40297, 0)--unselect tracks
  noitem=0
  
  counts = reaper.CountSelectedMediaItems(0)
  if counts>0 then
    reaper.Main_OnCommand(40061, 0) --split items
  end
  
  items = reaper.CountSelectedMediaItems(0)
    
    i=0
    
    while i<items do
    
      item = reaper.GetSelectedMediaItem(0, i)
      
      pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
              --earlypos=pos
      pos2 = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
      pos2 = pos+pos2
      
      if pos>=startOut and pos2<=endOut then
      
        track = reaper.GetMediaItem_Track(item)
        reaper.SetTrackSelected(track, true)
      
      end
      
      
      
      i=i+1
    
    end
  
  reaper.Main_OnCommand(40289, 0) --unselect all
  
  --counts = reaper.CountSelectedMediaItems(0)
  --if counts>0 then
    reaper.Main_OnCommand(40718, 0) --select all items in time selection no se tracks
  --end
  
  nothing=0
    earlypos=0
    latepos=0
    
    loopStart, loopEnd = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
    items = reaper.CountSelectedMediaItems(0)
    i=0
    
    item = reaper.GetSelectedMediaItem(0, i)
  if item then
      
        pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
        earlypos=pos
        pos2 = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
        pos2 = pos+pos2
        latepos=pos2
        if pos>=loopStart and pos2<=loopEnd then
          nothing=1
        else
          nothing=0
        end
        i=i+1
    while i<items do
      --reaper.ShowMessageBox(nothing,"TEST",0)
      item = reaper.GetSelectedMediaItem(0, i)
      pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
      if pos<earlypos then
        earlypos=pos
      end
      pos2 = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
      pos2 = pos+pos2
      if pos2>latepos then
        latepos=pos2
      end
      if pos>=loopStart and pos2<=loopEnd then
        nothing=1
      else
        nothing=0
      end
      i=i+1
    end
    --reaper.ShowMessageBox(nothing,"TEST",0)
    if nothing==0 then
      reaper.GetSet_LoopTimeRange(true, false, earlypos, latepos, false)
    end
    
  else
    noitem=1
  end
    

  if noitem==0 then
  loopStart, loopEnd = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  reaper.GetSet_LoopTimeRange(true, false, loopEnd, loopEnd+(loopEnd-loopStart), false)
  --reaper.Main_OnCommand(40032, 0)--all group memebers
  
  
  counts = reaper.CountSelectedMediaItems(0)
    if counts>0 then
      
    
      
      reaper.Main_OnCommand(40061, 0) --split items
    end
    
    
  --reaper.Main_OnCommand(41295, 0)--duplicate
  --reaper.Main_OnCommand(40290, 0)--time selection matches item
  
  
  --reaper.Main_OnCommand(40289, 0) --unselect all items
  
  --reaper.Main_OnCommand(40718, 0) --select all items in time selection no selected tracks
        
        reaper.SetEditCurPos(loopEnd+(loopEnd-loopStart), true, true)
        
        --counts = reaper.CountSelectedMediaItems(0)
          --if counts>0 then
            
            
            reaper.Main_OnCommand(40718, 0) --select all items in time selection no se tracks
          --end
        
      counts = reaper.CountSelectedMediaItems(0)
        if counts>0 then
          reaper.Main_OnCommand(40032, 0) --grup items
          reaper.Main_OnCommand(40061, 0) --split items
        end
      
     reaper.Main_OnCommand(40006, 0)--remove items
     
     reaper.GetSet_LoopTimeRange(true, false, loopStart, loopEnd, false) 
    
    --reaper.Main_OnCommand(40061, 0)
    
    --reaper.Main_OnCommand(40289, 0) --unselect all items
      
      --counts = reaper.CountSelectedMediaItems(0)
        --if counts>0 then
          reaper.Main_OnCommand(40718, 0) --select all items in time selection no se tracks
        --end
    
    counts = reaper.CountSelectedMediaItems(0)
      if counts>0 then
        reaper.Main_OnCommand(40061, 0) --split items
      end
    
    
    
    --reaper.Main_OnCommand(40697, 0) --delete
  --reaper.GetSet_LoopTimeRange(true, false, loopStart, loopEnd, false)
  --reaper.Main_OnCommand(40718, 0) --select all items in time selection no selected tracks
  reaper.Main_OnCommand(41296, 0) -- duplicate selected area of items
  
  counts = reaper.CountSelectedMediaItems(0)
  i=0
  array={}
  arrayb={}
  while i<counts do
    array[i]=reaper.GetSelectedMediaItem(0, i)
    i=i+1
  end
  reaper.Main_OnCommand(40289, 0)--unselect all items
  i=0
  while i<counts do
    groups=reaper.GetMediaItemInfo_Value(array[i], "I_GROUPID")
    if groups~=0 then
      --reaper.ShowMessageBox(groups,"TEST",0)
      reaper.SetMediaItemInfo_Value(array[i], "I_GROUPID", groups+10)
    end
    i=i+1
  end
  
  i=0
  while i<counts do
    reaper.SetMediaItemSelected(array[i], true)  
    i=i+1
  end
  
  --]]
  end
  
  
  --if noitem==1 then
    --reaper.SetEditCurPos(loopStart, true, true)
    --reaper.GetSet_LoopTimeRange(true, false, loopStart, loopEnd, false)  
  --end
  --reaper.Main_OnCommand(40032, 0) -- group items
  --reaper.SetEditCurPos(loopEnd, true, true)
  --reaper.Main_OnCommand(40635, 0) -- remove time selection
  
end

reaper.Undo_EndBlock("Duplicate", 0)

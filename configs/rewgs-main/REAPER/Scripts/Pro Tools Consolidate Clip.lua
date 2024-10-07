reaper.Undo_BeginBlock()

startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)

itemTest =  reaper.GetSelectedMediaItem(0, 0)

if itemTest then
group = reaper.GetMediaItemInfo_Value(itemTest, "I_GROUPID")
else
group=0
end

if group==0 then

if startOut==endOut then

  items = reaper.CountSelectedMediaItems(0)
  
  if items>0 then
    
    reaper.Main_OnCommand(40297, 0) --unselect all tracks
    
    i=0
    
    tempItem = reaper.GetSelectedMediaItem(0, i)
    tempItem1=tempItem
          
          timeStart = reaper.GetMediaItemInfo_Value(tempItem, "D_POSITION")
          
          timeEnd = reaper.GetMediaItemInfo_Value(tempItem, "D_LENGTH")
          
          timeEnd = timeEnd + timeStart
          
    track = reaper.GetMediaItem_Track(tempItem1)
          
          reaper.SetTrackSelected(track, true)     
          
    i=i+1
    
   
    
    while i<items do
    
      tempItem = reaper.GetSelectedMediaItem(0, i)
      
      timeStart1 = reaper.GetMediaItemInfo_Value(tempItem, "D_POSITION")
      
      timeEnd1 = reaper.GetMediaItemInfo_Value(tempItem, "D_LENGTH")
      
      timeEnd1 = timeEnd1 + timeStart1
      
      track = reaper.GetMediaItem_Track(tempItem)
      
      reaper.SetTrackSelected(track, true)
      
      if timeStart1<timeStart then
        timeStart=timeStart1
      end
      if timeEnd1>timeEnd then
        timeEnd=timeEnd1
      end
      
      i=i+1
    
    end
    
    selTracks = reaper.CountSelectedTracks(0)
    
    i=0
    
    array={}
    array1={}
    
    while i<selTracks do
    
      track = reaper.GetSelectedTrack(0, i)
    
      array1[i] = track
      
      --reaper.ShowMessageBox(tostring(track),"TEST",0)
      
      i=i+1
    
    end
    
    i=0
    
    --reaper.Main_OnCommand(40289, 0) --unselect all tracks
    reaper.GetSet_LoopTimeRange(true, true, timeStart, timeEnd, false)
    reaper.Main_OnCommand(40061, 0) --split items at time selection
    
    while i<selTracks do
    
      reaper.Main_OnCommand(40289, 0) --unselect all items
      reaper.Main_OnCommand(40297, 0) --unselect all tracks
      
      reaper.SetTrackSelected(array1[i], true)
      
      
      
      reaper.Main_OnCommand(40718, 0) --select items on selected track
      
      tempItem1 = reaper.GetSelectedMediaItem(0, 0)      
      take = reaper.GetActiveTake(tempItem1)
      retval, array[i] = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", false)
      
      --reaper.ShowMessageBox(tostring(array[i]),"TEST",0)
      
      i=i+1
    
    end
    
    i=0
    
    while i<selTracks do
    
      reaper.SetTrackSelected(array1[i], true)
      
      i=i+1
    
    end
    
    --reaper.GetSet_LoopTimeRange(true, true, timeStart, timeEnd, false)
    
    reaper.Main_OnCommand(40718, 0) --select all items in time selection on track
    
    reaper.Main_OnCommand(40061, 0) --split items at time selection
    
    reaper.Main_OnCommand(41588, 0) --glue items
    i=0
    
    items = reaper.CountSelectedMediaItems(0)
    
    while i<items do
    
      tempItem1 = reaper.GetSelectedMediaItem(0, i)
      take = reaper.GetActiveTake(tempItem1)
      reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", array[i], true)
      i=i+1  
    end
    
    reaper.Main_OnCommand(41173, 0) --move cursor to start of items
    reaper.Main_OnCommand(40289, 0) --unselect all items
    reaper.Main_OnCommand(40635, 0) --remove time selection
--]]
  end

else

items = reaper.CountSelectedMediaItems(0)

  
  if items>0 then
  
    i=0
    
    tempItem = reaper.GetSelectedMediaItem(0, i)
    tempItem1=tempItem
    
    
          
    i=i+1
    
    reaper.Main_OnCommand(40297, 0) --unselect all tracks
    
    track = reaper.GetMediaItem_Track(tempItem)
        
        reaper.SetTrackSelected(track, true)
    
    while i<items do
    
      tempItem = reaper.GetSelectedMediaItem(0, i)
      
      track = reaper.GetMediaItem_Track(tempItem)
      
      reaper.SetTrackSelected(track, true)
      
      i=i+1
    
    end
    
    selTracks = reaper.CountSelectedTracks(0)
    
    i=0
    
    array={}
    array1={}
    
    while i<selTracks do
    
      track = reaper.GetSelectedTrack(0, i)
    
      array1[i] = track
      
      --reaper.ShowMessageBox(tostring(track),"TEST",0)
      
      i=i+1
    
    end
    
    i=0
    
    --reaper.Main_OnCommand(40289, 0) --unselect all tracks
    reaper.GetSet_LoopTimeRange(true, true, startOut, endOut, false)
    reaper.Main_OnCommand(40061, 0) --split items at time selection
    
    while i<selTracks do
    
      reaper.Main_OnCommand(40289, 0) --unselect all items
      reaper.Main_OnCommand(40297, 0) --unselect all tracks
      
      reaper.SetTrackSelected(array1[i], true)
      
      
      
      reaper.Main_OnCommand(40718, 0) --select items on selected track
      
      tempItem1 = reaper.GetSelectedMediaItem(0, 0)      
      take = reaper.GetActiveTake(tempItem1)
      retval, array[i] = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", false)
      
      --reaper.ShowMessageBox(tostring(array[i]),"TEST",0)
      
      i=i+1
    
    end
    
    i=0
    
    while i<selTracks do
    
      reaper.SetTrackSelected(array1[i], true)
      
      i=i+1
    
    end
    
    --reaper.GetSet_LoopTimeRange(true, true, timeStart, timeEnd, false)
    
    reaper.Main_OnCommand(40718, 0) --select all items in time selection on track
    
    
    reaper.Main_OnCommand(41588, 0) --glue items
    i=0
    
    items = reaper.CountSelectedMediaItems(0)
    
    while i<items do
    
      tempItem1 = reaper.GetSelectedMediaItem(0, i)
      take = reaper.GetActiveTake(tempItem1)
      reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", array[i], true)
      i=i+1  
    end
    
    reaper.Main_OnCommand(41173, 0) --move cursor to start of items
    reaper.Main_OnCommand(40289, 0) --unselect all items
    reaper.Main_OnCommand(40635, 0) --remove time selection
--]]
  end

--reaper.Main_OnCommand(40061, 0) --split items at time selection
--reaper.Main_OnCommand(41588, 0) --glue items
--reaper.Main_OnCommand(41173, 0) --move cursor to start of items
--reaper.Main_OnCommand(40289, 0) --unselect all items
--reaper.Main_OnCommand(40635, 0) --remove time selection

end

else

if startOut==endOut then
    
    reaper.Main_OnCommand(40290, 0) --time selection to items
    
    reaper.Main_OnCommand(40034, 0) -- select all in group
    --[[
    items = reaper.CountSelectedMediaItems(0)
    
     i=0
     
     while i<items do
     
       item = reaper.GetSelectedMediaItem(0, i)
       
       track = reaper.GetMediaItem_Track(item)
       
       reaper.SetTrackSelected(track, true)
       
       i=i+1
     
     end
    
    --]]
    reaper.Main_OnCommand(40061, 0) --split items at time selection
    
    startOut, endOut = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
    
    
    
    
    
    
    
    
    
    
    
    items = reaper.CountSelectedMediaItems(0)
    
      
      if items>0 then
      
        i=0

        
        reaper.Main_OnCommand(40297, 0) --unselect all tracks
        
        while i<items do
        
          tempItem = reaper.GetSelectedMediaItem(0, i)
          
          track = reaper.GetMediaItem_Track(tempItem)
          
          reaper.SetTrackSelected(track, true)
          
          i=i+1
        
        end
        
        selTracks = reaper.CountSelectedTracks(0)
        
        i=0
        
        array={}
        array1={}
        
        while i<selTracks do
        
          track = reaper.GetSelectedTrack(0, i)
        
          array1[i] = track
          
          --reaper.ShowMessageBox(tostring(track),"TEST",0)
          
          i=i+1
        
        end
        
        i=0
        
        --reaper.Main_OnCommand(40289, 0) --unselect all tracks
        reaper.GetSet_LoopTimeRange(true, false, startOut, endOut, false)
        reaper.Main_OnCommand(40061, 0) --split items at time selection
        
        while i<selTracks do
        
          reaper.Main_OnCommand(40289, 0) --unselect all items
          reaper.Main_OnCommand(40297, 0) --unselect all tracks
          
          reaper.SetTrackSelected(array1[i], true)
          
          
          
          reaper.Main_OnCommand(40718, 0) --select items on selected track
          
          tempItem1 = reaper.GetSelectedMediaItem(0, 0)      
          take = reaper.GetActiveTake(tempItem1)
          retval, array[i] = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", false)
          
          --reaper.ShowMessageBox(tostring(array[i]),"TEST",0)
          
          i=i+1
        
        end
        
        i=0
        
        while i<selTracks do
        
          reaper.SetTrackSelected(array1[i], true)
          
          i=i+1
        
        end
        
        --reaper.GetSet_LoopTimeRange(true, true, timeStart, timeEnd, false)
        
        --reaper.Main_OnCommand(40718, 0) --select all items in time selection on track
        
        
        --reaper.Main_OnCommand(41588, 0) --glue items
        
        
        --reaper.Main_OnCommand(41173, 0) --move cursor to start of items
        --reaper.Main_OnCommand(40289, 0) --unselect all items
        --reaper.Main_OnCommand(40635, 0) --remove time selection
    
      end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    reaper.GetSet_LoopTimeRange(true, false, startOut, endOut, false)
    
    --reaper.Main_OnCommand(40289, 0) --unselect all items
    reaper.Main_OnCommand(40718, 0) --select all items in time selection no selected tracks

    reaper.Main_OnCommand(41588, 0) --glue items
    
    i=0
            
            items = reaper.CountSelectedMediaItems(0)
            
            while i<items do
            
              tempItem1 = reaper.GetSelectedMediaItem(0, i)
              take = reaper.GetActiveTake(tempItem1)
              reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", array[i], true)
              i=i+1  
            end
    
    reaper.Main_OnCommand(40032, 0) --group items
    reaper.Main_OnCommand(41173, 0) --move cursor to start of item
    reaper.Main_OnCommand(40289, 0) --unselect all items
    reaper.Main_OnCommand(40635, 0) --remove time selection
--]]
else

reaper.Main_OnCommand(40034, 0) -- select all in group
  --[[
  items = reaper.CountSelectedMediaItems(0)
  
  i=0
  
  while i<items do
  
    item = reaper.GetSelectedMediaItem(0, i)
    
    track = reaper.GetMediaItem_Track(item)
    
    reaper.SetTrackSelected(track, true)
    
    i=i+1
  
  end--]]
  
  
  reaper.Main_OnCommand(40061, 0) --split items at time selection
      
      startOut, endOut = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  
  
  
  items = reaper.CountSelectedMediaItems(0)
      
        
        if items>0 then
        
          i=0
  
          
          reaper.Main_OnCommand(40297, 0) --unselect all tracks
          
          while i<items do
          
            tempItem = reaper.GetSelectedMediaItem(0, i)
            
            track = reaper.GetMediaItem_Track(tempItem)
            
            reaper.SetTrackSelected(track, true)
            
            i=i+1
          
          end
          
          selTracks = reaper.CountSelectedTracks(0)
          
          i=0
          
          array={}
          array1={}
          
          while i<selTracks do
          
            track = reaper.GetSelectedTrack(0, i)
          
            array1[i] = track
            
            --reaper.ShowMessageBox(tostring(track),"TEST",0)
            
            i=i+1
          
          end
          
          i=0
          
          --reaper.Main_OnCommand(40289, 0) --unselect all tracks
          reaper.GetSet_LoopTimeRange(true, false, startOut, endOut, false)
          reaper.Main_OnCommand(40061, 0) --split items at time selection
          
          while i<selTracks do
          
            reaper.Main_OnCommand(40289, 0) --unselect all items
            reaper.Main_OnCommand(40297, 0) --unselect all tracks
            
            reaper.SetTrackSelected(array1[i], true)
            
            
            
            reaper.Main_OnCommand(40718, 0) --select items on selected track
            
            tempItem1 = reaper.GetSelectedMediaItem(0, 0)      
            if tempItem1~=nil then
              take = reaper.GetActiveTake(tempItem1)
              retval, array[i] = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", false)
            else
              array[i] = "nothing" 
            end
            
            i=i+1
            --reaper.ShowMessageBox(tostring(array[i]),"TEST",0)
            
            
          
          end
          
          i=0
          
          while i<selTracks do
          
            reaper.SetTrackSelected(array1[i], true)
            
            i=i+1
          
          end
          
          --reaper.GetSet_LoopTimeRange(true, true, timeStart, timeEnd, false)
          
          --reaper.Main_OnCommand(40718, 0) --select all items in time selection on track
          
          
          --reaper.Main_OnCommand(41588, 0) --glue items
          
          
          --reaper.Main_OnCommand(41173, 0) --move cursor to start of items
          --reaper.Main_OnCommand(40289, 0) --unselect all items
          --reaper.Main_OnCommand(40635, 0) --remove time selection
      
        end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


--reaper.Main_OnCommand(40061, 0) --split items at time selection
--reaper.Main_OnCommand(40289, 0) --unselect all items
reaper.Main_OnCommand(40718, 0) --select all items in time selection no selected tracks
    
    
    reaper.Main_OnCommand(41588, 0) --glue items
    
    
    i=0
                
                items = reaper.CountSelectedMediaItems(0)
                
                while i<items do
                
                  tempItem1 = reaper.GetSelectedMediaItem(0, i)
                  take = reaper.GetActiveTake(tempItem1)
                  while array[i]=="nothing" do
                    i=i+1
                  end
                  reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", array[i], true)
                  i=i+1  
                end
--reaper.Main_OnCommand(41173, 0) --move cursor to start of items
--reaper.Main_OnCommand(40718, 0) --select all items in time selection no selected tracks
    reaper.Main_OnCommand(40032, 0) --group items
    reaper.Main_OnCommand(41173, 0) --move cursor to start of items
reaper.Main_OnCommand(40289, 0) --unselect all items
reaper.Main_OnCommand(40635, 0) --remove time selection
--]]
end

end

reaper.Undo_EndBlock("Consolidate like Pro Tools", 0)

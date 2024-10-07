reaper.Undo_BeginBlock()

startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)

items = reaper.CountSelectedMediaItems(0)

if items>0 then

  if startOut==endOut then
  
    reaper.Main_OnCommand(40290, 0)
  
  end
  
  startOut, endOut = reaper.GetSet_LoopTimeRange(false, true, 0, 0, false)

  reaper.Main_OnCommand(40297, 0) --unselect all tracks
  
  i=0
      
  while i<items do
      
    tempItem = reaper.GetSelectedMediaItem(0, i)
        
    track = reaper.GetMediaItem_Track(tempItem)
        
    reaper.SetTrackSelected(track, true)
        
    i=i+1
      
  end
  
  selTracks = reaper.CountSelectedTracks(0)
  
  i=0
      
  --array={}
  array1={}
      
  while i<selTracks do
      
    track = reaper.GetSelectedTrack(0, i)
      
    array1[i] = track
                
    i=i+1
      
  end
  
  b=0
  
  while b<selTracks do
    
    reaper.Main_OnCommand(40297, 0) --unselect all tracks
    
    reaper.Main_OnCommand(40289, 0) --unselect all items
    
    reaper.GetSet_LoopTimeRange(true, true, startOut, endOut, false)
    
    --reaper.ShowMessageBox("poop", "", 1)
    
    doit=0
    
    reaper.SetTrackSelected(array1[b], true)
    
    reaper.Main_OnCommand(40718, 0) --select all items in track
    
    items = reaper.CountSelectedMediaItems(0)
    
    array = {}
    
    i=0
    
    while (i<items) do
      array[i] = {}
      i=i+1
    end
    
    i=0
    
    while (i<items) do
      array[i][0] = i
      array[i][1] = reaper.GetSelectedMediaItem(0, i)
      array[i][2] = reaper.GetMediaItemInfo_Value(array[i][1], "D_POSITION");
      array[i][3] = reaper.GetMediaItemInfo_Value(array[i][1], "D_LENGTH");
      array[i][3] = array[i][3] + array[i][2]
      array[i][4] = reaper.GetMediaItem_Track(array[i][1])
                
      --reaper.SetTrackSelected(array[i][4], true)
      
      i=i+1
    end
    
    i=0
    
    reaper.Main_OnCommand(40289, 0) -- unselect items
    
    --reaper.ShowMessageBox(items, "hmm", 1)
    
    while (i<items-1) do
    
      if array[i][3]>array[i+1][2] or array[i][3]==array[i+1][2] or array[i][3]+0.000001>array[i+1][2] then
         
        
        doit=1
        reaper.SetMediaItemSelected(array[i][1], true)
        reaper.SetMediaItemSelected(array[i+1][1], true)
        while i<items-1 do
          if array[i][3]>array[i+1][2] or array[i][3]==array[i+1][2] or array[i][3]+0.000001>array[i+1][2] then
            reaper.SetMediaItemSelected(array[i+1][1], true)
          else
            
            break
          
          end
            
          i=i+1
         
         end
         
         tempItem1 = reaper.GetSelectedMediaItem(0, 0)      
                   take = reaper.GetActiveTake(tempItem1)
                   retval, name = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", false)
                  
         
         if doit>0 then
          reaper.Main_OnCommand(40362, 0) -- glue
          tempItem1 = reaper.GetSelectedMediaItem(0, 0)      
                    take = reaper.GetActiveTake(tempItem1)
                     
                   reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", name, true)
         end
         
         reaper.Main_OnCommand(40289, 0) --unselect all 
      
      end
      
      i=i+1
    
    end
    
    reaper.Main_OnCommand(40635, 0) -- remove time selection
    
    i=0
    
    
    b=b+1
  
  end
  
  --reaper.GetSet_LoopTimeRange(true, true, timeStart, timeEnd, false)
  --reaper.Main_OnCommand(40061, 0) --split items at time selection

end



reaper.Undo_EndBlock("Commit like Pro Tools", 0)








--[[
items = reaper.CountSelectedMediaItems(0)

array = {}

i=0

while (i<items) do
array[i] = {}
i=i+1
end

i=0

reaper.Main_OnCommand(40297, 0) --unselect all tracks

while (i<items) do
  array[i][0] = i
  array[i][1] = reaper.GetSelectedMediaItem(0, i)
  array[i][2] = reaper.GetMediaItemInfo_Value(array[i][1], "D_POSITION");
  array[i][3] = reaper.GetMediaItemInfo_Value(array[i][1], "D_LENGTH");
  array[i][3] = array[i][3] + array[i][2]
  array[i][4] = reaper.GetMediaItem_Track(array[i][1])
            
  reaper.SetTrackSelected(array[i][4], true)
  --array[ar][3] = reaper.GetMediaItem_Track(array[ar][i])
  --ar=ar+1
  i=i+1
end

selTracks = reaper.CountSelectedTracks(0)

reaper.Main_OnCommand(40289, 0) --unselect all

ar=0
start=0
stop=0
i=0
j=0
array1={}


while (i<items-1) do

--reaper.ShowMessageBox(array[og][3], "hmm", 1)
  --start=0
  --stop=0
  


  if array[i][3]>array[i+1][2] or array[i][3]==array[i+1][2] or array[i][3]+0.000001>array[i+1][2] then
   
    --reaper.ShowMessageBox(tostring(array[1][1]), "hmm", 1)
   reaper.SetMediaItemSelected(array[i][1], true)
   reaper.SetMediaItemSelected(array[i+1][1], true)
   while i<items-1 do
    if array[i][3]>array[i+1][2] or array[i][3]==array[i+1][2] or array[i][3]+0.000001>array[i+1][2] then
      reaper.SetMediaItemSelected(array[i+1][1], true)
    else
      
      break
    end
      
    i=i+1
   end
   --reaper.Main_OnCommand(40362, 0)
         
         
    
    --reaper.Main_OnCommand(40362, 0) -- glue
    t=0
    
    --reaper.Main_OnCommand(40289, 0) --unselect all
  end 
  i=i+1
end     

reaper.GetSet_LoopTimeRange(true, false, 0, 0, false)
--]]

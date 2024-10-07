startOut, endOut = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)

retval, num_markersOut, num_regionsOut = reaper.CountProjectMarkers(0)

if startOut==0 and endOut==0 then

  
  if num_markersOut>0 then
    a=0
    i=0
    while i<num_markersOut+num_regionsOut do
      retval2, isrgnOut, posOut, rgnendOut, nameOut, idexnum = reaper.EnumProjectMarkers(i)
      if nameOut=="=START" then

      startposition = posOut
      a=1
      end
      if nameOut=="=END" then

      endposition = posOut
      a=2
      end
      i = i+1
    end
    
    
    if a==1 then
    reaper.GetSet_LoopTimeRange(true, false, startposition, startposition+1, false)

    end
    
    if a==2 then
      if startposition then
        reaper.GetSet_LoopTimeRange(true, false, startposition, endposition, false)
      else
        reaper.GetSet_LoopTimeRange(true, false, endposition-5, endposition, false)  
      end
    end
  
  
  end
  
  
  if num_markersOut==0 then
  
  
    mediaItems = reaper.CountMediaItems(0)
    
    if mediaItems>0 then
    item = reaper.GetMediaItem(0, 0)
    itemstart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")

    itemDuration = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    itemend = itemstart+itemDuration

    reaper.GetSet_LoopTimeRange(true, false, itemstart, itemend, false)
    else

    reaper.GetSet_LoopTimeRange(true, false, 40, 50, false)
    end
  
  
  
  end



end

masterproj, projfn = reaper.EnumProjects(-1, "NULL")

reaper.Main_OnCommand(41997, 0) --subproject

reaper.Main_OnCommand(40769, 0) --unselect all


















i=0
subproj, projfn = reaper.EnumProjects(i, "NULL")
while subproj do
i=i+1
subproj, projfn = reaper.EnumProjects(i, "NULL")  
end
subproj, projfn = reaper.EnumProjects(i-1, "NULL")

tracks = reaper.CountTracks(0)
i=0
isrgnOut = {}
posOut = {}
rgnendOut = {}
nameOut = {}
idexnum = {}

i=0
b=0
while i<tracks do
tr = reaper.GetTrack(0, i)
retval, trackname = reaper.GetSetMediaTrackInfo_String(tr, "P_NAME", "something", false)
trackname = string.upper(trackname)
if trackname == "VIDEO" then
track = reaper.GetTrack(0, i)
reaper.SetTrackSelected(track, true)
reaper.Main_OnCommand(40210, 0) --copy tracks

reaper.SelectProjectInstance(subproj)

commandID = reaper.NamedCommandLookup("_SWS_SELMASTER")

reaper.Main_OnCommand(commandID, 0) --select master

reaper.Main_OnCommand(40058, 0) --paste track

reaper.SelectProjectInstance(masterproj)

reaper.Main_OnCommand(40769, 0) --unselect all
break
end
i=i+1
b=b+1
end

commandID = reaper.NamedCommandLookup("_SWS_SELMASTER")

reaper.Main_OnCommand(commandID, 0) --select master

commandID = reaper.NamedCommandLookup("_SWSSNAPSHOT_NEWSEL")

reaper.Main_OnCommand(commandID, 0) --New Snapshot on selected track

commandID = reaper.NamedCommandLookup("_SWSSNAPSHOT_COPY")

reaper.Main_OnCommand(commandID, 0) --copy snapshot

reaper.SelectProjectInstance(subproj)

reaper.Main_OnCommand(40769, 0) --unselect all

reaper.Main_OnCommand(40145, 0) --turn off grid mode

commandID = reaper.NamedCommandLookup("_SWS_SELMASTER")

reaper.Main_OnCommand(commandID, 0) --select master



commandID = reaper.NamedCommandLookup("_SWSSNAPSHOT_PASTE")

reaper.Main_OnCommand(commandID, 0) --paste snapshot

reaper.Main_OnCommand(40031, 0) --reposition zoom












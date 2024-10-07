original = reaper.GetSelectedTrack(0, 0)

reaper.Main_OnCommand(40289, 0) --unselect all

reaper.Main_OnCommand(40528, 0) --select item under mouse cursor

items = reaper.CountSelectedMediaItems(0)

if items > 0 then

reaper.Main_OnCommand(40693, 0) --toggle take volume env

reaper.Main_OnCommand(40513, 0) --move edit cursor to mouse cursor

reaper.Main_OnCommand(40289, 0) --unselect all

else

tracks = reaper.CountTracks(0)
i=0
govisible=0
while i<tracks do
track = reaper.GetTrack(0, i)
reaper.SetOnlyTrackSelected(track)
env = reaper.GetTrackEnvelopeByName(track, "Volume")
if env ~= nil then
retval, string = reaper.GetEnvelopeStateChunk(env, "", 0)
m, n = string.find(string, "VIS")
volString = string.sub(string, m+4, m+4)
string1 = string.sub(string, 1, m+3)
string2 = string.sub(string, m+5)
if volString == "1" then
  govisible=govisible+1
end
else
  govisible=-1  
  break
end
i=i+1
end




i=0

if govisible==tracks then

while i<tracks do
track = reaper.GetTrack(0, i)
reaper.SetOnlyTrackSelected(track)
--track = reaper.GetSelectedTrack(0,0)
env = reaper.GetTrackEnvelopeByName(track, "Volume")
if env ~= nil then
retval, string = reaper.GetEnvelopeStateChunk(env, "", 0)
m, n = string.find(string, "VIS")
volString = 0
string1 = string.sub(string, 1, m+3)
string2 = string.sub(string, m+5)
--if volString == "1" then
  --volString = "0"
--else
  
--end
reaper.SetEnvelopeStateChunk(env, string1 .. volString .. string2, 0)
else
    
  reaper.Main_OnCommand(40406, 0) --toggle visible

end
i=i+1
end
--reaper.ShowMessageBox(temptrackname, "hmm", 1)


else


while i<tracks do
track = reaper.GetTrack(0, i)
reaper.SetOnlyTrackSelected(track)
--track = reaper.GetSelectedTrack(0,0)
env = reaper.GetTrackEnvelopeByName(track, "Volume")
if env ~= nil then
retval, string = reaper.GetEnvelopeStateChunk(env, "", 0)
m, n = string.find(string, "VIS")
volString = "1"
string1 = string.sub(string, 1, m+3)
string2 = string.sub(string, m+5)
--if volString == "0" then
  --volString = "1"
--else
 
--end
reaper.SetEnvelopeStateChunk(env, string1 .. volString .. string2, 0)
else
    
  reaper.Main_OnCommand(40406, 0) --toggle visible

end
i=i+1
end


end

end

reaper.Main_OnCommand(40297, 0) --unselect all

reaper.SetTrackSelected(original, true)

reaper.Main_OnCommand(40913, 0) --zoom in on original track


retval, retvals_csv = reaper.GetUserInputs("Marker", 1, "Enter Marker Number", "input")

b = retvals_csv
a = tonumber(retvals_csv)

if a~=nil then
reaper.GoToMarker( reaper.GetCurrentProjectInLoadSave(), a, false)
else
  i=0
  while ret~=0 do
  ret, isrgn, pos, regnedn, name, markid = reaper.EnumProjectMarkers(i)
    if ret==0 then
    break
    end
    if name==b then
    reaper.GoToMarker( reaper.GetCurrentProjectInLoadSave(), markid, false)
    end
  i=i+1
  end
end

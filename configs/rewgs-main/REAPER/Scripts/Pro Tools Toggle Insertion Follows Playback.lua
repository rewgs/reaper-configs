state = reaper.HasExtState("playtoggle", "togglevalue")

if state then
  value = reaper.GetExtState("playtoggle", "togglevalue")
  if value == "1" then
    reaper.SetExtState("playtoggle", "togglevalue", "0", true)
  else
    reaper.SetExtState("playtoggle", "togglevalue", "1", true)
  end
end

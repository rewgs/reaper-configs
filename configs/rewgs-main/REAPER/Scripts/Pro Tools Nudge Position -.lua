path = reaper.get_ini_file()
breaker=0
breaker1=0

f = io.input(path)

i=0

while i==0 do

  a = f:read()
  if a == nil then
    breaker=1
    break
  end
  m, n = string.find(a, "nudge=")
  if m ~= nil then
    n1 = string.sub(a, 7)
    while i==0 do
      a = f:read()
      if a==nil then
        breaker1=1
        break
      end
      m, n = string.find(a, "nudgeamt=")
      if m ~= nil then
        v1 = string.sub(a, 10)
        break
      end
      
    end

    if breaker1==1 then
      value = 1.0
    end
    value = tonumber(v1)

    if n1=="0" then
          nudgeunits=0
        elseif n1=="16" then
          nudgeunits=1
        elseif n1=="288" then
          nudgeunits=18
        elseif n1=="32" then
          nudgeunits=2
        elseif n1=="256" then
          nudgeunits=16
        elseif n1=="272" then
          nudgeunits=17
        elseif n1=="304" then
          nudgeunits=19
        elseif n1=="320" then
          nudgeunits=20
        elseif n1=="336" then
          nudgeunits=21
        else
          nudgeunits=18
        end
    

    f:close()
    
    x = reaper.CountSelectedMediaItems(0)
    
    if x==0 then
    
      reaper.ApplyNudge(0, 0, 6, nudgeunits, value, true, 1)
    
    else
    
      reaper.ApplyNudge(0, 0, 0, nudgeunits, value, true, 1)
    
      item = reaper.GetSelectedMediaItem(0, 0)
    
      itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    
      reaper.SetEditCurPos(itemStart, true, true)
    
    end
    break     
  end

  if breaker==1 then
  nudgeunits = 18
  value = 1.0
    f:close()
        
        x = reaper.CountSelectedMediaItems(0)
        
        if x==0 then
        
          reaper.ApplyNudge(0, 0, 6, nudgeunits, value, true, 1)
        
        else
        
          reaper.ApplyNudge(0, 0, 0, nudgeunits, value, true, 1)
        
          item = reaper.GetSelectedMediaItem(0, 0)
        
          itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
        
          reaper.SetEditCurPos(itemStart, true, true)
        
        end  
  end

end

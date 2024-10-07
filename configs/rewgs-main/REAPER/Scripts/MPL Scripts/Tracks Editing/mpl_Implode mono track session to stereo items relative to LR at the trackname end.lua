-- @description Implode mono track session to stereo items relative to LR at the trackname end
-- @version 1.03
-- @author MPL
-- @website https://forum.cockos.com/showthread.php?t=188335
-- @changelog
--    # fix looping all items instead only first one

  local cached_data = {}
  function CacheDATA()
    for i = 1, reaper.CountTracks(0) do 
      local tr = GetTrack(0,i-1)
      if not cached_data[tr] then cached_data[tr] = {} end
      for it = 1,  reaper.CountTrackMediaItems( tr ) do
        local itptr = reaper.GetTrackMediaItem( tr, it-1 )
        cached_data[tr][#cached_data[tr]+1] = reaper.GetMediaItemInfo_Value( itptr, 'D_POSITION' )
      end
    end
  end
  ---------------------------------------------------
  function MatchItByPosition(trR, itposL)
    for i = 1, #cached_data[trR] do
      if math.abs(cached_data[trR][i]-itposL) < 0.001 then
        return GetTrackMediaItem(trR, i-1)
      end
    end
  end
  ---------------------------------------------------
  function loop_matched_tr(GUIDs, trL, trL_name)
    for j = 1, #GUIDs do
      local trR = VF_GetTrackByGUID(GUIDs[j])
      if ValidatePtr2( 0, trR, 'MediaTrack*' )  then
        local _, trR_name = reaper.GetSetMediaTrackInfo_String(trR, 'P_NAME', '', false)
        if trR ~= trL and trR_name:sub(0,-2)== trL_name:sub(0,-2) then
          for itidx = reaper.CountTrackMediaItems( trL ), 1, -1 do
            local itemL = GetTrackMediaItem(trL, itidx-1)
            local itposL  = GetMediaItemInfo_Value( itemL, 'D_POSITION' )
            local itemR = MatchItByPosition(trR, itposL)
            if itemR then 
              local itposR  = GetMediaItemInfo_Value( itemR, 'D_POSITION' )
              
              local takeL = GetActiveTake( itemL)
              local takeR = AddTakeToMediaItem( itemL )
              local takeR0 = GetActiveTake( itemR )
              local srcR = GetMediaItemTake_Source( takeR0 )
              SetMediaItemTake_Source( takeR, srcR )
              
              SetMediaItemInfo_Value(itemL, 'B_ALLTAKESPLAY', 1) 
              SetMediaItemTakeInfo_Value( takeL, 'I_CHANMODE',3  )
              SetMediaItemTakeInfo_Value( takeL, 'D_PAN',-1 )
              SetMediaItemTakeInfo_Value( takeR, 'I_CHANMODE',4  )  
              SetMediaItemTakeInfo_Value( takeR, 'D_PAN',1 )
              
    
              SetMediaItemTakeInfo_Value( takeR, 'D_STARTOFFS', itposL- itposR  )
              UpdateItemInProject( itemL )
            end
          end
          DeleteTrack( trR )
          return true 
        end
      end  
    end  
  end
  ------------------------------
  function main()
    local  GUIDs = {} for i = 1, reaper.CountTracks(0) do GUIDs[#GUIDs+1] = GetTrackGUID( GetTrack(0,i-1) )  end
    for i = 1, #GUIDs do
      local trL = VF_GetTrackByGUID(GUIDs[i])
      if ValidatePtr2( 0, trL, 'MediaTrack*' )  then
        local _, trL_name = reaper.GetSetMediaTrackInfo_String(trL, 'P_NAME', '', false)
        if trL_name:sub(-1):upper():match('L') then  
          local ret = loop_matched_tr(GUIDs, trL, trL_name)
          if ret then
            GetSetMediaTrackInfo_String(trL, 'P_NAME', trL_name:sub(0,-2)..' (LR)', true)
            local panenv = GetTrackEnvelopeByName( trL, 'Pan' )
            if panenv then  
              DeleteEnvelopePointRangeEx( panenv, -1, -math.huge, math.huge ) 
              InsertEnvelopePointEx( panenv, -1, 0, 0, 0, 0, 0, false )
            end
          end
        end 
      end
    end  
    TrackList_AdjustWindows(false) 
  end
  ---------------------------------------------------------------------
  function VF_CheckFunctions(vrs)  local SEfunc_path = reaper.GetResourcePath()..'/Scripts/MPL Scripts/Functions/mpl_Various_functions.lua'  if  reaper.file_exists( SEfunc_path ) then dofile(SEfunc_path)  if not VF_version or VF_version < vrs then  reaper.MB('Update '..SEfunc_path:gsub('%\\', '/')..' to version '..vrs..' or newer', '', 0) else return true end   else  reaper.MB(SEfunc_path:gsub('%\\', '/')..' not found. You should have ReaPack installed. Right click on ReaPack package and click Install, then click Apply', '', 0) if reaper.APIExists('ReaPack_BrowsePackages') then ReaPack_BrowsePackages( 'Various functions' ) else reaper.MB('ReaPack extension not found', '', 0) end end end
  --------------------------------------------------------------------  
  local ret = VF_CheckFunctions(3.07) if ret then local ret2 = VF_CheckReaperVrs(5.975,true) if ret2 then 
    Undo_BeginBlock2( 0 )
    CacheDATA()
    main() 
    Undo_EndBlock2( 0, 'mpl_Implode mono track session to stereo items relative to LR at the trackname end', 0 )
  end end
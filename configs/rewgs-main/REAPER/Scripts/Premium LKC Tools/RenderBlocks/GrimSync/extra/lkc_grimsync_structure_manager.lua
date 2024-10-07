--[[
	Noindex: true
]]  
--[[
NOTE:This script is called from other scripts, not an action itself. It manages tracks and regions.

ALT+SHIFT+Q		Envelope: Reduce number of selected points by half				Sequence Container
ALT+SHIFT+A		Item edit: Trim left edge of item to edit cursor				Actor-Mixer
АLT+SHIFT+D		//																Blend Container
ALFT+SHIFT+F	//																Folder -- Normal Region
АLT+SHIFT+B		Item: Split item under mouse cursor (select left)				Bus
ALT+SHIFT+R		Markers: Insert region from time selection and edit...			Random Container
ALT+SHIFT+W		//																Switch container
]]
double_click_speed = 0.2

--UTILITIES
function Msg(param)
	reaper.ShowConsoleMsg(tostring(param).."\n")
end
reaper.ClearConsole()






--COLORS
colors = {}
tone = math.random(0,75)
tone2 = math.random(0,30)
colors[0] = reaper.ColorToNative(240-tone,104-tone,101-tone)|0x1000000 	-- light red							--FOLDER
colors[1] = reaper.ColorToNative(255-tone,240-tone,60)|0x1000000 	-- yellow									--SWITCH CONTAINER / MUSIC SWITCH							
colors[2] = reaper.ColorToNative(108-tone,213-tone,101)|0x1000000	-- green 1									--RANDOM CONTAINER
colors[3] = reaper.ColorToNative(101-tone,175-tone,213)|0x1000000 	-- light blue								--ACTOR-MIXER
colors[4] = reaper.ColorToNative(255-tone,165-tone,0+tone2)|0x1000000 	-- оrange								--SEQUENCE CONTAINER / MUSIC PLAYLIST
colors[5] = reaper.ColorToNative(225-tone,108-tone,225)|0x1000000 	-- heavy pink								--BLEND CONTAINER / MUSIC SEGMENT
colors[6] = reaper.ColorToNative(188-tone,188-tone,188-tone)|0x1000000 	-- white								--NO PREFIX
colors[7] = reaper.ColorToNative(30-tone2,30-tone2,30-tone2)|0x1000000 	-- black								--WORK UNIT




function CreateNewRegion()
	if container_prefix == "" then
		local retval, result
		if mega_ignore == nil and path_only == nil then --so it doesn't edit track name when P and I actions are called
			retval, result = reaper.GetUserInputs("Insert new region", 1, "Region name:,extrawidth=300", "")
		else
			result = ""
		end
		
		if result ~= "" then 
			reaper.AddProjectMarker2( 0, true, start_time, end_time, result, 0, colors[color_id] )
			reaper.Main_OnCommand(40635,0) -- remove time selection
		end
	else
		default_name = ""
		retval, result = reaper.GetUserInputs("Insert new region", 2, "WWISE Container Name:,WWISE Container Prefix:,extrawidth=300", default_name..","..container_prefix)
		
		w_name,w_type = string.match( result,"(.+),(.+)" )
		if w_name == nil then w_name = string.gsub(result,",","") end
		
		if w_name ~= nil and w_type ~= nil--[[  ]]  then
			if w_type == nil then w_type = "" end
			reaper.AddProjectMarker2( 0, true, start_time, end_time, w_type..w_name, 0, colors[color_id] )
			reaper.Main_OnCommand(40635,0) -- remove time selection	
		end
	end


end

function EditExistingRegion()
	local cursor_pos = reaper.GetCursorPosition()
	local marker_index, region_index = reaper.GetLastMarkerAndCurRegion( 0, cursor_pos )
	local retval, isrgn, pos, rgnend, name, markrgnindexnumber, color = reaper.EnumProjectMarkers3( 0, region_index )

	name = string.gsub( name,"%[%a+%]","")
	if isrgn == true then
		
		if container_prefix == "" then
			retval, result = reaper.GetUserInputs("Rename region", 1, "Region name:,extrawidth=300", name)
			reaper.SetProjectMarker3( 0, markrgnindexnumber, isrgn, pos, rgnend, result, colors[color_id])
		else
			retval, result = reaper.GetUserInputs("Rename WWISE "..container_type.." region:", 2, "WWISE Container Name:,WWISE Container Prefix:,extrawidth=300", name..","..container_prefix)
			w_name,w_type = string.match( result,"(.+),(.+)" )
			if w_name ~= nil and w_type ~= nil then
				if w_type == nil then w_type = "" end
				reaper.SetProjectMarker3( 0, markrgnindexnumber, isrgn, pos, rgnend, w_type..w_name, colors[color_id])
			end
		end


	end
end

function EditTrackName()
	-- track = reaper.BR_GetMouseCursorContext_Track() --disable for now
	local track = reaper.GetSelectedTrack(0, 0)
	if track then
		retval, track_name = reaper.GetTrackName( track, "" )
		track_name = string.gsub( track_name,"%[%a+%]","")
		track_name = string.gsub( track_name,"Track %d+", "" )
		local retval, result
		if container_prefix == "" then
			if mega_ignore == nil and path_only == nil then --so it doesn't edit track name when P and I actions are called
				retval, result = reaper.GetUserInputs("Rename Track to "..container_type..":", 1, "Тrack name:,extrawidth=300", track_name)
			else
				result = track_name
			end
		else
			retval, result = reaper.GetUserInputs("Rename Track to "..container_type..":", 2, "WWISE Container Name:,WWISE Container Prefix:,extrawidth=300", track_name..","..container_prefix)
		end
		if retval == true then
			w_name,w_type = string.match( result,"(.+),(.+)" )
			if w_name == nil then w_name = string.gsub(result,",","") end

			if w_name ~= nil then
				if w_type == nil then w_type = "" end
				
                retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( track, "P_NAME", w_type..w_name, true ) 
                
                if container_type ~= nil and container_type ~= "" then
                    local icon = container_type
                    if icon == "Folder" then icon = "Virtual Folder" end
                    icon = string.lower(icon)
                    icon = string.gsub(icon," ", "_")
                    icon = "wwise_" .. icon .. ".png"

                    if remove_track_icon then icon = "" end
                    
                    retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( track, "P_ICON", icon, true )
                end
			end	
		end
	end
	
end

function SetRegionType()
	if window == "arrange" then --do not use mouse cursor for changing region if toolbar is active
		reaper.PreventUIRefresh(1)
		reaper.Main_OnCommand(reaper.NamedCommandLookup("_BR_SAVE_CURSOR_POS_SLOT_1"),0) --SWS/BR: Save edit cursor position, slot1
		reaper.Main_OnCommand(40514,0)--move edit cursor to mouse cursor
	end
	
	local cursor_pos = reaper.GetCursorPosition()
	local marker_index, region_index = reaper.GetLastMarkerAndCurRegion( 0, cursor_pos )
	local retval, isrgn, pos, rgnend, name, markrgnindexnumber, color = reaper.EnumProjectMarkers3( 0, region_index )
	
	name = HandleType(name)

	if mega_ignore or path_only then
		color = color
	else
		color = colors[color_id]
	end

	reaper.SetProjectMarker3( 0, markrgnindexnumber, isrgn, pos, rgnend, name, color)
	
	if window == "arrange" then
		reaper.Main_OnCommand(reaper.NamedCommandLookup("_BR_RESTORE_CURSOR_POS_SLOT_1"),0) --SWS/BR: restore edit cursor position, slot1
		reaper.PreventUIRefresh(-1)
	end
end


function HandleType(name)
		--if it needs to set //prefix
		if mega_ignore then
			local ignored = string.match(name,"^//")
			-- Msg(ignored)
			if ignored then
				name = string.gsub(name,"^//","")
			else
				--remove braces
				-- Msg("remove braces")
				name = string.gsub(name,"%(","")
				name = string.gsub(name,"%)","")
				name = [[//]]..name
			end
		else

			--if it need to set [b]name into [b](name)
			if path_only then -- path only
				local ignored = string.match(name,"%(.*%)") -- check if there is a part with ()
				if ignored then
					--REMOVE - PATH ONLY - BRACES
					-- Msg("remove braces")
					name = string.gsub(name,"%(","")
					name = string.gsub(name,"%)","")
				else
					--SET PATH ONLY - BRACES
					-- Msg("add braces")

					--remove // prefix
					name = string.gsub(name,"//","")
					
					local prefix,sufix = string.match(name,"(%[%a+%])(.*)") -- split [r]name to [r] and name
					if prefix == nil then prefix = "" end
					if sufix == nil then sufix = name end

					name = [[(]]..sufix..[[)]] --set path only prefix, put in braces
					name = prefix..name

				end
			else
				--remove the type prefix
				name = string.gsub( name,"%[%a+%]","")
			end




			--keep the ignore if if there is already one
			local ignore_prefix = ""
			local ignored = string.match(name,"^//")
			if ignored then 
				name = string.gsub(name,"^//","")
				ignore_prefix = [[//]]
			end


			--change the track type
			name = ignore_prefix..container_prefix..name
		end
	
		return name
end

function SetTrackType()
	-- local track = reaper.BR_GetMouseCursorContext_Track() --disable for now
	local track = reaper.GetSelectedTrack(0, 0)
	if track then
		local retval, name = reaper.GetTrackName( track ,"")
		
		name = HandleType(name)

		--do not name tracks which are unnamed
		local noname = string.match( name,"Track %d+" )
		if noname ~= nil then
			name = "" 
			EditTrackName() -- edit track name if there is one
		else
			local icon = container_type
			if icon == "Folder" then icon = "Virtual Folder" end
            icon = string.lower(icon)
            icon = string.gsub(icon," ", "_")
            icon = "wwise_" .. icon .. ".png"

            if remove_track_icon then icon = "" end

			retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( track, "P_NAME", name, true ) 
			retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( track, "P_ICON", icon, true )
		end
	else
		--create new track if there is no time selection
		-- reaper.Main_OnCommand(40001,0) -- insert new track
		-- SetTrackType()
	end
end



function Main()
	--mouse cursor context info
	-- window, segment, details = reaper.BR_GetMouseCursorContext() -- disabled for now


	if container_prefix == nil then container_prefix = "" end
	if container_type == nil then container_type = "" end
	if color_id == nil then color_id = 6 end
	
	
	start_time, end_time =  reaper.GetSet_LoopTimeRange2( 0, false, false, 0, 0, false)
	selection_length= end_time - start_time
	

	--DOUBLE CLICK LOGIC=====================================================================================================================
	
	local prev_time = tonumber(reaper.GetExtState("LKC_TOOLS","dnaming_call_time"))
	local sys_time = reaper.time_precise()
	script_call_interval = nil
	if prev_time ~= nil then
		script_call_interval = sys_time - prev_time
	end
	reaper.SetExtState("LKC_TOOLS","dnaming_call_time",sys_time,true)

	if window == "tcp" then -- HANDLE TRACKS
		SetTrackType() --single click
		-- if script_call_interval then
		-- 	if script_call_interval < double_click_speed and disable_doubleclick == nil then
		-- 		EditTrackName() --double click
		-- 	end
		-- end
	else	-- HANDLE REGIONS
		if selection_length > 0 and mega_ignore == nil and path_only == nil then -- mega ignore and path only are here so it can ignore region with edit cursor even if there is time selection someplace else
			CreateNewRegion() --create
		else -- CHANGE SELECTED REGION (BASED ON CURSOR POSITION)
			--first do the one click action
			SetRegionType()
			--handle double click
			-- if script_call_interval ~= nil then
			-- 	if script_call_interval < double_click_speed and disable_doubleclick == nil then
			-- 		--do double click action
			-- 		EditExistingRegion()
			-- 	end
			-- end
		end
	end

	-- reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWSAUTOCOLOR_APPLY"),0) --SWS: Apply auto coloring
end



Main()
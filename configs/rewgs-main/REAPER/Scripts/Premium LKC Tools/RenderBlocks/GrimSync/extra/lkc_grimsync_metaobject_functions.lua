--[[
	Noindex: true
]]  
META_OBJECT = {}

META_OBJECT.change_name = function (name)
	-- reaper.ShowConsoleMsg("name:"..name.."\n")
	
	--detect stuff-----------------------------------------------------------
	
	--check if container
	-- reaper.ShowConsoleMsg("container_type:"..tostring(container_type).."\n")
	local container_type = string.match(name, "%[%a+%]")
	if container_type then
		name = string.gsub( name,"%[%a+%]","")
	end

	
	--check if ignored
	local ignored = string.match(name, "^(//).*")
	-- reaper.ShowConsoleMsg("ignored:"..tostring(ignored).."\n")
	if ignored then
		name = string.gsub( name,"^(//)","")
	end
	
	--check if path only
	local path_only = string.match(name, "(%(.*%))")
	if path_only then
		name = string.match( name,"%((.*)%)")
	end
	-- reaper.ShowConsoleMsg("path_only:"..tostring(path_only).."\n")
	
	--check if event
	local event = string.match(name, ".*(%+)$")
	-- reaper.ShowConsoleMsg("event:"..tostring(event).."\n")
	if event then
		name = string.gsub(name, "+", "")
	end
	

	--set stuff-----------------------------------------------------------
	local retval, new_name = reaper.GetUserInputs("Rename region", 1, "Region name:,extrawidth=300", name)
	
	if event then
		new_name = new_name .. "+"
	end

	if path_only then
		new_name = "("..new_name..")"
	end

	if container_type then
		new_name = container_type..new_name
	end
	
	if ignored then
		new_name = "//" .. new_name
	end


	return new_name
end

META_OBJECT.toggle_event = function(name)

	--check if ignored
	local ignored = string.match(name, "^(//).*")
	-- reaper.ShowConsoleMsg("ignored:"..tostring(ignored).."\n")
	if ignored then
		name = string.gsub( name,"^(//)","")
	end


	local container_type = string.match(name, "%[%a+%]")
	if container_type then
		name = string.gsub( name,"%[%a+%]","")
	end


	local path_only = string.match(name, "(%(.*%))")
	if path_only then
		name = string.match( name,"%((.*)%)")
	end

	--is event?------------------------------------------------------------------
	local event = string.match(name,"%+$")
	if event then
		name = string.gsub(name, "+", "")
	else
		name = name .. "+"
	end
	--is event?------------------------------------------------------------------


	
	if path_only then
		name = "("..name..")"
	end

	if container_type then
		name = container_type..name
	end
	
	if ignored then
		name = "//" .. name
	end

	return name
end
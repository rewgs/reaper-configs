--[[
	Noindex: true
]]

local sws = reaper.APIExists("CF_GetClipboardBig")
if sws then
    --OS INFO
    platform = reaper.GetOS()
    if platform == "OSX64" or platform == "OSX32" or platform == "OSX" or platform  == "Other" or platform == "macOS-arm64" then
        separator = [[/]]
    else
        separator = [[\]]	--win
    end

    local info = debug.getinfo(1,'S');
    script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]

    bin="x64"
    if platform == "Win32" or platform == "OSX32" then bin="x86" end


    --USER SETTINGS
    --[[
        Cluster Varaint 1: Label items are excluded from calculation
            Pros: Blocks can be directly on top of each other
            Cons: Editing unpacked blocks can lead to larger number of small blocks when repacked

        Cluster Variant 2: Label items are included in calculation
            Pros: labels are like anchors for clusters, allows greater editing flexibility
            Cons: Blocks cannot be layered on top of each other
    ]]
    cluster_variant = 1
    create_regions = 0
    VERTICAL_ONLY = 1

    luac = "53"
    if string.sub(reaper.GetAppVersion(),1,1) == "7" then luac = "54" end

    wrap_unwrap_dll = script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_renderblocks_pack_unpack.dll]]
    dofile(script_path..[[Data]]..separator..luac..separator..bin..separator..[[lkc_renderblocks_pack_clusters.dll]])
else
    reaper.ShowMessageBox("Please install SWS Extension version 2.9.7 or higher from:\nhttps://sws-extension.org/", "NO SWS FOUND", 0)
end
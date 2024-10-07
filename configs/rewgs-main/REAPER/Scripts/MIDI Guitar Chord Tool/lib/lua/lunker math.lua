------------------------------------------------------------------------------------------------------------------------

--[[

    Copied from here: https://rosettacode.org/wiki/Statistics/Normal_distribution#Lua
    Renamed and modified to use (mean, sd) instead of (mean, variance)

function gaussian (mean, variance)
    return  math.sqrt(-2 * variance * math.log(math.random())) *
            math.cos(2 * variance * math.pi * math.random()) + mean
end

--]]

function xGauss (mean, sd)
    local variance = sd ^ 2;
    return  mean +
            math.sqrt (-2 * variance * math.log (math.random ())) *
            math.cos  ( 2 * variance * math.pi * math.random ());
end

------------------------------------------------------------------------------------------------------------------------

--[[
function UnbiasedRoundTowardZero (x)

    local floor = math.floor (x);

    if (x == floor) or (x % 2.0 == 0.5) then
        return floor;
    else
        return math.floor (x + 0.5);
    end

end -- function UnbiasedRoundTowardZero
--]]

------------------------------------------------------------------------------------------------------------------------

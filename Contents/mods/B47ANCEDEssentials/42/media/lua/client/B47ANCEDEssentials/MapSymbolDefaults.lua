require "ISUI/Maps/ISMap"

B47ANCEDEssentials=B47ANCEDEssentials or {}

local vanillaScale=tonumber(ISMap and ISMap.SCALE) or 0.666

function B47ANCEDEssentials.applyMapSymbolDefaultScale()
    if not ISMap then return false end
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials
    if values and values.EnableMapSymbolDefaultScale==false then
        ISMap.SCALE=vanillaScale
        return false
    end
    local percent=tonumber(values and values.MapSymbolDefaultScalePercent) or 100
    percent=math.max(25,math.min(300,percent))
    ISMap.SCALE=vanillaScale*percent/100
    return true
end

if Events and Events.OnGameStart then Events.OnGameStart.Add(B47ANCEDEssentials.applyMapSymbolDefaultScale) end
B47ANCEDEssentials.applyMapSymbolDefaultScale()
return B47ANCEDEssentials

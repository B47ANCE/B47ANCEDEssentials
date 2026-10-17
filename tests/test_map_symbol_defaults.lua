local sourcePath=arg[1]
package.preload["ISUI/Maps/ISMap"]=function() ISMap={SCALE=0.666}; return true end
Events={OnGameStart={Add=function() end}}
SandboxVars={B47ANCEDEssentials={EnableMapSymbolDefaultScale=true,MapSymbolDefaultScalePercent=150}}
local B47ANCEDEssentials=dofile(sourcePath)
assert(math.abs(ISMap.SCALE-0.999)<0.0001,"configured default scale should preserve vanilla baseline")
SandboxVars.B47ANCEDEssentials.EnableMapSymbolDefaultScale=false
B47ANCEDEssentials.applyMapSymbolDefaultScale()
assert(math.abs(ISMap.SCALE-0.666)<0.0001,"disabling feature should restore vanilla scale")
print("B47ANCEDEssentials map-symbol-default checks passed")

local sourcePath=arg[1]
ISPanel={derive=function(_,name) return {Type=name} end,new=function(self) return setmetatable({},{__index=self}) end}
Events={OnGameStart={Add=function() end}}
local realRequire=require
require=function(name) if name=="ISUI/ISPanel" then return ISPanel end return realRequire(name) end
local B47ANCEDEssentials=dofile(sourcePath)
assert(B47ANCEDEssentials.formatExactWatchTime(17.9917,true)=="17:59")
assert(B47ANCEDEssentials.formatExactWatchTime(0.0,false)=="12:00 AM")
assert(B47ANCEDEssentials.formatExactWatchTime(13.0834,false)=="1:05 PM")
getClimateManager=function() return {getAirTemperatureForCharacter=function() error("player unavailable") end} end
assert(B47ANCEDEssentials.temperatureForClock(nil)==nil,"nil player must not reach the climate API")
assert(B47ANCEDEssentials.temperatureForClock({})==nil,"climate failures must not break the clock")
getClimateManager=function() return {getAirTemperatureForCharacter=function() return 21.5 end} end
assert(B47ANCEDEssentials.temperatureForClock({})==21.5,"valid temperature should remain available to digital watches")
print("B47ANCEDEssentials exact-watch clock checks passed")

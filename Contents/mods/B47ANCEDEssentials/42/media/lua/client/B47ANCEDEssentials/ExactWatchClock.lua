require "ISUI/ISPanel"
B47ANCEDEssentials=B47ANCEDEssentials or {}

local ASSET="media/ui/ClockAssets/"
local LIVE={r=100/255,g=200/255,b=210/255,a=1}
local GHOST={r=40/255,g=40/255,b=40/255,a=128/255}

local function featureEnabled()
    local root=rawget(_G,"SandboxVars")
    local values=root and root.B47ANCEDEssentials or nil
    return not values or values.EnableExactMinuteClock~=false
end

function B47ANCEDEssentials.formatExactWatchTime(timeOfDay,use24Hour)
    local total=math.floor((tonumber(timeOfDay) or 0)*60+0.0001)%1440
    local hour=math.floor(total/60); local minute=total%60
    if use24Hour then return string.format("%02d:%02d",hour,minute) end
    local suffix=hour<12 and "AM" or "PM"; hour=hour%12; if hour==0 then hour=12 end
    return string.format("%d:%02d %s",hour,minute,suffix)
end

local function electronicWatchPowered(item)
    local power=rawget(_G,"powerWorks")
    local profile=power and power.getConsumerProfile and power.getConsumerProfile(item) or nil
    if not profile or profile.provider~="powerWorksWatch" then return true end
    if power.ensurePoweredWatch then pcall(power.ensurePoweredWatch,item) end
    if not power.getInstalledBatteryType(item) then return false end
    local data=item:getModData(); local state=data and data.powerWorks or nil
    return state and (tonumber(state.chargeFraction) or 0)>0
end

local function isClock(item)
    if not item then return false end
    local ok,value=pcall(function()
        return instanceof(item,"AlarmClock") or instanceof(item,"AlarmClockClothing")
    end)
    return ok and value==true
end

local function isDigital(item)
    local ok,value=pcall(function() return item:hasTag(ItemTag.DIGITAL) end)
    if ok then return value==true end
    ok,value=pcall(function() return item:isDigital() end)
    return ok and value==true
end

B47ANCEDEssentials.ExactWatchClock=ISPanel:derive("B47ANCEDEssentials_ExactWatchClock")

function B47ANCEDEssentials.ExactWatchClock:loadAssets()
    local large=getCore():getOptionClockSize()==2
    if self.mainDigits and self.large==large then return end
    self.large=large
    local main,sub=large and "Large" or "Medium",large and "Medium" or "Small"
    self.background=getTexture(ASSET.."Clock"..(large and "Large" or "Small").."Background.png")
    self.mainDigits={}; self.subDigits={}
    for digit=0,9 do
        self.mainDigits[digit]=getTexture(ASSET.."ClockDigits"..main..digit..".png")
        self.subDigits[digit]=getTexture(ASSET.."ClockDigits"..sub..digit..".png")
    end
    self.colon=getTexture(ASSET.."ClockDivide"..main..".png")
    self.slash=getTexture(ASSET.."DateDivide"..sub..".png")
    self.minus=getTexture(ASSET.."ClockDigits"..sub.."Minus.png")
    self.dot=getTexture(ASSET.."ClockDigits"..sub.."Dot.png")
    self.tempC=getTexture(ASSET.."ClockDigits"..sub.."C.png")
    self.tempF=getTexture(ASSET.."ClockDigits"..sub.."F.png")
    self.tempE=getTexture(ASSET.."ClockDigits"..sub.."E.png")
    self.am=getTexture(ASSET.."ClockAm"..main..".png"); self.pm=getTexture(ASSET.."ClockPm"..main..".png")
    self.alarmOn=getTexture(ASSET.."ClockAlarm"..main.."Set.png")
    self.alarmRing=getTexture(ASSET.."ClockAlarm"..main.."Sound.png")
    if large then
        self.o={x=3,y=3,mainGap=2,smallGap=1,colon=3,ampm=3,bell=5,decimal=2,degree=2,slash=2,tempDate=8,date=65,minus=-2,amY=15,pmY=25,bellY=1,row=5,decimalY=15}
    else
        self.o={x=3,y=3,mainGap=1,smallGap=1,colon=1,ampm=1,bell=1,decimal=1,degree=1,slash=1,tempDate=5,date=33,minus=0,amY=7,pmY=12,bellY=1,row=2,decimalY=6}
    end
    self:setWidth(self.background:getWidth()); self:setHeight(self.background:getHeight())
end

function B47ANCEDEssentials.ExactWatchClock:scanState()
    self.clockPlayer=nil; self.digital=false; self.alarmSet=false; self.alarmRinging=false
    for playerIndex=0,getNumActivePlayers()-1 do
        local player=getSpecificPlayer(playerIndex)
        if player and not player:isDead() then
            local foundForPlayer=false
            local function consider(item)
                if not isClock(item) or not electronicWatchPowered(item) then return end
                local worn=false
                pcall(function() worn=item:isWorn() or item:isEquipped() end)
                if not worn then return end
                foundForPlayer=true
                self.digital=self.digital or isDigital(item)
                pcall(function() self.alarmSet=self.alarmSet or item:isAlarmSet() end)
                pcall(function() self.alarmRinging=self.alarmRinging or item:isRinging() end)
            end
            local worn=player:getWornItems()
            for index=0,worn:size()-1 do consider(worn:getItemByIndex(index)) end
            local items=player:getInventory():getItems()
            for index=0,items:size()-1 do consider(items:get(index)) end
            if foundForPlayer then self.clockPlayer=player end
        end
        if self.clockPlayer then break end
    end
end

local function draw(panel,texture,x,y,color)
    panel:drawTexture(texture,x,y,color.a,color.r,color.g,color.b)
end

local function temperatureFor(player)
    if not player or type(getClimateManager)~="function" then return nil end
    local manager=getClimateManager()
    if not manager or type(manager.getAirTemperatureForCharacter)~="function" then return nil end
    local ok,value=pcall(manager.getAirTemperatureForCharacter,manager,player,false)
    value=ok and tonumber(value) or nil
    return value
end
B47ANCEDEssentials.temperatureForClock=temperatureFor

function B47ANCEDEssentials.ExactWatchClock:timeDigits()
    local raw=GameTime.getInstance():getTimeOfDay(); local total=math.floor(raw*3600+0.5)
    local hour=math.floor(total/3600)%24; local minute=math.floor((total%3600)/60)
    local is24=getCore():getOptionClock24Hour(); local pm=hour>=12
    if not is24 then hour=hour%12; if hour==0 then hour=12 end end
    return {math.floor(hour/10),hour%10,math.floor(minute/10),minute%10},pm,is24
end

function B47ANCEDEssentials.ExactWatchClock:drawFace(ghost,color)
    local o=self.o; local x,y=o.x,o.y; local digits,pm,is24=self:timeDigits()
    for index=1,4 do
        draw(self,self.mainDigits[ghost and 8 or digits[index]],x,y,color); x=x+self.mainDigits[0]:getWidth()
        if index==2 then x=x+o.colon; draw(self,self.colon,x,y,color); x=x+self.colon:getWidth()+o.colon
        elseif index<4 then x=x+o.mainGap end
    end
    x=x+o.ampm
    if ghost or not is24 then
        if ghost or not pm then draw(self,self.am,x,y+o.amY,color) else draw(self,self.pm,x,y+o.pmY,color) end
    end
    local bellX=x+self.am:getWidth()+o.bell
    if ghost or self.alarmRinging then draw(self,self.alarmRing,bellX,y+o.bellY,color)
    elseif self.alarmSet then draw(self,self.alarmOn,bellX,y+o.bellY,color) end
    if not self.digital and not ghost then return end

    x=o.x; y=y+self.mainDigits[0]:getHeight()+o.row
    -- The UI can render once between player teardown/replacement and the next
    -- prerender scan. Time remains useful; optional weather data must not make
    -- the entire clock fail during that frame.
    local temperature=temperatureFor(self.clockPlayer)
    if temperature==nil then return end
    local fahrenheit=not getCore():getOptionDisplayAsCelsius()
    if fahrenheit then temperature=temperature*1.8+32 end
    local negative=temperature<0; temperature=math.abs(temperature)
    local td={math.floor(temperature/100),math.floor(temperature%100/10),math.floor(temperature)%10,math.floor(temperature*10)%10}
    if ghost or negative then draw(self,self.minus,x,y,color) end; x=x+o.minus
    for index=1,4 do
        if index>1 or td[1]>0 or ghost then draw(self,self.subDigits[ghost and 8 or td[index]],x,y,color) end
        x=x+self.subDigits[0]:getWidth()
        if index==3 then x=x+o.decimal; draw(self,self.dot,x,y+o.decimalY,color); x=x+self.dot:getWidth()+o.decimal
        elseif index<4 then x=x+o.smallGap end
    end
    x=x+o.degree; draw(self,self.dot,x,y,color); x=x+self.dot:getWidth()+o.degree
    draw(self,ghost and self.tempE or (fahrenheit and self.tempF or self.tempC),x,y,color)
    x=x+self.subDigits[0]:getWidth()+o.tempDate
    local day=GameTime.getInstance():getDay()+1; local month=GameTime.getInstance():getMonth()+1
    local date=getCore():getOptionClockFormat()==1 and {math.floor(month/10),month%10,math.floor(day/10),day%10}
        or {math.floor(day/10),day%10,math.floor(month/10),month%10}
    for index=1,4 do
        draw(self,self.subDigits[ghost and 8 or date[index]],x,y,color); x=x+self.subDigits[0]:getWidth()
        if index==2 then x=x+o.slash; draw(self,self.slash,x,y,color); x=x+self.slash:getWidth()+o.slash
        elseif index<4 then x=x+o.smallGap end
    end
end

function B47ANCEDEssentials.ExactWatchClock:prerender()
    local vanilla=UIManager.getClock()
    if not featureEnabled() then
        self:setVisible(false)
        if vanilla then vanilla:setVisible(true) end
        return
    end
    self:loadAssets(); self:scanState()
    if not self.clockPlayer then
        self:setVisible(false)
        if vanilla then vanilla:setVisible(false) end
        return
    end
    self:setVisible(true)
    if vanilla then
        vanilla:setVisible(true)
        self:setX(vanilla:getX()); self:setY(vanilla:getY())
    end
end

function B47ANCEDEssentials.ExactWatchClock:render()
    if not self.clockPlayer or not self.background or not self.mainDigits then return end
    draw(self,self.background,0,0,{r=1,g=1,b=1,a=1})
    self:drawFace(true,GHOST); self:drawFace(false,LIVE)
end

function B47ANCEDEssentials.ExactWatchClock:new()
    local vanilla=UIManager.getClock()
    local o=ISPanel:new(vanilla and vanilla:getX() or 0,vanilla and vanilla:getY() or 0,10,10)
    setmetatable(o,self); self.__index=self
    o.background=false; o.border=false
    if o.setConsumeMouseEvents then o:setConsumeMouseEvents(false) end
    return o
end

local instance
local function ensureClock()
    if instance or not featureEnabled() then return end
    instance=B47ANCEDEssentials.ExactWatchClock:new(); instance:initialise(); instance:addToUIManager()
end
if Events and Events.OnGameStart then Events.OnGameStart.Add(ensureClock) end
B47ANCEDEssentials.ensureExactWatchClock=ensureClock
return B47ANCEDEssentials

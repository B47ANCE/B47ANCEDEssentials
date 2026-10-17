local sourcePath=arg[1]
SandboxVars={B47ANCEDEssentials={EnableContextMenuCleanup=true,ContextGroupDebugActions=true,ContextGroupAdminActions=true}}
Events={OnFillInventoryObjectContextMenu={Add=function() end},OnFillWorldObjectContextMenu={Add=function() end}}
local function menu(options)
    return {options=options,numOptions=#options+1,addOption=function(self,name)
        local option={name=name,id=#self.options+1}; self.options[#self.options+1]=option; return option end,
        addSubMenu=function(_,option,sub) option.subOption=sub end,calcHeight=function() end,calcWidth=function() return 100 end,setWidth=function() end}
end
ISContextMenu={getNew=function(_,parent) return menu({}) end}
local play={name="Open",onSelect=function() return "play" end}
local debug={name="Debug tools",onSelect=function() return "debug" end}
local admin={name="Admin panel",onSelect=function() return "admin" end}
local context=menu({play,debug,admin})
local B47ANCEDEssentials=dofile(sourcePath)
assert(B47ANCEDEssentials.groupDeveloperContextActions(context,SandboxVars.B47ANCEDEssentials)==2,"developer entries should be grouped only when multiple exist")
assert(context.options[1]==play and context.options[2].__B47ANCEDEssentialsDeveloperBucket,"gameplay action must stay at top level")
local bucket=context.options[2].subOption
assert(bucket.options[1]==debug and bucket.options[2]==admin,"original option objects and callbacks must be preserved")
print("B47ANCEDEssentials context-menu-cleanup checks passed")

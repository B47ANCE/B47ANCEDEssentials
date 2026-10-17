local sourcePath=arg[1]
local function list(values) return {size=function() return #values end,get=function(_,index) return values[index+1] end} end
local function book(pages)
    return {IsLiterature=function() return true end,getNumberOfPages=function() return pages end,
        getFullType=function() return "Base.BookTest" end,hasModData=function() return false end,
        getLearnedRecipes=function() return nil end}
end
local readPages=25
local player={getAlreadyReadPages=function() return readPages end}
local B47ANCEDEssentials=dofile(sourcePath)
local status,current,total=B47ANCEDEssentials.literatureStatus(player,book(100))
assert(status=="partial" and current==25 and total==100,"partial page progress should be reported")
readPages=100
assert(B47ANCEDEssentials.literatureStatus(player,book(100))=="read","completed literature should be reported read")
readPages=0
local recipeBook=book(0)
local learned=list({"Make Useful Thing"})
learned.isEmpty=function() return false end
recipeBook.getLearnedRecipes=function() return learned end
player.getKnownRecipes=function()
    return {containsAll=function(_,recipes) return recipes==learned end}
end
assert(B47ANCEDEssentials.literatureStatus(player,recipeBook)=="read",
    "a non-empty fully known recipe list must report literature as read")
local nestedBook=book(100)
local bag={getFullType=function() return "Base.Bag" end,getInventory=function() return {getItems=function() return list({nestedBook}) end} end}
local root={getItems=function() return list({book(100),bag}) end}
local copies,limited=B47ANCEDEssentials.countCarriedCopies(root,"Base.BookTest",20)
assert(copies==2 and limited==false,"duplicate scan should include nested carried containers")
local lines={
    {getTextGuid=function() return "line-1" end,getCodes=function() return "CRP+1" end},
    {getTextGuid=function() return "line-2" end,getCodes=function() return "" end},
}
local media={getLineCount=function() return 2 end,getLine=function(_,index) return lines[index+1] end}
local tape={isRecordedMedia=function() return true end,getMediaData=function() return media end}
local watched={ ["line-1"]=true }
player.isKnownMediaLine=function(_,guid) return watched[guid]==true end
status,current,total=B47ANCEDEssentials.recordedMediaStatus(player,tape)
assert(status=="partial" and current==1 and total==2,"recorded media must use vanilla known-line progress")
watched["line-2"]=true
assert(B47ANCEDEssentials.recordedMediaStatus(player,tape)=="watched","all known media lines must report watched")
local rewards=B47ANCEDEssentials.mediaRewards(tape)
assert(#rewards==1 and rewards[1]=="Carpentry XP","media effect codes must identify skill XP")
local skillBook=book(220)
skillBook.getSkillTrained=function() return "Carpentry" end
skillBook.getLvlSkillTrained=function() return 3 end
skillBook.getNumLevelsTrained=function() return 2 end
skillBook.getLearnedRecipes=function() return list({"Make Useful Thing"}) end
rewards=B47ANCEDEssentials.mediaRewards(skillBook)
assert(rewards[1]=="Carpentry reading multiplier (levels 3-4)" and rewards[2]=="Recipe: Make Useful Thing",
    "literature rewards must expose skill ranges and recipes")
print("B47ANCEDEssentials literature-core checks passed")

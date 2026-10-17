require "ISUI/ISInventoryPane"

B47ANCEDEssentials=B47ANCEDEssentials or {}

local function enabled()
    local root=rawget(_G,"SandboxVars")
    local values=root and root.B47ANCEDEssentials or nil
    return not values or values.EnableInventorySelectionRepair~=false
end

local original=ISInventoryPane and ISInventoryPane.restoreSelection
if type(original)=="function" and not B47ANCEDEssentials.InventorySelectionRepairInstalled then
    function ISInventoryPane:restoreSelection(saved)
        original(self,saved)
        if not enabled() or type(saved)~="table" or type(self.itemslist)~="table" then return end
        local row=1
        for _,group in ipairs(self.itemslist) do
            local items=group and group.items
            local first=items and items[1]
            if first and saved[first]=="group" then
                self.selected[row]=group
            elseif first and saved[first] then
                self.selected[row]=first
            end
            row=row+1
            if items and not self.collapsed[group.name] then
                for index=2,#items do
                    if saved[items[index]] then self.selected[row]=items[index] end
                    row=row+1
                end
            end
        end
    end
    B47ANCEDEssentials.InventorySelectionRepairInstalled=true
end

return B47ANCEDEssentials

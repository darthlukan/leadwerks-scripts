Script.enabled = true
Script.isOn = true
Script.OnColor = "red"      -- string "Active Color"
Script.color_on = nil
-- transparent
Script.color_off = Vec4(0, 0, 0, 0)


function Script:Start()
    self.colors = {}
    self.colors["red"] = Vec4(1, 0, 0, 0)
    self.colors["green"] = Vec4(0, 1, 0, 0)
    self.colors["blue"] = Vec4(0, 0, 1, 0)
    self.colors["white"] = Vec4(1, 1, 1, 0)
    if self.color_on == nil then
        self.color_on = self.colors[string.lower(self.OnColor)]
    end
    self:On()
end


function Script:On()
    self.entity:SetColor(self.color_on)
    self.component:CallOutputs("On")
    self.isOn = true
end


function Script:Off()
    self.entity:SetColor(self.color_off)
    self.component:CallOutputs("Off")
    self.isOn = false
end


function Script:ToggleLight()
    if self.isOn then
        self:Off()
    else
        self:On()
    end
end


function Script:Enable()
    if self.enabled == false then
        self.enabled = true
        self.component:CallOutputs("Enable")
        self.entity:Show()
    end
end


function Script:Disable()
    if self.enabled then
        self.enabled = false
        self.component:CallOutputs("Disable")
        self.entity:Hide()
    end
end


function Script:UpdateWorld()
    if Time:Millisecs() % 11 == 0 then
        self:ToggleLight()
    end
end

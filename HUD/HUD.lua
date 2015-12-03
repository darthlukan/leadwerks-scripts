function Script:UpdateAmmo(weapon)
    if weapon ~= nil then
        self.current_ammo_total = weapon.ammo
        self.current_ammo_mag = weapon.clipammo
    end
end


function Script:AmmoHUD(context)
    context:SetColor(0.5, 0.5, 0.5, 1)
    local ammo_text = "Ammo: 0 / 0"
    if self.current_ammo_total ~= nil and self.current_ammo_mag ~= nil then
        ammo_text = "Ammo: "..self.current_ammo_mag.." / "..self.current_ammo_total
    end
    return ammo_text
end


function Script:HealthHUD(context, health)
    if health <= 100 and health > 90 then
        context:SetColor(self.full_health_color)
    elseif health <= 90 and health > 75 then
        context:SetColor(self.high_health_color)
    elseif health <= 75 and health >= 50 then
        context:SetColor(self.mid_health_color)
    else
        context:SetColor(self.low_health_color)
    end
    return "Health: "..health.." / 100"
end
        

function Script:DrawHUD(context, health, weapon)
    self.font = Font:Load("Fonts/arial.ttf", 12)
    context:SetFont(self.font)
    context:SetBlendMode(Blend.Alpha)
    
    if self.current_ammo_total == nil then
        self.current_ammo_total = 0
    end

    if self.current_ammo_mag == nil then
        self.current_ammo_mag = 0
    end

    self.full_health_color = Vec4(0, 0.5, 0, 1)
    self.high_health_color = Vec4(0.3, 0.5, 0, 1)
    self.mid_health_color = Vec4(0.5, 0.5, 0, 1)
    self.low_health_color = Vec4(0.5, 0, 0, 1)
    self.black = Vec4(0, 0, 0, 0.75)

    local screen_width = context:GetWidth()
    local screen_height = context:GetHeight()
    local h = 60
    local w = screen_width / 5
    local x = (screen_width / 2) - (w / 2)
    local y = 0

    context:DrawRect(x, y, w, h)

    local health_text = self:HealthHUD(context, health)
    local x = (screen_width / 2) - (self.font:GetTextWidth(health_text) / 2)
    local y = 12
    context:DrawText(health_text, x, y)

    self:UpdateAmmo(weapon)

    local ammo_text = self:AmmoHUD(context)
    context:DrawText(ammo_text, x, y + 16)
end

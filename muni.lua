local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local infiniteAmmoEnabled = false

local function getCurrentWeapon()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
            return tool
        end
    end
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
                return tool
            end
        end
    end
    return nil
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.V then
        infiniteAmmoEnabled = not infiniteAmmoEnabled
        if infiniteAmmoEnabled then
            print("Infinite Ammo aktiviert")
        else
            print("Infinite Ammo deaktiviert")
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if infiniteAmmoEnabled then
        local weapon = getCurrentWeapon()
        if weapon and weapon:FindFirstChild("Ammo") then
            weapon.Ammo.Value = math.huge
        end
    end
end)

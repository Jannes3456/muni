local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local infiniteAmmoEnabled = false

-- Funktion zum Senden von Benachrichtigungen
local function sendNotification(title, text)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- RemoteEvent für Server-Kommunikation (füge dies zu ReplicatedStorage hinzu)
local AmmoEvent = ReplicatedStorage:FindFirstChild("AmmoEvent")
if not AmmoEvent then
    AmmoEvent = Instance.new("RemoteEvent")
    AmmoEvent.Name = "AmmoEvent"
    AmmoEvent.Parent = ReplicatedStorage
end

-- Toggle Infinite Ammo mit "V"
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.V then
        infiniteAmmoEnabled = not infiniteAmmoEnabled
        if infiniteAmmoEnabled then
            sendNotification("Infinite Ammo", "Unendlich Munition aktiviert")
        else
            sendNotification("Infinite Ammo", "Unendlich Munition deaktiviert")
        end
    elseif input.KeyCode == Enum.KeyCode.R and infiniteAmmoEnabled then
        sendNotification("Reload", "Nachladen deaktiviert, Infinite Ammo aktiv")
    end
end)

-- Unendlich Munition setzen (Client-Seite sendet Event an Server)
RunService.RenderStepped:Connect(function()
    if infiniteAmmoEnabled then
        AmmoEvent:FireServer(true) -- Sendet an den Server, um Munition auf max zu setzen
    end
end)

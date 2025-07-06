-- itzC9 Gui To Lua
-- itzC9 Gui To Lua V1.4
-- Made By itzC9

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "VelonixAdmin"
gui.ResetOnSpawn = false

-- UICorner
local function addCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = instance
end

-- Admin Panel
local panel = Instance.new("Frame")
panel.Name = "Main"
panel.Size = UDim2.new(0, 300, 0, 350)
panel.Position = UDim2.new(0, 20, 0, 100)
panel.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
panel.BackgroundTransparency = 0.1
panel.Active = true
panel.Draggable = true
panel.Visible = false
panel.Parent = gui
addCorner(panel)

-- Title
local title = Instance.new("TextLabel", panel)
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Velonix Admin"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(100, 0, 160)
addCorner(title)

-- ScrollingCommandList
local scroll = Instance.new("ScrollingFrame", panel)
scroll.Name = "ScrollingCommandList"
scroll.Size = UDim2.new(1, -20, 0, 220)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 6
scroll.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
scroll.BackgroundTransparency = 0.1
scroll.ClipsDescendants = true
addCorner(scroll)

-- UIListLayout
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- CommandBar
local commandBar = Instance.new("TextBox", panel)
commandBar.Name = "CommandBar"
commandBar.Size = UDim2.new(1, -20, 0, 30)
commandBar.Position = UDim2.new(0, 10, 1, -40)
commandBar.PlaceholderText = "Enter command..."
commandBar.Font = Enum.Font.SourceSans
commandBar.TextSize = 16
commandBar.ClearTextOnFocus = true
commandBar.TextColor3 = Color3.fromRGB(255, 255, 255)
commandBar.BackgroundColor3 = Color3.fromRGB(90, 0, 130)
addCorner(commandBar)

-- OPEN/CLOSE
local openBtn = Instance.new("ImageButton", gui)
openBtn.Name = "OPEN"
openBtn.Size = UDim2.new(0, 40, 0, 40)
openBtn.Position = UDim2.new(0, 20, 0, 14)
openBtn.BackgroundColor3 = Color3.fromRGB(110, 0, 170)
openBtn.BackgroundTransparency = 0
openBtn.Image = "rbxassetid://12345678"
openBtn.ImageRectSize = Vector2.new(36, 36)
openBtn.ImageRectOffset = Vector2.new(324, 364)
openBtn.Active = true
openBtn.Draggable = true
addCorner(openBtn)

local tip = Instance.new("TextLabel", openBtn)
tip.Size = UDim2.new(0, 60, 0, 20)
tip.Position = UDim2.new(1, 2, 0.5, -10)
tip.BackgroundTransparency = 1
tip.Text = "OPEN"
tip.TextSize = 14
tip.Font = Enum.Font.SourceSans
tip.TextColor3 = Color3.new(1, 1, 1)
tip.Visible = false

openBtn.MouseEnter:Connect(function()
    tip.Visible = true
end)
openBtn.MouseLeave:Connect(function()
    tip.Visible = false
end)

local open = false
openBtn.MouseButton1Click:Connect(function()
    open = not open
    panel.Visible = open
    tip.Text = open and "CLOSE" or "OPEN"
end)

local function findPlayer(name)
    name = name:lower()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr.Name:lower():find(name) then
            return plr
        end
    end
end

-- Command
local commandActions = {
    ["goto"] = function(arg)
        local target = findPlayer(arg or "")
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            game.StarterGui:SetCore("SendNotification",{Title="Goto",Text="Teleported to "..target.Name,Duration=2})
        else
            game.StarterGui:SetCore("SendNotification",{Title="Goto",Text="Player not found",Duration=2})
        end
    end,
    ["fly"] = function()
        openBtn.Parent = nil
    end,
    ["rejoin"] = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
    ["reset"] = function()
        game.Players.LocalPlayer:LoadCharacter()
    end,
    ["fling"] = function(arg)
        local target = findPlayer(arg or "")
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = target.Character.HumanoidRootPart
            local bav = Instance.new("BodyAngularVelocity", hrp)
            bav.AngularVelocity = Vector3.new(100,100,100)
            bav.MaxTorque = Vector3.new(1e5,1e5,1e5)
            delay(2,function() bav:Destroy() end)
            game.StarterGui:SetCore("SendNotification",{
            Title="Fling", Text="Flinging "..target.Name, Duration=2
            })
        else
            game.StarterGui:SetCore("SendNotification",{
            Title="Fling", Text="Player not found", Duration=2
            })
        end
    end,
}

for cmd, _ in pairs(commandActions) do
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = cmd
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
    addCorner(btn)
    btn.MouseButton1Click:Connect(function()
        commandBar.Text = cmd
    end)
end

-- Execute commands
commandBar.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local text = commandBar.Text
        local args = string.split(text, " ")
        local cmd = args[1]:lower()
        local action = commandActions[cmd]
        if action then
            action(args[2])
        else
            game.StarterGui:SetCore("SendNotification",{
            Title="Error", Text="Unknown command", Duration=2
            })
        end
    end
end)

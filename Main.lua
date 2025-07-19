local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local VelonixUI = {}
VelonixUI.__index = VelonixUI

local Themes = {
    ["Purple"]        = Color3.fromRGB(128, 0, 128),
    ["Green"]         = Color3.fromRGB(0, 200, 0),
    ["Blue"]          = Color3.fromRGB(0, 153, 255),
    ["Cyan"]          = Color3.fromRGB(0, 255, 255),
    ["Red"]           = Color3.fromRGB(255, 0, 0),
    ["Orange"]        = Color3.fromRGB(255, 128, 0),
    ["Yellow"]        = Color3.fromRGB(255, 255, 0),
    ["Blue Water"]    = Color3.fromRGB(0, 153, 255):Lerp(Color3.new(1,1,1), 0.4),
    ["Cyan Water"]    = Color3.fromRGB(0, 255, 255):Lerp(Color3.new(1,1,1), 0.4),
    ["Orange Water"]  = Color3.fromRGB(255, 128, 0):Lerp(Color3.new(1,1,1), 0.4),
    ["Red Water"]     = Color3.fromRGB(255, 0, 0):Lerp(Color3.new(1,1,1), 0.4),
    ["Green Water"]   = Color3.fromRGB(0, 200, 0):Lerp(Color3.new(1,1,1), 0.4),
    ["Purple Water"]  = Color3.fromRGB(128, 0, 128):Lerp(Color3.new(1,1,1), 0.4),
    ["Moon"]          = Color3.fromRGB(200, 200, 255),
    ["Sun"]           = Color3.fromRGB(255, 200, 100),
    ["Moon Water"]    = Color3.fromRGB(200, 200, 255):Lerp(Color3.new(1,1,1), 0.4),
    ["Sun Water"]     = Color3.fromRGB(255, 200, 100):Lerp(Color3.new(1,1,1), 0.4),
    ["Rise"]          = Color3.fromRGB(255, 150, 80),
    ["Rise Water"]    = Color3.fromRGB(255, 150, 80):Lerp(Color3.new(1,1,1), 0.4),
}

-- Base UI Colors
local COLORS = {
    Accent          = Themes["Purple"],
    Background      = Color3.fromRGB(30, 30, 30),
    Header          = Color3.fromRGB(45, 45, 45),
    Button          = Color3.fromRGB(40, 40, 40),
    ButtonText      = Color3.fromRGB(240, 240, 240),
    ToggleOn        = Color3.fromRGB(0, 170, 0),
    ToggleOff       = Color3.fromRGB(100, 0, 0),
    Notification    = Color3.fromRGB(50, 50, 50),
    NotificationText= Color3.fromRGB(255, 255, 255),
}

function VelonixUI.setTheme(themeName)
    local accent = Themes[themeName]
    if not accent then
        warn("[VelonixUI] Unknown theme: " .. tostring(themeName))
        return
    end
    COLORS.Accent = accent
end

-- Internal state
local screenGui, windowFrame, tabsContainer, contentContainer, notifFolder
local tabContainers = {}
local currentTabId = nil

-- Creates base ScreenGui / window
function VelonixUI.createWindow(title)
    local player = Players.LocalPlayer
    screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "VelonixUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    windowFrame = Instance.new("Frame", screenGui)
    windowFrame.Name = "Window"
    windowFrame.Size = UDim2.new(0, 400, 0, 300)
    windowFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    windowFrame.BackgroundColor3 = COLORS.Background
    windowFrame.BorderSizePixel = 0

    local header = Instance.new("Frame", windowFrame)
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = COLORS.Header
    header.BorderSizePixel = 0

    local headerLabel = Instance.new("TextLabel", header)
    headerLabel.Size = UDim2.new(1, -10, 1, 0)
    headerLabel.Position = UDim2.new(0, 10, 0, 0)
    headerLabel.Text = title or "Velonix Hub"
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextSize = 18
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.TextColor3 = COLORS.ButtonText
    headerLabel.BackgroundTransparency = 1

    tabsContainer = Instance.new("Frame", windowFrame)
    tabsContainer.Name = "Tabs"
    tabsContainer.Size = UDim2.new(0, 100, 1, -30)
    tabsContainer.Position = UDim2.new(0, 0, 0, 30)
    tabsContainer.BackgroundTransparency = 1

    contentContainer = Instance.new("Frame", windowFrame)
    contentContainer.Name = "Content"
    contentContainer.Size = UDim2.new(1, -100, 1, -30)
    contentContainer.Position = UDim2.new(0, 100, 0, 30)
    contentContainer.BackgroundColor3 = COLORS.Background
    contentContainer.BorderSizePixel = 0

    notifFolder = Instance.new("Folder", screenGui)
    notifFolder.Name = "Notifications"
end

function VelonixUI.addTab(title, id)
    assert(screenGui, "createWindow() first")
    local btn = Instance.new("TextButton", tabsContainer)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, (#tabContainers)*35 + 5)
    btn.BackgroundColor3 = COLORS.Button
    btn.Text = title
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = COLORS.ButtonText
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false

    local frame = Instance.new("ScrollingFrame", contentContainer)
    frame.Size = UDim2.new(1, -10, 1, -10)
    frame.Position = UDim2.new(0, 5, 0, 5)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.ScrollBarThickness = 6
    frame.Visible = false

    tabContainers[id] = { button = btn, frame = frame, count = 0 }

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabContainers) do t.frame.Visible = false end
        frame.Visible = true
        currentTabId = id
    end)

    if not currentTabId then
        currentTabId = id
        frame.Visible = true
    end
end

local function updateCanvas(tab)
    local total = 0
    for _, child in ipairs(tab.frame:GetChildren()) do
        if child:IsA("GuiObject") then
            total = total + child.Size.Y.Offset + 10
        end
    end
    tab.frame.CanvasSize = UDim2.new(0, 0, 0, total)
end

function VelonixUI.addButton(text, tabId, callback)
    local tab = tabContainers[tabId]; assert(tab, "Invalid tab")
    local y = tab.count * 50 + 5
    local btn = Instance.new("TextButton", tab.frame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = COLORS.Accent
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = COLORS.ButtonText
    btn.BorderSizePixel = 0

    btn.AutoButtonColor = false
    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)

    tab.count = tab.count + 1
    updateCanvas(tab)
end

function VelonixUI.addToggle(text, default, tabId, callback)
    local tab = tabContainers[tabId]; assert(tab, "Invalid tab")
    local y = tab.count * 50 + 5

    local lbl = Instance.new("TextLabel", tab.frame)
    lbl.Size = UDim2.new(0.7, -20, 0, 40)
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 16
    lbl.TextColor3 = COLORS.ButtonText
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", tab.frame)
    toggle.Size = UDim2.new(0, 50, 0, 25)
    toggle.Position = UDim2.new(1, -60, 0, y + 7)
    toggle.BackgroundColor3 = default and COLORS.ToggleOn or COLORS.ToggleOff
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.AutoButtonColor = false

    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and COLORS.ToggleOn or COLORS.ToggleOff
        pcall(callback, state)
    end)

    tab.count = tab.count + 1
    updateCanvas(tab)
end

function VelonixUI.notif(title, description)
    local notif = Instance.new("Frame", notifFolder)
    notif.Size = UDim2.new(0, 250, 0, 60)
    notif.Position = UDim2.new(1, -260, 1, -70)
    notif.BackgroundColor3 = COLORS.Notification
    notif.BorderSizePixel = 0

    local top = Instance.new("TextLabel", notif)
    top.Size = UDim2.new(1, 0, 0, 25)
    top.BackgroundColor3 = COLORS.Accent
    top.Text = title
    top.Font = Enum.Font.GothamBold
    top.TextSize = 14
    top.TextColor3 = COLORS.ButtonText
    top.BorderSizePixel = 0

    local body = Instance.new("TextLabel", notif)
    body.Size = UDim2.new(1, -10, 1, -25)
    body.Position = UDim2.new(0, 5, 0, 25)
    body.BackgroundTransparency = 1
    body.Text = description
    body.Font = Enum.Font.Gotham
    body.TextSize = 14
    body.TextColor3 = COLORS.NotificationText
    body.TextWrapped = true

    spawn(function()
        for i = 0, 10 do
            notif.Position = notif.Position:Lerp(UDim2.new(1, -260, 1, -70 - i * 6), 0.3)
            task.wait(0.03)
        end
        task.wait(3)
        for i = 0, 10 do
            notif.Position = notif.Position:Lerp(UDim2.new(1, -260, 1, -10 + i * 6), 0.3)
            task.wait(0.03)
        end
        notif:Destroy()
    end)
end

return VelonixUI
-- Velonix UI Library (Cleaned Premium Style)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ThemeColors = {
	Green = {Main = Color3.fromRGB(0, 170, 0), Accent = Color3.fromRGB(0, 255, 0)},
	White = {Main = Color3.fromRGB(240, 240, 240), Accent = Color3.fromRGB(200, 200, 200)},
	Red = {Main = Color3.fromRGB(170, 0, 0), Accent = Color3.fromRGB(255, 0, 0)},
	Forest = {Main = Color3.fromRGB(34, 139, 34), Accent = Color3.fromRGB(50, 205, 50)},
	Dark = {Main = Color3.fromRGB(25, 25, 25), Accent = Color3.fromRGB(80, 80, 80)},
	Light = {Main = Color3.fromRGB(220, 220, 220), Accent = Color3.fromRGB(180, 180, 180)},
	Sun = {Main = Color3.fromRGB(255, 255, 153), Accent = Color3.fromRGB(255, 204, 0)},
	Sunrise = {Main = Color3.fromRGB(255, 94, 98), Accent = Color3.fromRGB(255, 178, 102)},
	Water = {Main = Color3.fromRGB(0, 255, 255), Accent = Color3.fromRGB(0, 150, 150)},
	Blaze = {Main = Color3.fromRGB(255, 87, 34), Accent = Color3.fromRGB(255, 138, 101)},
	Flame = {Main = Color3.fromRGB(255, 51, 51), Accent = Color3.fromRGB(255, 204, 0)},
	Purple = {Main = Color3.fromRGB(138, 43, 226), Accent = Color3.fromRGB(186, 85, 211)},
	Moon = {Main = Color3.fromRGB(200, 200, 255), Accent = Color3.fromRGB(150, 150, 200)},
	Premium = {Main = Color3.fromRGB(40, 40, 40), Accent = Color3.fromRGB(0, 200, 255)} -- Premium look
}

local gui = Instance.new("ScreenGui")
gui.Name = "Velonix_Library"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(127, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.Active = true
mainFrame.Selectable = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = gui

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0, 0, 255)
stroke.Thickness = 2
stroke.Transparency = 0.5

-- Containers
local tabFrame = Instance.new("ScrollingFrame", mainFrame)
tabFrame.Size = UDim2.new(0, 100, 1, -50)
tabFrame.Position = UDim2.new(0, 5, 0, 50)
tabFrame.ScrollBarThickness = 6
tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabFrame.BackgroundColor3 = Color3.fromRGB(127, 0, 0)
tabFrame.BackgroundTransparency = 0.5
tabFrame.ClipsDescendants = true

local tabLayout = Instance.new("UIListLayout", tabFrame)
tabLayout.Padding = UDim.new(0, 5)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local settingsFrame = Instance.new("ScrollingFrame", mainFrame)
settingsFrame.Size = UDim2.new(0, 100, 1, -50)
settingsFrame.Position = UDim2.new(1, -105, 0, 50)
settingsFrame.ScrollBarThickness = 6
settingsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
settingsFrame.BackgroundTransparency = 1
settingsFrame.ClipsDescendants = true

local settingsLayout = Instance.new("UIListLayout", settingsFrame)
settingsLayout.Padding = UDim.new(0, 5)
settingsLayout.SortOrder = Enum.SortOrder.LayoutOrder

local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 100, 0, 40) -- wider and shorter
openBtn.Position = UDim2.new(0, 20, 0.5, -20) -- vertically centered
openBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
openBtn.Text = "Open"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 16
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.ZIndex = 1000
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 6)

openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)
-- Variables
local tabContainers = {}
local currentTab = nil

-- Utility
local function addCorner(instance, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 100)
	corner.Parent = instance
end

addCorner(openBtn, 8)

local ThemeElements = {
	mainFrame = mainFrame,
	tabButtons = {},
	settingButtons = {},
	uiStroke = stroke,
}

-- UI API
function UIColor(name)
	local theme = ThemeColors[name]
	if not theme then
		warn("[Velonix UI] Unknown theme: " .. tostring(name))
		return
	end

	-- Main container color
	ThemeElements.mainFrame.BackgroundColor3 = theme.Main

	-- Stroke
	if ThemeElements.uiStroke then
		ThemeElements.uiStroke.Color = theme.Accent
	end

	-- Tab buttons
	for _, tab in ipairs(ThemeElements.tabButtons) do
		tab.BackgroundColor3 = theme.Main
		tab.TextColor3 = theme.Accent
	end

	-- Settings buttons
	for _, btn in ipairs(ThemeElements.settingButtons) do
		btn.BackgroundColor3 = theme.Main
		btn.TextColor3 = theme.Accent
	end
end

function createLogo(imageId)
	local logo = Instance.new("ImageLabel", mainFrame)
	logo.Size = UDim2.new(0, 40, 0, 40)
	logo.Position = UDim2.new(0, 5, 0, 5)
	logo.Image = "rbxassetid://" .. tostring(imageId)
	logo.BackgroundTransparency = 1
	logo.ImageTransparency = 1 -- Make it invisible initially
	TweenService:Create(logo, TweenInfo.new(1), {ImageTransparency = 0}):Play()
end

function createWindow(titleText, textSize)
	local title = Instance.new("TextLabel", mainFrame)
	title.Size = UDim2.new(0, 200, 0, 40)
	title.Position = UDim2.new(0, 50, 0, 5)
	title.Text = titleText
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = textSize
	title.TextColor3 = Color3.fromRGB(0, 0, 255)
	title.BackgroundTransparency = 1
	title.TextXAlignment = Enum.TextXAlignment.Left
end

function createTab(name, tabIndex)
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(1, -10, 0, 40)
	tab.Text = name
	tab.Font = Enum.Font.SourceSansBold
	tab.TextSize = 20
	tab.TextColor3 = Color3.fromRGB(0, 0, 255)
	tab.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	tab.BackgroundTransparency = 0.3
	tab.BorderSizePixel = 0
	tab.Parent = tabFrame
	addCorner(tab, 8)

	local content = Instance.new("ScrollingFrame")
	content.Name = tostring(tabIndex)
	content.Size = UDim2.new(0, 280, 1, -60)
	content.Position = UDim2.new(0, 110, 0, 50)
	content.BackgroundTransparency = 1
	content.ScrollBarThickness = 6
	content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	content.ClipsDescendants = true
	content.Visible = false
	content.Parent = mainFrame
	addCorner(content, 8)

	local layout = Instance.new("UIListLayout", content)
	layout.Padding = UDim.new(0, 5)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	tab.MouseButton1Click:Connect(function()
		if currentTab then currentTab.Visible = false end
		currentTab = content
		currentTab.Visible = true
	end)
    -- inside createTab
    table.insert(ThemeElements.createButton, createToggle, createWindow, createLabel, createTextBox, tab)
	tabContainers[tabIndex] = {frame = content}
end

function createButton(name, tabIndex, callback)
	local container = tabContainers[tabIndex]
	if not container then return end
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Text = name
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 20
	btn.TextColor3 = Color3.fromRGB(0, 0, 255)
	btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	btn.BackgroundTransparency = 0.3
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.Parent = container.frame
	btn.MouseButton1Click:Connect(callback)
	addCorner(btn, 8)
end

function createLabel(text, tabIndex)
	local container = tabContainers[tabIndex]
	if not container then return end
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 0, 30)
	label.Text = text
	label.Font = Enum.Font.SourceSans
	label.TextSize = 16
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.Parent = container.frame
	addCorner(label, 8)
end

function createSection(name, tabIndex)
	local container = tabContainers[tabIndex]
	if not container then return end
	local section = Instance.new("TextLabel")
	section.Size = UDim2.new(1, -10, 0, 30)
	section.Text = "-- " .. name
	section.Font = Enum.Font.SourceSansBold
	section.TextSize = 18
	section.TextColor3 = Color3.fromRGB(0, 200, 255)
	section.BackgroundTransparency = 1
	section.TextXAlignment = Enum.TextXAlignment.Left
	section.Parent = container.frame
	addCorner(section, 8)
end

function createNotify(title, desc)
	game.StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = desc,
		Duration = 5
	})
end

function createNotify2(title, desc, duration)
	game.StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = desc,
		Duration = duration or 10
	})
end

function createSettingButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Text = name
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.TextColor3 = Color3.fromRGB(0, 0, 255)
	btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	btn.BackgroundTransparency = 0.3
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(callback)
	btn.Parent = settingsFrame
	addCorner(btn, 8)

	table.insert(ThemeElements.settingButtons, btn) -- ✅ Proper placement
end



function createToggle(name, tabIndex, default, callback)
	local container = tabContainers[tabIndex]
	if not container then return end

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 40)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Parent = container.frame

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.Text = name
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 18
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggleButton = Instance.new("Frame", frame)
	toggleButton.Size = UDim2.new(0, 60, 0, 25)
	toggleButton.Position = UDim2.new(1, -65, 0.5, -12)
	toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(100, 0, 0)
	toggleButton.BorderSizePixel = 0
	addCorner(toggleButton, 12)

	local toggleCircle = Instance.new("Frame", toggleButton)
	toggleCircle.Size = UDim2.new(0.5, -4, 1, -4)
	toggleCircle.Position = default and UDim2.new(1, -toggleCircle.Size.X.Offset - 2, 0, 2) or UDim2.new(0, 2, 0, 2)
	toggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
	toggleCircle.BorderSizePixel = 0
	addCorner(toggleCircle, 12)

	local state = default
	toggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			state = not state
			TweenService:Create(toggleButton, TweenInfo.new(0.2), {
				BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(100, 0, 0)
			}):Play()
			TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
				Position = state and UDim2.new(1, -toggleCircle.Size.X.Offset - 2, 0, 2) or UDim2.new(0, 2, 0, 2)
			}):Play()

			pcall(function()
				callback(state)
			end)
		end
	end)
end

function createTextBox(tabIndex, placeholderText, callback)
    local container = tabContainers[tabIndex]
    if not container then
        return
    end
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -10, 0, 35)
    box.PlaceholderText = placeholderText
    box.Font = Enum.Font.SourceSans
    box.TextSize = 16
    box.TextColor3 = Color3.new(1, 1, 1)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.BackgroundTransparency = 0.1
    box.ClearTextOnFocus = false
    box.Text = ""
    box.BorderSizePixel = 0
    box.FocusLost:Connect(function(enter)
    if enter then
        callback(box.Text)
    end
end)
    box.Parent = container.frame
        if addCorner then
            addCorner(box, 8)
        end
    end

function createDivider(tabIndex)
    
    local container = tabContainers[tabIndex]
    if not container then
        return
    end
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, -10, 0, 2)
    divider.BackgroundColor3 = Color3.new(1, 1, 1)
    divider.BackgroundTransparency = 0.3
    divider.BorderSizePixel = 0
    divider.Parent = container.frame
end

function createSlider(tabIndex, title, min, max, default, callback)
	local container = tabContainers[tabIndex]
	if not container then return end

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 0, 20)
	label.Text = title .. ": " .. tostring(default)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 14
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BorderSizePixel = 0
	label.Parent = container.frame

	local slider = Instance.new("Frame")
	slider.Size = UDim2.new(1, -10, 0, 20)
	slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	slider.BorderSizePixel = 0
	slider.Parent = container.frame
	addCorner(slider)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	fill.BorderSizePixel = 0
	fill.ZIndex = 2
	fill.Name = "Fill"
	fill.Parent = slider
	addCorner(fill)

	local dragging = false

	-- Start dragging
	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	-- Stop dragging
	slider.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local relativeX = input.Position.X - slider.AbsolutePosition.X
			local percent = math.clamp(relativeX / slider.AbsoluteSize.X, 0, 1)
			local value = math.floor(min + (max - min) * percent)

			fill.Size = UDim2.new(percent, 0, 1, 0)
			label.Text = title .. ": " .. tostring(value)

			if callback then
				pcall(function()
					callback(value)
				end)
			end
		end
	end)
end
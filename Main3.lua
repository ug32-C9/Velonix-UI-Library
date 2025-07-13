-- Velonix UI Library (Revamped Premium Style)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))

-- ScreenGui Settings
gui.Name = "Velonix_Library"
gui.ResetOnSpawn = false

-- Main Frame
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

-- Add UIStroke
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0, 0, 255)
stroke.Thickness = 2
stroke.Transparency = 0.5

local tabFrame = Instance.new("ScrollingFrame", mainFrame)
tabFrame.Size = UDim2.new(0, 100, 1, -50)
tabFrame.Position = UDim2.new(0, 5, 0, 50)
tabFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
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
settingsFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
settingsFrame.ScrollBarThickness = 6
settingsFrame.BackgroundTransparency = 1
settingsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
settingsFrame.ClipsDescendants = true

local settingsLayout = Instance.new("UIListLayout", settingsFrame)
settingsLayout.Padding = UDim.new(0, 5)
settingsLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabY, settingsY = 0, 0
local tabContainers = {}
local currentTab = nil
local consoleTextBox

function addCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 100)
    corner.Parent = instance
end

-- FUNCTIONS
function createOpen(index)
local openBtn = Instance.new("ImageButton", gui)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0.5, -25)
openBtn.BackgroundTransparency = 1
openBtn.Image = "rbxassetid://" .. tostring(index)
openBtn.ZIndex = 1000
openBtn.Active = true
openBtn.Draggable = true
openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
addCorner(openBtn, 100)
end
function createLogo(index)
    local logo = Instance.new("ImageLabel", mainFrame)
    logo.Size = UDim2.new(0, 40, 0, 40)
    logo.Position = UDim2.new(0, 5, 0, 5)
    logo.Image = "rbxassetid://" .. tostring(index)
    logo.BackgroundTransparency = 1
    logo.ImageTransparency = 1
    local tween = TweenService:Create(logo, TweenInfo.new(1), {ImageTransparency = 0})
    tween:Play()
end

function createWindow(name, textSize)
	local title = Instance.new("TextLabel", mainFrame)
	title.Size = UDim2.new(0, 200, 0, 40)
	title.Position = UDim2.new(0, 50, 0, 5)
	title.Text = name
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = textSize
	title.TextColor3 = Color3.fromRGB(0, 0, 255)
	title.BackgroundTransparency = 1
	title.TextXAlignment = Enum.TextXAlignment.Left
end

function createTab(name, tabIndex)
	-- Create tab button
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

	if addCorner then
		addCorner(tab, 8)
	end

	local content = Instance.new("ScrollingFrame")
	content.Name = tostring(tabIndex)
	content.Size = UDim2.new(0, 280, 1, -60)
	content.Position = UDim2.new(0, 110, 0, 50)
	content.BackgroundTransparency = 1
	content.ScrollBarThickness = 6
	content.CanvasSize = UDim2.new(0, 0, 0, 500)
	content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	content.ClipsDescendants = true
	content.Visible = false
	content.Parent = mainFrame

	if addCorner then
		addCorner(content, 8)
	end

	local layout = Instance.new("UIListLayout", content)
	layout.Padding = UDim.new(0, 5)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	tab.MouseButton1Click:Connect(function()
		if currentTab then currentTab.Visible = false end
		currentTab = content
		currentTab.Visible = true
	end)

	tabContainers[tabIndex] = {frame = content}

	if name:lower() == "console" then
		consoleTextBox = Instance.new("TextBox")
		consoleTextBox.Size = UDim2.new(1, -10, 1, -10)
		consoleTextBox.Position = UDim2.new(0, 5, 0, 5)
		consoleTextBox.Text = "[Console]\n"
		consoleTextBox.ClearTextOnFocus = false
		consoleTextBox.Font = Enum.Font.Code
		consoleTextBox.TextSize = 14
		consoleTextBox.TextXAlignment = Enum.TextXAlignment.Left
		consoleTextBox.TextYAlignment = Enum.TextYAlignment.Top
		consoleTextBox.MultiLine = true
		consoleTextBox.TextEditable = false
		consoleTextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		consoleTextBox.TextColor3 = Color3.new(0, 1, 0)
		consoleTextBox.Parent = content

		if addCorner then
			addCorner(consoleTextBox, 8)
		end
	end
end

function createButton(name, tabIndex, callback)
    local container = tabContainers[tabIndex]
    if not container or not container.frame then return end
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
    if typeof(callback) == "function" then
        btn.MouseButton1Click:Connect(callback)
    end
    btn.Parent = container.frame
    if addCorner and typeof(addCorner) == "function" then
        addCorner(btn, 8)
    end
end

function createLabel(text, tabIndex)
    local container = tabContainers[tabIndex]
    if not container or not container.frame then return end
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
    if addCorner and typeof(addCorner) == "function" then
        addCorner(label, 8)
    end
end

function createSection(name, tabIndex)
    local container = tabContainers[tabIndex]
    if not container then return end
    local section = Instance.new("TextLabel")
    section.Size = UDim2.new(1, -10, 0, 30)
    section.Text = "-- " .. name ..
    section.Font = Enum.Font.SourceSansBold
    section.TextSize = 18
    section.TextColor3 = Color3.fromRGB(0, 200, 255)
    section.BackgroundTransparency = 1
    section.TextXAlignment = Enum.TextXAlignment.Left
    section.BorderSizePixel = 0
    section.Parent = container.frame
    if addCorner then
        addCorner(section, 8)
    end
end

function createNotify(title, description)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = description,
        Duration = 5
    })
    end

function createNotify2(title, description, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = description,
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
    if addCorner then
        addCorner(btn, 8)
    end
end

function createToggle(name, tabIndex, default, callback)
    local container = tabContainers[tabIndex]
    if not container then
        return
    end
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -10, 0, 40)
    toggle.Font = Enum.Font.SourceSansBold
    toggle.TextSize = 18
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    toggle.BackgroundTransparency = 0.2
    toggle.BorderSizePixel = 0
    local state = default
    toggle.Text = name .. ": " .. (state and "ON" or "OFF")
    toggle.MouseButton1Click:Connect(function()
    state = not state
    toggle.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
    toggle.Parent = container.frame
    if addCorner then
        addCorner(toggle, 8)
    end
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

function createDropdown(title, tabIndex, callback)
	local container = tabContainers[tabIndex]
	if not container then return end

	local dropdownFrame = Instance.new("Frame")
	dropdownFrame.Size = UDim2.new(1, -10, 0, 30)
	dropdownFrame.BackgroundTransparency = 1
	dropdownFrame.AutomaticSize = Enum.AutomaticSize.Y
	dropdownFrame.ClipsDescendants = true
	dropdownFrame.Name = "Dropdown_" .. title
	dropdownFrame.Parent = container.frame

	local dropdownButton = Instance.new("TextButton")
	dropdownButton.Size = UDim2.new(1, 0, 0, 30)
	dropdownButton.Text = title .. " ▼"
	dropdownButton.Font = Enum.Font.SourceSansBold
	dropdownButton.TextSize = 16
	dropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	dropdownButton.TextColor3 = Color3.new(1, 1, 1)
	dropdownButton.BorderSizePixel = 0
	dropdownButton.Parent = dropdownFrame
	if addCorner then addCorner(dropdownButton, 8) end

	local buttonList = Instance.new("Frame")
	buttonList.Size = UDim2.new(1, 0, 0, 0)
	buttonList.Position = UDim2.new(0, 0, 1, 0)
	buttonList.BackgroundTransparency = 1
	buttonList.Visible = false
	buttonList.Parent = dropdownFrame

	local listLayout = Instance.new("UIListLayout")
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0, 5)
	listLayout.Parent = buttonList

	local isOpen = false

	dropdownButton.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		buttonList.Visible = isOpen
	end)

local dropdownAPI = {}

function dropdownAPI:AddOption(name)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 30)
		btn.Text = name
		btn.Font = Enum.Font.SourceSans
		btn.TextSize = 14
		btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.BorderSizePixel = 0
		btn.Parent = buttonList
		if addCorner then addCorner(btn, 6) end

		btn.MouseButton1Click:Connect(function()
			pcall(callback, name)
			buttonList.Visible = false
			isOpen = false
		end)
	end

	return dropdownAPI
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

function Console(text)
	if consoleTextBox then
		consoleTextBox.Text = consoleTextBox.Text .. text .. "\n"
	end
end
-- itzC9 Gui To Lua
-- itzC9 Lua V1.3
-- Made By itzC9

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "Velonix_Library"
gui.ResetOnSpawn = false

-- MAIN FRAME
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

-- FRAMES
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(0, 100, 1, -50)
tabFrame.Position = UDim2.new(0, 5, 0, 50)
tabFrame.BackgroundColor3 = Color3.fromRGB(127, 0, 0)
tabFrame.BackgroundTransparency = 0.5

local settingsFrame = Instance.new("Frame", mainFrame)
settingsFrame.Size = UDim2.new(0, 100, 1, -50)
settingsFrame.Position = UDim2.new(1, -105, 0, 50)
settingsFrame.BackgroundTransparency = 1

-- OPEN BUTTON
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 100, 0, 40)
openBtn.Position = UDim2.new(0, 20, 0.5, -20)
openBtn.Text = "Open"
openBtn.Font = Enum.Font.SourceSansBold
openBtn.TextSize = 20
openBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
openBtn.BackgroundTransparency = 0.3

openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

local tabY, settingsY = 0, 0
local tabContainers = {}
local currentTab = nil
local consoleTextBox

-- FUNCTIONS
function addLogo(index)
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
	local tab = Instance.new("TextButton", tabFrame)
	tab.Size = UDim2.new(1, -10, 0, 40)
	tab.Position = UDim2.new(0, 5, 0, tabY)
	tab.Text = name
	tab.Font = Enum.Font.SourceSansBold
	tab.TextSize = 20
	tab.TextColor3 = Color3.fromRGB(0, 0, 255)
	tab.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	tab.BackgroundTransparency = 0.3
	local content = Instance.new("Frame", mainFrame)
	content.Name = "" .. tabIndex
	content.Size = UDim2.new(0, 200, 1, -50)
	content.Position = UDim2.new(0, 110, 0, 50)
	content.BackgroundTransparency = 1
	content.Visible = false
	tab.MouseButton1Click:Connect(function()
		if currentTab then currentTab.Visible = false end
		currentTab = content
		currentTab.Visible = true
	end)
	tabContainers[tabIndex] = {frame = content, buttonY = 0}
	if name:lower() == "console" then
		consoleTextBox = Instance.new("TextBox", content)
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
	end

	tabY = tabY + 45
end

function createButton(name, tabIndex, callback)
	local container = tabContainers[tabIndex]
	if not container then return end
	local btn = Instance.new("TextButton", container.frame)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, container.buttonY)
	btn.Text = name
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 20
	btn.TextColor3 = Color3.fromRGB(0, 0, 255)
	btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	btn.BackgroundTransparency = 0.3
	btn.MouseButton1Click:Connect(callback)
	container.buttonY = container.buttonY + 45
end

function createLabel(text, subtext)
	if not currentTab then return end
	local label = Instance.new("TextLabel", currentTab)
	label.Size = UDim2.new(1, -10, 0, 30)
	label.Position = UDim2.new(0, 5, 0, 0)
	label.Text = text .. " - " .. subtext
	label.Font = Enum.Font.SourceSans
	label.TextSize = 16
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
end

function createSection(name)
	if not currentTab then return end
	local section = Instance.new("TextLabel", currentTab)
	section.Size = UDim2.new(1, -10, 0, 30)
	section.Position = UDim2.new(0, 5, 0, 0)
	section.Text = "== " .. name .. " =="
	section.Font = Enum.Font.SourceSansBold
	section.TextSize = 18
	section.TextColor3 = Color3.fromRGB(0, 200, 255)
	section.BackgroundTransparency = 1
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
	local btn = Instance.new("TextButton", settingsFrame)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, settingsY)
	btn.Text = name
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.TextColor3 = Color3.fromRGB(0, 0, 255)
	btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	btn.BackgroundTransparency = 0.3
	btn.MouseButton1Click:Connect(callback)
	settingsY = settingsY + 45
end

function createToggle(name, tabIndex, default, callback)
	local container = tabContainers[tabIndex]
	if not container then return end
	local toggle = Instance.new("TextButton", container.frame)
	toggle.Size = UDim2.new(1, -10, 0, 40)
	toggle.Position = UDim2.new(0, 5, 0, container.buttonY)
	local state = default
	toggle.Text = name .. ": " .. (state and "ON" or "OFF")
	toggle.Font = Enum.Font.SourceSansBold
	toggle.TextSize = 18
	toggle.TextColor3 = Color3.new(1,1,1)
	toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
	toggle.BackgroundTransparency = 0.2
	toggle.MouseButton1Click:Connect(function()
		state = not state
		toggle.Text = name .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
	container.buttonY = container.buttonY + 45
end

function createTextBox(tabIndex, placeholderText, callback)
	local container = tabContainers[tabIndex]
	if not container then return end
	local box = Instance.new("TextBox", container.frame)
	box.Size = UDim2.new(1, -10, 0, 35)
	box.Position = UDim2.new(0, 5, 0, container.buttonY)
	box.PlaceholderText = placeholderText
	box.Font = Enum.Font.SourceSans
	box.TextSize = 16
	box.TextColor3 = Color3.new(1,1,1)
	box.BackgroundColor3 = Color3.fromRGB(50,50,50)
	box.BackgroundTransparency = 0.1
	box.ClearTextOnFocus = false
	box.FocusLost:Connect(function(enter)
		if enter then callback(box.Text) end
	end)
	container.buttonY = container.buttonY + 40
end

function createDropdown(tabIndex, title, options, callback)
	local container = tabContainers[tabIndex]
	if not container then return end
	local dropdown = Instance.new("TextButton", container.frame)
	dropdown.Size = UDim2.new(1, -10, 0, 35)
	dropdown.Position = UDim2.new(0, 5, 0, container.buttonY)
	local index = 1
	dropdown.Text = title .. ": " .. options[index]
	dropdown.Font = Enum.Font.SourceSansBold
	dropdown.TextSize = 16
	dropdown.TextColor3 = Color3.new(1,1,1)
	dropdown.BackgroundColor3 = Color3.fromRGB(40,40,40)
	dropdown.BackgroundTransparency = 0.1
	dropdown.MouseButton1Click:Connect(function()
		index = index % #options + 1
		dropdown.Text = title .. ": " .. options[index]
		callback(options[index])
	end)
	container.buttonY = container.buttonY + 40
end

function createDivider(tabIndex)
	local container = tabContainers[tabIndex]
	if not container then return end
	local divider = Instance.new("Frame", container.frame)
	divider.Size = UDim2.new(1, -10, 0, 2)
	divider.Position = UDim2.new(0, 5, 0, container.buttonY)
	divider.BackgroundColor3 = Color3.new(1,1,1)
	divider.BackgroundTransparency = 0.3
	divider.BorderSizePixel = 0
	container.buttonY = container.buttonY + 10
end

function createSlider(tabIndex, title, min, max, default, callback)
	local container = tabContainers[tabIndex]
	if not container then return end

	local label = Instance.new("TextLabel", container.frame)
	label.Size = UDim2.new(1, -10, 0, 20)
	label.Position = UDim2.new(0, 5, 0, container.buttonY)
	label.Text = title .. ": " .. default
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 14
	label.TextColor3 = Color3.new(1,1,1)
	label.BackgroundTransparency = 1
	container.buttonY = container.buttonY + 20

	local slider = Instance.new("Frame", container.frame)
	slider.Size = UDim2.new(1, -10, 0, 20)
	slider.Position = UDim2.new(0, 5, 0, container.buttonY)
	slider.BackgroundColor3 = Color3.fromRGB(100,100,100)

	local fill = Instance.new("Frame", slider)
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
	fill.BorderSizePixel = 0

	local dragging = false
	slider.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
	end)
	slider.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local rel = math.clamp((i.Position.X - slider.AbsolutePosition.X)/slider.AbsoluteSize.X,0,1)
			fill.Size = UDim2.new(rel,0,1,0)
			local val = math.floor(min + (max-min)*rel)
			label.Text = title .. ": " .. val
			callback(val)
		end
	end)
	container.buttonY = container.buttonY + 25
end

function Console(text)
	if consoleTextBox then
		consoleTextBox.Text = consoleTextBox.Text .. text .. "\n"
	end
end
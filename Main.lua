local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local library = {}

function library:MakeWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "VelonixUILib"

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = config.Name or "Velonix UI"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 18
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -40, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Close = Instance.new("TextButton", MainFrame)
    Close.Text = "X"
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 14
    Close.TextColor3 = Color3.new(1, 1, 1)
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Position = UDim2.new(1, -35, 0, 5)
    Close.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local TabFrame = Instance.new("Frame", MainFrame)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(0, 130, 1, -50)
    TabFrame.Position = UDim2.new(0, 0, 0, 40)

    local TabsLayout = Instance.new("UIListLayout", TabFrame)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Size = UDim2.new(1, -140, 1, -50)
    ContentFrame.Position = UDim2.new(0, 140, 0, 40)

    local function MakeTab(tabConfig)
        local TabButton = Instance.new("TextButton", TabFrame)
        TabButton.Text = tabConfig.Name
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabButton.TextColor3 = Color3.new(1, 1, 1)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

        local TabContent = Instance.new("Frame", ContentFrame)
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false

        local Layout = Instance.new("UIListLayout", TabContent)
        Layout.Padding = UDim.new(0, 8)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder

        TabButton.MouseButton1Click:Connect(function()
            for _, v in ipairs(ContentFrame:GetChildren()) do
                if v:IsA("Frame") then v.Visible = false end
            end
            TabContent.Visible = true
        end)

        local tab = {}

        function tab:AddLabel(text)
            local lbl = Instance.new("TextLabel", TabContent)
            lbl.Text = text
            lbl.Size = UDim2.new(1, 0, 0, 20)
            lbl.TextColor3 = Color3.new(1, 1, 1)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamSemibold
            lbl.TextSize = 14
        end

        function tab:AddParagraph(title, desc)
            local frame = Instance.new("Frame", TabContent)
            frame.Size = UDim2.new(1, 0, 0, 50)
            frame.BackgroundTransparency = 1

            local titleLabel = Instance.new("TextLabel", frame)
            titleLabel.Text = title
            titleLabel.TextColor3 = Color3.new(1, 1, 1)
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.BackgroundTransparency = 1
            titleLabel.Size = UDim2.new(1, 0, 0, 20)

            local descLabel = Instance.new("TextLabel", frame)
            descLabel.Text = desc
            descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            descLabel.Font = Enum.Font.Gotham
            descLabel.TextSize = 13
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.BackgroundTransparency = 1
            descLabel.Position = UDim2.new(0, 0, 0, 20)
            descLabel.Size = UDim2.new(1, 0, 0, 30)
        end

        function tab:AddSection(section)
            tab:AddLabel(section.Name)
        end

        function tab:AddButton(button)
            local btn = Instance.new("TextButton", TabContent)
            btn.Text = button.Name
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(function()
                button.Callback()
            end)
        end

        function tab:AddSlider(slider)
            local sliderLabel = Instance.new("TextLabel", TabContent)
            sliderLabel.Text = slider.Name .. " " .. slider.ValueName
            sliderLabel.TextColor3 = Color3.new(1, 1, 1)
            sliderLabel.Font = Enum.Font.Gotham
            sliderLabel.TextSize = 14
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Size = UDim2.new(1, 0, 0, 20)

            local bar = Instance.new("Frame", TabContent)
            bar.Size = UDim2.new(1, 0, 0, 20)
            bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            bar.BorderSizePixel = 0
            local fill = Instance.new("Frame", bar)
            fill.Size = UDim2.new((slider.Default-slider.Min)/(slider.Max-slider.Min), 0, 1, 0)
            fill.BackgroundColor3 = slider.Color
            fill.BorderSizePixel = 0
        end

        return tab
    end

    local window = {}
    function window:MakeTab(tcfg)
        return MakeTab(tcfg)
    end

    return window
end

return library
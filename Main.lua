local Players       = game:GetService("Players")
local TweenService  = game:GetService("TweenService")
local LocalPlayer   = Players.LocalPlayer

local library = {}
library.__index = library

-- Predefined Color Themes
library.Themes = {
    Purple = Color3.fromRGB(170,  85, 255),
    Green  = Color3.fromRGB( 85, 255, 127),
    Yellow = Color3.fromRGB(255, 255,   0),
    Blue   = Color3.fromRGB(  0, 170, 255),
    Cyan   = Color3.fromRGB(  0, 255, 255),
    Black  = Color3.fromRGB( 20,  20,  20),
    Fire   = Color3.fromRGB(255, 100,   0),
    Flame  = Color3.fromRGB(255,  85,   0),
    Blaze  = Color3.fromRGB(255,   0,   0),
    Ice    = Color3.fromRGB(180, 255, 255),
    Water  = Color3.fromRGB(  0, 140, 255),
    Glass  = Color3.fromRGB(200, 200, 255),
    Moon   = Color3.fromRGB(180, 180, 255),
    Light  = Color3.fromRGB(245, 245, 245),
    Dark   = Color3.fromRGB( 20,  20,  20),
}

-- Change global accent color
function library:Color(themeName)
    local col = self.Themes[themeName]
    if col then
        self._AccentColor = col
        for _, obj in ipairs(self._AccentObjects or {}) do
            if obj and obj:IsA("GuiObject") then
                obj.BackgroundColor3 = col
            end
        end
    end
end

-- Utility to create instances
local function new(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do inst[k] = v end
    return inst
end

-- Creates the main window
function library:MakeWindow(config)
    -- screen gui
    local gui = new("ScreenGui", {
        Name = "VelonixUI",
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        ResetOnSpawn = false,
    })

    -- Intro animation
    if config.IntroEnabled then
        local overlay = new("Frame", {
            Parent = gui,
            Size = UDim2.new(1,0,1,0),
            BackgroundColor3 = self.Themes.Black,
            BackgroundTransparency = 0.5,
        })
        local label = new("TextLabel", {
            Parent = overlay,
            Text = config.IntroText or "Welcome to Velonix",
            Font = Enum.Font.GothamBold,
            TextSize = 32,
            TextColor3 = Color3.new(1,1,1),
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,0,50),
            Position = UDim2.new(0,0,0.4,0),
        })
        label.TextTransparency = 1
        TweenService:Create(label, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
        task.wait(1)
        TweenService:Create(label, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
        task.wait(0.6)
        overlay:Destroy()
    end

    -- Main frame
    local main = new("Frame", {
        Parent       = gui,
        Size         = UDim2.new(0,600,0,400),
        Position     = UDim2.new(0.5,-300,0.5,-200),
        AnchorPoint  = Vector2.new(0.5,0.5),
        BackgroundColor3 = self.Themes.Dark,
        Active       = true,
        Draggable    = true,
    })
    new("UICorner", {Parent=main, CornerRadius=UDim.new(0,12)})

    -- Title + controls
    local title = new("TextLabel", {
        Parent = main,
        Text = config.Name or "Velonix UI",
        Font = Enum.Font.GothamBold,
        TextSize = 22,
        TextColor3 = Color3.new(1,1,1),
        BackgroundTransparency = 1,
        Size = UDim2.new(1,-140,0,40),
        Position = UDim2.new(0,20,0,0),
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local ctrlFrame = new("Frame", {
        Parent = main,
        Size = UDim2.new(0,120,0,40),
        Position = UDim2.new(1,-120,0,0),
        BackgroundTransparency = 1,
    })
    local btnMin = new("TextButton", {
        Parent = ctrlFrame, Text = "_", Font = Enum.Font.GothamBold, TextSize = 20,
        TextColor3 = Color3.new(1,1,1), BackgroundColor3 = self.Themes.Blue,
        Size = UDim2.new(0,40,1,0), Position = UDim2.new(0,0,0,0),
    })
    local btnExpand = new("TextButton", {
        Parent = ctrlFrame, Text = "—", Font = Enum.Font.GothamBold, TextSize = 20,
        TextColor3 = Color3.new(1,1,1), BackgroundColor3 = self.Themes.Cyan,
        Size = UDim2.new(0,40,1,0), Position = UDim2.new(0.333,0,0,0),
    })
    local btnClose = new("TextButton", {
        Parent = ctrlFrame, Text = "X", Font = Enum.Font.GothamBold, TextSize = 18,
        TextColor3 = Color3.new(1,1,1), BackgroundColor3 = self.Themes.Fire,
        Size = UDim2.new(0,40,1,0), Position = UDim2.new(0.666,0,0,0),
    })
    for _,b in ipairs({btnMin,btnExpand,btnClose}) do
        new("UICorner", {Parent=b, CornerRadius=UDim.new(0,6)})
    end
    btnMin.MouseButton1Click:Connect(function() main.Size = UDim2.new(0,600,0,40) end)
    btnExpand.MouseButton1Click:Connect(function() main.Size = UDim2.new(0,600,0,400) end)
    btnClose.MouseButton1Click:Connect(function() gui:Destroy() end)

    -- Scrolling tab list
    local tabList = new("ScrollingFrame", {
        Parent = main,
        Size = UDim2.new(0,150,1,-50),
        Position = UDim2.new(0,0,0,50),
        BackgroundTransparency = 1,
        ScrollBarThickness = 6,
    })
    local tabLayout = new("UIListLayout", {
        Parent = tabList,
        Padding = UDim.new(0,8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    -- Scrolling content
    local content = new("ScrollingFrame", {
        Parent = main,
        Size = UDim2.new(1,-160,1,-50),
        Position = UDim2.new(0,160,0,50),
        BackgroundTransparency = 1,
        ScrollBarThickness = 6,
    })
    local contentLayout = new("UIListLayout", {
        Parent = content,
        Padding = UDim.new(0,10),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    -- Accent objects for theme changes
    self._AccentObjects = { btnMin, btnExpand, btnClose, title }
    self._AccentColor = self.Themes.Purple

    -- Store refs
    self._Gui        = gui
    self._MainFrame  = main
    self._TabList    = tabList
    self._Content    = content
    self._Tabs       = {}

    setmetatable(self, library)
    return self
end

-- Window methods
library.MakeTab = function(self, tabConfig)
    -- button
    local btn = new("TextButton", {
        Parent = self._TabList,
        Text = tabConfig.Name,
        Font = Enum.Font.Gotham,
        TextSize = 16,
        TextColor3 = Color3.new(1,1,1),
        BackgroundColor3 = self.Themes.Black,
        Size = UDim2.new(1,-10,0,30),
    })
    new("UICorner", {Parent=btn, CornerRadius=UDim.new(0,6)})

    -- panel
    local panel = new("Frame", {
        Parent = self._Content,
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1,
        Visible = false,
    })
    local layout = new("UIListLayout", {
        Parent = panel,
        Padding = UDim.new(0,10),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    btn.MouseButton1Click:Connect(function()
        for _,v in ipairs(self._Content:GetChildren()) do
            if v:IsA("Frame") then v.Visible = false end
        end
        panel.Visible = true
        self._Content.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y)
    end)

    -- auto-activate first tab
    if #self._Tabs == 0 then
        btn:Activate()
        panel.Visible = true
        self._Content.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y)
    end

    table.insert(self._Tabs, panel)

    -- tab API
    local tab = {}

    function tab:AddLabel(txt)
        return new("TextLabel", {
            Parent = panel,
            Text = txt,
            Font = Enum.Font.GothamSemibold,
            TextSize = 14,
            TextColor3 = Color3.new(1,1,1),
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,0,20),
        })
    end

    function tab:AddParagraph(title, desc)
        local f = new("Frame", {Parent=panel, Size=UDim2.new(1,0,0,50), BackgroundTransparency=1})
        new("TextLabel", {Parent=f, Text=title, Font=Enum.Font.GothamBold, TextSize=14, TextColor3=Color3.new(1,1,1), BackgroundTransparency=1, Size=UDim2.new(1,0,0,20)})
        new("TextLabel", {Parent=f, Text=desc, Font=Enum.Font.Gotham, TextSize=12, TextColor3=Color3.fromRGB(180,180,180), BackgroundTransparency=1, Size=UDim2.new(1,0,0,30), Position=UDim2.new(0,0,0,20)})
        return f
    end

    function tab:AddSection(opts)
        return tab:AddLabel(opts.Name)
    end

    function tab:AddButton(opts)
        local b = new("TextButton", {
            Parent = panel,
            Text = opts.Name,
            Font = Enum.Font.Gotham,
            TextSize = 14,
            TextColor3 = Color3.new(1,1,1),
            BackgroundColor3 = self.Themes.Black,
            Size = UDim2.new(1,0,0,30),
        })
        new("UICorner", {Parent=b, CornerRadius=UDim.new(0,6)})
        b.MouseButton1Click:Connect(opts.Callback)
        return b
    end

    return tab
end

return library
-- itzC9 GUI v1.4
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LogService = game:GetService("LogService")
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui")); 
gui.Name="Velonix_Library"; 
gui.ResetOnSpawn=false

-- Main Frame settings
local mainFrame = Instance.new("Frame", gui)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
mainFrame.Size=UDim2.new(0,500,0,300);
mainFrame.Position=UDim2.new(0.3,0,0.3,0)
mainFrame.BackgroundColor3=Color3.fromRGB(127,0,0);
mainFrame.BackgroundTransparency=0.3
mainFrame.Active=true;
mainFrame.Selectable=true;
mainFrame.Draggable=true;
mainFrame.Visible=false

-- Blue glow
local stroke=Instance.new("UIStroke", mainFrame);
stroke.Color=Color3.fromRGB(0,0,255);
stroke.Thickness=2;
stroke.Transparency=0.5

-- Scrollable Tab Frame
local tabFrame=Instance.new("ScrollingFrame", mainFrame)
Instance.new("UICorner", tabFrame).CornerRadius = UDim.new(0, 8)
tabFrame.Size=UDim2.new(0,100,1,-50);
tabFrame.Position=UDim2.new(0,5,0,50)
tabFrame.BackgroundColor3=Color3.fromRGB(127,0,0);
tabFrame.BackgroundTransparency=0.5
tabFrame.ScrollBarThickness=6;
tabFrame.CanvasSize=UDim2.new(0,0,0,0)

-- Settings Frame
local settingsFrame=Instance.new("Frame", mainFrame)
Instance.new("UICorner", settingsFrame).CornerRadius = UDim.new(0, 8)
settingsFrame.Size=UDim2.new(0,100,1,-50);
settingsFrame.Position=UDim2.new(1,-105,0,50)

local openBtn=Instance.new("Frame", gui)
openBtn.Size=UDim2.new(0,100,0,40);
openBtn.Position=UDim2.new(0,20,0.5,-20)
openBtn.BackgroundColor3=Color3.fromRGB(255,0,0);
openBtn.BackgroundTransparency=0.3
openBtn.Active=true;
openBtn.Selectable=true;
openBtn.Draggable=true

local openText=Instance.new("TextLabel", openBtn)
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)
openText.Size=UDim2.new(1,0,1,0);
openText.BackgroundTransparency=1;
openText.Text="Open"
openText.Font=Enum.Font.SourceSansBold;
openText.TextSize=20;
openText.TextColor3=Color3.fromRGB(0,0,0)
openBtn.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then
        mainFrame.Visible=not mainFrame.Visible
        openText.Text=mainFrame.Visible and "Close" or "Open"
    end
end)

local tabY=0;
local settingsY=0;
local tabContainers={};
local currentTab;
local consoleBox

LogService.MessageOut:Connect(function(msg)
    if consoleBox then
        consoleBox.Text=consoleBox.Text..msg.."\n"
    end
end)

function addLogo(id)
    local logo=Instance.new("ImageLabel", mainFrame)
    logo.Size=UDim2.new(0,40,0,40); logo.Position=UDim2.new(0,5,0,5)
    logo.Image="rbxassetid://"..id; 
    logo.ImageTransparency=1
    TweenService:Create(logo, TweenInfo.new(1), {ImageTransparency=0}):Play()
end

function createWindow(name,sz)
    local title=Instance.new("TextLabel", mainFrame)
    title.Size=UDim2.new(0,200,0,40); 
    title.Position=UDim2.new(0,50,0,5)
    title.Text=name; 
    title.Font=Enum.Font.SourceSansBold; 
    title.TextSize=sz
    title.TextColor3=Color3.fromRGB(0,0,255); 
    title.BackgroundTransparency=1
    title.TextXAlignment=Enum.TextXAlignment.Left
end

function createTab(name,idx)
    local btn=Instance.new("TextButton", tabFrame)
    btn.Size=UDim2.new(1,-10,0,40); 
    btn.Position=UDim2.new(0,5,0,tabY)
    btn.Text=name; 
    btn.Font=Enum.Font.SourceSansBold; 
    btn.TextSize=20
    btn.TextColor3=Color3.fromRGB(0,0,255); 
    btn.BackgroundColor3=Color3.fromRGB(255,0,0)
    btn.BackgroundTransparency=0.3
    
    local ctr=Instance.new("Frame", mainFrame)
    ctr.Name=""..idx; 
    ctr.Size=UDim2.new(0,200,1,-50); 
    ctr.Position=UDim2.new(0,110,0,50)
    ctr.BackgroundTransparency=1;
    ctr.Visible=false
    btn.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Visible=false
        end;
        currentTab=ctr; 
        currentTab.Visible=true
    end)
    tabContainers[idx]={frame=ctr,y=0}
    tabY=tabY+45;
    tabFrame.CanvasSize=UDim2.new(0,0,0,tabY)
    if name:lower()=="console" then
        consoleBox=Instance.new("TextBox",ctr)
        Instance.new("UICorner", consoleBox).CornerRadius = UDim.new(0, 6)
        consoleBox.Size=UDim2.new(1,-10,1,-10);
        consoleBox.Position=UDim2.new(0,5,0,5)
        consoleBox.Text="Console Loaded!";
        consoleBox.ClearTextOnFocus=false
        consoleBox.Font=Enum.Font.Code;
        consoleBox.TextSize=14
        consoleBox.TextEditable=false;
        consoleBox.BackgroundColor3=Color3.fromRGB(20,20,20)
        consoleBox.TextColor3=Color3.fromRGB(0,1,0);
        consoleBox.MultiLine=true
    end
end

function createButton(txt,idx,cb)
    local c=tabContainers[idx];
    if not c then
        return
    end
    
    local b=Instance.new("TextButton",c.frame)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.Size=UDim2.new(1,-10,0,40);
    b.Position=UDim2.new(0,5,0,c.y)
    b.Text=txt;
    b.Font=Enum.Font.SourceSansBold; 
    b.TextSize=20
    b.TextColor3=Color3.fromRGB(0,0,255);
    b.BackgroundColor3=Color3.fromRGB(255,0,0)
    b.BackgroundTransparency=0.3;
    b.MouseButton1Click:Connect(cb)
    c.y=c.y+45
end

function createToggle(txt,idx,def,cb)
    local c=tabContainers[idx]; 
    
    if not c then
        return
    end
    
    local b=Instance.new("TextButton",c.frame)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.Size=UDim2.new(1,-10,0,40); 
    b.Position=UDim2.new(0,5,0,c.y)
    
    local s=def; b.Text=txt..": "..(s and"ON"or"OFF")
    b.Font=Enum.Font.SourceSansBold;
    b.TextSize=18; 
    b.TextColor3=Color3.new(1,1,1)
    b.BackgroundColor3=Color3.fromRGB(0,170,0); 
    b.BackgroundTransparency=0.2
    b.MouseButton1Click:Connect(function() s=not s; 
    b.Text=txt..": "..(s and"ON"or"OFF"); 
    cb(s) 
    end)
    c.y=c.y+45
end

function createTextBox(idx,ph,cb)
    local c=tabContainers[idx]; 
    
    if not c then
        return
    end
    
    local tb=Instance.new("TextBox",c.frame)
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)
    tb.Size=UDim2.new(1,-10,0,35); 
    tb.Position=UDim2.new(0,5,0,c.y)
    tb.PlaceholderText=ph; 
    tb.Font=Enum.Font.SourceSans; 
    tb.TextSize=16
    tb.TextColor3=Color3.new(1,1,1); 
    tb.BackgroundColor3=Color3.fromRGB(50,50,50)
    tb.BackgroundTransparency=0.1; 
    tb.ClearTextOnFocus=false
    tb.FocusLost:Connect(function(e) 
    if e then 
        cb(tb.Text)
    end
    end)
    c.y=c.y+40
end

function createDropdown(idx,ttl,opts,cb)
    local c=tabContainers[idx];
    
    if not c then
        return
    end
    
    local d=Instance.new("TextButton",c.frame)
    Instance.new("UICorner", d).CornerRadius = UDim.new(0, 6)
    d.Size=UDim2.new(1,-10,0,35); 
    d.Position=UDim2.new(0,5,0,c.y)
    
    local i=1; 
    d.Text=ttl..": "..opts[i]
    d.Font=Enum.Font.SourceSansBold; 
    d.TextSize=16; 
    d.TextColor3=Color3.new(1,1,1)
    d.BackgroundColor3=Color3.fromRGB(40,40,40); 
    d.BackgroundTransparency=0.1
    d.MouseButton1Click:Connect(function() i=i%#opts+1; d.Text=ttl..": "..opts[i]; cb(opts[i]) 
    end)
    c.y=c.y+40
end

function createDivider(idx)
    local c=tabContainers[idx];
    if not c then
        return
    end
    
    local f=Instance.new("Frame",c.frame)
    f.Size=UDim2.new(1,-10,0,2); f.Position=UDim2.new(0,5,0,c.y)
    f.BackgroundColor3=Color3.new(1,1,1); f.BackgroundTransparency=0.3; c.y=c.y+10
end

function createSlider(idx,ttl,min,max,def,cb)
    local c=tabContainers[idx];
    if not c then
        return
    end
    
    local lbl=Instance.new("TextLabel",c.frame)
    lbl.Size=UDim2.new(1,-10,0,20); 
    lbl.Position=UDim2.new(0,5,0,c.y)
    lbl.Text=ttl..": "..def; 
    lbl.Font=Enum.Font.SourceSansBold; 
    lbl.TextSize=14
    lbl.TextColor3=Color3.new(1,1,1); 
    lbl.BackgroundTransparency=1; c.y=c.y+20
    
    local bar=Instance.new("Frame",c.frame)
    bar.Size=UDim2.new(1,-10,0,20); 
    bar.Position=UDim2.new(0,5,0,c.y); 
    bar.BackgroundColor3=Color3.fromRGB(100,100,100)
    
    local fill=Instance.new("Frame",bar)
    fill.Size=UDim2.new((def-min)/(max-min),0,1,0); 
    fill.BackgroundColor3=Color3.fromRGB(0,170,255); 
    fill.BorderSizePixel=0
    
    local drag=false
    bar.InputBegan:Connect(function(i) 
    if i.UserInputType==Enum.UserInputType.MouseButton1 then 
    drag=true
    end
    end)
    bar.InputEnded:Connect(function(i) 
    if i.UserInputType==Enum.UserInputType.MouseButton1 then 
    drag=false 
    end 
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local rel=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
            fill.Size=UDim2.new(rel,0,1,0)
            
            local v=math.floor(min+(max-min)*rel)
            lbl.Text=ttl..": "..v; cb(v)
        end
    end)
    c.y=c.y+25
end

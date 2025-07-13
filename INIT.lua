loadstring(game:HttpGet("https://raw.githubusercontent.com/ug32-C9/Velonix-UI-Library/refs/heads/main/Main3.lua"))()

createWindow("Velonix Hub", 28)
createLogo(12345678)

createTab("Home", 1)
createLabel("Label" 1)
createButton("Button", 1, function()
    print("Button Clicked!")
    Console("Button Clicked!")
end)
createDivider(1)
createToggle("Toggle", 1, false, function(s)
    print("Toggled: "..tostring(s))
    Console("Toggled: "..tostring(s))
end)
-- Settings
createSettingButton("Rejoin", function()
    print("Setting Button clicked!") 
    Console("Setting Button clicked!") 
end)

createNotify("Title","Description")
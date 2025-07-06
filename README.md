# Velonix UI Library

**Velonix UI Library** is a modular Roblox GUI framework designed for developers who want fast, functional, and stylish UI for their games or scripts. It provides a simple API to build tabbed interfaces, buttons, toggles, sliders, dropdowns, and more.

---

## 📥 How to Load

- Simply paste this line into your script editor to load the UI Library:

- Window Loader
loadstring(game:HttpGet("https://raw.githubusercontent.com/itzC9/Velonix-UI-Library/refs/heads/main/Main2.lua"))()

---

# 🚀 Quickstart

```createWindow("Velonix Hub", 28) -- Title and optional logo size```
```addLogo(12345678)               -- Replace with your actual decal ID```


---

# 📂 Creating Tabs

```createTab("Home", 1)``
```createTab("Console", 2)```


---

# 🛠️ Inside Tab Example

- Label
```createLabel("Label", "Description", 1)```

- Section
```createSection("Section", 1)```

- Button
```createButton("Button", 1, function()
    print("Button Clicked!")
    Console("Button Clicked!")
end)```

- Toggle
```createToggle("Toggle", 1, false, function(state)
    print("Toggled: "..tostring(state))
    Console("Toggled: "..tostring(state))
end)```

- Divider
```createDivider(1)```

- TextBox
```createTextBox(1, "Enter Text", function(text)
    print("Text Entered: "..text)
    Console("Text Entered: "..text)
end)```

- Drop-Down
```createDropdown(1, "Drop-down", {"Hello, World!", "Hi, World!", "Good, World!"}, function(choice)
    print("Drop-down-Set: "..choice)
    Console("Drop-down-Set: "..choice)
end)```
---



---
# ⚙️ Settings Panel
```createSettingButton("Rejoin", function()
    print("Setting Button clicked!") 
    Console("Setting Button clicked!") 
end)```
---



---
# 🖥️ Notifications

- Notification
```createNotify("Title", "Description")```

- Notification 2
```createNotify2("Title", "Description", 10) -- Custom duration (seconds)```



---
# 🧾 Console Logging
- You can print messages directly to the console tab:
```Console("Console Logged!")```
---



---
# 📌 Requirements
Works in Roblox Studio or Executor environment.
Uses ScrollingFrame-based dynamic layout.
UI is auto-styled with corner rounding and spacing.
---



---
# 📣 Credits
- Developer: itzC9
- Concept Contributor: Nov
- UI Design: Velonix Studio
---



---

# 📜 License:
- MIT License. You are free to use, modify, and redistribute with credit.
---



---
💬 Contact
For questions or issues, open an Issue or contact via Discord.
---
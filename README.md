# Velonix UI Library

**Velonix UI Library** is a modular Roblox GUI framework designed for developers who want fast, functional, and stylish UI for their games or scripts. It provides a simple API to build tabbed interfaces, buttons, toggles, sliders, dropdowns, and more.

---

## 📥 How to Load

Simply paste this line into your script to load the UI Library:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/ug32-C9/Velonix-UI-Library/refs/heads/main/Main3.lua"))()
```

---

## 🚀 Quickstart

```lua
createWindow("Velonix Hub", 28) -- Title and optional logo size
addLogo(12345678)               -- Replace with your actual decal ID
```

---

## 📂 Creating Tabs

```lua
createTab("Home", 1)
createTab("Console", 3)
```

---

## 🛠️ Home Tab Example

```lua
createLabel("Credits:", "Developer: itzC9\nIDEA: Nov", 1)

createSection("Made By Velonix Team", 1)

createButton("Button", 1, function()
    print("Button Clicked!")
    Console("Button Clicked!")
end)

createToggle("Toggle", 1, false, function(state)
    print("Toggled: "..tostring(state))
    Console("Toggled: "..tostring(state))
end)

createDivider(1)

createTextBox(1, "Enter Text", function(text)
    print("Text Entered: "..text)
    Console("Text Entered: "..text)
end)

createDropdown(1, "Drop-down", {"GuardHouse", "Gate", "House"}, function(choice)
    print("Drop-down-Set: "..choice)
    Console("Drop-down-Set: "..choice)
end)
```

---

## ⚙️ Settings Panel

```lua
createSettingButton("Rejoin", function()
    print("Setting Button clicked!") 
    Console("Setting Button clicked!") 
end)
```

---

## 🖥️ Notifications

```lua
createNotify("Title", "Description")

createNotify2("Title", "Description", 10) -- Custom duration (seconds)
```

---

## 🧾 Console Logging

You can print messages directly to the console tab:

```lua
Console("Console Logged!")
```

---

## 📌 Requirements

- Works in Roblox Studio or Executor environment.
- Uses `ScrollingFrame`-based dynamic layout.
- UI is auto-styled with corner rounding and spacing.

---

## 📣 Credits

- **Developer:** [itzC9](https://github.com/ug32-C9)
- **Concept Contributor:** Nov
- **UI Design:** Velonix Studio

---

## 📜 License

MIT License. You are free to use, modify, and redistribute with credit.

---

## 💬 Contact

For questions or issues, open an [Issue](https://github.com/ug32-C9/Velonix-UI-Library/issues) or contact via Discord.

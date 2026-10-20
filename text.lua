
--========================================================
-- NEOHUB MM2 | COMBINED EDITION
-- LocalScript > StarterPlayer > StarterPlayerScripts
--========================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local CONFIG = {
    Name = "NEOHUB",
    Version = "MM2 EDITION",
    Logo = "rbxassetid://80870779095600",
}

local BLUE = Color3.fromRGB(0, 145, 255)
local BG = Color3.fromRGB(8, 10, 16)
local PANEL = Color3.fromRGB(15, 19, 29)
local OFF = Color3.fromRGB(27, 32, 43)
local WHITE = Color3.fromRGB(240, 245, 255)
local MUTED = Color3.fromRGB(135, 150, 175)

local Flags = {
    FULLBRIGHT = false,
    INFINITE_JUMP = false,
    NOCLIP = false,
    NAME_ESP = false,
    BOX_ESP = false,
    TRACER_ESP = false,
    HIGHLIGHT_ESP = false,
    DISTANCE_ESP = false,
    FARM = false,
}

local OriginalLighting = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    ExposureCompensation = Lighting.ExposureCompensation,
}

local connections = {}
local espObjects = {}
local running = true

local function connect(signal, callback)
    local c = signal:Connect(callback)
    table.insert(connections, c)
    return c
end

local function create(className, properties, parent)
    local obj = Instance.new(className)
    for key, value in pairs(properties or {}) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local old = PlayerGui:FindFirstChild("NEOHUB_MM2")
if old then old:Destroy() end

-- GUI ROOT
local Gui = create("ScreenGui", {
    Name = "NEOHUB_MM2",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
}, PlayerGui)

local Main = create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(540, 375),
    Position = UDim2.new(0.5, -270, 0.5, -187),
    BackgroundColor3 = BG,
    BorderSizePixel = 0,
    Active = true,
}, Gui)
create("UICorner", {CornerRadius = UDim.new(0, 10)}, Main)
create("UIStroke", {Color = BLUE, Thickness = 1.5}, Main)

local Header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 62),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0,
}, Main)
create("UICorner", {CornerRadius = UDim.new(0, 10)}, Header)
create("Frame", {
    Position = UDim2.new(0, 0, 1, -10),
    Size = UDim2.new(1, 0, 0, 10),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0,
}, Header)

create("ImageLabel", {
    Position = UDim2.fromOffset(11, 9),
    Size = UDim2.fromOffset(43, 43),
    BackgroundTransparency = 1,
    Image = CONFIG.Logo,
    ScaleType = Enum.ScaleType.Fit,
}, Header)

create("TextLabel", {
    Position = UDim2.fromOffset(62, 7),
    Size = UDim2.new(1, -150, 0, 29),
    BackgroundTransparency = 1,
    Text = CONFIG.Name,
    TextColor3 = BLUE,
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

create("TextLabel", {
    Position = UDim2.fromOffset(63, 35),
    Size = UDim2.new(1, -150, 0, 15),
    BackgroundTransparency = 1,
    Text = CONFIG.Version,
    TextColor3 = MUTED,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

local MinButton = create("TextButton", {
    Position = UDim2.new(1, -65, 0, 16),
    Size = UDim2.fromOffset(24, 27),
    BackgroundColor3 = OFF,
    Text = "−",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    BorderSizePixel = 0,
}, Header)
create("UICorner", {CornerRadius = UDim.new(0, 5)}, MinButton)

local CloseButton = create("TextButton", {
    Position = UDim2.new(1, -35, 0, 16),
    Size = UDim2.fromOffset(24, 27),
    BackgroundColor3 = Color3.fromRGB(105, 35, 48),
    Text = "×",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    BorderSizePixel = 0,
}, Header)
create("UICorner", {CornerRadius = UDim.new(0, 5)}, CloseButton)

local Tabs = create("Frame", {
    Position = UDim2.fromOffset(10, 72),
    Size = UDim2.new(0, 130, 1, -82),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0,
}, Main)
create("UICorner", {CornerRadius = UDim.new(0, 8)}, Tabs)
create("UIPadding", {
    PaddingTop = UDim.new(0, 9),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
}, Tabs)
create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, Tabs)

local Content = create("ScrollingFrame", {
    Position = UDim2.fromOffset(150, 72),
    Size = UDim2.new(1, -160, 1, -82),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = BLUE,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
}, Main)
create("UICorner", {CornerRadius = UDim.new(0, 8)}, Content)
create("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10),
}, Content)
create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, Content)

-- DRAG
local dragging, dragStart, startPosition = false, nil, nil

connect(Header.InputBegan, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

connect(UIS.InputChanged, function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

connect(UIS.InputEnded, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local Floating = create("ImageButton", {
    Name = "FloatingIcon",
    Size = UDim2.fromOffset(52, 52),
    Position = UDim2.new(0, 15, 0.45, 0),
    BackgroundColor3 = BG,
    Image = CONFIG.Logo,
    Visible = false,
}, Gui)
create("UICorner", {CornerRadius = UDim.new(1, 0)}, Floating)
create("UIStroke", {Color = BLUE, Thickness = 2}, Floating)

MinButton.Activated:Connect(function()
    Main.Visible = false
    Floating.Visible = true
end)

Floating.Activated:Connect(function()
    Main.Visible = true
    Floating.Visible = false
end)

-- FULLBRIGHT
local function setFullbright(enabled)
    Flags.FULLBRIGHT = enabled

    if enabled then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1000000
        Lighting.GlobalShadows = false
        Lighting.ExposureCompensation = 0.5
    else
        for property, value in pairs(OriginalLighting) do
            pcall(function()
                Lighting[property] = value
            end)
        end
    end
end

-- ROLE DETECTION: LOCAL TOOL CHECK ONLY
local function getRole()
    local character = Player.Character
    local backpack = Player:FindFirstChildOfClass("Backpack")

    local function hasTool(toolName)
        if character then
            local tool = character:FindFirstChild(toolName)
            if tool and tool:IsA("Tool") then return true end
        end
        if backpack then
            local tool = backpack:FindFirstChild(toolName)
            if tool and tool:IsA("Tool") then return true end
        end
        return false
    end

    if hasTool("Knife") then return "MURDERER" end
    if hasTool("Gun") then return "SHERIFF / HERO" end
    return "INNOCENT / UNKNOWN"
end

-- PLAYER FEATURES
connect(UIS.JumpRequest, function()
    if not Flags.INFINITE_JUMP then return end
    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

connect(RunService.Stepped, function()
    if not Flags.NOCLIP then return end
    local character = Player.Character
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

-- CONTENT HELPERS
local function clearContent()
    for _, child in ipairs(Content:GetChildren()) do
        if not child:IsA("UIListLayout")
            and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function label(text)
    return create("TextLabel", {
        Size = UDim2.new(1, -4, 0, 34),
        BackgroundColor3 = BG,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = WHITE,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextWrapped = true,
    }, Content)
end

local function action(text, callback)
    local button = create("TextButton", {
        Size = UDim2.new(1, -4, 0, 38),
        BackgroundColor3 = OFF,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = WHITE,
        Font = Enum.Font.Gotham,
        TextSize = 12,
    }, Content)
    create("UICorner", {CornerRadius = UDim.new(0, 6)}, button)
    button.Activated:Connect(callback)
    return button
end

local function toggle(text, key, callback)
    local button = create("TextButton", {
        Size = UDim2.new(1, -4, 0, 38),
        BackgroundColor3 = Flags[key] and BLUE or OFF,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    }, Content)
    create("UICorner", {CornerRadius = UDim.new(0, 6)}, button)

    create("TextLabel", {
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -60, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = WHITE,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, button)

    local state = create("TextLabel", {
        Position = UDim2.new(1, -48, 0, 0),
        Size = UDim2.fromOffset(40, 38),
        BackgroundTransparency = 1,
        Text = Flags[key] and "ON" or "OFF",
        TextColor3 = WHITE,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
    }, button)

    button.Activated:Connect(function()
        Flags[key] = not Flags[key]
        button.BackgroundColor3 = Flags[key] and BLUE or OFF
        state.Text = Flags[key] and "ON" or "OFF"
        if callback then callback(Flags[key]) end
    end)
end

-- BASIC LOCAL DEBUG ESP
local function removeESP(target)
    local info = espObjects[target]
    if not info then return end
    if info.highlight then info.highlight:Destroy() end
    if info.billboard then info.billboard:Destroy() end
    espObjects[target] = nil
end

local function clearESP()
    for target in pairs(espObjects) do
        removeESP(target)
    end
end

local function updateESP()
    if not (Flags.NAME_ESP or Flags.HIGHLIGHT_ESP or Flags.DISTANCE_ESP) then
        clearESP()
        return
    end

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= Player then
            local character = target.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if root and humanoid and humanoid.Health > 0 then
                local info = espObjects[target]
                if not info then
                    info = {}
                    espObjects[target] = info
                end

                if Flags.HIGHLIGHT_ESP and not info.highlight then
                    info.highlight = create("Highlight", {
                        FillColor = BLUE,
                        OutlineColor = WHITE,
                        FillTransparency = 0.75,
                        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                    }, character)
                elseif not Flags.HIGHLIGHT_ESP and info.highlight then
                    info.highlight:Destroy()
                    info.highlight = nil
                end

                if (Flags.NAME_ESP or Flags.DISTANCE_ESP) and not info.billboard then
                    info.billboard = create("BillboardGui", {
                        Size = UDim2.fromOffset(180, 40),
                        StudsOffset = Vector3.new(0, 3, 0),
                        AlwaysOnTop = true,
                        Adornee = root,
                    }, PlayerGui)

                    info.text = create("TextLabel", {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundTransparency = 1,
                        TextColor3 = WHITE,
                        TextStrokeTransparency = 0.2,
                        Font = Enum.Font.GothamBold,
                        TextSize = 12,
                    }, info.billboard)
                end

                if info.text then
                    local text = ""
                    if Flags.NAME_ESP then text = target.Name end
                    if Flags.DISTANCE_ESP then
                        local myRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local distance = math.floor((root.Position - myRoot.Position).Magnitude)
                            text = text == "" and (tostring(distance) .. " studs")
                                or (text .. " | " .. tostring(distance) .. " studs")
                        end
                    end
                    info.text.Text = text
                end
            else
                removeESP(target)
            end
        end
    end
end

-- TABS
local function renderTab(tabName)
    clearContent()
    label(CONFIG.Name .. " / " .. string.upper(tabName))

    if tabName == "Murder" then
        label("Role detected: " .. getRole())
        action("Refresh Role", function()
            renderTab("Murder")
        end)
        label("Knife/Gun detection is client-side and may not reflect server role data.")

    elseif tabName == "Sheriff" then
        label("Sheriff tools")
        label("Detected role: " .. getRole())
        label("Weapon and shooting behavior should use your own game's server logic.")

    elseif tabName == "Innocent" then
        label("Innocent tools")
        label("Detected role: " .. getRole())
        label("Gun pickup requires the game's pickup/server logic.")

    elseif tabName == "Farm" then
        label("Candy / Farm")
        toggle("Candy Farm (placeholder)", "FARM", function(enabled)
            if enabled then
                label("Connect this toggle to your own game's candy collection system.")
            end
        end)
        label("Candy names and pickup rules vary by game.")

    elseif tabName == "Player" then
        label("PLAYER SETTINGS")
        toggle("Fullbright", "FULLBRIGHT", setFullbright)
        toggle("Infinite Jump", "INFINITE_JUMP")
        toggle("Noclip", "NOCLIP")
        label("Visual / ESP settings")
        toggle("Name ESP", "NAME_ESP")
        toggle("Distance ESP", "DISTANCE_ESP")
        toggle("Highlight ESP", "HIGHLIGHT_ESP")
        action("Clear ESP", clearESP)
        label("ESP is intended for debugging your own experience.")
    end
end

local tabNames = {"Murder", "Sheriff", "Innocent", "Farm", "Player"}

for index, tabName in ipairs(tabNames) do
    local button = create("TextButton", {
        Name = tabName .. "Tab",
        LayoutOrder = index,
        Size = UDim2.new(1, 0, 0, 39),
        BackgroundColor3 = index == 1 and BLUE or OFF,
        BorderSizePixel = 0,
        Text = tabName,
        TextColor3 = WHITE,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
    }, Tabs)
    create("UICorner", {CornerRadius = UDim.new(0, 6)}, button)

    button.Activated:Connect(function()
        for _, child in ipairs(Tabs:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = OFF
            end
        end
        button.BackgroundColor3 = BLUE
        renderTab(tabName)
    end)
end

connect(RunService.Heartbeat, function()
    if running then updateESP() end
end)

CloseButton.Activated:Connect(function()
    running = false
    setFullbright(false)
    Flags.NOCLIP = false
    clearESP()

    for _, connection in ipairs(connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    Gui:Destroy()
end)

renderTab("Murder")
Main.Visible = true
print("NEOHUB MM2 loaded")

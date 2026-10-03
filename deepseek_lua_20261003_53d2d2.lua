-- ============================================================
-- NOTHING GUI  •  SINGLE FILE VERSION
-- Animated popup • Draggable toggle icon • Bottom-left profile
-- Settings: background/panel/title colors, accents, opacity, resize
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

pcall(function()
    if CoreGui:FindFirstChild("NothingGUI") then CoreGui.NothingGUI:Destroy() end
    if CoreGui:FindFirstChild("NothingIcon") then CoreGui.NothingIcon:Destroy() end
    if CoreGui:FindFirstChild("NothingProfile") then CoreGui.NothingProfile:Destroy() end
end)

--// State
local Settings = {
    BGColor = Color3.fromRGB(14, 14, 20),
    PanelColor = Color3.fromRGB(22, 22, 32),
    TitleColor = Color3.fromRGB(28, 28, 42),
    Accent = Color3.fromRGB(0, 255, 200),
    Accent2 = Color3.fromRGB(120, 100, 255),
    Opacity = 1,
    Width = 440,
    Height = 300,
}

local TEXT_MAIN = Color3.fromRGB(240, 240, 250)
local TEXT_DIM  = Color3.fromRGB(150, 150, 170)

--// ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NothingGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

--// Main window
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = Settings.BGColor
Main.BackgroundTransparency = 1 - Settings.Opacity
Main.BorderSizePixel = 0
Main.ClipsDescendants = false
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Settings.Accent
MainStroke.Thickness = 2
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Settings.BGColor),
    ColorSequenceKeypoint.new(0.5, Settings.PanelColor),
    ColorSequenceKeypoint.new(1, Settings.BGColor),
})
Gradient.Rotation = 0
Gradient.Parent = Main

local function refreshGradient()
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Settings.BGColor),
        ColorSequenceKeypoint.new(0.5, Settings.PanelColor),
        ColorSequenceKeypoint.new(1, Settings.BGColor),
    })
    Main.BackgroundColor3 = Settings.BGColor
    Main.BackgroundTransparency = 1 - Settings.Opacity
    MainStroke.Color = Settings.Accent
end

task.spawn(function()
    while Main.Parent do
        for i = 0, 360, 3 do
            if not Main.Parent then break end
            Gradient.Rotation = i
            task.wait(0.05)
        end
    end
end)

--// Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Settings.TitleColor
TitleBar.BackgroundTransparency = 1 - Settings.Opacity
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = TitleBar

local TitleCover = Instance.new("Frame")
TitleCover.Name = "TitleCover"
TitleCover.Size = UDim2.new(1, 0, 0, 16)
TitleCover.Position = UDim2.new(0, 0, 1, -16)
TitleCover.BackgroundColor3 = Settings.TitleColor
TitleCover.BackgroundTransparency = 1 - Settings.Opacity
TitleCover.BorderSizePixel = 0
TitleCover.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -160, 1, 0)
Title.Position = UDim2.new(0, 48, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "NOTHING GUI"
Title.TextColor3 = TEXT_MAIN
Title.TextSize = 20
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Settings.Accent),
    ColorSequenceKeypoint.new(0.5, Settings.Accent2),
    ColorSequenceKeypoint.new(1, Settings.Accent),
})
TitleGrad.Rotation = 0
TitleGrad.Parent = Title

local function refreshTitleGrad()
    TitleGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Settings.Accent),
        ColorSequenceKeypoint.new(0.5, Settings.Accent2),
        ColorSequenceKeypoint.new(1, Settings.Accent),
    })
end

task.spawn(function()
    while Title.Parent do
        for i = 0, 360, 3 do
            if not Title.Parent then break end
            TitleGrad.Rotation = i
            task.wait(0.05)
        end
    end
end)

local Dot = Instance.new("Frame")
Dot.Name = "Dot"
Dot.Size = UDim2.new(0, 10, 0, 10)
Dot.Position = UDim2.new(0, 22, 0.5, -5)
Dot.BackgroundColor3 = Settings.Accent
Dot.BorderSizePixel = 0
Dot.Parent = TitleBar

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = Dot

task.spawn(function()
    while Dot.Parent do
        TweenService:Create(Dot, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {BackgroundColor3 = Settings.Accent2, Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 20, 0.5, -7)}):Play()
        task.wait(0.9)
        TweenService:Create(Dot, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {BackgroundColor3 = Settings.Accent, Size = UDim2.new(0, 10, 0, 10), Position = UDim2.new(0, 22, 0.5, -5)}):Play()
        task.wait(0.9)
    end
end)

--// Buttons
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(210, 60, 80)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -76, 0, 6)
MinBtn.BackgroundColor3 = Color3.fromRGB(230, 180, 60)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(30, 30, 40)
MinBtn.TextSize = 18
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.AutoButtonColor = false
MinBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinBtn

local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Name = "SettingsBtn"
SettingsBtn.Size = UDim2.new(0, 30, 0, 30)
SettingsBtn.Position = UDim2.new(1, -112, 0, 6)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 220)
SettingsBtn.Text = "⚙"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsBtn.TextSize = 18
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.BorderSizePixel = 0
SettingsBtn.AutoButtonColor = false
SettingsBtn.Parent = TitleBar

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 8)
SettingsCorner.Parent = SettingsBtn

CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 80, 100)}):Play() end)
CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(210, 60, 80)}):Play() end)
MinBtn.MouseEnter:Connect(function() TweenService:Create(MinBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 210, 80)}):Play() end)
MinBtn.MouseLeave:Connect(function() TweenService:Create(MinBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(230, 180, 60)}):Play() end)
SettingsBtn.MouseEnter:Connect(function() TweenService:Create(SettingsBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 160, 255)}):Play() end)
SettingsBtn.MouseLeave:Connect(function() TweenService:Create(SettingsBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 130, 220)}):Play() end)

--// Resize grip
local ResizeGrip = Instance.new("TextButton")
ResizeGrip.Name = "ResizeGrip"
ResizeGrip.Size = UDim2.new(0, 22, 0, 22)
ResizeGrip.Position = UDim2.new(1, -26, 1, -26)
ResizeGrip.BackgroundTransparency = 1
ResizeGrip.Text = "◢"
ResizeGrip.TextColor3 = Settings.Accent
ResizeGrip.TextSize = 18
ResizeGrip.Font = Enum.Font.GothamBold
ResizeGrip.BorderSizePixel = 0
ResizeGrip.AutoButtonColor = false
ResizeGrip.Parent = Main

--// Body
local Body = Instance.new("Frame")
Body.Name = "Body"
Body.Size = UDim2.new(1, -24, 1, -70)
Body.Position = UDim2.new(0, 12, 0, 58)
Body.BackgroundColor3 = Settings.PanelColor
Body.BackgroundTransparency = 1 - Settings.Opacity
Body.BorderSizePixel = 0
Body.Parent = Main

local BodyCorner = Instance.new("UICorner")
BodyCorner.CornerRadius = UDim.new(0, 10)
BodyCorner.Parent = Body

local BodyStroke = Instance.new("UIStroke")
BodyStroke.Color = Settings.Accent
BodyStroke.Thickness = 1
BodyStroke.Transparency = 0.7
BodyStroke.Parent = Body

local EmptyIcon = Instance.new("TextLabel")
EmptyIcon.Size = UDim2.new(1, 0, 0, 60)
EmptyIcon.Position = UDim2.new(0, 0, 0.5, -50)
EmptyIcon.BackgroundTransparency = 1
EmptyIcon.Text = "◌"
EmptyIcon.TextColor3 = Settings.Accent
EmptyIcon.TextSize = 60
EmptyIcon.Font = Enum.Font.GothamBold
EmptyIcon.Parent = Body

task.spawn(function()
    while EmptyIcon.Parent do
        TweenService:Create(EmptyIcon, TweenInfo.new(1.4, Enum.EasingStyle.Sine), {Rotation = 180, TextTransparency = 0.3}):Play()
        task.wait(1.4)
        TweenService:Create(EmptyIcon, TweenInfo.new(1.4, Enum.EasingStyle.Sine), {Rotation = 360, TextTransparency = 0}):Play()
        task.wait(1.4)
        EmptyIcon.Rotation = 0
    end
end)

local EmptyText = Instance.new("TextLabel")
EmptyText.Size = UDim2.new(1, 0, 0, 26)
EmptyText.Position = UDim2.new(0, 0, 0.5, 10)
EmptyText.BackgroundTransparency = 1
EmptyText.Text = "Nothing here… yet."
EmptyText.TextColor3 = TEXT_DIM
EmptyText.TextSize = 15
EmptyText.Font = Enum.Font.Gotham
EmptyText.Parent = Body

local EmptySub = Instance.new("TextLabel")
EmptySub.Size = UDim2.new(1, 0, 0, 20)
EmptySub.Position = UDim2.new(0, 0, 0.5, 34)
EmptySub.BackgroundTransparency = 1
EmptySub.Text = "an intentionally empty place"
EmptySub.TextColor3 = Color3.fromRGB(110, 110, 130)
EmptySub.TextSize = 12
EmptySub.Font = Enum.Font.Gotham
EmptySub.Parent = Body

--// Settings page
local SettingsPage = Instance.new("Frame")
SettingsPage.Name = "SettingsPage"
SettingsPage.Size = UDim2.new(1, -24, 1, -70)
SettingsPage.Position = UDim2.new(0, 12, 0, 58)
SettingsPage.BackgroundColor3 = Settings.PanelColor
SettingsPage.BackgroundTransparency = 1 - Settings.Opacity
SettingsPage.BorderSizePixel = 0
SettingsPage.Visible = false
SettingsPage.Parent = Main

local SettingsPageCorner = Instance.new("UICorner")
SettingsPageCorner.CornerRadius = UDim.new(0, 10)
SettingsPageCorner.Parent = SettingsPage

local SettingsPageStroke = Instance.new("UIStroke")
SettingsPageStroke.Color = Settings.Accent
SettingsPageStroke.Thickness = 1
SettingsPageStroke.Transparency = 0.7
SettingsPageStroke.Parent = SettingsPage

local SettingsScroll = Instance.new("ScrollingFrame")
SettingsScroll.Size = UDim2.new(1, -12, 1, -12)
SettingsScroll.Position = UDim2.new(0, 6, 0, 6)
SettingsScroll.BackgroundTransparency = 1
SettingsScroll.BorderSizePixel = 0
SettingsScroll.ScrollBarThickness = 4
SettingsScroll.ScrollBarImageColor3 = Settings.Accent
SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsScroll.Parent = SettingsPage

local SettingsList = Instance.new("UIListLayout")
SettingsList.Padding = UDim.new(0, 8)
SettingsList.SortOrder = Enum.SortOrder.LayoutOrder
SettingsList.Parent = SettingsScroll

--// Widget builders
local function sectionHeader(text)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -8, 0, 26)
    f.BackgroundTransparency = 1
    f.Parent = SettingsScroll

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -8, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Settings.Accent
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = f

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -8, 0, 1)
    line.Position = UDim2.new(0, 8, 1, -1)
    line.BackgroundColor3 = Settings.Accent
    line.BackgroundTransparency = 0.6
    line.BorderSizePixel = 0
    line.Parent = f

    return f
end

local function colorRow(label, default, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -8, 0, 38)
    f.BackgroundColor3 = Settings.BGColor
    f.BackgroundTransparency = 1 - Settings.Opacity * 0.7
    f.BorderSizePixel = 0
    f.Parent = SettingsScroll

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = f

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = TEXT_MAIN
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = f

    local preview = Instance.new("TextButton")
    preview.Size = UDim2.new(0, 40, 0, 24)
    preview.Position = UDim2.new(1, -52, 0.5, -12)
    preview.BackgroundColor3 = default
    preview.Text = ""
    preview.BorderSizePixel = 0
    preview.Parent = f

    local pc = Instance.new("UICorner")
    pc.CornerRadius = UDim.new(0, 6)
    pc.Parent = preview

    local ps = Instance.new("UIStroke")
    ps.Color = Color3.fromRGB(255, 255, 255)
    ps.Thickness = 1
    ps.Transparency = 0.5
    ps.Parent = preview

    local editing = false
    local colorFrame = Instance.new("Frame")
    colorFrame.Size = UDim2.new(0, 200, 0, 150)
    colorFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    colorFrame.BorderSizePixel = 0
    colorFrame.Visible = false
    colorFrame.ZIndex = 60
    colorFrame.Parent = Main

    local cfCorner = Instance.new("UICorner")
    cfCorner.CornerRadius = UDim.new(0, 10)
    cfCorner.Parent = colorFrame

    local cfStroke = Instance.new("UIStroke")
    cfStroke.Color = Settings.Accent
    cfStroke.Thickness = 1
    cfStroke.Parent = colorFrame

    local cfTitle = Instance.new("TextLabel")
    cfTitle.Size = UDim2.new(1, -34, 0, 26)
    cfTitle.Position = UDim2.new(0, 8, 0, 4)
    cfTitle.BackgroundTransparency = 1
    cfTitle.Text = label
    cfTitle.TextColor3 = TEXT_MAIN
    cfTitle.TextSize = 13
    cfTitle.Font = Enum.Font.GothamBold
    cfTitle.TextXAlignment = Enum.TextXAlignment.Left
    cfTitle.Parent = colorFrame

    local cfClose = Instance.new("TextButton")
    cfClose.Size = UDim2.new(0, 22, 0, 22)
    cfClose.Position = UDim2.new(1, -26, 0, 4)
    cfClose.BackgroundColor3 = Color3.fromRGB(200, 60, 80)
    cfClose.Text = "✕"
    cfClose.TextColor3 = Color3.fromRGB(255, 255, 255)
    cfClose.TextSize = 12
    cfClose.Font = Enum.Font.GothamBold
    cfClose.BorderSizePixel = 0
    cfClose.Parent = colorFrame

    local cfCloseC = Instance.new("UICorner")
    cfCloseC.CornerRadius = UDim.new(0, 6)
    cfCloseC.Parent = cfClose

    local hueBar = Instance.new("Frame")
    hueBar.Size = UDim2.new(1, -20, 0, 14)
    hueBar.Position = UDim2.new(0, 10, 0, 38)
    hueBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueBar.BorderSizePixel = 0
    hueBar.Parent = colorFrame

    local hueCorner = Instance.new("UICorner")
    hueCorner.CornerRadius = UDim.new(0, 3)
    hueCorner.Parent = hueBar

    local hueGrad = Instance.new("UIGradient")
    hueGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
    })
    hueGrad.Parent = hueBar

    local svBox = Instance.new("Frame")
    svBox.Size = UDim2.new(1, -20, 0, 55)
    svBox.Position = UDim2.new(0, 10, 0, 60)
    svBox.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    svBox.BorderSizePixel = 0
    svBox.Parent = colorFrame

    local svCorner = Instance.new("UICorner")
    svCorner.CornerRadius = UDim.new(0, 3)
    svCorner.Parent = svBox

    local svWhite = Instance.new("Frame")
    svWhite.Size = UDim2.new(1, 0, 1, 0)
    svWhite.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    svWhite.BorderSizePixel = 0
    svWhite.Parent = svBox

    local svWhiteC = Instance.new("UICorner")
    svWhiteC.CornerRadius = UDim.new(0, 3)
    svWhiteC.Parent = svWhite

    local svWhiteGrad = Instance.new("UIGradient")
    svWhiteGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1),
    })
    svWhiteGrad.Parent = svWhite

    local svBlack = Instance.new("Frame")
    svBlack.Size = UDim2.new(1, 0, 1, 0)
    svBlack.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    svBlack.BorderSizePixel = 0
    svBlack.Parent = svBox

    local svBlackC = Instance.new("UICorner")
    svBlackC.CornerRadius = UDim.new(0, 3)
    svBlackC.Parent = svBlack

    local svBlackGrad = Instance.new("UIGradient")
    svBlackGrad.Rotation = 90
    svBlackGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1),
    })
    svBlackGrad.Parent = svBlack

    local svCursor = Instance.new("Frame")
    svCursor.Size = UDim2.new(0, 8, 0, 8)
    svCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    svCursor.BorderSizePixel = 0
    svCursor.ZIndex = 2
    svCursor.Parent = svBox

    local svcC = Instance.new("UICorner")
    svcC.CornerRadius = UDim.new(1, 0)
    svcC.Parent = svCursor

    local svcStroke = Instance.new("UIStroke")
    svcStroke.Color = Color3.fromRGB(0, 0, 0)
    svcStroke.Thickness = 1
    svcStroke.Parent = svCursor

    local hueCursor = Instance.new("Frame")
    hueCursor.Size = UDim2.new(0, 6, 1, 0)
    hueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueCursor.BorderSizePixel = 0
    hueCursor.ZIndex = 2
    hueCursor.Parent = hueBar

    local hcC = Instance.new("UICorner")
    hcC.CornerRadius = UDim.new(0, 2)
    hcC.Parent = hueCursor

    local hcStroke = Instance.new("UIStroke")
    hcStroke.Color = Color3.fromRGB(0, 0, 0)
    hcStroke.Thickness = 1
    hcStroke.Parent = hueCursor

    local curH, curS, curV = default:ToHSV()
    local hDrag, sDrag = false, false

    local function applyColor()
        local col = Color3.fromHSV(curH, curS, curV)
        preview.BackgroundColor3 = col
        callback(col)
    end

    local function updateCursors()
        hueCursor.Position = UDim2.new(curH, -3, 0, 0)
        svCursor.Position = UDim2.new(curS, -4, 1 - curV, -4)
        svBox.BackgroundColor3 = Color3.fromHSV(curH, 1, 1)
    end
    updateCursors()

    hueBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            hDrag = true
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if hDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local rel = math.clamp((input.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
            curH = rel
            updateCursors()
            applyColor()
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            hDrag = false
        end
    end)

    svBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = true
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relX = math.clamp((input.Position.X - svBox.AbsolutePosition.X) / svBox.AbsoluteSize.X, 0, 1)
            local relY = math.clamp((input.Position.Y - svBox.AbsolutePosition.Y) / svBox.AbsoluteSize.Y, 0, 1)
            curS = relX
            curV = 1 - relY
            updateCursors()
            applyColor()
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sDrag = false
        end
    end)

    preview.MouseButton1Click:Connect(function()
        editing = not editing
        colorFrame.Visible = editing
        if editing then
            local abs = preview.AbsolutePosition
            colorFrame.Position = UDim2.new(
                0,
                math.clamp(abs.X - 140, 8, math.max(8, Main.AbsoluteSize.X - 208)),
                0,
                math.clamp(abs.Y + 30, 8, math.max(8, Main.AbsoluteSize.Y - 158))
            )
        end
    end)
    cfClose.MouseButton1Click:Connect(function()
        editing = false
        colorFrame.Visible = false
    end)

    return f
end

local function sliderRow(label, min, max, default, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -8, 0, 48)
    f.BackgroundColor3 = Settings.BGColor
    f.BackgroundTransparency = 1 - Settings.Opacity * 0.7
    f.BorderSizePixel = 0
    f.Parent = SettingsScroll

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = f

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 0, 20)
    lbl.Position = UDim2.new(0, 12, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = TEXT_MAIN
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = f

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0.25, 0, 0, 20)
    valLbl.Position = UDim2.new(0.72, 0, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Settings.Accent
    valLbl.TextSize = 13
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = f

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -24, 0, 6)
    bar.Position = UDim2.new(0, 12, 1, -14)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    bar.BorderSizePixel = 0
    bar.Parent = f

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 3)
    bc.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Settings.Accent
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 3)
    fc.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(fill.Size.X.Scale, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = bar

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local dragging = false
    local function update(input)
        local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = min + (max - min) * rel
        val = math.floor(val * 100 + 0.5) / 100
        fill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -7, 0.5, -7)
        valLbl.Text = tostring(val)
        callback(val)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input)
        end
    end)
    bar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return f
end

--// Build Settings content
sectionHeader("COLORS")

colorRow("Background", Settings.BGColor, function(c)
    Settings.BGColor = c
    refreshGradient()
end)

colorRow("Panel", Settings.PanelColor, function(c)
    Settings.PanelColor = c
    Body.BackgroundColor3 = c
    Body.BackgroundTransparency = 1 - Settings.Opacity
    SettingsPage.BackgroundColor3 = c
    SettingsPage.BackgroundTransparency = 1 - Settings.Opacity
    refreshGradient()
end)

colorRow("Title Bar", Settings.TitleColor, function(c)
    Settings.TitleColor = c
    TitleBar.BackgroundColor3 = c
    TitleBar.BackgroundTransparency = 1 - Settings.Opacity
    TitleCover.BackgroundColor3 = c
    TitleCover.BackgroundTransparency = 1 - Settings.Opacity
end)

colorRow("Accent", Settings.Accent, function(c)
    Settings.Accent = c
    MainStroke.Color = c
    BodyStroke.Color = c
    SettingsPageStroke.Color = c
    SettingsScroll.ScrollBarImageColor3 = c
    Dot.BackgroundColor3 = c
    EmptyIcon.TextColor3 = c
    ResizeGrip.TextColor3 = c
    refreshTitleGrad()
end)

colorRow("Accent 
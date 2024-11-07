local CoreGui = game:GetService("CoreGui")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Tween(obj, dur, prop, eas, wuf)
    local eas = eas or Enum.EasingStyle.Quint
    local wuf = wuf or false
    local cTween = TweenService:Create(obj, TweenInfo.new(dur), prop, eas, Enum.EasingDirection.Out)
    cTween:Play()
    if wuf then
        cTween.Completed:Wait()
    end
end

local Library = {}

function Library:Window(title, smalltitle)

    local MainUi = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local MainFrameCorner = Instance.new("UICorner")
    local Pages = Instance.new("Folder")
    local AboveFrame = Instance.new("Frame")
    local AboveFrameCorner = Instance.new("UICorner")
    local TitleLabel = Instance.new("TextLabel")
    local AutorLabel = Instance.new("TextLabel")
    local UiToggle = Instance.new("ImageButton")
    local MainSort = Instance.new("UIListLayout")

    local MainPage = Instance.new("ScrollingFrame")
    local MainPageList = Instance.new("UIListLayout")

    do
        if CoreGui:FindFirstChild("U-Modern Ui") then
            CoreGui:FindFirstChild("U-Modern Ui"):Destroy()
        end
    end

    MainUi.Name = "U-Modern Ui"
    MainUi.Parent = CoreGui

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = MainUi
    MainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    MainFrame.ClipsDescendants = true
    MainFrame.Position = UDim2.new(0.840884572, 0, 0.634282375, 0)
    MainFrame.Size = UDim2.new(0, 296, 0, 352)
    
    MainFrameCorner.CornerRadius = UDim.new(0, 5)
    MainFrameCorner.Name = "MainFrameCorner"
    MainFrameCorner.Parent = MainFrame
    
    Pages.Name = "Pages"
    Pages.Parent = MainFrame
    
    AboveFrame.Name = "AboveFrame"
    AboveFrame.Parent = MainFrame
    AboveFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AboveFrame.BackgroundTransparency = 1.000
    AboveFrame.Size = UDim2.new(0, 296, 0, 56)
    
    AboveFrameCorner.CornerRadius = UDim.new(0, 5)
    AboveFrameCorner.Name = "AboveFrameCorner"
    AboveFrameCorner.Parent = AboveFrame
    
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = AboveFrame
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1.000
    TitleLabel.Position = UDim2.new(0.033444792, 0, 0.142857149, 0)
    TitleLabel.Size = UDim2.new(0, 215, 0, 25)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14.000
    TitleLabel.TextWrapped = true
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    AutorLabel.Name = "AutorLabel"
    AutorLabel.Parent = AboveFrame
    AutorLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AutorLabel.BackgroundTransparency = 1.000
    AutorLabel.Position = UDim2.new(0.0334448069, 0, 0.578460097, 0)
    AutorLabel.Size = UDim2.new(0, 200, 0, 22)
    AutorLabel.Font = Enum.Font.GothamSemibold
    AutorLabel.Text = smalltitle
    AutorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutorLabel.TextSize = 11.000
    AutorLabel.TextTransparency = 0.450
    AutorLabel.TextWrapped = true
    AutorLabel.TextXAlignment = Enum.TextXAlignment.Left
    AutorLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    UiToggle.Name = "UiToggle"
    UiToggle.Parent = AboveFrame
    UiToggle.BackgroundTransparency = 1.000
    UiToggle.LayoutOrder = 4
    UiToggle.Position = UDim2.new(0.891384482, 0, 0.149079338, 0)
    UiToggle.Size = UDim2.new(0, 25, 0, 25)
    UiToggle.ZIndex = 2
    UiToggle.Image = "rbxassetid://3926307971"
    UiToggle.ImageRectOffset = Vector2.new(324, 364)
    UiToggle.ImageRectSize = Vector2.new(36, 36)
    
    MainSort.Name = "MainSort"
    MainSort.Parent = MainFrame
    MainSort.HorizontalAlignment = Enum.HorizontalAlignment.Center
    MainSort.Padding = UDim.new(0, 3)

    MainPage.Name = "MainPage"
    MainPage.Parent = MainFrame
    MainPage.Active = true
    MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainPage.BackgroundTransparency = 2.000
    MainPage.BorderSizePixel = 0
    MainPage.Position = UDim2.new(0.0334448144, 0, 0.158640221, 0)
    MainPage.Size = UDim2.new(0, 279, 0, 287)
    MainPage.CanvasPosition = Vector2.new(0, 118.789978)
    MainPage.ScrollBarThickness = 2

    MainPageList.Name = "MainPageList"
    MainPageList.Parent = MainPage
    MainPageList.SortOrder = Enum.SortOrder.LayoutOrder
    MainPageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    MainPageList.Padding = UDim.new(0, 3)

    UiToggle.MouseEnter:Connect(function()
        Tween(UiToggle, 0.15, {Rotation = 45})
    end)
    UiToggle.MouseLeave:Connect(function()
        if MainFrame.Size == UDim2.new(0, 296, 0, 352) then
            Tween(UiToggle, 0.15, {Rotation = 0})
        elseif MainFrame.Size == UDim2.new(0, 296, 0, 56) then
            Tween(UiToggle, 0.15, {Rotation = 90})
        end
    end)
    UiToggle.MouseButton1Click:Connect(function()
        if MainFrame.Size == UDim2.new(0, 296, 0, 352) then
            Tween(UiToggle, 0.15, {Rotation = 0})
            Tween(MainFrame, 0.15, {Size = UDim2.new(0, 296, 0, 56)})
        elseif MainFrame.Size == UDim2.new(0, 296, 0, 56) then
            Tween(UiToggle, 0.15, {Rotation = 90})
            Tween(MainFrame, 0.15, {Size = UDim2.new(0, 296, 0, 352)})
        end
    end)

    local dragToggle = nil
	local dragSpeed = 0.12
	local dragStart = nil
	local startPos = nil
 
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		TweenService:Create(MainFrame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end
 
	AboveFrame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
 
	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)

    local Window = {}

    function Window:Button(buttonname, buttondescription, callback)

        local Button = Instance.new("Frame")
        local ButtonCorner = Instance.new("UICorner")
        local ButtonDescription = Instance.new("TextLabel")
        local ButtonText = Instance.new("TextLabel")
        local ButtonPress = Instance.new("ImageLabel")
        local ButtonTrigger = Instance.new("TextButton")

        Button.Name = "Button"
        Button.Parent = MainPage
        Button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(0, 279, 0, 50)
        
        ButtonCorner.CornerRadius = UDim.new(0, 4)
        ButtonCorner.Name = "ButtonCorner"
        ButtonCorner.Parent = Button
        
        ButtonDescription.Name = "ButtonDescription"
        ButtonDescription.Parent = Button
        ButtonDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonDescription.BackgroundTransparency = 1.000
        ButtonDescription.Position = UDim2.new(0.0226921719, 0, 0.596317112, 0)
        ButtonDescription.Size = UDim2.new(0.480286747, 0, 0.239999995, 0)
        ButtonDescription.Font = Enum.Font.GothamSemibold
        ButtonDescription.Text = buttondescription
        ButtonDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonDescription.TextSize = 11.000
        ButtonDescription.TextTransparency = 0.450
        ButtonDescription.TextWrapped = true
        ButtonDescription.TextXAlignment = Enum.TextXAlignment.Left
        ButtonDescription.TextYAlignment = Enum.TextYAlignment.Top
        
        ButtonText.Name = "ButtonText"
        ButtonText.Parent = Button
        ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonText.BackgroundTransparency = 1.000
        ButtonText.Position = UDim2.new(0.0262761824, 0, 0.119999997, 0)
        ButtonText.Size = UDim2.new(0.537634432, 0, 0.340000004, 0)
        ButtonText.Font = Enum.Font.GothamSemibold
        ButtonText.Text = buttonname
        ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonText.TextSize = 14.000
        ButtonText.TextWrapped = true
        ButtonText.TextXAlignment = Enum.TextXAlignment.Left

        ButtonPress.Name = "ButtonPress"
        ButtonPress.Parent = Button
        ButtonPress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonPress.BackgroundTransparency = 1.000
        ButtonPress.Position = UDim2.new(0.838709652, 0, 0.239999995, 0)
        ButtonPress.Size = UDim2.new(0, 25, 0, 25)
        ButtonPress.Image = "rbxassetid://3926307971"
        ButtonPress.ImageColor3 = Color3.fromRGB(212, 212, 212)
        ButtonPress.ImageRectOffset = Vector2.new(764, 244)
        ButtonPress.ImageRectSize = Vector2.new(36, 36)
        
        ButtonTrigger.Name = "ButtonTrigger"
        ButtonTrigger.Parent = Button
        ButtonTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonTrigger.BackgroundTransparency = 1.000
        ButtonTrigger.Size = UDim2.new(1, 0, 1, 0)
        ButtonTrigger.AutoButtonColor = false
        ButtonTrigger.Font = Enum.Font.SourceSans
        ButtonTrigger.Text = ""
        ButtonTrigger.TextColor3 = Color3.fromRGB(0, 0, 0)
        ButtonTrigger.TextSize = 14.000

        ButtonTrigger.MouseButton1Click:Connect(function()
            Tween(Button, 0.1, {Size = UDim2.new(0, 240, 0, 40)}, Enum.EasingStyle.Quint, true)
            Tween(Button, 0.06, {Size = UDim2.new(0, 279, 0, 50)}, Enum.EasingStyle.Quint, true)
        end)
        ButtonTrigger.MouseButton1Click:Connect(function()
            callback()
        end)

        MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)

    end

    function Window:Toggle(togglename, toggledescription, preset, callback)

        local Toggle = Instance.new("Frame")
        local ToggleCorner = Instance.new("UICorner")
        local ToggleText = Instance.new("TextLabel")
        local ToggleDescription = Instance.new("TextLabel")
        local ToggleOut = Instance.new("ImageLabel")
        local ToggleIn = Instance.new("ImageLabel")
        local ToggleTrigger = Instance.new("TextButton")

        Toggle.Name = "Toggle"
        Toggle.Parent = MainPage
        Toggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(0, 279, 0, 50)
        
        ToggleCorner.CornerRadius = UDim.new(0, 4)
        ToggleCorner.Name = "ToggleCorner"
        ToggleCorner.Parent = Toggle
        
        ToggleText.Name = "ToggleText"
        ToggleText.Parent = Toggle
        ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleText.BackgroundTransparency = 1.000
        ToggleText.Position = UDim2.new(0.0226921719, 0, 0.596317112, 0)
        ToggleText.Size = UDim2.new(0.480286747, 0, 0.239999995, 0)
        ToggleText.Font = Enum.Font.GothamSemibold
        ToggleText.Text = toggledescription
        ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleText.TextSize = 11.000
        ToggleText.TextTransparency = 0.450
        ToggleText.TextWrapped = true
        ToggleText.TextXAlignment = Enum.TextXAlignment.Left
        ToggleText.TextYAlignment = Enum.TextYAlignment.Top
        
        ToggleDescription.Name = "ToggleDescription"
        ToggleDescription.Parent = Toggle
        ToggleDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleDescription.BackgroundTransparency = 1.000
        ToggleDescription.Position = UDim2.new(0.0262761824, 0, 0.119999997, 0)
        ToggleDescription.Size = UDim2.new(0.837634432, 0, 0.340000004, 0)
        ToggleDescription.Font = Enum.Font.GothamSemibold
        ToggleDescription.Text = togglename
        ToggleDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleDescription.TextSize = 14.000
        ToggleDescription.TextWrapped = true
        ToggleDescription.TextXAlignment = Enum.TextXAlignment.Left
        
        ToggleOut.Name = "ToggleOut"
        ToggleOut.Parent = Toggle
        ToggleOut.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleOut.BackgroundTransparency = 1.000
        ToggleOut.Position = UDim2.new(0.820788503, 0, 0.360000014, 0)
        ToggleOut.Size = UDim2.new(0.125448033, 0, 0.280000001, 0)
        ToggleOut.Image = "rbxassetid://3570695787"
        ToggleOut.ImageColor3 = Color3.fromRGB(120, 120, 120)
        ToggleOut.ScaleType = Enum.ScaleType.Slice
        ToggleOut.SliceCenter = Rect.new(100, 100, 100, 100)
        ToggleOut.SliceScale = 0.400
        
        ToggleIn.Name = "ToggleIn"
        ToggleIn.Parent = Toggle
        ToggleIn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleIn.BackgroundTransparency = 1.000
        ToggleIn.Position = UDim2.new(0.820788562, 0, 0.340000033, 0)
        ToggleIn.Size = UDim2.new(0.0573476702, 0, 0.319999993, 0)
        ToggleIn.Image = "rbxassetid://3570695787"
        ToggleIn.ImageColor3 = Color3.fromRGB(212, 212, 212)
        ToggleIn.ScaleType = Enum.ScaleType.Slice
        ToggleIn.SliceCenter = Rect.new(100, 100, 100, 100)
        ToggleIn.SliceScale = 0.400
        
        ToggleTrigger.Name = "ToggleTrigger"
        ToggleTrigger.Parent = Toggle
        ToggleTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleTrigger.BackgroundTransparency = 1.000
        ToggleTrigger.Size = UDim2.new(1, 0, 1, 0)
        ToggleTrigger.AutoButtonColor = false
        ToggleTrigger.Font = Enum.Font.SourceSans
        ToggleTrigger.Text = ""
        ToggleTrigger.TextColor3 = Color3.fromRGB(0, 0, 0)
        ToggleTrigger.TextSize = 14.000

        local toggled = preset or false
        local tweentime = 0.14

        do
            if toggled then
                Tween(ToggleIn, tweentime, {Position = UDim2.new(0.892, 0, 0.34, 0)})
                Tween(ToggleOut, tweentime, {ImageColor3 = Color3.fromRGB(200, 200, 200)})
                Tween(ToggleIn, tweentime, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            end
            callback(toggled)
        end

        ToggleTrigger.MouseButton1Click:Connect(function()
            if toggled then
                toggled = false
                Tween(ToggleIn, tweentime, {Position = UDim2.new(0.820788562, 0, 0.340000033, 0)})
                Tween(ToggleOut, tweentime, {ImageColor3 = Color3.fromRGB(120, 120, 120)})
                Tween(ToggleIn, tweentime, {ImageColor3 = Color3.fromRGB(212, 212, 212)})
            else
                toggled = true
                Tween(ToggleIn, tweentime, {Position = UDim2.new(0.892, 0, 0.34, 0)})
                Tween(ToggleOut, tweentime, {ImageColor3 = Color3.fromRGB(200, 200, 200)})
                Tween(ToggleIn, tweentime, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            end
            callback(toggled)
        end)

        MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)

    end

    function Window:Slider(slidername, sliderdescription, minvalue, maxvalue, startvalue, callback)

        local Slider = Instance.new("Frame")
        local SliderCorner = Instance.new("UICorner")
        local SliderDescription = Instance.new("TextLabel")
        local SliderText = Instance.new("TextLabel")
        local SliderOut = Instance.new("Frame")
        local SliderOutCorner = Instance.new("UICorner")
        local SliderCircle = Instance.new("ImageButton")
        local SliderIn = Instance.new("Frame")
        local SliderInCorner = Instance.new("UICorner")
        local SliderValue = Instance.new("TextBox")
        local SliderValueCorner = Instance.new("UICorner")

        Slider.Name = "Slider"
        Slider.Parent = MainPage
        Slider.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Slider.BorderSizePixel = 0
        Slider.Size = UDim2.new(0, 279, 0, 50)
        
        SliderCorner.CornerRadius = UDim.new(0, 4)
        SliderCorner.Name = "SliderCorner"
        SliderCorner.Parent = Slider
        
        SliderDescription.Name = "SliderDescription"
        SliderDescription.Parent = Slider
        SliderDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderDescription.BackgroundTransparency = 1.000
        SliderDescription.Position = UDim2.new(0.0226921719, 0, 0.596317112, 0)
        SliderDescription.Size = UDim2.new(0.480286747, 0, 0.239999995, 0)
        SliderDescription.Font = Enum.Font.GothamSemibold
        SliderDescription.Text = sliderdescription
        SliderDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderDescription.TextSize = 11.000
        SliderDescription.TextTransparency = 0.450
        SliderDescription.TextWrapped = true
        SliderDescription.TextXAlignment = Enum.TextXAlignment.Left
        SliderDescription.TextYAlignment = Enum.TextYAlignment.Top
        
        SliderText.Name = "SliderText"
        SliderText.Parent = Slider
        SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderText.BackgroundTransparency = 1.000
        SliderText.Position = UDim2.new(0.0262761824, 0, 0.119999997, 0)
        SliderText.Size = UDim2.new(0.537634432, 0, 0.340000004, 0)
        SliderText.Font = Enum.Font.GothamSemibold
        SliderText.Text = slidername
        SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderText.TextSize = 14.000
        SliderText.TextWrapped = true
        SliderText.TextXAlignment = Enum.TextXAlignment.Left
        
        SliderOut.Name = "SliderOut"
        SliderOut.Parent = Slider
        SliderOut.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        SliderOut.Position = UDim2.new(0.430107534, 0, 0.239999995, 0)
        SliderOut.Size = UDim2.new(0, 144, 0, 5)
        
        SliderOutCorner.CornerRadius = UDim.new(0, 4)
        SliderOutCorner.Name = "SliderOutCorner"
        SliderOutCorner.Parent = SliderOut
        
        SliderCircle.Name = "SliderCircle"
        SliderCircle.Parent = SliderOut
        SliderCircle.BackgroundTransparency = 1.000
        SliderCircle.LayoutOrder = 4
        SliderCircle.Position = UDim2.new(0.444444448, 0, -1.10000002, 0)
        SliderCircle.Size = UDim2.new(0.111111112, 0, 3.20000005, 0)
        SliderCircle.ZIndex = 2
        SliderCircle.Image = "rbxassetid://3926305904"
        SliderCircle.ImageRectOffset = Vector2.new(124, 124)
        SliderCircle.ImageRectSize = Vector2.new(36, 36)
        
        SliderIn.Name = "SliderIn"
        SliderIn.Parent = SliderOut
        SliderIn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        SliderIn.BorderSizePixel = 0
        SliderIn.Size = UDim2.new(0, 144, 0, 5)
        
        SliderInCorner.CornerRadius = UDim.new(0, 4)
        SliderInCorner.Name = "SliderInCorner"
        SliderInCorner.Parent = SliderIn
        
        SliderValue.Name = "SliderValue"
        SliderValue.Parent = Slider
        SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderValue.BackgroundTransparency = 1.000
        SliderValue.Position = UDim2.new(0.770609319, 0, 0.519999981, 0)
        SliderValue.Size = UDim2.new(0.175627246, 0, 0.360000014, 0)
        SliderValue.Font = Enum.Font.GothamSemibold
        SliderValue.Text = "50"
        SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderValue.TextSize = 14.000
        SliderValue.TextXAlignment = Enum.TextXAlignment.Right
        
        SliderValueCorner.CornerRadius = UDim.new(0, 4)
        SliderValueCorner.Name = "SliderValueCorner"
        SliderValueCorner.Parent = SliderValue

        local dragging = false
        local value = startvalue

        do
            SliderCircle.Position = UDim2.new((startvalue or 0) / maxvalue, -6,-1.30499995, 0)
            SliderIn.Size = UDim2.new((startvalue or 0) / maxvalue, 0, 0, 5)
            SliderValue.Text = tostring(startvalue)
        end

        local function move(input)
            local pos =
                UDim2.new(
                    math.clamp((input.Position.X - SliderOut.AbsolutePosition.X) / SliderOut.AbsoluteSize.X, 0, 1),
                    -6,
                    -1.30499995,
                    0
                )
            local pos1 =
                UDim2.new(
                    math.clamp((input.Position.X - SliderOut.AbsolutePosition.X) / SliderOut.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    5
                )
            SliderIn:TweenSize(pos1, "Out", "Sine", 0.1, true)
            SliderCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
            value = math.floor(((pos.X.Scale * maxvalue) / maxvalue) * (maxvalue - minvalue) + minvalue)
            SliderValue.Text = tostring(value)
            callback(value)
        end
        SliderCircle.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end
        )
        SliderCircle.InputEnded:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end
        )
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                move(input)
            end
        end)

        SliderValue.FocusLost:Connect(function()
            if type(tonumber(SliderValue.Text)) == "number" then
                SliderCircle.Position = UDim2.new((tonumber(SliderValue.Text) or 0) / maxvalue, -6,-1.30499995, 0)
                SliderIn.Size = UDim2.new((tonumber(SliderValue.Text) or 0) / maxvalue, 0, 0, 5)
                value = tonumber(SliderValue.Text)
            else
                SliderValue.Text = tostring(value)
            end
        end)

        MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)

    end

    function Window:Textbox(textboxname, textboxdescription, presettext, callback)

        local Textbox = Instance.new("Frame")
        local TextboxCorner = Instance.new("UICorner")
        local TextboxDescription = Instance.new("TextLabel")
        local TextboxText = Instance.new("TextLabel")
        local TextBoxInput = Instance.new("TextBox")
        local TextboxInputCorner = Instance.new("UICorner")
        local TextBoxInputConstraint = Instance.new("UITextSizeConstraint")

        Textbox.Name = "Textbox"
        Textbox.Parent = MainPage
        Textbox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Textbox.BorderSizePixel = 0
        Textbox.Size = UDim2.new(0, 279, 0, 50)
        
        TextboxCorner.CornerRadius = UDim.new(0, 4)
        TextboxCorner.Name = "TextboxCorner"
        TextboxCorner.Parent = Textbox
        
        TextboxDescription.Name = "TextboxDescription"
        TextboxDescription.Parent = Textbox
        TextboxDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextboxDescription.BackgroundTransparency = 1.000
        TextboxDescription.Position = UDim2.new(0.0226921719, 0, 0.596317112, 0)
        TextboxDescription.Size = UDim2.new(0.480286747, 0, 0.239999995, 0)
        TextboxDescription.Font = Enum.Font.GothamSemibold
        TextboxDescription.Text = textboxdescription
        TextboxDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextboxDescription.TextSize = 11.000
        TextboxDescription.TextTransparency = 0.450
        TextboxDescription.TextWrapped = true
        TextboxDescription.TextXAlignment = Enum.TextXAlignment.Left
        TextboxDescription.TextYAlignment = Enum.TextYAlignment.Top
        
        TextboxText.Name = "TextboxText"
        TextboxText.Parent = Textbox
        TextboxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextboxText.BackgroundTransparency = 1.000
        TextboxText.Position = UDim2.new(0.0262761824, 0, 0.119999997, 0)
        TextboxText.Size = UDim2.new(0.476702511, 0, 0.340000004, 0)
        TextboxText.Font = Enum.Font.GothamSemibold
        TextboxText.Text = textboxname
        TextboxText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextboxText.TextSize = 14.000
        TextboxText.TextWrapped = true
        TextboxText.TextXAlignment = Enum.TextXAlignment.Left
        
        TextBoxInput.Name = "TextBoxInput"
        TextBoxInput.Parent = Textbox
        TextBoxInput.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        TextBoxInput.BorderSizePixel = 0
        TextBoxInput.Position = UDim2.new(0.71684587, 0, 0.219999999, 0)
        TextBoxInput.Size = UDim2.new(0.229390681, 0, 0.560000002, 0)
        TextBoxInput.Font = Enum.Font.Gotham
        TextBoxInput.PlaceholderText = presettext
        TextBoxInput.Text = ""
        TextBoxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBoxInput.TextScaled = true
        TextBoxInput.TextSize = 14.000
        TextBoxInput.TextWrapped = true
        
        TextboxInputCorner.CornerRadius = UDim.new(0, 4)
        TextboxInputCorner.Name = "TextboxInputCorner"
        TextboxInputCorner.Parent = TextBoxInput
        
        TextBoxInputConstraint.Name = "TextBoxInputConstraint"
        TextBoxInputConstraint.Parent = TextBoxInput
        TextBoxInputConstraint.MaxTextSize = 14
        TextBoxInputConstraint.MinTextSize = 8

        Textbox.MouseEnter:Connect(function()
            Tween(TextBoxInput, 0.2, {Size = UDim2.new(0.382, 0, 0.56, 0)})
            Tween(TextBoxInput, 0.2, {Position = UDim2.new(0.564, 0, 0.22, 0)})
        end)
        Textbox.MouseLeave:Connect(function()
            Tween(TextBoxInput, 0.2, {Size = UDim2.new(0.229390681, 0, 0.560000002, 0)})
            Tween(TextBoxInput, 0.2, {Position = UDim2.new(0.71684587, 0, 0.219999999, 0)})
        end)
        TextBoxInput.FocusLost:Connect(function()
            if TextBoxInput.Text ~= "" then
                callback(TextBoxInput.Text)
            end
        end)

        MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)

    end

    function Window:Dropdown(dropdownname, dropdowndescription, list, callback)

        local itemcount = 0
        local framesize = 0

        local Dropdown = Instance.new("Frame")
        local DropdownCorner = Instance.new("UICorner")
        local DropdownInfoHolder = Instance.new("Frame")
        local DropdownTrigger = Instance.new("TextBox")
        local DropdownTriggerInputConstraint = Instance.new("UITextSizeConstraint")
        local DropdownDescription = Instance.new("TextLabel")
        local DropdownText = Instance.new("TextLabel")
        local DropdownOutSort = Instance.new("UIListLayout")
        local DropdownItemHolder = Instance.new("ScrollingFrame")
        local DropdownItemHolderList = Instance.new("UIListLayout")

        Dropdown.Name = "Dropdown"
        Dropdown.Parent = MainPage
        Dropdown.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Dropdown.BorderSizePixel = 0
        Dropdown.Position = UDim2.new(0, 0, 0.216027871, 0)
        Dropdown.Size = UDim2.new(0, 279, 0, 50) -- 95
        Dropdown.ClipsDescendants = true
        
        DropdownCorner.CornerRadius = UDim.new(0, 4)
        DropdownCorner.Name = "DropdownCorner"
        DropdownCorner.Parent = Dropdown
        
        DropdownInfoHolder.Name = "DropdownInfoHolder"
        DropdownInfoHolder.Parent = Dropdown
        DropdownInfoHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownInfoHolder.BackgroundTransparency = 1.000
        DropdownInfoHolder.Size = UDim2.new(0, 279, 0, 50)
        
        DropdownTrigger.Name = "DropdownTrigger"
        DropdownTrigger.Parent = DropdownInfoHolder
        DropdownTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownTrigger.BackgroundTransparency = 1.000
        DropdownTrigger.Position = UDim2.new(0.502978683, 0, 0.140000001, 0)
        DropdownTrigger.Size = UDim2.new(0.440860212, 0, 0.699999988, 0)
        DropdownTrigger.Font = Enum.Font.GothamSemibold
        DropdownTrigger.PlaceholderText = "Search .."
        DropdownTrigger.Text = ""
        DropdownTrigger.TextColor3 = Color3.fromRGB(255, 255, 255)
        DropdownTrigger.TextScaled = true
        DropdownTrigger.TextSize = 12.000
        DropdownTrigger.TextWrapped = true
        DropdownTrigger.TextXAlignment = Enum.TextXAlignment.Right
        
        DropdownTriggerInputConstraint.Name = "DropdownTriggerInputConstraint"
        DropdownTriggerInputConstraint.Parent = DropdownTrigger
        DropdownTriggerInputConstraint.MaxTextSize = 12
        DropdownTriggerInputConstraint.MinTextSize = 8
        
        DropdownDescription.Name = "DropdownDescription"
        DropdownDescription.Parent = DropdownInfoHolder
        DropdownDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownDescription.BackgroundTransparency = 1.000
        DropdownDescription.Position = UDim2.new(0.0226921719, 0, 0.596317112, 0)
        DropdownDescription.Size = UDim2.new(0.480286747, 0, 0.239999995, 0)
        DropdownDescription.Font = Enum.Font.GothamSemibold
        DropdownDescription.Text = dropdowndescription
        DropdownDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
        DropdownDescription.TextSize = 11.000
        DropdownDescription.TextTransparency = 0.450
        DropdownDescription.TextWrapped = true
        DropdownDescription.TextXAlignment = Enum.TextXAlignment.Left
        DropdownDescription.TextYAlignment = Enum.TextYAlignment.Top
        
        DropdownText.Name = "DropdownText"
        DropdownText.Parent = DropdownInfoHolder
        DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownText.BackgroundTransparency = 1.000
        DropdownText.Position = UDim2.new(0.0262761824, 0, 0.119999997, 0)
        DropdownText.Size = UDim2.new(0.476702511, 0, 0.340000004, 0)
        DropdownText.Font = Enum.Font.GothamSemibold
        DropdownText.Text = dropdownname
        DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
        DropdownText.TextSize = 14.000
        DropdownText.TextWrapped = true
        DropdownText.TextXAlignment = Enum.TextXAlignment.Left
        
        DropdownOutSort.Name = "DropdownOutSort"
        DropdownOutSort.Parent = Dropdown
        DropdownOutSort.HorizontalAlignment = Enum.HorizontalAlignment.Center
        DropdownOutSort.SortOrder = Enum.SortOrder.LayoutOrder
        DropdownOutSort.Padding = UDim.new(0, 1)
        
        DropdownItemHolder.Name = "DropdownItemHolder"
        DropdownItemHolder.Parent = Dropdown
        DropdownItemHolder.Active = true
        DropdownItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownItemHolder.BackgroundTransparency = 1.000
        DropdownItemHolder.BorderSizePixel = 0
        DropdownItemHolder.Position = UDim2.new(0.0161290318, 0, 0.322580636, 0)
        DropdownItemHolder.Size = UDim2.new(0, 270, 0, 40)
        DropdownItemHolder.ScrollBarThickness = 2

        DropdownItemHolderList.Name = "DropdownItemHolderList"
        DropdownItemHolderList.Parent = DropdownItemHolder
        DropdownItemHolderList.SortOrder = Enum.SortOrder.LayoutOrder
        DropdownItemHolderList.Padding = UDim.new(0, 2)

        DropdownTrigger.Focused:Connect(function()
            Tween(Dropdown, 0.2, {Size = UDim2.new(0, 279, 0, (50 + framesize + 5))})
            for i = 1, 200000000 do
                MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)
                wait(0.00000001)
            end
        end)
        --[[DropdownTrigger.FocusLost:Connect(function()
            Tween(Dropdown, 0.2, {Size = UDim2.new(0, 279, 0, 50)})
            for i = 1, 200000000 do
                MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)
                wait(0.00000001)
            end
        end)--]]
        DropdownTrigger.Changed:Connect(function()
            local tblow = string.lower(DropdownTrigger.Text)
            if DropdownTrigger.Text ~= "" then
                for i, v in pairs(DropdownItemHolder:GetChildren()) do
                    if v:IsA("TextButton") then
                        if not string.find(string.lower(v.Text), tblow) then
                            v.Visible = false
                            DropdownItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropdownItemHolderList.AbsoluteContentSize.Y)
                        end
                    end
                end
            end
            if DropdownTrigger.Text == "" then
                for i, v in pairs(DropdownItemHolder:GetChildren()) do
                    if v:IsA("TextButton") then
                        v.Visible = true
                        DropdownItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropdownItemHolderList.AbsoluteContentSize.Y)
                    end
                end
            end
        end)

        for i, v in next, list do

            itemcount = itemcount + 1
            if itemcount <= 4 then
                framesize = framesize + (40 + 2)
            end

            DropdownItemHolder.Size = UDim2.new(0, 270, 0, framesize)
            DropdownItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropdownItemHolderList.AbsoluteContentSize.Y)

            local Item = Instance.new("TextButton")
            local ItemCorner = Instance.new("UICorner")

            Item.Name = "Item"
            Item.Parent = DropdownItemHolder
            Item.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            Item.Position = UDim2.new(0, 0, 0, 0)
            Item.Size = UDim2.new(0, 270, 0, 40)
            Item.AutoButtonColor = false
            Item.Font = Enum.Font.GothamBold
            Item.Text = v
            Item.TextColor3 = Color3.fromRGB(212, 212, 212)
            Item.TextSize = 14.000
            
            ItemCorner.CornerRadius = UDim.new(0, 4)
            ItemCorner.Name = "ItemCorner"
            ItemCorner.Parent = Item

            Item.MouseEnter:Connect(function()
                Tween(Item, 0.1, {BackgroundColor3 = Color3.fromRGB(16, 16, 16)})
            end)
            Item.MouseLeave:Connect(function()
                Tween(Item, 0.1, {BackgroundColor3 = Color3.fromRGB(18, 18, 18)})
            end)
            Item.MouseButton1Click:Connect(function()
                Tween(Dropdown, 0.2, {Size = UDim2.new(0, 279, 0, 50)})
                DropdownTrigger.Text = v
                for i = 1, 200000000 do
                    MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)
                    wait(0.00000001)
                end
            end)
            Item.MouseButton1Click:Connect(function()
                callback(Item.Text)
            end)

        end

        MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)

    end

    function Window:Label(labelname)

        local Label = Instance.new("Frame")
        local LabelCorner = Instance.new("UICorner")
        local LabelText = Instance.new("TextLabel")
        local LabelConstraint = Instance.new("UITextSizeConstraint")

        Label.Name = "Label"
        Label.Parent = MainPage
        Label.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Label.BorderSizePixel = 0
        Label.Size = UDim2.new(0, 279, 0, 50)

        LabelCorner.CornerRadius = UDim.new(0, 4)
        LabelCorner.Name = "LabelCorner"
        LabelCorner.Parent = Label

        LabelText.Name = "LabelText"
        LabelText.Parent = Label
        LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelText.BackgroundTransparency = 1.000
        LabelText.Position = UDim2.new(0.0191077255, 0, 0.0199999809, 0)
        LabelText.Size = UDim2.new(0.957594812, 0, 0.959999979, 0)
        LabelText.Font = Enum.Font.Gotham
        LabelText.Text = labelname
        LabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
        LabelText.TextScaled = true
        LabelText.TextSize = 13.000
        LabelText.TextWrapped = true

        LabelConstraint.Name = "LabelConstraint"
        LabelConstraint.Parent = LabelText
        LabelConstraint.MaxTextSize = 13
		
	MainPage.CanvasSize = UDim2.new(0, 0, 0, MainPageList.AbsoluteContentSize.Y)

        local Config = {}

        function Config:Text(text)
            LabelText.Text = text
        end 
        function Config:Color(color)
            LabelText.TextColor3 = color
        end

        return Config
        
    end

    return Window

end

return Library

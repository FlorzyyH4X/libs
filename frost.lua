local Lib = {}

local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Lib.new(Args)
	local FrostLib = Instance.new("ScreenGui")
	local Container = Instance.new("Frame")
	local MainCorners = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local TabSwitches = Instance.new("ScrollingFrame")
	local ButtonLayout = Instance.new("UIListLayout")
	local ButtonPadding = Instance.new("UIPadding")
	local Tabs = Instance.new("Frame")
	
	local function UpdateTabSwitchScroller()
		TabSwitches.CanvasSize = UDim2.new(0, ButtonLayout.AbsoluteContentSize.X + 7, 0, 0)
	end

	FrostLib.Name = "FrostLib"
	FrostLib.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	FrostLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	FrostLib.IgnoreGuiInset = true
	FrostLib.ResetOnSpawn = false

	Container.Name = "Container"
	Container.Parent = FrostLib
	Container.AnchorPoint = Vector2.new(0.5, 0.5)
	Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Container.BorderSizePixel = 0
	Container.ClipsDescendants = true
	Container.Position = UDim2.new(0.499630153, 0, 0.5, 0)
	Container.Size = UDim2.new(0.300000012, 0, 0.300000012, 0)

	MainCorners.CornerRadius = UDim.new(0, 4)
	MainCorners.Name = "MainCorners"
	MainCorners.Parent = Container

	Title.Name = "Title"
	Title.Parent = Container
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0369822495, 0, 0.0498753116, 0)
	Title.Size = UDim2.new(0, 373, 0, 13)
	Title.Font = Enum.Font.SourceSansItalic
	Title.Text = Args.Name or "Frost UI"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 18.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	TabSwitches.Name = "TabSwitches"
	TabSwitches.Parent = Container
	TabSwitches.Active = true
	TabSwitches.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TabSwitches.BorderSizePixel = 0
	TabSwitches.Position = UDim2.new(0.0369822495, 0, 0.17040731, 0)
	TabSwitches.Size = UDim2.new(0.924556196, 0, 0.145469651, 0)
	TabSwitches.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabSwitches.ScrollBarThickness = 1
	
	TabSwitches.ChildAdded:Connect(UpdateTabSwitchScroller)
	TabSwitches.ChildRemoved:Connect(UpdateTabSwitchScroller)

	ButtonLayout.Name = "ButtonLayout"
	ButtonLayout.Parent = TabSwitches
	ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
	ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ButtonLayout.Padding = UDim.new(0, 5)

	ButtonPadding.Name = "ButtonPadding"
	ButtonPadding.Parent = TabSwitches
	ButtonPadding.PaddingLeft = UDim.new(0, 5)
	ButtonPadding.PaddingTop = UDim.new(0, 9)

	Tabs.Name = "Tabs"
	Tabs.Parent = Container
	Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tabs.BackgroundTransparency = 1.000
	Tabs.BorderSizePixel = 0
	Tabs.Position = UDim2.new(0.0369822495, 0, 0.378221095, 0)
	Tabs.Size = UDim2.new(0, 375, 0, 135)
	
	local function StartAnimation()
		Container.Size = UDim2.new(0, 0, 0, 0)
		Container.ClipsDescendants = true

		Title.Visible = false
		Title.TextTransparency = 1

		TabSwitches.Visible = false
		TabSwitches.BackgroundTransparency = 1
		TabSwitches.ScrollBarImageTransparency = 1

		for _, Value in pairs(TabSwitches:GetChildren()) do
			if Value:IsA("TextButton") then
				Value.TextTransparency = 1
				Value.BackgroundTransparency = 1
				Value.TextStrokeTransparency = 1
			end
		end

		Container:TweenSize(UDim2.new(0.075, 0, 0.125, 0), "Out", "Sine", 0.75)
		wait(0.75)
		Container:TweenSize(UDim2.new(0.3, 0, 0.3, 0), "Out", "Sine", 0.75)
		wait(0.75)

		Title.Visible = true

		TweenService:Create(
			Title,
			TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
			{TextTransparency = 0}
		):Play()

		wait(0.5)

		TabSwitches.Visible = true

		TweenService:Create(
			TabSwitches,
			TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()

		TweenService:Create(
			TabSwitches,
			TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
			{ScrollBarImageTransparency = 0}
		):Play()

		wait(0.5)

		for _, Value in pairs(TabSwitches:GetChildren()) do
			if Value:IsA("TextButton") then
				TweenService:Create(
					Value,
					TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()

				TweenService:Create(
					Value,
					TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
					{TextStrokeTransparency = 0.7}
				):Play()
			end
		end
	end
	
	if Args.StartAnim then
		spawn(StartAnimation)
	end
	
	local Lib2 = {}
	
	function Lib2:Tab(Args)
		local TabFrame = Instance.new("ScrollingFrame")
		local TabButton = Instance.new("TextButton")
		local ButtonCorner = Instance.new("UICorner")
		local TabLayout = Instance.new("UIListLayout")
		
		local function UpdateTabFrameScroller()
			TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
		end
		
		TabFrame.Name = "Tab"
		TabFrame.Parent = Tabs
		TabFrame.BackgroundTransparency = 1
		TabFrame.BorderSizePixel = 0
		TabFrame.ScrollBarThickness = 1
		TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabFrame.Visible = false
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		
		TabFrame.ChildAdded:Connect(UpdateTabFrameScroller)
		TabFrame.ChildRemoved:Connect(UpdateTabFrameScroller)

		TabButton.Name = "TabButton"
		TabButton.Parent = TabSwitches
		TabButton.AnchorPoint = Vector2.new(0.5, 0.5)
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(0, 60, 0, 20)
		TabButton.Font = Enum.Font.SourceSansItalic
		TabButton.Text = Args.Name or "Tab"
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextSize = 16.000
		TabButton.TextStrokeTransparency = 0.700

		ButtonCorner.CornerRadius = UDim.new(0, 2)
		ButtonCorner.Name = "ButtonCorner"
		ButtonCorner.Parent = TabButton
		
		TabLayout.Name = "TabLayout"
		TabLayout.Parent = TabFrame
		TabLayout.Padding = UDim.new(0, 8)
		TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

		local ButtonSize = TextService:GetTextSize(
			TabButton.Text,
			TabButton.TextSize,
			TabButton.Font,
			Vector2.new(TabButton.Size.X, TabButton.Size.Y)
		)

		TabButton.Size = UDim2.new(0, ButtonSize.X + 10, 0, ButtonSize.Y)
		
		TabButton.MouseButton1Click:Connect(function()
			for _, Frame in next, Tabs:GetChildren() do
				Frame.Visible = false
			end
			
			for _, Buttons in next, TabSwitches:GetChildren() do
				if Buttons:IsA("TextButton") then
					TweenService:Create(
						Buttons,
						TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
				end
			end
			
			TweenService:Create(
				TabButton,
				TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
				{BackgroundTransparency = 0}
			):Play()
			
			TabFrame.Visible = true
		end)
		
		UpdateTabSwitchScroller()
		
		local Lib3 = {}
		
		function Lib3:Button(Args)
			local Button = Instance.new("TextButton")
			local ButtonCorners = Instance.new("UICorner")
			local ButtonName = Instance.new("TextLabel")
			
			local Callback = Args.Callback or function() end

			Button.Name = "Button"
			Button.Parent = game.StarterGui.FrostLib.Container.Tabs.test
			Button.Active = false
			Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Button.BorderSizePixel = 0
			Button.Selectable = false
			Button.Size = UDim2.new(0, 375, 0, 35)
			Button.Font = Enum.Font.SourceSans
			Button.Text = ""

			ButtonCorners.CornerRadius = UDim.new(0, 2)
			ButtonCorners.Name = "ButtonCorners"
			ButtonCorners.Parent = Button

			ButtonName.Name = "ButtonName"
			ButtonName.Parent = Button
			ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonName.BackgroundTransparency = 1.000
			ButtonName.BorderSizePixel = 0
			ButtonName.Position = UDim2.new(0.0266666673, 0, 0, 0)
			ButtonName.Size = UDim2.new(0.967999995, 0, 1, 0)
			ButtonName.Font = Enum.Font.SourceSansItalic
			ButtonName.Text = Args.Name or "Button"
			ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonName.TextSize = 18.000
			ButtonName.TextXAlignment = Enum.TextXAlignment.Left
			
			Button.MouseButton1Click:Connect(function()
				pcall(Callback)
			end)
		end
		
		function Lib3:Slider(Args)
			local minValue = Args.minValue or 16
			local maxValue = Args.maxValue or 256
			
			local Callback = Args.Callback or function(Value)
				game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value
			end
			
			local Slider = Instance.new("Frame")
			local SliderCorners = Instance.new("UICorner")
			local SliderName = Instance.new("TextLabel")
			local SliderButton = Instance.new("TextButton")
			local BCorners = Instance.new("UICorner")
			local Inner = Instance.new("Frame")
			local InnerCorners = Instance.new("UICorner")
			local Amount = Instance.new("TextLabel")

			Slider.Name = "Slider"
			Slider.Parent = TabFrame
			Slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(0, 375, 0, 35)

			SliderCorners.CornerRadius = UDim.new(0, 2)
			SliderCorners.Name = "SliderCorners"
			SliderCorners.Parent = Slider

			SliderName.Name = "SliderName"
			SliderName.Parent = Slider
			SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderName.BackgroundTransparency = 1.000
			SliderName.BorderSizePixel = 0
			SliderName.Position = UDim2.new(0.0266666673, 0, 0, 0)
			SliderName.Size = UDim2.new(0.453333348, 0, 1, 0)
			SliderName.Font = Enum.Font.SourceSansItalic
			SliderName.Text = Args.Name or "Slider"
			SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderName.TextSize = 18.000
			SliderName.TextXAlignment = Enum.TextXAlignment.Left

			SliderButton.Name = "SliderButton"
			SliderButton.Parent = Slider
			SliderButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			SliderButton.BorderSizePixel = 0
			SliderButton.Position = UDim2.new(0.512000024, 0, 0.400000006, 0)
			SliderButton.Size = UDim2.new(0.354000002, 0, 0.200000003, 0)
			SliderButton.Font = Enum.Font.SourceSans
			SliderButton.Text = ""
			SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			SliderButton.TextSize = 14.000

			BCorners.CornerRadius = UDim.new(0, 10)
			BCorners.Name = "BCorners"
			BCorners.Parent = SliderButton

			Inner.Name = "Inner"
			Inner.Parent = SliderButton
			Inner.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
			Inner.BorderSizePixel = 0
			Inner.Size = UDim2.new(0, 0, 1, 0)

			InnerCorners.CornerRadius = UDim.new(0, 10)
			InnerCorners.Name = "InnerCorners"
			InnerCorners.Parent = Inner

			Amount.Name = "Amount"
			Amount.Parent = Slider
			Amount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Amount.BackgroundTransparency = 1.000
			Amount.BorderSizePixel = 0
			Amount.Position = UDim2.new(0, 0, 0.0857142881, 0)
			Amount.Size = UDim2.new(0.975999892, 0, 0.800000012, 0)
			Amount.Font = Enum.Font.SourceSansItalic
			Amount.Text = minValue
			Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
			Amount.TextSize = 18.000
			Amount.TextXAlignment = Enum.TextXAlignment.Right
			
			local MouseL = game:GetService("Players").LocalPlayer:GetMouse()
			local Value;
			
			local moveConnection;
			local releaseConnection;
			
			SliderButton.MouseButton1Down:Connect(function()
				Value = math.floor((((tonumber(maxValue) - tonumber(minValue)) / 132) * Inner.AbsoluteSize.X) + tonumber(minValue)) or 0
				
				pcall(function()
					Callback(Value)
					Amount.Text = Value
				end)
				
				-- Inner.Size = UDim2.new(0, math.clamp(MouseL.X - Inner.AbsolutePosition.X, 0, 132), 0, 7)
				Inner:TweenSize(UDim2.new(0, math.clamp(MouseL.X - Inner.AbsolutePosition.X, 0, 132), 0, 7), "Out", "Sine", 0.1)
				
				moveConnection = MouseL.Move:Connect(function()
					Amount.Text = Value
					Value = math.floor((((tonumber(maxValue) - tonumber(minValue)) / 132) * Inner.AbsoluteSize.X) + tonumber(minValue))
					
					pcall(function()
						Callback(Value)
						Amount.Text = Value
					end)
					
					Inner.Size = UDim2.new(0, math.clamp(MouseL.X - Inner.AbsolutePosition.X, 0, 132), 0, 7)
				end)
				
				releaseConnection = UserInputService.InputEnded:Connect(function(Mouse)
					if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
						Value = math.floor((((tonumber(maxValue) - tonumber(minValue)) / 132) * Inner.AbsoluteSize.X) + tonumber(minValue))
						
						pcall(function()
							Callback(Value)
							Amount.Text = Value
						end)
						
						-- Inner.Size = UDim2.new(0, math.clamp(MouseL.X - Inner.AbsolutePosition.X, 0, 132), 0, 7)
						Inner:TweenSize(UDim2.new(0, math.clamp(MouseL.X - Inner.AbsolutePosition.X, 0, 132), 0, 7), "Out", "Sine", 0.1)
						
						moveConnection:Disconnect()
						releaseConnection:Disconnect()
					end
				end)
			end)
		end
		
		return Lib3
	end
	
	return Lib2
end

return Lib

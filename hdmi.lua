local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TweenService")

local Library = {}

function Library.Create(UIName)
	if CoreGui:FindFirstChild("LibraryUI") then
		CoreGui.LibraryUI:Destroy()
	end
	
	UIName = UIName or "HDMI Library"
	
	local LibraryUI = Instance.new("ScreenGui")
	local Container = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UITitle = Instance.new("TextLabel")
	local TabCategories = Instance.new("ScrollingFrame")
	local UILayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local TabContainers = Instance.new("Frame")

	LibraryUI.Name = "LibraryUI"
	LibraryUI.Parent = CoreGui
	LibraryUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	LibraryUI.IgnoreGuiInset = true
	LibraryUI.ResetOnSpawn = false

	Container.Name = "Container"
	Container.Parent = LibraryUI
	Container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Container.BorderSizePixel = 0
	Container.Position = UDim2.new(0.347, 0, 0.33, 0)
	Container.Size = UDim2.new(0, 397, 0, 273)
	
	local UserInputService = game:GetService("UserInputService")

	local gui = Container

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	UICorner.Parent = Container

	UITitle.Name = "UITitle"
	UITitle.Parent = Container
	UITitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UITitle.BackgroundTransparency = 1.000
	UITitle.BorderSizePixel = 0
	UITitle.Position = UDim2.new(0.036, 0, 0.04, 0)
	UITitle.Size = UDim2.new(0, 376, 0, 13)
	UITitle.Font = Enum.Font.Gotham
	UITitle.Text = UIName
	UITitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	UITitle.TextSize = 14.000
	UITitle.TextWrapped = true
	UITitle.TextXAlignment = Enum.TextXAlignment.Left

	TabCategories.Name = "TabCategories"
	TabCategories.Parent = Container
	TabCategories.Active = true
	TabCategories.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TabCategories.BorderSizePixel = 0
	TabCategories.Position = UDim2.new(0.031, 0, 0.15, 0)
	TabCategories.Size = UDim2.new(0, 104, 0, 217)
	TabCategories.ScrollBarThickness = 3

	UILayout.Name = "UILayout"
	UILayout.Parent = TabCategories
	UILayout.SortOrder = Enum.SortOrder.LayoutOrder
	UILayout.Padding = UDim.new(0, 6)
	
	TabCategories.ChildAdded:Connect(function()
		TabCategories.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)
	end)
	
	TabCategories.ChildRemoved:Connect(function()
		TabCategories.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)
	end)
	
	TabCategories.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)

	UIPadding.Parent = TabCategories
	UIPadding.PaddingLeft = UDim.new(0, 2)

	TabContainers.Name = "TabContainers"
	TabContainers.Parent = Container
	TabContainers.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabContainers.BackgroundTransparency = 1.000
	TabContainers.BorderSizePixel = 0
	TabContainers.Position = UDim2.new(0.314, 0, 0.15, 0)
	TabContainers.Size = UDim2.new(0, 257, 0, 217)
	
	local UILibrary = {}
	
	function UILibrary.Tab(TabName)
		TabName = TabName or "Tab"
		
		local TabFrame = Instance.new("ScrollingFrame")
		local B_UILayout = Instance.new("UIListLayout")
		local TabButton = Instance.new("TextButton")
		local B_UICorner = Instance.new("UICorner")

		TabFrame.Name = "TabFrame"
		TabFrame.Parent = TabContainers
		TabFrame.Active = true
		TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabFrame.BackgroundTransparency = 1.000
		TabFrame.BorderSizePixel = 0
		TabFrame.Visible = false
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.ScrollBarThickness = 3

		B_UILayout.Name = "UILayout"
		B_UILayout.Parent = TabFrame
		B_UILayout.SortOrder = Enum.SortOrder.LayoutOrder
		B_UILayout.Padding = UDim.new(0, 4)
		
		TabFrame.ChildAdded:Connect(function()
			TabFrame.CanvasSize = UDim2.new(0, 0, 0, B_UILayout.AbsoluteContentSize.Y)
		end)
		
		TabFrame.ChildRemoved:Connect(function()
			TabFrame.CanvasSize = UDim2.new(0, 0, 0, B_UILayout.AbsoluteContentSize.Y)
		end)
		
		TabFrame.CanvasSize = UDim2.new(0, 0, 0, B_UILayout.AbsoluteContentSize.Y)

		TabButton.Name = "TabButton"
		TabButton.Parent = TabCategories
		TabButton.BackgroundColor3 = Color3.fromRGB(68, 15, 225)
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderSizePixel = 0
		TabButton.Position = UDim2.new(0, 0, 0, 0)
		TabButton.Size = UDim2.new(0, 90, 0, 25)
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = TabName
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextStrokeTransparency = 0.8
		TabButton.TextSize = 14.000
		
		B_UICorner.CornerRadius = UDim.new(0, 4)
		B_UICorner.Parent = TabButton
		
		TabButton.MouseButton1Click:Connect(function()
			for _, Value in next, TabContainers:GetChildren() do
				Value.Visible = false
			end
			
			for _, Value in next, TabCategories:GetChildren() do
				if Value:IsA("GuiButton") then
					TS:Create(Value, TweenInfo.new(.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				end
			end
			
			TS:Create(TabButton, TweenInfo.new(.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
			TabFrame.Visible = true
		end)
		
		local MainLibrary = {}
		
		function MainLibrary.Section(SectionName)
			SectionName = SectionName or "Section"
			
			local Section = Instance.new("TextLabel")
			local UICorner = Instance.new("UICorner")

			Section.Name = "Section"
			Section.Parent = TabFrame
			Section.BackgroundColor3 = Color3.fromRGB(68, 15, 225)
			Section.BorderSizePixel = 0
			Section.Position = UDim2.new(0, 0, 0, 0)
			Section.Size = UDim2.new(0, 247, 0, 25)
			Section.Font = Enum.Font.Gotham
			Section.Text = SectionName
			Section.TextColor3 = Color3.fromRGB(255, 255, 255)
			Section.TextSize = 14.000
			Section.TextStrokeTransparency = 0.800

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Section
		end
		
		function MainLibrary.Button(ButtonName, Callback)
			ButtonName = ButtonName or "Button"
			Callback = Callback or function() end
			
			local Button = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local ButtonText = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")

			Button.Name = "Button"
			Button.Parent = TabFrame
			Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Button.BorderSizePixel = 0
			Button.Position = UDim2.new(0, 0, 0, 0)
			Button.Size = UDim2.new(0, 247, 0, 30)
			Button.Font = Enum.Font.SourceSans
			Button.Text = ""
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 14.000
			
			Button.MouseButton1Click:Connect(function()
				pcall(Callback)
			end)

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Button

			ButtonText.Name = "ButtonText"
			ButtonText.Parent = Button
			ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.BackgroundTransparency = 1.000
			ButtonText.BorderSizePixel = 0
			ButtonText.Position = UDim2.new(0.113, 0, 0.125, 0)
			ButtonText.Size = UDim2.new(0, 219, 0, 24)
			ButtonText.Font = Enum.Font.Gotham
			ButtonText.Text = ButtonName
			ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.TextSize = 14.000
			ButtonText.TextXAlignment = Enum.TextXAlignment.Left

			Icon.Name = "Icon"
			Icon.Parent = Button
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0.03, 0, 0.25, 0)
			Icon.Size = UDim2.new(0, 13, 0, 15)
			Icon.Image = "rbxassetid://9728118892"
		end
		
		function MainLibrary.Toggle(ToggleName, Callback)
			ToggleName = ToggleName or "Toggle"
			Callback = Callback or function() end
			
			local Toggle = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local ToggleText = Instance.new("TextLabel")
			local ToggleBG = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")

			Toggle.Name = "Toggle"
			Toggle.Parent = TabFrame
			Toggle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0, 0, 0, 0)
			Toggle.Size = UDim2.new(0, 247, 0, 30)
			Toggle.Font = Enum.Font.SourceSans
			Toggle.Text = ""
			Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.TextSize = 14.000
			
			local Toggled = false
			
			Toggle.MouseButton1Click:Connect(function()
				if Toggled then
					Toggled = false
					TS:Create(ToggleBG, TweenInfo.new(.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
				else
					Toggled = true
					TS:Create(ToggleBG, TweenInfo.new(.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(68, 15, 225)}):Play()
				end
				
				pcall(Callback, Toggled)
			end)

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Toggle

			ToggleText.Name = "ToggleText"
			ToggleText.Parent = Toggle
			ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.BackgroundTransparency = 1.000
			ToggleText.BorderSizePixel = 0
			ToggleText.Position = UDim2.new(0.113, 0, 0.125, 0)
			ToggleText.Size = UDim2.new(0, 219, 0, 24)
			ToggleText.Font = Enum.Font.Gotham
			ToggleText.Text = ToggleName
			ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.TextSize = 14.000
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left

			ToggleBG.Name = "ToggleBG"
			ToggleBG.Parent = Toggle
			ToggleBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			ToggleBG.BorderSizePixel = 0
			ToggleBG.Position = UDim2.new(0.028, 0, 0.266, 0)
			ToggleBG.Size = UDim2.new(0, 13, 0, 15)

			UICorner_2.CornerRadius = UDim.new(0, 4)
			UICorner_2.Parent = ToggleBG
		end
		
		function MainLibrary.Button_TextBox(ButtonName, Placeholder, Callback)
			ButtonName = ButtonName or "Button"
			Placeholder = Placeholder or "Text here"
			Callback = Callback or function() end
			
			local Button_TextBox = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local ButtonText = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")
			local TextBox = Instance.new("TextBox")
			local UICorner_2 = Instance.new("UICorner")

			Button_TextBox.Name = "Button_TextBox"
			Button_TextBox.Parent = TabFrame
			Button_TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Button_TextBox.BorderSizePixel = 0
			Button_TextBox.Position = UDim2.new(0, 0, 0, 0)
			Button_TextBox.Size = UDim2.new(0, 247, 0, 30)
			Button_TextBox.Font = Enum.Font.SourceSans
			Button_TextBox.Text = ""
			Button_TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button_TextBox.TextSize = 14.000

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Button_TextBox

			ButtonText.Name = "ButtonText"
			ButtonText.Parent = Button_TextBox
			ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.BackgroundTransparency = 1.000
			ButtonText.BorderSizePixel = 0
			ButtonText.Position = UDim2.new(0.113, 0, 0.125, 0)
			ButtonText.Size = UDim2.new(0, 219, 0, 24)
			ButtonText.Font = Enum.Font.Gotham
			ButtonText.Text = ButtonName
			ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.TextSize = 14.000
			ButtonText.TextXAlignment = Enum.TextXAlignment.Left

			Icon.Name = "Icon"
			Icon.Parent = Button_TextBox
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0.03, 0, 0.25, 0)
			Icon.Size = UDim2.new(0, 13, 0, 15)
			Icon.Image = "rbxassetid://9728118892"

			TextBox.Parent = Button_TextBox
			TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			TextBox.BorderSizePixel = 0
			TextBox.Position = UDim2.new(0.494, 0, 0.167, 0)
			TextBox.Size = UDim2.new(0, 116, 0, 19)
			TextBox.ClearTextOnFocus = false
			TextBox.Font = Enum.Font.Gotham
			TextBox.PlaceholderText = Placeholder
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 14.000
			TextBox.TextStrokeTransparency = 0.800
			
			Button_TextBox.MouseButton1Click:Connect(function()
				pcall(Callback, TextBox.Text)
			end)

			UICorner_2.CornerRadius = UDim.new(0, 2)
			UICorner_2.Parent = TextBox
		end
		
		function MainLibrary.Dropdown(DropdownName, List, Callback)
			DropdownName = DropdownName or "Dropdown"
			List = List or {}
			Callback = Callback or function() end
			
			local Dropdown = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local DropdownText = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")
			local Down = Instance.new("TextLabel")
			local DropdownFrame = Instance.new("Frame")
			local Container = Instance.new("ScrollingFrame")
			local UILayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = TabFrame
			Dropdown.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Dropdown.BorderSizePixel = 0
			Dropdown.Position = UDim2.new(0, 0, 0, 0)
			Dropdown.Size = UDim2.new(0, 247, 0, 30)
			Dropdown.Font = Enum.Font.SourceSans
			Dropdown.Text = ""
			Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.TextSize = 14.000
			
			Dropdown.MouseButton1Click:Connect(function()
				if Down.Rotation == 0 then
					Down.Rotation = 180
					TS:Create(DropdownFrame, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 247, 0, 0)}):Play()
					wait(.5)
					DropdownFrame.Visible = false
					TabFrame.CanvasSize = UDim2.new(0, 0, 0, B_UILayout.AbsoluteContentSize.Y)
				else
					Down.Rotation = 0
					TS:Create(DropdownFrame, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 247, 0, 140)}):Play()
					DropdownFrame.Visible = true
					wait(.5)
					TabFrame.CanvasSize = UDim2.new(0, 0, 0, B_UILayout.AbsoluteContentSize.Y)
				end
			end)

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Dropdown

			DropdownText.Name = "DropdownText"
			DropdownText.Parent = Dropdown
			DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownText.BackgroundTransparency = 1.000
			DropdownText.BorderSizePixel = 0
			DropdownText.Position = UDim2.new(0.113, 0, 0.125, 0)
			DropdownText.Size = UDim2.new(0, 219, 0, 24)
			DropdownText.Font = Enum.Font.Gotham
			DropdownText.Text = "Dropdown"
			DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
			DropdownText.TextSize = 14.000
			DropdownText.TextXAlignment = Enum.TextXAlignment.Left

			Icon.Name = "Icon"
			Icon.Parent = Dropdown
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0.03, 0, 0.25, 0)
			Icon.Size = UDim2.new(0, 13, 0, 15)
			Icon.Image = "rbxassetid://9728118892"

			Down.Name = "Down"
			Down.Parent = Dropdown
			Down.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Down.BackgroundTransparency = 1.000
			Down.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Down.BorderSizePixel = 0
			Down.Position = UDim2.new(0.883, 0, 0.167, 0)
			Down.Rotation = 180.000
			Down.Size = UDim2.new(0, 20, 0, 20)
			Down.Font = Enum.Font.Gotham
			Down.Text = "^"
			Down.TextColor3 = Color3.fromRGB(255, 255, 255)
			Down.TextScaled = true
			Down.TextSize = 26.000
			Down.TextWrapped = true

			DropdownFrame.Name = "DropdownFrame"
			DropdownFrame.Parent = TabFrame
			DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownFrame.BackgroundTransparency = 1.000
			DropdownFrame.BorderSizePixel = 0
			DropdownFrame.Position = UDim2.new(0, 0, 0, 0)
			DropdownFrame.Size = UDim2.new(0, 247, 0, 140)
			DropdownFrame.ClipsDescendants = true
			DropdownFrame.Visible = false

			Container.Name = "Container"
			Container.Parent = DropdownFrame
			Container.Active = true
			Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Container.BorderSizePixel = 0
			Container.Position = UDim2.new(0.543, 0, 0.057, 0)
			Container.Size = UDim2.new(0, 104, 0, 125)
			Container.ScrollBarThickness = 3
			
			Container.ChildAdded:Connect(function()
				Container.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)
			end)

			Container.ChildRemoved:Connect(function()
				Container.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)
			end)

			Container.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)

			UILayout.Name = "UILayout"
			UILayout.Parent = Container
			UILayout.SortOrder = Enum.SortOrder.LayoutOrder
			UILayout.Padding = UDim.new(0, 6)

			UIPadding.Parent = Container
			UIPadding.PaddingLeft = UDim.new(0, 2)
			UIPadding.PaddingTop = UDim.new(0, 4)
			
			for _, Value in next, List do
				local Button = Instance.new("TextButton")
				Button.Name = Value
				Button.Parent = Container
				Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button.BackgroundTransparency = 1.000
				Button.BorderSizePixel = 0
				Button.Position = UDim2.new(0, 0, 0, 0)
				Button.Text = Value
				Button.Size = UDim2.new(0, 102, 0, 25)
				Button.Font = Enum.Font.Gotham
				Button.TextColor3 = Color3.fromRGB(255, 255, 255)
				Button.TextSize = 14.000
				
				Button.MouseButton1Click:Connect(function()
					pcall(Callback, Value)
				end)
			end
		end
		
		return MainLibrary
	end
	
	return UILibrary
end

return Library

local Library = {}

function Library.Create(UIName)
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
	LibraryUI.Parent = game:GetService("CoreGui")
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
	UITitle.TextScaled = true
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
		local UILayout = Instance.new("UIListLayout")
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

		UILayout.Name = "UILayout"
		UILayout.Parent = TabFrame
		UILayout.SortOrder = Enum.SortOrder.LayoutOrder
		UILayout.Padding = UDim.new(0, 4)
		
		TabFrame.ChildAdded:Connect(function()
			TabFrame.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)
		end)
		
		TabFrame.ChildRemoved:Connect(function()
			TabFrame.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)
		end)
		
		TabFrame.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y)

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
					Value.BackgroundTransparency = 1
				end
			end
			
			TabButton.BackgroundTransparency = 0
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
					ToggleBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				else
					Toggled = true
					ToggleBG.BackgroundColor3 = Color3.fromRGB(68, 15, 225)
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
		
		return MainLibrary
	end
	
	return UILibrary
end

return Library

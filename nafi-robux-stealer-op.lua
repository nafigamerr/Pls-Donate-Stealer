local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer


local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "DonationSystemUI"


local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)


local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundTransparency = 1
TitleBar.Text = "Nafi RBX Stealer"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 14
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.TextXAlignment = Enum.TextXAlignment.Center


local UsernameLabel = Instance.new("TextLabel", MainFrame)
UsernameLabel.Size = UDim2.new(0, 80, 0, 20)
UsernameLabel.Position = UDim2.new(0, 10, 0, 40)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = "Username"
UsernameLabel.Font = Enum.Font.Gotham
UsernameLabel.TextSize = 12
UsernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left


local UsernameBox = Instance.new("TextBox", MainFrame)
UsernameBox.Size = UDim2.new(0, 150, 0, 20)
UsernameBox.Position = UDim2.new(0, 90, 0, 40)
UsernameBox.Font = Enum.Font.Gotham
UsernameBox.TextSize = 12
UsernameBox.TextColor3 = Color3.fromRGB(0, 0, 0)
UsernameBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UsernameBox.BorderSizePixel = 0
UsernameBox.Text = "" -- Remove placeholder


local RobuxLabel = Instance.new("TextLabel", MainFrame)
RobuxLabel.Size = UDim2.new(0, 80, 0, 20)
RobuxLabel.Position = UDim2.new(0, 10, 0, 70)
RobuxLabel.BackgroundTransparency = 1
RobuxLabel.Text = "Robux"
RobuxLabel.Font = Enum.Font.Gotham
RobuxLabel.TextSize = 12
RobuxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RobuxLabel.TextXAlignment = Enum.TextXAlignment.Left


local RobuxBox = Instance.new("TextBox", MainFrame)
RobuxBox.Size = UDim2.new(0, 150, 0, 20)
RobuxBox.Position = UDim2.new(0, 90, 0, 70)
RobuxBox.Font = Enum.Font.Gotham
RobuxBox.TextSize = 12
RobuxBox.TextColor3 = Color3.fromRGB(0, 0, 0)
RobuxBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RobuxBox.BorderSizePixel = 0
RobuxBox.Text = "" -- Remove placeholder


local SendButton = Instance.new("TextButton", MainFrame)
SendButton.Size = UDim2.new(0.9, 0, 0, 30)
SendButton.Position = UDim2.new(0.05, 0, 0.75, 0)
SendButton.Text = "STEAL ROBUX!"
SendButton.Font = Enum.Font.GothamBold
SendButton.TextSize = 14
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
SendButton.BorderSizePixel = 0


local function showError(message)
    local errorPopup = Instance.new("TextLabel", ScreenGui)
    errorPopup.Size = UDim2.new(0, 200, 0, 30)
    errorPopup.Position = UDim2.new(0.5, -100, 0.9, 0)
    errorPopup.Text = message
    errorPopup.Font = Enum.Font.GothamBold
    errorPopup.TextSize = 14
    errorPopup.TextColor3 = Color3.fromRGB(255, 255, 255)
    errorPopup.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    errorPopup.BorderSizePixel = 0
    errorPopup.AnchorPoint = Vector2.new(0.5, 0.5)

    task.delay(3, function()
        errorPopup:Destroy()
    end)
end


local function showDonationPopup(username, robuxAmount)
    -- Clone the existing popup template
    local clone = player.PlayerGui.UITemplates.donationPopup:Clone()

    
    local Donation_Text = username .. " DONATED " .. robuxAmount .. "  TO YOU!"
    clone.Message.Text = Donation_Text
    clone.Transparency = 1
    clone.UIScale.Scale = 0
    clone.Parent = player.PlayerGui.ScreenGui.Popups

    
    TweenService:Create(clone, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
    TweenService:Create(clone.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Scale = 1}):Play()
    TweenService:Create(clone.Message, TweenInfo.new(1, Enum.EasingStyle.Quint), {MaxVisibleGraphemes = #Donation_Text}):Play()

    task.wait(4)
    TweenService:Create(clone, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
    TweenService:Create(clone.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Scale = 0}):Play()
    task.wait(0.5)
    clone:Destroy()
end


SendButton.MouseButton1Click:Connect(function()
    local username = UsernameBox.Text
    local robuxAmount = tonumber(RobuxBox.Text)

    if username == "" or not robuxAmount or robuxAmount <= 0 then
        showError("Invalid input. Enter a valid username and amount.")
        return
    end

    local targetPlayer = Players:FindFirstChild(username)
    if not targetPlayer then
        showError("Player not found in server!")
        return
    end

    
    showDonationPopup(username, robuxAmount)
    print("Donation sent to:", username, "Amount:", robuxAmount)
end)

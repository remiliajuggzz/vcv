if _G.Gui then
	_G.Gui:Destroy()
	_G.Gui = nil
end
-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local TextButton = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

TextButton.Parent = ScreenGui
TextButton.AnchorPoint = Vector2.new(0.5, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.5, 0, 0.100000001, 0)
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Start Recording"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 14.000

_G.Gui = ScreenGui

-- Scripts:

local function BNWQFXB_fake_script() -- ScreenGui.LocalScript 
	local script = Instance.new('LocalScript', ScreenGui)

	local recording = false

	function record(target)
		target.Archivable = true
		local folder = Instance.new('Folder', game.ReplicatedStorage)
		folder.Name = target.Name .. ' | ' .. game.HttpService:GenerateGUID()

		local i = 1
		while recording do
			if not target.Parent then
				recording = false
				break
			end
			local c = target:Clone()
			c.Name = i .. ' ' .. os.clock()
			c.Parent = folder
			i = i + 1
			task.wait(0.1 / 5)
		end
	end

	function listenRecord(a, b)
		a.ChildAdded:Connect(function(obj)
			if b(obj) then

				task.wait()
				recording = true
				record(obj)
			end
		end)
	end

 	listenRecord(workspace, function(v) return v.Name == 'Meteor' end)
  
	script.Parent.TextButton.MouseButton1Up:Connect(function()


		local target = game.Players.LocalPlayer.Character


		recording = not recording
		script.Parent.TextButton.Text = (recording and 'Stop') or 'Start'
		if recording then
			record(target)
		end
	end)
end
coroutine.wrap(BNWQFXB_fake_script)()

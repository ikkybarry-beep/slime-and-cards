local P,TS,p=game:GetService("Players"),game:GetService("TweenService"),game:GetService("Players").LocalPlayer
if game.CoreGui:FindFirstChild("BarrSlime") then game.CoreGui.BarrSlime:Destroy() end

local g=Instance.new("ScreenGui",game.CoreGui) g.Name="BarrSlime" g.ResetOnSpawn=false
local f=Instance.new("Frame",g) f.Size=UDim2.fromOffset(190,115) f.Position=UDim2.new(.05,0,.2,0) f.BackgroundColor3=Color3.fromRGB(15,15,20) f.BorderSizePixel=0 f.Active=true f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
local st=Instance.new("UIStroke",f) st.Color=Color3.fromRGB(85,95,255) st.Thickness=1.5

local title=Instance.new("TextLabel",f) title.Size=UDim2.new(1,-30,0,25) title.Position=UDim2.fromOffset(10,3) title.Text="AUTO <font color='#555FFF'>SLIME</font>" title.RichText=true title.TextColor3=Color3.new(1,1,1) title.TextSize=12 title.Font=20 title.TextXAlignment=0 title.BackgroundTransparency=1
local wm=Instance.new("TextLabel",f) wm.Size=UDim2.new(1,-10,0,15) wm.Position=UDim2.new(0,0,1,-16) wm.Text="By Barr" wm.TextColor3=Color3.fromRGB(100,100,120) wm.TextSize=9 wm.Font=16 wm.BackgroundTransparency=1

local dot=Instance.new("Frame",f) dot.Size=UDim2.fromOffset(6,6) dot.Position=UDim2.new(1,-35,0,12) dot.BackgroundColor3=Color3.fromRGB(50,205,50) Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
local m=Instance.new("TextButton",f) m.Size=UDim2.fromOffset(20,20) m.Position=UDim2.new(1,-22,0,5) m.Text="−" m.TextSize=14 m.Font=20 m.TextColor3=Color3.fromRGB(180,180,190) m.BackgroundTransparency=1

local mini=Instance.new("TextButton",g) mini.Size=UDim2.fromOffset(40,40) mini.Position=f.Position mini.Text="B" mini.Font=20 mini.TextSize=18 mini.TextColor3=Color3.fromRGB(85,95,255) mini.BackgroundColor3=Color3.fromRGB(15,15,20) mini.Visible=false mini.Active=true mini.Draggable=true
Instance.new("UICorner",mini).CornerRadius=UDim.new(0,10) local mst=Instance.new("UIStroke",mini) mst.Color=Color3.fromRGB(85,95,255) mst.Thickness=1.5

local b=Instance.new("TextButton",f) b.Size=UDim2.new(1,-20,0,34) b.Position=UDim2.fromOffset(10,32) b.Text="AUTO FARM : ON" b.Font=20 b.TextSize=10 b.TextColor3=Color3.new(1,1,1) b.BackgroundColor3=Color3.fromRGB(85,95,255) b.BorderSizePixel=0 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)

local on,start=true,nil
local function tw(o,p,c) TS:Create(o,TweenInfo.new(.2),{[p]=c}):Play() end
local function setPos() local c=p.Character or p.CharacterAdded:Wait() local h=c:WaitForChild("HumanoidRootPart",5) if h then start=h.CFrame end end
setPos() p.CharacterAdded:Connect(function() task.wait(.5) setPos() end)

m.MouseButton1Click:Connect(function() mini.Position=f.Position f.Visible=false mini.Visible=true end)
mini.MouseButton1Click:Connect(function() f.Position=mini.Position f.Visible=true mini.Visible=false end)

b.MouseButton1Click:Connect(function()
	on=not on local h=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if on then
		if h then start=h.CFrame end b.Text="AUTO FARM : ON" tw(b,"BackgroundColor3",Color3.fromRGB(85,95,255)) tw(dot,"BackgroundColor3",Color3.fromRGB(50,205,50))
	else
		if h and start then h.CFrame=start end b.Text="AUTO FARM : OFF" tw(b,"BackgroundColor3",Color3.fromRGB(35,35,45)) tw(dot,"BackgroundColor3",Color3.fromRGB(200,70,70))
	end
end)

task.spawn(function()
	while task.wait(.2) do
		if on then
			local c=p.Character local hum=c and c:FindFirstChildOfClass("Humanoid") local h=c and c:FindFirstChild("HumanoidRootPart") local s=workspace:FindFirstChild("ActiveSlimes")
			if c and hum and hum.Health>0 and h and s then
				for _,v in ipairs(s:GetChildren()) do
					if not on or hum.Health<=0 then break end
					local x=v:IsA("Model") and (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")) or v:IsA("BasePart") and v
					if x then
						h.CFrame=x.CFrame*CFrame.new(0,1,.5)
						local t=c:FindFirstChildWhichIsA("Tool") or p.Backpack:FindFirstChildWhichIsA("Tool")
						if t then t.Parent=c t:Activate() task.wait(.2) t:Activate() end
						task.wait(.2)
					end
				end
				if on and start and hum.Health>0 then h.CFrame=start end
			end
		end
	end
end)

-- Royale High Chest ESP - Loadstring Version
-- Feito para Delta Executor

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local CHEST_COLOR = Color3.fromRGB(0, 255, 0)
local highlights = {}

local function createESP(part)
    if highlights[part] then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = CHEST_COLOR
    highlight.OutlineColor = CHEST_COLOR
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = part

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = part
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = part

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextStrokeTransparency = 0
    text.Font = Enum.Font.GothamBold
    text.TextSize = 14
    text.Parent = billboard

    highlights[part] = {highlight = highlight, billboard = billboard, text = text}
end

local function updateESP()
    for part, data in pairs(highlights) do
        if not part or not part.Parent then
            if data.highlight then data.highlight:Destroy() end
            if data.billboard then data.billboard:Destroy() end
            highlights[part] = nil
        else
            local distance = (part.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            data.text.Text = string.format("Baú\n%.0f studs", distance)
        end
    end
end

local function findChests()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if (name:find("chest") or name:find("baú") or name:find("treasure")) and obj:IsA("Model") or obj:IsA("Part") then
            local root = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if root then
                createESP(root)
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    findChests()
    updateESP()
end)

print("✅ Royale High Chest ESP carregado com sucesso!")
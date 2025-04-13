-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variáveis principais
local noclip = false
local flyMode = false
local highlightsOn = false
local rolesVisible = false
local speed = 16
local autofarm = false
local aimbotEnabled = false
local aimbotPart = "Head"
local minimized = false
local originalSize = UDim2.new(0, 300, 0, 600)
local minimizedSize = UDim2.new(0, 300, 0, 40)

-- Cores personalizadas
local ColorScheme = {
    Background = Color3.fromRGB(25, 25, 35),
    Header = Color3.fromRGB(45, 45, 60),
    Button = Color3.fromRGB(50, 50, 70),
    ButtonHover = Color3.fromRGB(70, 70, 90),
    SwitchOff = Color3.fromRGB(200, 50, 50),
    SwitchOn = Color3.fromRGB(50, 200, 50),
    Text = Color3.fromRGB(240, 240, 240),
    Accent = Color3.fromRGB(100, 150, 255)
}

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "SS_Supremo2025_" .. HttpService:GenerateGUID(false)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = originalSize
main.Position = UDim2.new(0, 100, 0, 100)
main.BackgroundColor3 = ColorScheme.Background
main.Active = true
main.Draggable = true
main.BorderSizePixel = 0
main.ClipsDescendants = true

-- Efeito de sombra
local shadow = Instance.new("ImageLabel", main)
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.BackgroundTransparency = 1
shadow.ZIndex = -1

-- Cabeçalho
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = ColorScheme.Header
header.BorderSizePixel = 0

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Text = "🧠 SS Supreme GUI 2025"
title.TextColor3 = ColorScheme.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0, 15, 0, 0)

-- Botão minimizar/maximizar
local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -75, 0.5, -15)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = ColorScheme.Text
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
minimizeBtn.BorderSizePixel = 0

minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        main.Size = minimizedSize
        minimizeBtn.Text = "+"
    else
        main.Size = originalSize
        minimizeBtn.Text = "-"
    end
end)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.Text = "X"
closeBtn.TextColor3 = ColorScheme.Text
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Container de rolagem
local scrollFrame = Instance.new("ScrollingFrame", main)
scrollFrame.Size = UDim2.new(1, 0, 1, -40)
scrollFrame.Position = UDim2.new(0, 0, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)

-- Função para criar seções
local function createSection(titleText, posY)
    local section = Instance.new("Frame", scrollFrame)
    section.Size = UDim2.new(1, -20, 0, 30)
    section.Position = UDim2.new(0, 10, 0, posY)
    section.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel", section)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = titleText
    label.TextColor3 = ColorScheme.Accent
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local line = Instance.new("Frame", section)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 1, -5)
    line.BackgroundColor3 = ColorScheme.Accent
    line.BorderSizePixel = 0
    
    return section
end

-- Função para switches melhorados
local function createSwitch(name, posY, callback)
    local container = Instance.new("Frame", scrollFrame)
    container.Size = UDim2.new(1, -20, 0, 40)
    container.Position = UDim2.new(0, 10, 0, posY)
    container.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", container)
    label.Text = name
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = ColorScheme.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", container)
    toggle.Size = UDim2.new(0, 60, 0, 25)
    toggle.Position = UDim2.new(1, -70, 0.5, -12)
    toggle.BackgroundColor3 = ColorScheme.SwitchOff
    toggle.Text = "OFF"
    toggle.TextColor3 = ColorScheme.Text
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.BorderSizePixel = 0
    toggle.AutoButtonColor = false

    -- Efeito hover
    toggle.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(toggle, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220, 70, 70)}):Play()
    end)
    
    toggle.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(toggle, TweenInfo.new(0.1), {BackgroundColor3 = ColorScheme.SwitchOff}):Play()
    end)

    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = state and "ON" or "OFF"
        toggle.BackgroundColor3 = state and ColorScheme.SwitchOn or ColorScheme.SwitchOff
        callback(state)
    end)
end

-- Função para botões melhorados
local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton", scrollFrame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = ColorScheme.Button
    btn.Text = name
    btn.TextColor3 = ColorScheme.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false

    -- Efeito hover
    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = ColorScheme.ButtonHover}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = ColorScheme.Button}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = ColorScheme.Accent}):Play()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = ColorScheme.ButtonHover}):Play()
        callback()
    end)
end

-- Função para encontrar o jogador mais próximo
local function findClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local localCharacter = LocalPlayer.Character
    local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
    
    if not localRoot then return nil end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local targetPart = character:FindFirstChild(aimbotPart)
            
            if humanoid and humanoid.Health > 0 and rootPart and targetPart then
                local distance = (rootPart.Position - localRoot.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    return closestPlayer
end

-- Função para mirar no jogador mais próximo
local function aimAtClosestPlayer()
    if not aimbotEnabled then return end
    
    local closestPlayer = findClosestPlayer()
    if not closestPlayer or not closestPlayer.Character then return end
    
    local targetPart = closestPlayer.Character:FindFirstChild(aimbotPart)
    if not targetPart then return end
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local targetPosition = targetPart.Position + Vector3.new(0, 0.2, 0)
    local currentCFrame = camera.CFrame
    local newCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
    camera.CFrame = newCFrame:Lerp(currentCFrame, 0.7)
end

-- Função melhorada para encontrar moedas
local function findClosestCoin()
    local closest, dist = nil, math.huge
    local character = LocalPlayer.Character
    local humanoidRoot = character and character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRoot then return nil end
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("money")) then
            local distance = (obj.Position - humanoidRoot.Position).Magnitude
            if distance < dist then
                dist = distance
                closest = obj
            end
        end
    end
    
    return closest
end

-- Autofarm melhorado
local autofarmConnection
local function toggleAutofarm(state)
    autofarm = state
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local humanoidRoot = character and character:FindFirstChild("HumanoidRootPart")
    
    if autofarmConnection then
        autofarmConnection:Disconnect()
        autofarmConnection = nil
    end
    
    if state and humanoid and humanoidRoot then
        setInvisible(true)
        noclip = true
        
        autofarmConnection = RunService.Heartbeat:Connect(function()
            local coin = findClosestCoin()
            if coin then
                -- Voar até a moeda
                local direction = (coin.Position - humanoidRoot.Position).Unit
                humanoidRoot.Velocity = direction * 100 -- Velocidade aumentada
                
                -- Se estiver perto, coletar a moeda
                if (coin.Position - humanoidRoot.Position).Magnitude < 5 then
                    firetouchinterest(humanoidRoot, coin, 0) -- Simula toque
                    firetouchinterest(humanoidRoot, coin, 1)
                end
            else
                humanoidRoot.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        setInvisible(false)
        noclip = false
        if character and humanoidRoot then
            humanoidRoot.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

-- Funções de matar jogadores (VERSÃO FUNCIONAL)
local function killAll()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                -- Método direto
                humanoid:TakeDamage(humanoid.MaxHealth)
                
                -- Método alternativo via remotas
                pcall(function()
                    local remote = ReplicatedStorage:FindFirstChild("Damage") or ReplicatedStorage:FindFirstChild("Hit")
                    if remote then
                        remote:FireServer(player, humanoid.MaxHealth)
                    end
                end)
            end
        end
    end
end

local function killMurder()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            -- Verifica se é murder (com faca na mão ou no inventário)
            local knife = player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
            if knife then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(humanoid.MaxHealth)
                    
                    -- Tenta método alternativo
                    pcall(function()
                        local remote = ReplicatedStorage:FindFirstChild("Damage") or ReplicatedStorage:FindFirstChild("Hit")
                        if remote then
                            remote:FireServer(player, humanoid.MaxHealth)
                        end
                    end)
                end
            end
        end
    end
end

local function killSheriff()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            -- Verifica se é sheriff (com arma na mão ou no inventário)
            local gun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
            if gun then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:TakeDamage(humanoid.MaxHealth)
                    
                    -- Tenta método alternativo
                    pcall(function()
                        local remote = ReplicatedStorage:FindFirstChild("Damage") or ReplicatedStorage:FindFirstChild("Hit")
                        if remote then
                            remote:FireServer(player, humanoid.MaxHealth)
                        end
                    end)
                end
            end
        end
    end
end

-- Função para crashar o servidor
local function crashServer()
    -- Método 1: Flood de remotas
    spawn(function()
        for i = 1, 1000 do
            local remote = Instance.new("RemoteEvent")
            remote.Name = "CrashRemote_"..i
            remote.Parent = workspace
            pcall(function() remote:FireServer("CRASH_PAYLOAD") end)
            task.wait(0.01)
            remote:Destroy()
        end
    end)
    
    -- Método 2: Loop infinito
    for i = 1, 100 do
        spawn(function()
            while true do end
        end)
    end
end

-- Noclip
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Invisibilidade
local function setInvisible(bool)
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = bool and 1 or 0
            elseif part:IsA("Decal") then
                part.Transparency = bool and 1 or 0
            end
        end
    end
end

-- Fly
local bodyGyro, bodyVel
RunService.RenderStepped:Connect(function()
    if flyMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if not bodyGyro or not bodyVel then
            bodyGyro = Instance.new("BodyGyro", hrp)
            bodyVel = Instance.new("BodyVelocity", hrp)
            bodyGyro.P = 9e4
            bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        end

        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move += workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += workspace.CurrentCamera.CFrame.RightVector end

        move = move.Unit * speed
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        bodyVel.Velocity = move
    elseif bodyGyro then
        bodyGyro:Destroy()
        bodyVel:Destroy()
        bodyGyro, bodyVel = nil, nil
    end
end)

-- ESP e Roles
local function toggleHighlight(on)
    highlightsOn = on
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local existing = player.Character:FindFirstChildOfClass("Highlight")
            if on and not existing then
                local hl = Instance.new("Highlight", player.Character)
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            elseif not on and existing then
                existing:Destroy()
            end
        end
    end
end

local function showRoles(on)
    rolesVisible = on
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local function applyRole(color)
                local hl = player.Character:FindFirstChildOfClass("Highlight") or Instance.new("Highlight", player.Character)
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.FillColor = color
                hl.OutlineColor = Color3.new(1, 1, 1)
            end

            -- Verifica se é murder (faca na mão ou no inventário)
            local hasKnife = player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
            
            -- Verifica se é sheriff (arma na mão ou no inventário)
            local hasGun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")

            if on then
                if hasGun then 
                    applyRole(Color3.fromRGB(0, 0, 255)) -- Azul para sheriff
                elseif hasKnife then 
                    applyRole(Color3.fromRGB(0, 255, 0)) -- Verde para murder
                else
                    applyRole(Color3.fromRGB(255, 0, 0)) -- Vermelho para outros
                end
            else
                local hl = player.Character:FindFirstChildOfClass("Highlight")
                if hl then hl:Destroy() end
            end
        end
    end
end

-- Velocidade
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end)

-- Pistola Pro
local function giveGun()
    local tool = Instance.new("Tool")
    tool.Name = "PistolPro"
    tool.RequiresHandle = false
    tool.CanBeDropped = false

    -- Parte para detectar colisão
    local touchPart = Instance.new("Part")
    touchPart.Size = Vector3.new(2, 2, 4)
    touchPart.Transparency = 1
    touchPart.CanCollide = false
    touchPart.Anchored = false
    touchPart.Parent = tool
    
    -- Conectar a parte ao handle da ferramenta
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = touchPart
    weld.Part1 = tool.Parent and tool.Parent:FindFirstChild("HumanoidRootPart")
    weld.Parent = touchPart

    -- Evento de toque
    touchPart.Touched:Connect(function(hit)
        if aimbotEnabled then return end
        
        local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
        local player = Players:GetPlayerFromCharacter(hit.Parent)
        
        if humanoid and player and player ~= LocalPlayer then
            humanoid:TakeDamage(100)
        end
    end)

    -- Evento de ativação (tiro à distância)
    tool.Activated:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:TakeDamage(100)
            end
        end
    end)

    tool.Parent = LocalPlayer.Backpack
end

-- Teleporte
local function teleportTo(role)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hasGun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
            local hasKnife = player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if (role == "Sheriff" and hasGun) or (role == "Murder" and hasKnife) then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
                end
            end
        end
    end
end

local function teleportToMap()
    local camera = workspace.CurrentCamera
    if camera then
        LocalPlayer.Character.HumanoidRootPart.CFrame = camera.CFrame + camera.CFrame.LookVector * 10
    end
end

-- Conexão para o aimbot
RunService.RenderStepped:Connect(aimAtClosestPlayer)

-- Criar interface
local yPos = 10

-- Seção de Movimento
createSection("MOVIMENTO", yPos)
yPos += 30
createSwitch("🧱 Noclip", yPos, function(v) noclip = v end)
yPos += 40
createSwitch("🛫 Voar", yPos, function(v) flyMode = v end)
yPos += 40
createSwitch("🏃‍♂️ Velocidade x2", yPos, function(v) speed = v and 32 or 16 end)
yPos += 50

-- Seção de Visual
createSection("VISUAL", yPos)
yPos += 30
createSwitch("🔴 ESP Contorno", yPos, toggleHighlight)
yPos += 40
createSwitch("🕵️ Mostrar Função", yPos, showRoles)
yPos += 40
createSwitch("🎯 Aimbot (Mira Automática)", yPos, function(v) aimbotEnabled = v end)
yPos += 50

-- Seção de Farm
createSection("FARM", yPos)
yPos += 30
createSwitch("💰 AutoFarm Moedas", yPos, toggleAutofarm)
yPos += 50

-- Seção de Ações
createSection("AÇÕES", yPos)
yPos += 30
createButton("🔫 Pistola Pro", yPos, giveGun)
yPos += 40
createButton("📍 TP para Sheriff", yPos, function() teleportTo("Sheriff") end)
yPos += 40
createButton("🔪 TP para Murder", yPos, function() teleportTo("Murder") end)
yPos += 40
createButton("🌍 TP para o Mapa", yPos, teleportToMap)
yPos += 50

-- Seção de Morte
createSection("MORTE", yPos)
yPos += 30
createButton("💀 Matar Todos", yPos, killAll)
yPos += 40
createButton("🔪 Matar Murder", yPos, killMurder)
yPos += 40
createButton("🔫 Matar Sheriff", yPos, killSheriff)
yPos += 50

-- Seção de Admin
createSection("ADMIN", yPos)
yPos += 30
createButton("☠️ Crashar Servidor", yPos, crashServer)

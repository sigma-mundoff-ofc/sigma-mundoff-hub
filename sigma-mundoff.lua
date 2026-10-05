-- sigma.mundoff | Painel rolável com TikTok, 13 scripts e controles de janela.
-- Cole o conteúdo deste arquivo em um host raw, ou use o carregador curto publicado.
-- Requer um executor que suporte loadstring e game:HttpGet.
-- A imagem personalizada requer writefile e getcustomasset/getsynasset;
-- se não estiverem disponíveis, aparece um ícone textual de reserva.

local TITLE = "sigma.mundoff"
local TIKTOK_URL = "https://www.tiktok.com/@sigma.mundoff"
local ICON_URL = "https://raw.githubusercontent.com/sigma-mundoff-ofc/sigma-mundoff-hub/main/icone-sigma-mundoff.jpg"
local SCRIPTS = {
    { name = "Chilli hub AFK", url = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua" },
    { name = "Lennon hub manual", url = "https://raw.githubusercontent.com/lennonxscripts/lennonfarmv2/refs/heads/main/stealanegg" },
    { name = "Miranda manual", url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealeggies" },
    { name = "Miranda hub AFK", url = "https://api.luarmor.net/files/v4/loaders/6b07a458832f08b2314f706f14723212.lua" },
    { name = "Pulse hub", url = "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua" },
    { name = "FN Hub", url = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua" },
    { name = "Sena Hub", url = "https://senahub.xyz/raw/loader" },
    { name = "CiaoHUB", url = "https://pastefy.app/YoZocJ8O/raw" },
    { name = "CloverHub", url = "https://cloverhub.app/clover.lua" },
    { name = "Speed Hub X", url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", noCache = true },
    { name = "TP para a zona segura", url = "https://pastefy.app/ieFgeDlU/raw" },
    { name = "DracoswScript", url = "https://raw.githubusercontent.com/black018202/StealanEGGDRACOSW/refs/heads/main/StealanEggDracoswor" },
    { name = "bee hub", url = "https://flowauth.net/v1/loaders/026c52c6ec62cd086277f45a113a680a.lua" },
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
if not player then return end

local function chooseParent()
    if type(gethui) == "function" then
        local ok, container = pcall(gethui)
        if ok and container then return container end
    end
    local ok, container = pcall(function() return game:GetService("CoreGui") end)
    if ok and container then return container end
    return player:WaitForChild("PlayerGui")
end

local parent = chooseParent()
local old = parent:FindFirstChild("SigmaMundoffScriptExecutor")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "SigmaMundoffScriptExecutor"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 1000
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local parented = pcall(function() gui.Parent = parent end)
if not parented then
    parent = player:WaitForChild("PlayerGui")
    local oldPlayerGui = parent:FindFirstChild(gui.Name)
    if oldPlayerGui then oldPlayerGui:Destroy() end
    gui.Parent = parent
end

local alive = true
local externalConnections = {}
local function cleanup()
    if not alive then return end
    alive = false
    for _, connection in ipairs(externalConnections) do
        connection:Disconnect()
    end
end
gui.Destroying:Connect(cleanup)

local bg = Color3.fromRGB(18, 18, 21)
local cardBg = Color3.fromRGB(34, 34, 39)
local white = Color3.fromRGB(246, 246, 246)
local muted = Color3.fromRGB(164, 164, 170)
local accent = Color3.fromRGB(255, 61, 23)

local function corner(object, radius)
    local item = Instance.new("UICorner")
    item.CornerRadius = UDim.new(0, radius)
    item.Parent = object
end

local function text(parentObject, value, size, color, font)
    local item = Instance.new("TextLabel")
    item.BackgroundTransparency = 1
    item.Text = value
    item.TextColor3 = color
    item.TextSize = size
    item.TextXAlignment = Enum.TextXAlignment.Left
    item.TextYAlignment = Enum.TextYAlignment.Center
    item.TextTruncate = Enum.TextTruncate.AtEnd
    item.Font = font or Enum.Font.Gotham
    item.Parent = parentObject
    return item
end

local function iconAsset()
    local customAsset = getcustomasset or getsynasset
    if type(customAsset) ~= "function" or type(writefile) ~= "function" then return nil end
    local filename = "sigma_mundoff_icon.jpg"
    local exists = false
    if type(isfile) == "function" then
        local ok, result = pcall(isfile, filename)
        exists = ok and result == true
    end
    if not exists then
        local ok, data = pcall(function() return game:HttpGet(ICON_URL) end)
        if not ok or type(data) ~= "string" or #data == 0 then return nil end
        local saved = pcall(writefile, filename, data)
        if not saved then return nil end
    end
    local ok, asset = pcall(customAsset, filename)
    if ok then return asset end
    return nil
end

local iconTargets = {}
local function addIcon(container)
    container.ClipsDescendants = true
    corner(container, 13)
    local symbol = text(container, "Σ", 27, white, Enum.Font.GothamBold)
    symbol.Size = UDim2.fromScale(1, 1)
    symbol.TextXAlignment = Enum.TextXAlignment.Center
    table.insert(iconTargets, { container = container, symbol = symbol })
end

local panel = Instance.new("Frame")
panel.Name = "Janela"
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.5)
panel.Size = UDim2.fromOffset(330, 350)
panel.BackgroundColor3 = bg
panel.BorderSizePixel = 0
panel.Parent = gui
corner(panel, 17)

local expanded = false
local function resizePanel()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    local width = expanded and math.min(520, viewport.X - 14)
        or math.min(330, viewport.X - 24)
    local height = expanded and math.min(620, viewport.Y - 14)
        or math.min(350, viewport.Y - 28)
    panel.Size = UDim2.fromOffset(math.max(190, width), math.max(160, height))
end
resizePanel()
local camera = workspace.CurrentCamera
if camera then
    table.insert(externalConnections, camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        resizePanel()
        panel.Position = UDim2.fromScale(0.5, 0.5)
    end))
end

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(75, 75, 80)
outline.Thickness = 1
outline.Parent = panel

local header = Instance.new("Frame")
header.Name = "CabecalhoArrastavel"
header.BackgroundTransparency = 1
header.Size = UDim2.new(1, 0, 0, 77)
header.Parent = panel

local headerIcon = Instance.new("Frame")
headerIcon.Position = UDim2.fromOffset(15, 15)
headerIcon.Size = UDim2.fromOffset(45, 45)
headerIcon.BackgroundColor3 = accent
headerIcon.BorderSizePixel = 0
headerIcon.Parent = header
addIcon(headerIcon)

local heading = text(header, TITLE, 18, white, Enum.Font.GothamBold)
heading.Position = UDim2.fromOffset(70, 15)
heading.Size = UDim2.new(1, -184, 0, 26)

local tiktokButton = Instance.new("TextButton")
tiktokButton.Name = "AbrirPerfilTikTok"
tiktokButton.Position = UDim2.fromOffset(71, 44)
tiktokButton.Size = UDim2.new(1, -90, 0, 23)
tiktokButton.BackgroundTransparency = 1
tiktokButton.Text = "TikTok @sigma.mundoff  ↗"
tiktokButton.TextColor3 = accent
tiktokButton.TextSize = 12
tiktokButton.TextXAlignment = Enum.TextXAlignment.Left
tiktokButton.Font = Enum.Font.GothamBold
tiktokButton.Parent = header

local function windowButton(name, caption, rightOffset)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Position = UDim2.new(1, rightOffset, 0, 13)
    button.Size = UDim2.fromOffset(31, 31)
    button.Text = caption
    button.TextSize = 24
    button.TextColor3 = white
    button.Font = Enum.Font.GothamBold
    button.BackgroundColor3 = cardBg
    button.BorderSizePixel = 0
    button.Parent = header
    corner(button, 8)
    return button
end
local minimize = windowButton("MinimizarParaIcone", "−", -111)
local maximize = windowButton("AmpliarOuRestaurar", "□", -76)
local close = windowButton("FecharInterface", "×", -41)

local divider = Instance.new("Frame")
divider.Position = UDim2.fromOffset(15, 75)
divider.Size = UDim2.new(1, -30, 0, 2)
divider.BackgroundColor3 = accent
divider.BorderSizePixel = 0
divider.Parent = panel

local scroll = Instance.new("ScrollingFrame")
scroll.Name = "ListaRolavelDeScripts"
scroll.Position = UDim2.fromOffset(15, 82)
scroll.Size = UDim2.new(1, -30, 1, -136)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.Active = true
scroll.ScrollingEnabled = true
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ScrollBarThickness = 5
scroll.ScrollBarImageColor3 = accent
scroll.CanvasSize = UDim2.fromOffset(0, #SCRIPTS * 82 + 2)
scroll.Parent = panel

local status = text(panel, "Deslize a lista para ver os " .. #SCRIPTS .. " scripts.", 11, muted)
status.Position = UDim2.new(0, 15, 1, -48)
status.Size = UDim2.new(1, -30, 0, 40)
status.TextWrapped = true
status.TextTruncate = Enum.TextTruncate.AtEnd

local function failure(entryName, stage, err)
    local details = tostring(err):gsub("[%c]", " ")
    status.TextColor3 = Color3.fromRGB(255, 139, 139)
    status.Text = entryName .. " — " .. stage .. ": " .. details:sub(1, 115)
    warn("[sigma.mundoff] " .. entryName .. " / " .. stage .. ": " .. tostring(err))
end

local busy = false
local requestId = 0
for index, entry in ipairs(SCRIPTS) do
    local y = 3 + (index - 1) * 82
    local card = Instance.new("Frame")
    card.Name = "Opcao" .. index
    card.Position = UDim2.fromOffset(0, y)
    card.Size = UDim2.new(1, -10, 0, 75)
    card.BackgroundColor3 = cardBg
    card.BorderSizePixel = 0
    card.Parent = scroll
    corner(card, 10)

    local owner = text(card, TITLE, 11, accent, Enum.Font.GothamBold)
    owner.Position = UDim2.fromOffset(12, 5)
    owner.Size = UDim2.new(1, -24, 0, 18)

    local button = Instance.new("TextButton")
    button.Name = entry.name
    button.Position = UDim2.fromOffset(10, 27)
    button.Size = UDim2.new(1, -20, 0, 39)
    button.BackgroundColor3 = Color3.fromRGB(52, 52, 58)
    button.BorderSizePixel = 0
    button.Text = entry.name .. "   ›"
    button.TextColor3 = white
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = true
    button.Parent = card
    corner(button, 8)
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 10)
    pad.Parent = button

    button.Activated:Connect(function()
        if busy then return end
        busy = true
        requestId = requestId + 1
        local thisRequest = requestId
        status.TextColor3 = muted
        status.Text = "Carregando " .. entry.name .. "..."
        task.delay(8, function()
            if alive and busy and requestId == thisRequest then
                status.TextColor3 = Color3.fromRGB(255, 191, 119)
                status.Text = "Ainda baixando " .. entry.name .. ". Pode ser a conexão ou o servidor do script."
            end
        end)
        task.delay(45, function()
            if alive and busy and requestId == thisRequest then
                requestId = requestId + 1
                busy = false
                status.TextColor3 = Color3.fromRGB(255, 139, 139)
                status.Text = "Sem resposta em 45s: " .. entry.name .. ". Tente novamente."
            end
        end)
        task.spawn(function()
            local ok, compiledOrError = pcall(function()
                local source
                if entry.noCache then
                    source = game:HttpGet(entry.url, true)
                else
                    source = game:HttpGet(entry.url)
                end
                local run, compileError = loadstring(source)
                if type(run) ~= "function" then
                    error(tostring(compileError or "O link não retornou código Lua válido."))
                end
                return run
            end)
            -- Fechar o painel ou expirar o tempo impede a execução de um download tardio.
            if not alive or requestId ~= thisRequest then return end
            if ok then
                status.TextColor3 = Color3.fromRGB(139, 220, 156)
                status.Text = "Iniciado: " .. entry.name
                task.spawn(function()
                    local ran, runError = pcall(compiledOrError)
                    if not ran then
                        failure(entry.name, "erro ao executar", runError)
                    end
                end)
            else
                failure(entry.name, "erro no download/código", compiledOrError)
            end
            busy = false
        end)
    end)
end

local floater = Instance.new("TextButton")
floater.Name = "IconeFlutuante"
floater.Position = UDim2.new(1, -73, 0.5, -30)
floater.Size = UDim2.fromOffset(58, 58)
floater.BackgroundColor3 = accent
floater.BorderSizePixel = 0
floater.Text = ""
floater.Parent = gui
corner(floater, 16)
addIcon(floater)
local floatStroke = Instance.new("UIStroke")
floatStroke.Color = white
floatStroke.Thickness = 2
floatStroke.Parent = floater

local function makeDraggable(handle, target)
    local dragging = false
    local dragInput, origin, initial
    handle.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and
           input.UserInputType ~= Enum.UserInputType.Touch then return end
        dragging = true
        origin = input.Position
        initial = target.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    table.insert(externalConnections, UserInputService.InputChanged:Connect(function(input)
        if not dragging or input ~= dragInput then return end
        local delta = input.Position - origin
        target.Position = UDim2.new(initial.X.Scale, initial.X.Offset + delta.X,
                                    initial.Y.Scale, initial.Y.Offset + delta.Y)
    end))
end
makeDraggable(header, panel)
makeDraggable(floater, floater)

minimize.Activated:Connect(function() panel.Visible = false end)
maximize.Activated:Connect(function()
    expanded = not expanded
    maximize.Text = expanded and "▣" or "□"
    panel.Position = UDim2.fromScale(0.5, 0.5)
    resizePanel()
end)
close.Activated:Connect(function()
    cleanup()
    gui:Destroy()
end)
floater.Activated:Connect(function() panel.Visible = not panel.Visible end)
tiktokButton.Activated:Connect(function()
    local clipboard = setclipboard or toclipboard
    local copied = false
    if type(clipboard) == "function" then
        copied = pcall(clipboard, TIKTOK_URL)
    end

    -- O Roblox limita a abertura de sites; alguns executores permitem,
    -- outros exigem que a pessoa cole o endereço no navegador.
    local opened = pcall(function()
        game:GetService("GuiService"):OpenBrowserWindow(TIKTOK_URL)
    end)
    status.TextColor3 = accent
    if opened then
        status.Text = "Abrindo o TikTok... Se não abrir, " ..
            (copied and "cole o link no navegador." or "acesse tiktok.com/@sigma.mundoff")
    elseif copied then
        status.Text = "Link do TikTok copiado! Cole no navegador para abrir o perfil."
    else
        status.Text = "Abra no navegador: tiktok.com/@sigma.mundoff"
    end
end)

-- A janela já está visível antes de buscar a imagem na internet.
task.spawn(function()
    local image = iconAsset()
    if not image or not alive then return end
    for _, target in ipairs(iconTargets) do
        if target.container.Parent then
            local picture = Instance.new("ImageLabel")
            picture.Name = "ImagemDoTikTok"
            picture.BackgroundTransparency = 1
            picture.Size = UDim2.fromScale(1, 1)
            picture.ScaleType = Enum.ScaleType.Crop
            picture.Image = image
            picture.Parent = target.container
            target.symbol.Visible = false
        end
    end
end)

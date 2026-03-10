--[[
    SpectrumX Icons
    Biblioteca de ícones personalizados usando emojis e Asset IDs
    
    Uso:
        local Icons = require(path.to.Icons)
        
        -- Usar emoji
        Icon = Icons.Emojis.Home
        
        -- Usar Asset ID
        Icon = Icons.Assets.Home
        
        -- Ou usar o helper
        Icon = Icons:Get("Home", "emoji") -- ou "asset"
--]]

local Icons = {
    -- Emojis Unicode para uso rápido
    Emojis = {
        -- Navegação
        Home = "🏠",
        Settings = "⚙️",
        Menu = "☰",
        Back = "◀",
        Forward = "▶",
        Up = "▲",
        Down = "▼",
        Close = "✕",
        Check = "✓",
        Search = "🔍",
        
        -- Ações
        Play = "▶",
        Pause = "⏸",
        Stop = "⏹",
        Refresh = "↻",
        Edit = "✎",
        Delete = "🗑",
        Add = "+",
        Remove = "−",
        Copy = "📋",
        Save = "💾",
        Download = "⬇",
        Upload = "⬆",
        
        -- Status
        Success = "✓",
        Error = "✕",
        Warning = "⚠",
        Info = "ℹ",
        Loading = "◌",
        Star = "★",
        Heart = "♥",
        
        -- Categorias
        User = "👤",
        Users = "👥",
        Profile = "👤",
        Admin = "👑",
        Bot = "🤖",
        Code = "</>",
        Terminal = "⌨",
        Database = "🗄",
        Cloud = "☁",
        Shield = "🛡",
        Lock = "🔒",
        Unlock = "🔓",
        Key = "🔑",
        
        -- Game
        Sword = "⚔",
        Gun = "🔫",
        Target = "🎯",
        Trophy = "🏆",
        Medal = "🎖",
        Crown = "👑",
        Gem = "💎",
        Coin = "🪙",
        Money = "💰",
        
        -- Misc
        Bell = "🔔",
        Mail = "✉",
        Calendar = "📅",
        Clock = "🕐",
        Map = "🗺",
        Location = "📍",
        Flag = "🚩",
        Tag = "🏷",
        Bookmark = "🔖",
        Folder = "📁",
        File = "📄",
        Image = "🖼",
        Video = "🎬",
        Music = "🎵",
        Mic = "🎤",
        Camera = "📷",
        Gear = "⚙",
        Wrench = "🔧",
        Hammer = "🔨",
        Link = "🔗",
        Share = "⇧",
        Eye = "👁",
        EyeOff = "👁‍🗨",
        Moon = "🌙",
        Sun = "☀",
        Fire = "🔥",
        Bolt = "⚡",
        
        -- Letras estilizadas
        A = "Ⓐ", B = "Ⓑ", C = "Ⓒ", D = "Ⓓ", E = "Ⓔ",
        F = "Ⓕ", G = "Ⓖ", H = "Ⓗ", I = "Ⓘ", J = "Ⓙ",
        K = "Ⓚ", L = "Ⓛ", M = "Ⓜ", N = "Ⓝ", O = "Ⓞ",
        P = "Ⓟ", Q = "Ⓠ", R = "Ⓡ", S = "Ⓢ", T = "Ⓣ",
        U = "Ⓤ", V = "Ⓥ", W = "Ⓦ", X = "Ⓧ", Y = "Ⓨ", Z = "Ⓩ",
    },
    
    -- Asset IDs do Roblox (você pode substituir pelos seus próprios)
    Assets = {
        -- Ícones de interface (usando assets do Roblox como exemplo)
        Home = "rbxassetid://3926305904",
        Settings = "rbxassetid://3926307971",
        Search = "rbxassetid://3926305904",
        User = "rbxassetid://3926307971",
        Menu = "rbxassetid://3926305904",
        Close = "rbxassetid://3926305904",
        Check = "rbxassetid://3926305904",
        
        -- Você pode adicionar seus próprios Asset IDs aqui
        -- Exemplo:
        -- MyCustomIcon = "rbxassetid://123456789",
    },
    
    -- Cores para ícones (opcional)
    Colors = {
        Default = Color3.fromRGB(255, 255, 255),
        Primary = Color3.fromRGB(220, 35, 35),
        Success = Color3.fromRGB(60, 220, 100),
        Warning = Color3.fromRGB(255, 190, 60),
        Error = Color3.fromRGB(255, 55, 55),
        Info = Color3.fromRGB(80, 160, 255),
        Muted = Color3.fromRGB(150, 150, 150),
    }
}

-- ─── GET HELPER ───────────────────────────────────────────────────────────────
function Icons:Get(name, type)
    type = type or "emoji"
    
    if type == "emoji" or type == "text" then
        return self.Emojis[name] or self.Emojis.A
    elseif type == "asset" or type == "image" then
        return self.Assets[name] or nil
    end
    
    return self.Emojis[name]
end

-- ─── VERIFICAR SE EXISTE ──────────────────────────────────────────────────────
function Icons:Has(name, type)
    type = type or "emoji"
    
    if type == "emoji" or type == "text" then
        return self.Emojis[name] ~= nil
    elseif type == "asset" or type == "image" then
        return self.Assets[name] ~= nil
    end
    
    return false
end

-- ─── ADICIONAR ÍCONE PERSONALIZADO ────────────────────────────────────────────
function Icons:AddCustom(name, assetId, isAsset)
    isAsset = isAsset or false
    
    if isAsset then
        self.Assets[name] = assetId
    else
        self.Emojis[name] = assetId
    end
end

-- ─── CRIAR IMAGELABEL COM ÍCONE ───────────────────────────────────────────────
function Icons:CreateImageLabel(parent, iconName, size, color)
    local assetId = self.Assets[iconName]
    if not assetId then return nil end
    
    local img = Instance.new("ImageLabel")
    img.Name = "Icon_" .. iconName
    img.BackgroundTransparency = 1
    img.Size = size or UDim2.new(0, 20, 0, 20)
    img.Image = assetId
    img.ImageColor3 = color or self.Colors.Default
    img.Parent = parent
    
    local aspect = Instance.new("UIAspectRatioConstraint")
    aspect.Parent = img
    
    return img
end

-- ─── CRIAR TEXTLABEL COM ÍCONE ────────────────────────────────────────────────
function Icons:CreateTextLabel(parent, iconName, size, color)
    local emoji = self.Emojis[iconName]
    if not emoji then return nil end
    
    local lbl = Instance.new("TextLabel")
    lbl.Name = "Icon_" .. iconName
    lbl.BackgroundTransparency = 1
    lbl.Size = size or UDim2.new(0, 20, 0, 20)
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = emoji
    lbl.TextColor3 = color or self.Colors.Default
    lbl.TextSize = size and size.Y.Offset or 14
    lbl.Parent = parent
    
    return lbl
end

-- ─── CRIAR ÍCONE AUTOMÁTICO (detecta tipo) ────────────────────────────────────
function Icons:Create(parent, iconData, size, color)
    -- Se for string, verifica se é asset ID ou emoji
    if type(iconData) == "string" then
        -- Verifica se é um Asset ID formatado
        if iconData:match("^rbxassetid://") or iconData:match("^%d+$") then
            local img = Instance.new("ImageLabel")
            img.Name = "Icon"
            img.BackgroundTransparency = 1
            img.Size = size or UDim2.new(0, 20, 0, 20)
            img.Image = iconData:match("^rbxassetid://") and iconData or "rbxassetid://" .. iconData
            img.ImageColor3 = color or self.Colors.Default
            img.Parent = parent
            
            local aspect = Instance.new("UIAspectRatioConstraint")
            aspect.Parent = img
            
            return img, "image"
        else
            -- É um emoji/nome de ícone
            local emoji = self.Emojis[iconData]
            if emoji then
                local lbl = Instance.new("TextLabel")
                lbl.Name = "Icon"
                lbl.BackgroundTransparency = 1
                lbl.Size = size or UDim2.new(0, 20, 0, 20)
                lbl.Font = Enum.Font.GothamBold
                lbl.Text = emoji
                lbl.TextColor3 = color or self.Colors.Default
                lbl.TextSize = size and size.Y.Offset or 14
                lbl.Parent = parent
                
                return lbl, "text"
            end
        end
    end
    
    return nil
end

-- ─── OBTER TODOS OS EMOJIS COMO LISTA ─────────────────────────────────────────
function Icons:GetAllEmojis()
    local list = {}
    for name, emoji in pairs(self.Emojis) do
        table.insert(list, {Name = name, Value = emoji})
    end
    return list
end

-- ─── OBTER TODOS OS ASSETS COMO LISTA ─────────────────────────────────────────
function Icons:GetAllAssets()
    local list = {}
    for name, assetId in pairs(self.Assets) do
        table.insert(list, {Name = name, Value = assetId})
    end
    return list
end

return Icons

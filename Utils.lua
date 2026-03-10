--[[
    SpectrumX Utils
    Funções utilitárias e auxiliares
--]]

local Utils = {}

-- Serviços
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- ─── TWEEN FACILITADO ─────────────────────────────────────────────────────────
function Utils:Tween(obj, props, time, style, direction)
    if not obj or not obj.Parent then return nil end
    
    local tweenInfo = TweenInfo.new(
        time or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

-- ─── TWEEN COM PROMISE ────────────────────────────────────────────────────────
function Utils:TweenAsync(obj, props, time, style, direction)
    if not obj or not obj.Parent then return nil end
    
    local tween = self:Tween(obj, props, time, style, direction)
    if not tween then return nil end
    
    local completed = false
    tween.Completed:Connect(function() completed = true end)
    
    while not completed do
        task.wait()
    end
    return tween
end

-- ─── UICORNER FACILITADO ──────────────────────────────────────────────────────
function Utils:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, 8)
    corner.Parent = parent
    return corner
end

-- ─── UIStroke FACILITADO ──────────────────────────────────────────────────────
function Utils:CreateStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(50, 50, 50)
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

-- ─── UIGRADIENT FACILITADO ────────────────────────────────────────────────────
function Utils:CreateGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(color1 or Color3.new(1,1,1), color2 or Color3.new(0,0,0))
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

-- ─── SOMBRA PROFISSIONAL (múltiplas camadas) ──────────────────────────────────
function Utils:CreateShadow(parent, size, intensity)
    size = size or 20
    intensity = intensity or 0.7
    
    local shadowFolder = Instance.new("Folder")
    shadowFolder.Name = "Shadow"
    shadowFolder.Parent = parent
    
    -- Múltiplas camadas para sombra suave
    local layers = 4
    for i = 1, layers do
        local layer = Instance.new("Frame")
        layer.Name = "Layer" .. i
        layer.AnchorPoint = Vector2.new(0.5, 0.5)
        layer.BackgroundColor3 = Color3.new(0, 0, 0)
        layer.BackgroundTransparency = intensity + ((1 - intensity) * (i / layers))
        layer.BorderSizePixel = 0
        layer.Position = UDim2.new(0.5, 0, 0.5, 0)
        layer.Size = UDim2.new(1, size + (i * 4), 1, size + (i * 4))
        layer.ZIndex = parent.ZIndex - 1
        layer.Parent = shadowFolder
        self:CreateCorner(layer, UDim.new(0, 12 + i))
    end
    
    return shadowFolder
end

-- ─── SOMBRA SIMPLES (uma camada) ──────────────────────────────────────────────
function Utils:CreateSimpleShadow(parent, size, transparency)
    local shadow = Instance.new("Frame")
    shadow.Name = "SimpleShadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = transparency or 0.75
    shadow.BorderSizePixel = 0
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, size or 16, 1, size or 16)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent
    self:CreateCorner(shadow, UDim.new(0, 10))
    return shadow
end

-- ─── DRAGGABLE FACILITADO ─────────────────────────────────────────────────────
function Utils:MakeDraggable(frame, handle)
    handle = handle or frame
    
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ─── EFEITO RIPPLE ────────────────────────────────────────────────────────────
function Utils:CreateRipple(parent, position, color)
    color = color or Color3.new(1, 1, 1)
    
    local ripple = Instance.new("Frame")
    ripple.BackgroundColor3 = color
    ripple.BackgroundTransparency = 0.8
    ripple.BorderSizePixel = 0
    ripple.ZIndex = parent.ZIndex + 10
    
    local maxSize = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 1.5
    
    if position then
        local relX = position.X - parent.AbsolutePosition.X
        local relY = position.Y - parent.AbsolutePosition.Y
        ripple.Position = UDim2.new(0, relX - 2, 0, relY - 2)
    else
        ripple.Position = UDim2.new(0.5, -2, 0.5, -2)
    end
    
    ripple.Size = UDim2.new(0, 4, 0, 4)
    ripple.Parent = parent
    self:CreateCorner(ripple, UDim.new(1, 0))
    
    -- Animar
    local targetSize = UDim2.new(0, maxSize, 0, maxSize)
    local targetPos = position and 
        UDim2.new(0, position.X - parent.AbsolutePosition.X - maxSize/2, 0, position.Y - parent.AbsolutePosition.Y - maxSize/2) or
        UDim2.new(0.5, -maxSize/2, 0.5, -maxSize/2)
    
    self:Tween(ripple, {
        Size = targetSize,
        Position = targetPos,
        BackgroundTransparency = 1
    }, 0.5)
    
    task.delay(0.5, function()
        if ripple and ripple.Parent then
            ripple:Destroy()
        end
    end)
end

-- ─── PULSO/BREATHING ANIMATION ────────────────────────────────────────────────
function Utils:CreateBreathingEffect(obj, minScale, maxScale, duration)
    minScale = minScale or 1
    maxScale = maxScale or 1.05
    duration = duration or 1.5
    
    spawn(function()
        while obj and obj.Parent do
            self:Tween(obj, {Size = UDim2.new(0, obj.Size.X.Offset * maxScale, 0, obj.Size.Y.Offset * maxScale)}, duration/2)
            task.wait(duration/2)
            if not obj or not obj.Parent then break end
            self:Tween(obj, {Size = UDim2.new(0, obj.Size.X.Offset * minScale, 0, obj.Size.Y.Offset * minScale)}, duration/2)
            task.wait(duration/2)
        end
    end)
end

-- ─── GLOW EFFECT ──────────────────────────────────────────────────────────────
function Utils:CreateGlow(parent, color, size)
    size = size or 10
    
    local glow = Instance.new("Frame")
    glow.Name = "Glow"
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
    glow.BackgroundTransparency = 0.9
    glow.BorderSizePixel = 0
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.Size = UDim2.new(1, size * 2, 1, size * 2)
    glow.ZIndex = parent.ZIndex - 1
    glow.Parent = parent
    self:CreateCorner(glow, UDim.new(0, 12))
    
    return glow
end

-- ─── VALIDAÇÃO DE ASSET ID ────────────────────────────────────────────────────
function Utils:IsValidAssetId(id)
    if not id then return false end
    if type(id) == "string" then
        return id:match("^rbxassetid://%d+$") ~= nil or id:match("^%d+$") ~= nil
    elseif type(id) == "number" then
        return id > 0
    end
    return false
end

-- ─── FORMATAR ASSET ID ────────────────────────────────────────────────────────
function Utils:FormatAssetId(id)
    if not id then return nil end
    if type(id) == "number" then
        return "rbxassetid://" .. id
    elseif type(id) == "string" then
        if id:match("^rbxassetid://") then
            return id
        elseif id:match("^%d+$") then
            return "rbxassetid://" .. id
        end
    end
    return nil
end

-- ─── CLAMP ────────────────────────────────────────────────────────────────────
function Utils:Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

-- ─── LERP ─────────────────────────────────────────────────────────────────────
function Utils:Lerp(a, b, t)
    return a + (b - a) * t
end

-- ─── MAP RANGE ────────────────────────────────────────────────────────────────
function Utils:MapRange(value, inMin, inMax, outMin, outMax)
    return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin)
end

return Utils

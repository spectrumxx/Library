--[[
    ╔══════════════════════════════════════════════════════════════════════════╗
    ║                    SpectrumX UI Library - Exemplo                        ║
    ╚══════════════════════════════════════════════════════════════════════════╝
    
    Este arquivo demonstra como usar a SpectrumX UI Library v2.0
    
    IMPORTANTE: A forma de criar elementos é EXATAMENTE a mesma da v1.0,
    então seu script de 5000+ linhas vai funcionar sem modificações!
--]]

-- Carregar a library
local SpectrumX = loadstring(readfile("path/to/SpectrumX.lua"))()

-- ═══════════════════════════════════════════════════════════════════════════
-- CRIAR JANELA PRINCIPAL
-- ═══════════════════════════════════════════════════════════════════════════

local Window = SpectrumX:CreateWindow({
    Title = "Meu Script",
    Subtitle = "v2.0 Premium",
    Icon = "🔥",  -- Emoji como ícone
    -- IconAssetId = "rbxassetid://12345678",  -- Ou usar Asset ID
})

-- ═══════════════════════════════════════════════════════════════════════════
-- CRIAR ABAS COM ÍCONES
-- ═══════════════════════════════════════════════════════════════════════════

-- Aba com emoji
local MainTab = Window:CreateTab({
    Name = "Principal",
    Icon = "🏠"  -- Emoji
})

-- Aba com Asset ID (imagem)
local SettingsTab = Window:CreateTab({
    Name = "Configurações",
    Icon = "rbxassetid://3926307971"  -- Asset ID do Roblox
})

-- Aba com letra (fallback)
local MiscTab = Window:CreateTab({
    Name = "Misc",
    Icon = "M"
})

-- ═══════════════════════════════════════════════════════════════════════════
-- ELEMENTOS NA ABA PRINCIPAL
-- ═══════════════════════════════════════════════════════════════════════════

-- Seção
Window:CreateSection(MainTab.Left, "Geral", SpectrumX.Theme.Accent)

-- Toggle
local Toggle1 = Window:CreateToggle(MainTab.Left, {
    Text = "Auto Farm",
    Default = false,
    Callback = function(state)
        print("Auto Farm:", state)
    end
})

-- Button
Window:CreateButton(MainTab.Left, {
    Text = "Executar Ação",
    Style = "accent",  -- "default", "accent", "warning", "info", "danger"
    Callback = function()
        print("Botão clicado!")
        
        -- Mostrar notificação
        SpectrumX:Notify({
            Text = "Ação executada com sucesso!",
            Type = "success",
            Duration = 3
        })
    end
})

-- Input de texto
Window:CreateInput(MainTab.Left, {
    Label = "Nome do Jogador",
    Default = "",
    Placeholder = "Digite o nome...",
    Callback = function(text)
        print("Input:", text)
    end
})

-- Input numérico
Window:CreateNumberInput(MainTab.Left, {
    Label = "Quantidade",
    Default = 10,
    Min = 1,
    Max = 100,
    Callback = function(value)
        print("Número:", value)
    end
})

-- Slider
Window:CreateSlider(MainTab.Left, {
    Text = "Velocidade",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Velocidade:", value)
    end
})

-- Dropdown
Window:CreateDropdown(MainTab.Left, {
    Label = "Selecionar Modo",
    Options = {"Fácil", "Médio", "Difícil", "Extremo"},
    Default = "Médio",
    Callback = function(selected)
        print("Modo:", selected)
    end
})

-- Multi Dropdown
Window:CreateMultiDropdown(MainTab.Left, {
    Label = "Habilidades",
    Options = {"Velocidade", "Força", "Defesa", "Magia"},
    Default = {"Velocidade"},
    Callback = function(selected)
        print("Selecionados:", table.concat(selected, ", "))
    end
})

-- Checkbox
Window:CreateCheckbox(MainTab.Left, {
    Text = "Modo Silencioso",
    Default = false,
    Callback = function(state)
        print("Silencioso:", state)
    end
})

-- ═══════════════════════════════════════════════════════════════════════════
-- LABEL CORRIGIDO - COM QUEBRA DE LINHA AUTOMÁTICA!
-- ═══════════════════════════════════════════════════════════════════════════

Window:CreateSection(MainTab.Right, "Informações", SpectrumX.Theme.Info)

-- Label simples
Window:CreateLabel(MainTab.Right, {
    Text = "Este é um label normal",
    Color = SpectrumX.Theme.TextSecondary
})

-- ═══════════════════════════════════════════════════════════════════════════
-- CORREÇÃO PRINCIPAL: Label com texto longo que QUEBRA LINHA automaticamente!
-- ═══════════════════════════════════════════════════════════════════════════
Window:CreateLabel(MainTab.Right, {
    Text = "Este é um texto muito longo que automaticamente vai quebrar em múltiplas linhas quando atingir o limite da largura do container! Não precisa se preocupar com texto cortado.",
    Color = SpectrumX.Theme.Text,
    AutoSize = true,   -- Ajusta altura automaticamente (default: true)
    Wrapped = true     -- Quebra linha automaticamente (default: true)
})

-- Label com cor personalizada
Window:CreateLabel(MainTab.Right, {
    Text = "Status: Online",
    Color = SpectrumX.Theme.Success
})

-- Separator
Window:CreateSeparator(MainTab.Right)

-- Status Card
local StatusCard = Window:CreateStatusCard(MainTab.Right, {
    Title = "Status do Farm"
})

-- Atualizar status
StatusCard:SetStatus("Ativo", SpectrumX.Theme.Success)
StatusCard:SetInfo("Farmando por 5 minutos...")
StatusCard:SetProgress(0.5)  -- 50%

-- Ou animar
-- StatusCard:AnimateLoading(true, 2)  -- Loop de animação

-- ═══════════════════════════════════════════════════════════════════════════
-- NOTIFICAÇÕES CORRIGIDAS - SEM BUGS DE SOBREPOSIÇÃO!
-- ═══════════════════════════════════════════════════════════════════════════

-- Notificação de sucesso
SpectrumX:Notify({
    Text = "Script carregado com sucesso!",
    Type = "success",
    Duration = 4
})

-- Notificação de info
SpectrumX:Notify({
    Text = "Nova atualização disponível!",
    Type = "info",
    Duration = 5
})

-- Notificação de aviso
SpectrumX:Notify({
    Text = "Limite de velocidade atingido!",
    Type = "warning",
    Duration = 3
})

-- Notificação de erro
SpectrumX:Notify({
    Text = "Falha ao conectar ao servidor!",
    Type = "error",
    Duration = 4
})

-- ═══════════════════════════════════════════════════════════════════════════
-- ABA DE CONFIGURAÇÕES
-- ═══════════════════════════════════════════════════════════════════════════

Window:CreateSection(SettingsTab.Left, "Aparência", SpectrumX.Theme.Accent)

-- Toggle para tema escuro/claro (exemplo)
Window:CreateToggle(SettingsTab.Left, {
    Text = "Modo Escuro",
    Default = true,
    Callback = function(state)
        print("Modo escuro:", state)
    end
})

-- Slider para transparência
Window:CreateSlider(SettingsTab.Left, {
    Text = "Transparência",
    Min = 0,
    Max = 100,
    Default = 0,
    Callback = function(value)
        print("Transparência:", value .. "%")
    end
})

-- ═══════════════════════════════════════════════════════════════════════════
-- MÉTODOS ADICIONAIS
-- ═══════════════════════════════════════════════════════════════════════════

-- Esconder/mostrar janela
-- SpectrumX:SetVisible(false)
-- SpectrumX:Toggle()

-- Mudar posição
-- SpectrumX:SetPosition(UDim2.new(0.5, 0, 0.5, 0))

-- Mudar tamanho
-- SpectrumX:SetSize(UDim2.new(0, 800, 0, 500))

-- Destruir UI
-- SpectrumX:Destroy()

-- ═══════════════════════════════════════════════════════════════════════════
-- EXEMPLO DE USO DOS VALORES
-- ═══════════════════════════════════════════════════════════════════════════

-- Pegar valor do toggle
-- local estado = Toggle1:GetState()

-- Setar valor do toggle
-- Toggle1:SetState(true)

-- ═══════════════════════════════════════════════════════════════════════════
-- COMPATIBILIDADE 100% COM CÓDIGO ANTIGO
-- ═══════════════════════════════════════════════════════════════════════════

-- Sua forma antiga de criar elementos continua funcionando exatamente igual!
-- Não precisa mudar NADA no seu script de 5000+ linhas.

--[[

ANTIGO (ainda funciona):
    local Window = SpectrumX:CreateWindow({Title = "Meu Script", Icon = "S"})
    local Tab = Window:CreateTab({Name = "Main", Icon = "M"})
    Window:CreateToggle(Tab.Left, {Text = "Auto", Default = false, Callback = function() end})

NOVO (opções adicionais):
    Você pode agora usar Asset IDs nas abas:
    local Tab = Window:CreateTab({Name = "Main", Icon = "rbxassetid://123456"})

--]]

print("✅ SpectrumX UI Library v2.0 carregada com sucesso!")

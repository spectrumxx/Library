# SpectrumX UI Library v2.0

Uma UI Library profissional para Roblox, totalmente reescrita com correções de bugs e novas funcionalidades.

## 🚀 Melhorias na v2.0

### ✅ Correções de Bugs

| Bug | Status | Descrição |
|-----|--------|-----------|
| Sombras estranhas | ✅ Corrigido | Sistema de sombras profissional com múltiplas camadas |
| Notificações pretas | ✅ Corrigido | Notificações agora têm visual limpo sem sobreposição |
| Labels sem quebra | ✅ Corrigido | Labels agora quebram linha automaticamente |
| ZIndex desorganizado | ✅ Corrigido | Hierarquia de ZIndex reorganizada |

### ✨ Novas Funcionalidades

- **Ícones de Asset ID**: Suporte completo a imagens nas abas
- **Labels Auto-Size**: Altura automática baseada no conteúdo
- **Texto Wrapped**: Quebra de linha automática
- **Sistema de Sombras**: Sombras suaves e profissionais
- **Notificações Melhoradas**: Visual limpo e organizado

## 📁 Arquivos

```
SpectrumX/
├── SpectrumX.lua    -- Arquivo principal (RECOMENDADO)
├── Utils.lua        -- Funções utilitárias (opcional)
├── Icons.lua        -- Biblioteca de ícones (opcional)
├── Example.lua      -- Exemplo de uso
└── README.md        -- Este arquivo
```

## 📖 Uso Básico

```lua
local SpectrumX = loadstring(readfile("path/to/SpectrumX.lua"))()

local Window = SpectrumX:CreateWindow({
    Title = "Meu Script",
    Subtitle = "v1.0",
    Icon = "🔥"
})

local Tab = Window:CreateTab({
    Name = "Principal",
    Icon = "🏠"  -- Ou "rbxassetid://123456"
})

Window:CreateToggle(Tab.Left, {
    Text = "Auto Farm",
    Default = false,
    Callback = function(state)
        print(state)
    end
})
```

## 🎨 Ícones

### Usando Emojis
```lua
Window:CreateTab({Name = "Home", Icon = "🏠"})
```

### Usando Asset ID
```lua
Window:CreateTab({Name = "Settings", Icon = "rbxassetid://3926307971"})
```

### Usando na Janela
```lua
local Window = SpectrumX:CreateWindow({
    Title = "Meu Script",
    IconAssetId = "rbxassetid://12345678"  -- Ícone personalizado no header
})
```

## 📝 Label com Quebra de Linha

```lua
-- CORREÇÃO PRINCIPAL: Labels agora quebram linha automaticamente!
Window:CreateLabel(Tab.Left, {
    Text = "Este texto muito longo vai quebrar automaticamente em múltiplas linhas sem cortar o conteúdo!",
    AutoSize = true,   -- Ajusta altura automaticamente
    Wrapped = true     -- Quebra linha (default)
})
```

## 🔔 Notificações

```lua
SpectrumX:Notify({
    Text = "Operação concluída!",
    Type = "success",  -- "success", "info", "warning", "error"
    Duration = 4
})
```

## 🎯 Elementos Disponíveis

| Elemento | Função |
|----------|--------|
| CreateWindow | Cria a janela principal |
| CreateTab | Cria uma aba |
| CreateSection | Cria uma seção com título |
| CreateToggle | Toggle switch |
| CreateButton | Botão com estilos |
| CreateInput | Campo de texto |
| CreateNumberInput | Campo numérico |
| CreateSlider | Slider de valor |
| CreateDropdown | Dropdown simples |
| CreateMultiDropdown | Dropdown multi-seleção |
| CreateCheckbox | Checkbox |
| CreateLabel | Label de texto |
| CreateSeparator | Linha separadora |
| CreateStatusCard | Card de status arrastável |
| Notify | Notificação |

## 🔄 Compatibilidade

**100% compatível com código antigo!**

Sua forma de criar elementos continua exatamente igual:

```lua
-- Código antigo (ainda funciona)
local Window = SpectrumX:CreateWindow({Title = "Script", Icon = "S"})
local Tab = Window:CreateTab({Name = "Main", Icon = "M"})
Window:CreateToggle(Tab.Left, {Text = "Auto", Callback = function() end})
```

## 🛠️ Métodos Adicionais

```lua
-- Visibilidade
SpectrumX:SetVisible(false)
SpectrumX:Toggle()

-- Posição e Tamanho
SpectrumX:SetPosition(UDim2.new(0.5, 0, 0.5, 0))
SpectrumX:SetSize(UDim2.new(0, 800, 0, 500))

-- Destruir
SpectrumX:Destroy()

-- Notificações
SpectrumX:Notify({Text = "Mensagem", Type = "info", Duration = 3})
```

## 🎨 Temas

```lua
-- Personalizar cores
SpectrumX:SetTheme({
    Accent = Color3.fromRGB(0, 150, 255),
    Background = Color3.fromRGB(10, 10, 10)
})
```

## 📱 Responsivo

A UI se adapta automaticamente a diferentes resoluções e dispositivos móveis.

## 🐛 Reportar Bugs

Encontrou algum problema? Verifique:
1. Se está usando a versão mais recente
2. Se o código segue os exemplos
3. Se não há conflitos com outras UIs

---

**Versão**: 2.0  
**Autor**: SpectrumX Team  
**Licença**: MIT

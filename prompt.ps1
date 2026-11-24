# ==============================================================================
# shuvoCodes — VS Code Terminal Themes
# Author: Shakhawat Hossain Shuvo (https://github.com/shakhawat-hossain-shuvo)
# Repository: https://github.com/shuvoCodes/vscode-terminal-themes
# ==============================================================================

# Ensure UTF-8 output encoding for box-drawing characters and symbols
try {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
} catch {}

# Constants
$script:ESC = [char]27
$script:RESET = "$script:ESC[0m"

# Box drawing characters
$script:CORNER_TOP    = [char]0x250C # ┌
$script:HLINE         = [char]0x2500 # ─
$script:CORNER_BOTTOM = [char]0x2514 # └
$script:BLOCK_CURSOR  = [char]0x2588 # █
$script:NF_BRANCH     = [char]0xF418 #  (Nerd Font Git branch)
$script:EMOJI_BRANCH  = [System.Char]::ConvertFromUtf32(0x1F33F) # 🌿

# Arrow style definitions
$script:ArrowStyles = [ordered]@{
    'Pointer'  = [char]0x25BA # ► (100% seamless, perfectly aligns with horizontal line)
    'Angle'    = [char]0x276F # ❯ (Oh My Posh / Starship chevron, vertically centered)
    'Triangle' = [char]0x25B8 # ▸ (Small centered triangle)
    'Greater'  = '>'          # > (Classic ASCII greater-than)
    'Arrow'    = [char]0x2192 # → (Unicode arrow)
}
$script:SelectedArrowStyle = 'Pointer'

function script:Get-ArrowSymbol {
    if ($global:ShuvoCodesArrow) {
        return $global:ShuvoCodesArrow
    }
    if ($script:SelectedArrowStyle -and $script:ArrowStyles.Contains($script:SelectedArrowStyle)) {
        return $script:ArrowStyles[$script:SelectedArrowStyle]
    }
    return [char]0x25BA
}

# Built-in Fallback Theme Definitions
$script:BuiltinThemes = [ordered]@{
    'Matrix' = [ordered]@{
        Name            = 'Matrix'
        Colors          = 'Green on Black'
        Vibe            = 'Hacker / Classic'
        AccentColor     = '#00FF41'
        FrameColor      = '#00FF41'
        BracketColor    = '#00FF41'
        SeparatorColor  = '#00FF41'
        UserHostColor   = '#53FEA7'
        PathColor       = '#FFFFFF'
        VenvColor       = '#FFFF00'
        BranchColor     = '#53FEA7'
        BranchIconColor = '#00FF41'
        ArrowClean      = '#00FF41'
        ArrowDirty      = '#FF3333'
        CursorColor     = '#00FF41'
    }
    'Cyberpunk' = [ordered]@{
        Name            = 'Cyberpunk'
        Colors          = 'Cyan on Dark'
        Vibe            = 'Futuristic Neon'
        AccentColor     = '#00F0FF'
        FrameColor      = '#00F0FF'
        BracketColor    = '#00F0FF'
        SeparatorColor  = '#00F0FF'
        UserHostColor   = '#00F0FF'
        PathColor       = '#FFFFFF'
        VenvColor       = '#FFE600'
        BranchColor     = '#52EBF9'
        BranchIconColor = '#00FF66'
        ArrowClean      = '#00F0FF'
        ArrowDirty      = '#FF0055'
        CursorColor     = '#00F0FF'
    }
    'Dracula' = [ordered]@{
        Name            = 'Dracula'
        Colors          = 'Magenta & Purple'
        Vibe            = 'Gothic Dark'
        AccentColor     = '#FF79C6'
        FrameColor      = '#FF79C6'
        BracketColor    = '#FF79C6'
        SeparatorColor  = '#FF79C6'
        UserHostColor   = '#FF79C6'
        PathColor       = '#F8F8F2'
        VenvColor       = '#F1FA8C'
        BranchColor     = '#F8F8F2'
        BranchIconColor = '#F1FA8C'
        ArrowClean      = '#FF79C6'
        ArrowDirty      = '#FF5555'
        CursorColor     = '#FF79C6'
    }
    'OneDarkPro' = [ordered]@{
        Name            = 'OneDarkPro'
        Colors          = 'Yellow & Orange'
        Vibe            = 'Warm Dark'
        AccentColor     = '#E5C07B'
        FrameColor      = '#E5C07B'
        BracketColor    = '#E5C07B'
        SeparatorColor  = '#E5C07B'
        UserHostColor   = '#E5C07B'
        PathColor       = '#ABB2BF'
        VenvColor       = '#E5C07B'
        BranchColor     = '#ABB2BF'
        BranchIconColor = '#E5C07B'
        ArrowClean      = '#E5C07B'
        ArrowDirty      = '#E06C75'
        CursorColor     = '#E5C07B'
    }
    'Nord' = [ordered]@{
        Name            = 'Nord'
        Colors          = 'Blue & White'
        Vibe            = 'Arctic Minimal'
        AccentColor     = '#88C0D0'
        FrameColor      = '#88C0D0'
        BracketColor    = '#88C0D0'
        SeparatorColor  = '#88C0D0'
        UserHostColor   = '#81A1C1'
        PathColor       = '#ECEFF4'
        VenvColor       = '#EBCB8B'
        BranchColor     = '#ECEFF4'
        BranchIconColor = '#A3BE8C'
        ArrowClean      = '#88C0D0'
        ArrowDirty      = '#BF616A'
        CursorColor     = '#88C0D0'
    }
    'TokyoNight' = [ordered]@{
        Name            = 'TokyoNight'
        Colors          = 'Purple & Pink'
        Vibe            = 'Synthwave City'
        AccentColor     = '#BB9AF7'
        FrameColor      = '#BB9AF7'
        BracketColor    = '#BB9AF7'
        SeparatorColor  = '#BB9AF7'
        UserHostColor   = '#7AA2F7'
        PathColor       = '#C0CAF5'
        VenvColor       = '#E0AF68'
        BranchColor     = '#C0CAF5'
        BranchIconColor = '#E0AF68'
        ArrowClean      = '#BB9AF7'
        ArrowDirty      = '#F7768E'
        CursorColor     = '#BB9AF7'
    }
    'MinimalDark' = [ordered]@{
        Name            = 'MinimalDark'
        Colors          = 'White on Black'
        Vibe            = 'Clean & Simple'
        AccentColor     = '#FFFFFF'
        FrameColor      = '#FFFFFF'
        BracketColor    = '#FFFFFF'
        SeparatorColor  = '#FFFFFF'
        UserHostColor   = '#FFFFFF'
        PathColor       = '#FFFFFF'
        VenvColor       = '#FACC15'
        BranchColor     = '#FFFFFF'
        BranchIconColor = '#FDE047'
        ArrowClean      = '#FFFFFF'
        ArrowDirty      = '#EF4444'
        CursorColor     = '#E5E7EB'
    }
    'SolarizedDark' = [ordered]@{
        Name            = 'SolarizedDark'
        Colors          = 'Teal & Green'
        Vibe            = 'Retro Warm'
        AccentColor     = '#2AA198'
        FrameColor      = '#2AA198'
        BracketColor    = '#2AA198'
        SeparatorColor  = '#2AA198'
        UserHostColor   = '#2AA198'
        PathColor       = '#93A1A1'
        VenvColor       = '#B58900'
        BranchColor     = '#93A1A1'
        BranchIconColor = '#859900'
        ArrowClean      = '#2AA198'
        ArrowDirty      = '#DC322F'
        CursorColor     = '#2AA198'
    }
    'RetroGreen' = [ordered]@{
        Name            = 'RetroGreen'
        Colors          = 'Bright Green'
        Vibe            = 'Old-school CRT'
        AccentColor     = '#00FF00'
        FrameColor      = '#00FF00'
        BracketColor    = '#00FF00'
        SeparatorColor  = '#00FF00'
        UserHostColor   = '#00FF00'
        PathColor       = '#66FF66'
        VenvColor       = '#FFFF00'
        BranchColor     = '#00FF00'
        BranchIconColor = '#00FF00'
        ArrowClean      = '#00FF00'
        ArrowDirty      = '#FF2200'
        CursorColor     = '#00FF00'
    }
}

# Config Directory
$script:ConfigDir = Join-Path $HOME ".shuvoCodes"
$script:ConfigFile = Join-Path $script:ConfigDir "theme.txt"

# Convert Hex to ANSI 24-bit TrueColor
function script:HexToAnsi {
    param([string]$Hex, [switch]$Background)
    if ($Hex -match '^#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$') {
        $r = [Convert]::ToInt32($matches[1], 16)
        $g = [Convert]::ToInt32($matches[2], 16)
        $b = [Convert]::ToInt32($matches[3], 16)
        if ($Background) {
            return "$script:ESC[48;2;$r;$g;${b}m"
        }
        return "$script:ESC[38;2;$r;$g;${b}m"
    }
    return "$script:ESC[0m"
}

# Resolve Theme Directory
function script:Get-ThemesDirectory {
    if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "themes"))) {
        return (Join-Path $PSScriptRoot "themes")
    }
    $homeThemes = Join-Path $script:ConfigDir "themes"
    if (Test-Path $homeThemes -ErrorAction SilentlyContinue) {
        return $homeThemes
    }
    return $null
}

# Load a Theme by Name
function script:Get-ThemeDefinition {
    param([string]$ThemeName)

    $themesDir = script:Get-ThemesDirectory
    if ($themesDir) {
        $themeFile = Join-Path $themesDir "$ThemeName.ps1"
        if (Test-Path $themeFile) {
            try {
                $loaded = . $themeFile
                if ($loaded -is [System.Collections.IDictionary]) {
                    return $loaded
                }
            } catch {}
        }
    }

    # Fallback to builtin
    foreach ($key in $script:BuiltinThemes.Keys) {
        if ($key -ieq $ThemeName) {
            return $script:BuiltinThemes[$key]
        }
    }

    # Default to Matrix if not found
    return $script:BuiltinThemes['Matrix']
}

# Cache ANSI escape codes for active theme to optimize prompt speed
$script:ActiveTheme = $null
$script:AnsiCache = [ordered]@{}

function script:ApplyThemeColors {
    param($theme)
    $script:ActiveTheme = $theme
    $script:AnsiCache = [ordered]@{
        Frame       = script:HexToAnsi $theme.FrameColor
        Bracket     = script:HexToAnsi $theme.BracketColor
        Separator   = script:HexToAnsi $theme.SeparatorColor
        UserHost    = script:HexToAnsi $theme.UserHostColor
        Path        = script:HexToAnsi $theme.PathColor
        Venv        = script:HexToAnsi $theme.VenvColor
        Branch      = script:HexToAnsi $theme.BranchColor
        BranchIcon  = script:HexToAnsi $theme.BranchIconColor
        ArrowClean  = script:HexToAnsi $theme.ArrowClean
        ArrowDirty  = script:HexToAnsi $theme.ArrowDirty
        Cursor      = script:HexToAnsi $theme.CursorColor
    }
}

# Get Branch Icon Symbol
function script:Get-BranchIcon {
    if ($global:ShuvoCodesBranchIcon) {
        return $global:ShuvoCodesBranchIcon
    }
    if ($global:ShuvoCodesUseEmoji -or $env:SHUVOCODES_USE_EMOJI) {
        return $script:EMOJI_BRANCH
    }
    return $script:NF_BRANCH
}

# ==============================================================================
# PROMPT RENDERING ENGINE
# ==============================================================================
function global:prompt {
    # If not yet initialized, load active theme
    if (-not $script:ActiveTheme) {
        $themeToLoad = 'Matrix'
        if (Test-Path $script:ConfigFile -ErrorAction SilentlyContinue) {
            $saved = (Get-Content $script:ConfigFile -Raw).Trim()
            if ($saved) { $themeToLoad = $saved }
        }
        $themeDef = script:Get-ThemeDefinition $themeToLoad
        script:ApplyThemeColors $themeDef
    }

    $c = $script:AnsiCache
    $rst = $script:RESET

    # 1. User & Computer Name
    $user = $env:USERNAME
    if (-not $user) { $user = "user" }
    $hostName = $env:COMPUTERNAME
    if (-not $hostName) { $hostName = "Windows" }
    $userHost = "$user@$hostName"

    # 2. Project / Current Folder
    $currentPath = (Get-Location).Path
    $folderName = Split-Path -Leaf $currentPath
    if (-not $folderName) {
        $folderName = $currentPath
    }

    # 3. Python Virtual Environment (if active)
    $venvName = $null
    if ($env:VIRTUAL_ENV) {
        $venvName = Split-Path -Leaf $env:VIRTUAL_ENV
    } elseif ($env:CONDA_DEFAULT_ENV) {
        $venvName = $env:CONDA_DEFAULT_ENV
    }

    # 4. Git Branch & Status (if in repo)
    $inGit = $false
    $gitBranch = ""
    $isDirty = $false

    if (Get-Command git -ErrorAction SilentlyContinue) {
        $insideWorkTree = git rev-parse --is-inside-work-tree 2>$null
        if ($insideWorkTree -eq 'true') {
            $inGit = $true
            $gitBranch = git branch --show-current 2>$null
            if (-not $gitBranch) {
                $gitBranch = git rev-parse --short HEAD 2>$null
                if (-not $gitBranch) { $gitBranch = "HEAD" }
            }
            $status = git status --porcelain 2>$null
            if ($status) {
                $isDirty = $true
            }
        }
    }

    # Build Line 1
    # ┌─[username@machine]-[ my-project ]-[ (.venv) ]-[  main]
    $topLine = "$rst$($c.Frame)$($script:CORNER_TOP)$($script:HLINE)" +
               "$($c.Bracket)[$($c.UserHost)$userHost$($c.Bracket)]" +
               "$($c.Separator)-$($c.Bracket)[ $($c.Path)$folderName $($c.Bracket)]"

    if ($venvName) {
        $topLine += "$($c.Separator)-$($c.Bracket)[ $($c.Venv)($venvName) $($c.Bracket)]"
    }

    if ($inGit) {
        $bIcon = script:Get-BranchIcon
        $topLine += "$($c.Separator)-$($c.Bracket)[ $($c.BranchIcon)$bIcon $($c.Branch)$gitBranch$($c.Bracket)]"
    }

    # Build Line 2
    # └──→ (Arrow color: clean green, dirty red, or theme clean if outside git)
    $arrowColor = if ($inGit) {
        if ($isDirty) { $c.ArrowDirty } else { $c.ArrowClean }
    } else {
        $c.ArrowClean
    }

    $arrowSym = script:Get-ArrowSymbol
    $bottomLine = "$rst$($c.Frame)$($script:CORNER_BOTTOM)$($script:HLINE)" +
                  "$arrowColor$arrowSym $rst"

    return "$topLine`n$bottomLine"
}

# ==============================================================================
# PUBLIC FUNCTIONS
# ==============================================================================

<#
.SYNOPSIS
    Changes the active terminal theme.
.PARAMETER Theme
    The name of the theme to apply.
#>
function global:Set-TerminalTheme {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateSet('Matrix', 'Cyberpunk', 'Dracula', 'OneDarkPro', 'Nord', 'TokyoNight', 'MinimalDark', 'SolarizedDark', 'RetroGreen', IgnoreCase = $true)]
        [string]$Theme,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Pointer', 'Angle', 'Triangle', 'Greater', 'Arrow', IgnoreCase = $true)]
        [string]$ArrowStyle
    )

    if ($ArrowStyle) {
        $canonicalArrow = $null
        foreach ($k in $script:ArrowStyles.Keys) {
            if ($k -ieq $ArrowStyle) {
                $canonicalArrow = $k
                break
            }
        }
        if ($canonicalArrow) {
            $script:SelectedArrowStyle = $canonicalArrow
            Write-Host "`n  ✔ Arrow style set to: $canonicalArrow ($($script:ArrowStyles[$canonicalArrow]))" -ForegroundColor Green
        }
    }

    if (-not $Theme) {
        if (-not $ArrowStyle) {
            Write-Host "`nPlease specify a theme name. Example: Set-TerminalTheme -Theme Cyberpunk`n" -ForegroundColor Yellow
            Get-TerminalThemes
        }
        return
    }

    # Find canonical theme name
    $canonical = $null
    foreach ($key in $script:BuiltinThemes.Keys) {
        if ($key -ieq $Theme) {
            $canonical = $key
            break
        }
    }
    if (-not $canonical) { $canonical = $Theme }

    $themeDef = script:Get-ThemeDefinition $canonical
    script:ApplyThemeColors $themeDef

    # Save to config file
    try {
        if (-not (Test-Path $script:ConfigDir -ErrorAction SilentlyContinue)) {
            New-Item -ItemType Directory -Path $script:ConfigDir -Force -ErrorAction Stop | Out-Null
        }
        Set-Content -Path $script:ConfigFile -Value $canonical -Force -ErrorAction Stop
    } catch {}

    $esc = $script:ESC
    $accentAnsi = script:HexToAnsi $themeDef.AccentColor
    Write-Host ""
    Write-Host "  $esc[1m$accentAnsi✔ Theme switched to: $($themeDef.Name)$esc[0m"
    Write-Host "  $esc[90mColors: $($themeDef.Colors)  |  Vibe: $($themeDef.Vibe)$esc[0m"
    Write-Host ""
}

<#
.SYNOPSIS
    Lists all available terminal themes.
#>
function global:Get-TerminalThemes {
    [CmdletBinding()]
    param()

    $currentName = if ($script:ActiveTheme) { $script:ActiveTheme.Name } else { 'Matrix' }
    if (Test-Path $script:ConfigFile -ErrorAction SilentlyContinue) {
        $saved = (Get-Content $script:ConfigFile -Raw).Trim()
        if ($saved) { $currentName = $saved }
    }

    $esc = $script:ESC
    Write-Host ""
    Write-Host "  $esc[1;36m🎨 shuvoCodes — Available Themes$esc[0m"
    Write-Host "  $esc[90m-----------------------------------------------------------------$esc[0m"
    Write-Host "  $esc[1mSTATUS   THEME             COLORS                VIBE$esc[0m"
    Write-Host "  $esc[90m-----------------------------------------------------------------$esc[0m"

    foreach ($name in $script:BuiltinThemes.Keys) {
        $t = $script:BuiltinThemes[$name]
        $themeDef = script:Get-ThemeDefinition $name
        $accent = script:HexToAnsi $themeDef.AccentColor

        $isActive = ($name -ieq $currentName)
        $statusMark = if ($isActive) { "$esc[1;32m  *  $esc[0m" } else { "     " }
        $activeBadge = if ($isActive) { " $esc[1;32m[ACTIVE]$esc[0m" } else { "" }

        $paddedName = $name.PadRight(16)
        $paddedColors = $t.Colors.PadRight(22)
        $vibe = $t.Vibe

        Write-Host "$statusMark $accent$paddedName$esc[0m $paddedColors $esc[90m$vibe$esc[0m$activeBadge"
    }

    Write-Host "  $esc[90m-----------------------------------------------------------------$esc[0m"
    Write-Host "  $esc[90mChange theme with: $esc[1;33mSet-TerminalTheme -Theme <ThemeName>$esc[0m"
    Write-Host "  $esc[90mPreview theme with: $esc[1;33mShow-ThemePreview -Theme <ThemeName>$esc[0m"
    Write-Host ""
}

<#
.SYNOPSIS
    Previews one or all themes without permanently changing the active theme.
.PARAMETER Theme
    The theme to preview. If omitted, previews all themes.
#>
function global:Show-ThemePreview {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateSet('Matrix', 'Cyberpunk', 'Dracula', 'OneDarkPro', 'Nord', 'TokyoNight', 'MinimalDark', 'SolarizedDark', 'RetroGreen', IgnoreCase = $true)]
        [string]$Theme,

        [switch]$All
    )

    $themesToPreview = @()
    if ($Theme) {
        $themesToPreview = @($Theme)
    } else {
        $themesToPreview = $script:BuiltinThemes.Keys
    }

    $esc = $script:ESC
    $bIcon = script:Get-BranchIcon

    foreach ($tName in $themesToPreview) {
        $t = script:Get-ThemeDefinition $tName
        $accent = script:HexToAnsi $t.AccentColor
        $frame  = script:HexToAnsi $t.FrameColor
        $brk    = script:HexToAnsi $t.BracketColor
        $sep    = script:HexToAnsi $t.SeparatorColor
        $uh     = script:HexToAnsi $t.UserHostColor
        $path   = script:HexToAnsi $t.PathColor
        $venv   = script:HexToAnsi $t.VenvColor
        $br     = script:HexToAnsi $t.BranchColor
        $bico   = script:HexToAnsi $t.BranchIconColor
        $clean  = script:HexToAnsi $t.ArrowClean
        $dirty  = script:HexToAnsi $t.ArrowDirty
        $cursor = script:HexToAnsi $t.CursorColor
        $rst    = $script:RESET

        Write-Host ""
        Write-Host "  $accent● $($t.Name) Style$rst  $esc[90m($($t.Colors) — $($t.Vibe))$rst"
        $demoLine1 = "  $frame$script:CORNER_TOP$script:HLINE" +
                     "$brk[$uh" + "shuvoCodes@Windows" + "$brk]$sep-" +
                     "$brk[ $path" + "my-project" + " $brk]$sep-" +
                     "$brk[ $venv" + "(.venv)" + " $brk]$sep-" +
                     "$brk[ $bico$bIcon $br" + "main" + "$brk]$rst"
        Write-Host $demoLine1
        $demoArrow = script:Get-ArrowSymbol
        Write-Host "  $frame$script:CORNER_BOTTOM$script:HLINE$clean$demoArrow $cursor$script:BLOCK_CURSOR$rst  $esc[90m(clean working tree)$rst"
        Write-Host "  $frame$script:CORNER_BOTTOM$script:HLINE$dirty$demoArrow $cursor$script:BLOCK_CURSOR$rst  $esc[90m(uncommitted changes)$rst"
    }
    Write-Host ""
}

<#
.SYNOPSIS
    Resets terminal prompt to default PowerShell prompt or uninstalls shuvoCodes.
.PARAMETER Uninstall
    Removes shuvoCodes from $PROFILE.
#>
function global:Reset-TerminalTheme {
    [CmdletBinding()]
    param(
        [switch]$Uninstall
    )

    # Restore standard prompt function
    function global:prompt {
        "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
    }

    if ($Uninstall) {
        if ($PROFILE -and (Test-Path $PROFILE)) {
            try {
                $content = Get-Content $PROFILE -Raw
                if ($content -match '(?ms)# shuvoCodes START.*?# shuvoCodes END\r?\n?') {
                    $cleaned = $content -replace '(?ms)# shuvoCodes START.*?# shuvoCodes END\r?\n?', ''
                    Set-Content -Path $PROFILE -Value $cleaned.Trim() -Force
                    Write-Host "`n  [✔] shuvoCodes removed from your PowerShell `$PROFILE.`n" -ForegroundColor Green
                } else {
                    Write-Host "`n  [i] No shuvoCodes block found in `$PROFILE.`n" -ForegroundColor Yellow
                }
            } catch {
                Write-Host "`n  [!] Could not modify `$PROFILE: $_`n" -ForegroundColor Red
            }
        }
        Write-Host "  [✔] Restored default PowerShell prompt.`n" -ForegroundColor Green
    } else {
        Write-Host "`n  [✔] Restored default PowerShell prompt for current session." -ForegroundColor Green
        Write-Host "      Run: . `$PROFILE to reload your saved theme.`n" -ForegroundColor DarkGray
    }
}

# ==============================================================================
# INITIALIZE
# ==============================================================================
# Automatically load saved theme from config (or default to Matrix)
$initialTheme = 'Matrix'
if (Test-Path $script:ConfigFile -ErrorAction SilentlyContinue) {
    try {
        $saved = (Get-Content $script:ConfigFile -Raw).Trim()
        if ($saved) { $initialTheme = $saved }
    } catch {}
}
$initDef = script:Get-ThemeDefinition $initialTheme
script:ApplyThemeColors $initDef

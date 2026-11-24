# ==============================================================================
# shuvoCodes - VS Code Terminal Themes
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
$script:CORNER_TOP    = [char]0x250C # Top-left corner
$script:HLINE         = [char]0x2500 # Horizontal line
$script:CORNER_BOTTOM = [char]0x2514 # Bottom-left corner
$script:BLOCK_CURSOR  = [char]0x2588 # Solid block cursor

# Git branch icons (Status is default: tick when uploaded/clean, cross when changed/not uploaded)
$script:BranchIcons = [ordered]@{
    'Status'   = 'Status'                                # Dynamic: tick when uploaded, cross when changed
    'Leaf'     = [System.Char]::ConvertFromUtf32(0x1F33F) # Leaf emoji (Works out of the box on Windows)
    'Symbol'   = [char]0x2387                            # Standard Unicode branch symbol (U+2387)
    'NerdFont' = [char]0xF418                            # Nerd Font octicon (Requires Nerd Font)
    'None'     = ''                                      # No icon
}
$script:SelectedBranchIcon = 'Status'

# Arrow style definitions
$script:ArrowStyles = [ordered]@{
    'Pointer'  = [char]0x25BA # Seamless pointer, perfectly aligned with horizontal line
    'Angle'    = [char]0x276F # Centered chevron
    'Triangle' = [char]0x25B8 # Centered small triangle
    'Greater'  = '>'          # Classic ASCII greater-than
    'Arrow'    = [char]0x2192 # Unicode right arrow
}
$script:SelectedArrowStyle = 'Pointer'

# Paths
$script:ConfigDir        = Join-Path $HOME ".shuvoCodes"
$script:ConfigFile       = Join-Path $script:ConfigDir "theme.txt"
$script:ArrowConfigFile  = Join-Path $script:ConfigDir "arrow.txt"
$script:BranchConfigFile = Join-Path $script:ConfigDir "branch.txt"
$script:ThemesDir        = Join-Path $script:ConfigDir "themes"

function script:Get-BranchIcon {
    if ($global:ShuvoCodesBranchIcon) {
        return $global:ShuvoCodesBranchIcon
    }
    if ($script:SelectedBranchIcon -and $script:BranchIcons.Contains($script:SelectedBranchIcon)) {
        return $script:BranchIcons[$script:SelectedBranchIcon]
    }
    return [System.Char]::ConvertFromUtf32(0x1F33F)
}

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
        PathColor       = '#FF0055'
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
        SeparatorColor  = '#6272A4'
        UserHostColor   = '#8BE9FD'
        PathColor       = '#BD93F9'
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
        SeparatorColor  = '#5C6370'
        UserHostColor   = '#61AFEF'
        PathColor       = '#98C379'
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
        SeparatorColor  = '#4C566A'
        UserHostColor   = '#81A1C1'
        PathColor       = '#D8DEE9'
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
        SeparatorColor  = '#565F89'
        UserHostColor   = '#7AA2F7'
        PathColor       = '#7DCFFF'
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
        SeparatorColor  = '#4B5563'
        UserHostColor   = '#9CA3AF'
        PathColor       = '#E5E7EB'
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
        SeparatorColor  = '#586E75'
        UserHostColor   = '#268BD2'
        PathColor       = '#839496'
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
        SeparatorColor  = '#008800'
        UserHostColor   = '#33FF33'
        PathColor       = '#00FF00'
        VenvColor       = '#FFFF00'
        BranchColor     = '#00FF00'
        BranchIconColor = '#00FF00'
        ArrowClean      = '#00FF00'
        ArrowDirty      = '#FF2200'
        CursorColor     = '#00FF00'
    }
}

# ==============================================================================
# HELPER FUNCTIONS
# ==============================================================================

function script:HexToAnsi {
    param([string]$hex)
    if (-not $hex) { return "$script:ESC[0m" }
    $hex = $hex.TrimStart('#')
    if ($hex.Length -ne 6) { return "$script:ESC[0m" }
    try {
        $r = [Convert]::ToInt32($hex.Substring(0, 2), 16)
        $g = [Convert]::ToInt32($hex.Substring(2, 2), 16)
        $b = [Convert]::ToInt32($hex.Substring(4, 2), 16)
        return "$script:ESC[38;2;$r;$g;${b}m"
    } catch {
        return "$script:ESC[0m"
    }
}

function script:Get-ThemeDefinition {
    param([string]$themeName)

    # 1. Check external theme file
    $themeFile = Join-Path $script:ThemesDir "$themeName.ps1"
    if (Test-Path $themeFile -ErrorAction SilentlyContinue) {
        try {
            $def = & $themeFile
            if ($def -and $def.Name) { return $def }
        } catch {}
    }

    # 2. Check built-in fallback
    foreach ($key in $script:BuiltinThemes.Keys) {
        if ($key -ieq $themeName) {
            return $script:BuiltinThemes[$key]
        }
    }

    # 3. Default to Matrix
    return $script:BuiltinThemes['Matrix']
}

function script:ApplyThemeColors {
    param($theme)

    $script:ActiveThemeName = $theme.Name

    $script:Ansi = [ordered]@{
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

# ==============================================================================
# MAIN PROMPT FUNCTION
# ==============================================================================

function global:prompt {
    $c = $script:Ansi
    $rst = $script:RESET

    # 1. User & Machine
    $userHost = "$($env:USERNAME)@$($env:COMPUTERNAME)"

    # 2. Current Folder Name
    $currPath = $executionContext.SessionState.Path.CurrentLocation.Path
    $folderName = Split-Path -Leaf $currPath
    if (-not $folderName -or $folderName -eq '\' -or $folderName -eq '/') {
        $folderName = $currPath
    }

    # 3. Python Virtual Environment (.venv)
    $venvName = $null
    if ($env:VIRTUAL_ENV) {
        $venvName = Split-Path -Leaf $env:VIRTUAL_ENV
    } elseif ($env:CONDA_DEFAULT_ENV) {
        $venvName = $env:CONDA_DEFAULT_ENV
    }

    # 4. Git Branch & Status
    $inGit = $false
    $gitBranch = $null
    $isDirty = $false
    $isUnpushed = $false

    if (Get-Command git -ErrorAction SilentlyContinue) {
        $branchOut = git rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -eq 0 -and $branchOut) {
            $inGit = $true
            $gitBranch = $branchOut.Trim()
            if ($gitBranch -eq 'HEAD') {
                $shortSha = git rev-parse --short HEAD 2>$null
                $gitBranch = if ($shortSha) { ":$($shortSha.Trim())" } else { "detached" }
            }

            $statusLines = git status --porcelain -b 2>$null
            if ($statusLines) {
                if ($statusLines.Count -gt 1) {
                    $isDirty = $true
                }
                if ($statusLines[0] -match '\[ahead\s+\d+') {
                    $isUnpushed = $true
                }
            }
        }
    }

    # Build Line 1
    # Top frame with box brackets: [user@host]-[ folder ]-[ (.venv) ]-[ icon branch ]
    $topLine = "$rst$($c.Frame)$($script:CORNER_TOP)$($script:HLINE)" +
               "$($c.Bracket)[$($c.UserHost)$userHost$($c.Bracket)]" +
               "$($c.Separator)-$($c.Bracket)[ $($c.Path)$folderName $($c.Bracket)]"

    if ($venvName) {
        $topLine += "$($c.Separator)-$($c.Bracket)[ $($c.Venv)($venvName) $($c.Bracket)]"
    }

    $isNotUploaded = ($isDirty -or $isUnpushed)

    if ($inGit) {
        $bIcon = $null
        $bColor = $c.BranchIcon

        if ($script:SelectedBranchIcon -eq 'Status') {
            if ($isNotUploaded) {
                $bIcon = [char]0x2717 # Cross (not uploaded)
                $bColor = $c.ArrowDirty
            } else {
                $bIcon = [char]0x2714 # Checkmark (uploaded)
                $bColor = $c.ArrowClean
            }
        } else {
            $bIcon = script:Get-BranchIcon
            $bColor = $c.BranchIcon
        }

        $iconSpacer = if ($bIcon) { "$bIcon " } else { "" }
        $topLine += "$($c.Separator)-$($c.Bracket)[ $bColor$iconSpacer$($c.Branch)$gitBranch $($c.Bracket)]"
    }

    # Build Line 2
    # Arrow color: clean green or dirty red
    $arrowColor = if ($inGit) {
        if ($isNotUploaded) { $c.ArrowDirty } else { $c.ArrowClean }
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
    Changes the active terminal theme, arrow style, or git branch icon.
.PARAMETER Theme
    The name of the theme to apply.
.PARAMETER ArrowStyle
    Arrow style: Pointer, Angle, Triangle, Greater, Arrow.
.PARAMETER BranchIcon
    Git branch icon: Status, Leaf, Symbol, NerdFont, None.
#>
function global:Set-TerminalTheme {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateSet('Matrix', 'Cyberpunk', 'Dracula', 'OneDarkPro', 'Nord', 'TokyoNight', 'MinimalDark', 'SolarizedDark', 'RetroGreen', IgnoreCase = $true)]
        [string]$Theme,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Pointer', 'Angle', 'Triangle', 'Greater', 'Arrow', IgnoreCase = $true)]
        [string]$ArrowStyle,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Status', 'Leaf', 'Symbol', 'NerdFont', 'None', IgnoreCase = $true)]
        [string]$BranchIcon
    )

    $checkMark = [char]0x2714

    if ($BranchIcon) {
        $canonicalIcon = $null
        foreach ($k in $script:BranchIcons.Keys) {
            if ($k -ieq $BranchIcon) {
                $canonicalIcon = $k
                break
            }
        }
        if ($canonicalIcon) {
            $script:SelectedBranchIcon = $canonicalIcon
            try {
                Set-Content -Path $script:BranchConfigFile -Value $canonicalIcon -Force -ErrorAction SilentlyContinue
            } catch {}
            $displayIcon = if ($canonicalIcon -eq 'Status') { "$([char]0x2714)/$([char]0x2717)" } else { $script:BranchIcons[$canonicalIcon] }
            Write-Host "`n  $checkMark Branch icon set to: $canonicalIcon ($displayIcon)" -ForegroundColor Green
        }
    }

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
            try {
                Set-Content -Path $script:ArrowConfigFile -Value $canonicalArrow -Force -ErrorAction SilentlyContinue
            } catch {}
            $displayArrow = $script:ArrowStyles[$canonicalArrow]
            Write-Host "`n  $checkMark Arrow style set to: $canonicalArrow ($displayArrow)" -ForegroundColor Green
        }
    }

    if (-not $Theme) {
        if (-not $ArrowStyle -and -not $BranchIcon) {
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

    # Persist selection
    try {
        if (-not (Test-Path $script:ConfigDir -ErrorAction SilentlyContinue)) {
            New-Item -ItemType Directory -Path $script:ConfigDir -Force -ErrorAction SilentlyContinue | Out-Null
        }
        Set-Content -Path $script:ConfigFile -Value $themeDef.Name -Force -ErrorAction SilentlyContinue
    } catch {}

    $rst = "$script:ESC[0m"
    $bld = "$script:ESC[1m"
    $dim = "$script:ESC[90m"
    $accentAnsi = script:HexToAnsi $themeDef.AccentColor
    Write-Host ""
    Write-Host "  $bld$accentAnsi$checkMark Theme switched to: $($themeDef.Name)$rst"
    Write-Host "  $dim Colors: $($themeDef.Colors)  |  Vibe: $($themeDef.Vibe)$rst"
    Write-Host ""
}

<#
.SYNOPSIS
    Lists all available terminal themes with descriptions and active status.
#>
function global:Get-TerminalThemes {
    [CmdletBinding()]
    param()

    $active = $script:ActiveThemeName
    $rst = "$script:ESC[0m"
    $bld = "$script:ESC[1m"
    $dim = "$script:ESC[90m"
    $cyn = "$script:ESC[1;36m"
    $yel = "$script:ESC[1;33m"
    $checkMark = [char]0x2714
    $palette   = [System.Char]::ConvertFromUtf32(0x1F3A8)

    Write-Host ""
    Write-Host "  $cyn$palette shuvoCodes - Available Themes$rst"
    Write-Host "  $dim-----------------------------------------------------------------$rst"
    Write-Host "  $bld STATUS   THEME             COLORS                VIBE$rst"
    Write-Host "  $dim-----------------------------------------------------------------$rst"

    foreach ($name in $script:BuiltinThemes.Keys) {
        $t = $script:BuiltinThemes[$name]
        $isActive = ($name -ieq $active)
        $accent = script:HexToAnsi $t.AccentColor

        $statusMark  = if ($isActive) { "$script:ESC[1;32m   $checkMark  $rst" } else { "      " }
        $activeBadge = if ($isActive) { " $script:ESC[1;32m[active]$rst" } else { "" }

        $paddedName = $name.PadRight(16)
        $paddedColors = $t.Colors.PadRight(22)
        $vibe = $t.Vibe

        Write-Host "$statusMark $accent$paddedName$rst $paddedColors $dim$vibe$rst$activeBadge"
    }

    Write-Host "  $dim-----------------------------------------------------------------$rst"
    Write-Host "  $dim Change theme with: $yel Set-TerminalTheme -Theme <ThemeName>$rst"
    Write-Host "  $dim Preview theme with: $yel Show-ThemePreview -Theme <ThemeName>$rst"
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

    $bIcon = script:Get-BranchIcon
    $iconSpacer = if ($bIcon) { "$bIcon " } else { "" }
    $rst = "$script:ESC[0m"
    $dim = "$script:ESC[90m"
    $bullet = [char]0x25CF

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

        Write-Host ""
        $vibeLabel = "(" + $t.Colors + " - " + $t.Vibe + ")"
        Write-Host "  $accent$bullet $($t.Name) Style$rst  $dim$vibeLabel$rst"
        $demoClean = "  $frame$($script:CORNER_TOP)$($script:HLINE)" +
                     "$brk" + "[" + "$uh" + "shuvoCodes@Windows" + "$brk" + "]" + "$sep" + "-" +
                     "$brk" + "[ " + "$path" + "my-project " + "$brk" + "]" + "$sep" + "-" +
                     "$brk" + "[ " + "$venv" + "(.venv) " + "$brk" + "]" + "$sep" + "-" +
                     "$brk" + "[ " + "$clean" + "$([char]0x2714) " + "$br" + "main " + "$brk" + "]" + "$rst"
        $demoDirty = "  $frame$($script:CORNER_TOP)$($script:HLINE)" +
                     "$brk" + "[" + "$uh" + "shuvoCodes@Windows" + "$brk" + "]" + "$sep" + "-" +
                     "$brk" + "[ " + "$path" + "my-project " + "$brk" + "]" + "$sep" + "-" +
                     "$brk" + "[ " + "$venv" + "(.venv) " + "$brk" + "]" + "$sep" + "-" +
                     "$brk" + "[ " + "$dirty" + "$([char]0x2717) " + "$br" + "main " + "$brk" + "]" + "$rst"
        $demoArrow = script:Get-ArrowSymbol
        Write-Host $demoClean
        Write-Host "  $frame$($script:CORNER_BOTTOM)$($script:HLINE)$clean$demoArrow $cursor$script:BLOCK_CURSOR$rst  $dim(clean / uploaded)$rst"
        Write-Host $demoDirty
        Write-Host "  $frame$($script:CORNER_BOTTOM)$($script:HLINE)$dirty$demoArrow $cursor$script:BLOCK_CURSOR$rst  $dim(uncommitted / not uploaded)$rst"
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

    $checkMark = [char]0x2714

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
                    Write-Host "`n  [$checkMark] shuvoCodes removed from your PowerShell `$PROFILE.`n" -ForegroundColor Green
                } else {
                    Write-Host "`n  [i] No shuvoCodes block found in `$PROFILE.`n" -ForegroundColor Yellow
                }
            } catch {
                Write-Host "`n  [!] Could not modify `$PROFILE: $_`n" -ForegroundColor Red
            }
        }
        Write-Host "  [$checkMark] Restored default PowerShell prompt.`n" -ForegroundColor Green
    } else {
        Write-Host "`n  [$checkMark] Restored default PowerShell prompt for current session." -ForegroundColor Green
        Write-Host "      Run: . `$PROFILE to reload your saved theme.`n" -ForegroundColor DarkGray
    }
}

# ==============================================================================
# INITIALIZE
# ==============================================================================
# 1. Load saved theme (or default to Matrix)
$initialTheme = 'Matrix'
if (Test-Path $script:ConfigFile -ErrorAction SilentlyContinue) {
    try {
        $saved = (Get-Content $script:ConfigFile -Raw).Trim()
        if ($saved) { $initialTheme = $saved }
    } catch {}
}

# 2. Load saved arrow style (or default to Pointer)
if (Test-Path $script:ArrowConfigFile -ErrorAction SilentlyContinue) {
    try {
        $savedArrow = (Get-Content $script:ArrowConfigFile -Raw).Trim()
        if ($savedArrow -and $script:ArrowStyles.Contains($savedArrow)) {
            $script:SelectedArrowStyle = $savedArrow
        }
    } catch {}
}

# 3. Load saved branch icon (or default to Status: tick/cross)
if (Test-Path $script:BranchConfigFile -ErrorAction SilentlyContinue) {
    try {
        $savedBranch = (Get-Content $script:BranchConfigFile -Raw).Trim()
        if ($savedBranch -and $script:BranchIcons.Contains($savedBranch)) {
            $script:SelectedBranchIcon = $savedBranch
        }
    } catch {}
}

$initDef = script:Get-ThemeDefinition $initialTheme
script:ApplyThemeColors $initDef

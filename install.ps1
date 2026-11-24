# ==============================================================================
# shuvoCodes — VS Code Terminal Themes Installer
# Author: Shakhawat Hossain Shuvo (https://github.com/shakhawat-hossain-shuvo)
# Repository: https://github.com/shuvoCodes/vscode-terminal-themes
# ==============================================================================

# Default theme if not specified
$DefaultTheme = 'Matrix'

# Ensure UTF-8 output
try {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
} catch {}

$ESC = [char]27
$CYAN   = "$ESC[1;36m"
$GREEN  = "$ESC[1;32m"
$YELLOW = "$ESC[1;33m"
$MAGENTA= "$ESC[1;35m"
$GRAY   = "$ESC[90m"
$BOLD   = "$ESC[1m"
$RESET  = "$ESC[0m"

$Banner = @"
$CYAN
        __                     ______          __          
  _____/ /_  __  ___   _____  / ____/___  ____/ /__  _____ 
 / ___/ __ \/ / / / | / / _ \/ /   / __ \/ __  / _ \/ ___/ 
(__  ) / / / /_/ /| |/ / (_) / /___/ /_/ / /_/ /  __(__  )  
/____/_/ /_/\__,_/ |___/\___/\____/\____/\__,_/\___/____/   
$MAGENTA
           VS Code Terminal Themes — by shuvoCodes
$RESET
"@

Write-Host $Banner

$InstallDir = Join-Path $HOME ".shuvoCodes"
$ThemesDir  = Join-Path $InstallDir "themes"
$ConfigFile = Join-Path $InstallDir "theme.txt"
$PromptFile = Join-Path $InstallDir "prompt.ps1"

# All 9 Built-in Theme Names
$ThemeNames = @(
    'Matrix',
    'Cyberpunk',
    'Dracula',
    'OneDarkPro',
    'Nord',
    'TokyoNight',
    'MinimalDark',
    'SolarizedDark',
    'RetroGreen'
)

Write-Host "  $CYAN[1/4]$RESET Creating shuvoCodes directories..."
if (-not (Test-Path $ThemesDir)) {
    New-Item -ItemType Directory -Path $ThemesDir -Force | Out-Null
}

# Determine if running locally from cloned repository or remotely via irm
$isLocal = $PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "prompt.ps1"))

if ($isLocal) {
    Write-Host "  $CYAN[2/4]$RESET Installing from local repository files..."
    Copy-Item -Path (Join-Path $PSScriptRoot "prompt.ps1") -Destination $PromptFile -Force

    $localThemes = Join-Path $PSScriptRoot "themes"
    if (Test-Path $localThemes) {
        Get-ChildItem -Path $localThemes -Filter "*.ps1" | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination (Join-Path $ThemesDir $_.Name) -Force
        }
    }
} else {
    Write-Host "  $CYAN[2/4]$RESET Downloading latest release from GitHub..."
    $baseUrl = "https://raw.githubusercontent.com/shuvoCodes/vscode-terminal-themes/main"

    try {
        Invoke-RestMethod -Uri "$baseUrl/prompt.ps1" -OutFile $PromptFile
        foreach ($theme in $ThemeNames) {
            $dest = Join-Path $ThemesDir "$theme.ps1"
            Invoke-RestMethod -Uri "$baseUrl/themes/$theme.ps1" -OutFile $dest
        }
    } catch {
        Write-Warning "Could not download themes from GitHub: $_"
        Write-Host "  $YELLOW[!] Falling back to built-in themes.$RESET"
    }
}

# Initialize default theme
if (-not (Test-Path $ConfigFile)) {
    Set-Content -Path $ConfigFile -Value $DefaultTheme -Force
}

Write-Host "  $CYAN[3/4]$RESET Configuring PowerShell Profile..."
try {
    $profilePath = $PROFILE
    if ($profilePath) {
        $profileDir = Split-Path -Parent $profilePath
        if (-not (Test-Path $profileDir)) {
            New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
        }
        if (-not (Test-Path $profilePath)) {
            New-Item -ItemType File -Path $profilePath -Force | Out-Null
        }

        $profileContent = Get-Content -Path $profilePath -Raw -ErrorAction SilentlyContinue
        if ($profileContent -notmatch '# shuvoCodes START') {
            $hook = @"

# shuvoCodes START
if (Test-Path "`$HOME\.shuvoCodes\prompt.ps1") {
    . "`$HOME\.shuvoCodes\prompt.ps1"
}
# shuvoCodes END
"@
            Add-Content -Path $profilePath -Value $hook
            Write-Host "  $GREEN[✔]$RESET Added shuvoCodes to `$PROFILE ($profilePath)"
        } else {
            Write-Host "  $GREEN[✔]$RESET shuvoCodes hook already configured in `$PROFILE"
        }
    }
} catch {
    Write-Warning "Could not update `$PROFILE automatically: $_"
    Write-Host "  $YELLOW[!] To complete setup, add this to your `$PROFILE manually:$RESET"
    Write-Host "      . `"$PromptFile`"" -ForegroundColor Gray
}

Write-Host "  $CYAN[4/4]$RESET Activating terminal themes..."
if (Test-Path $PromptFile) {
    . $PromptFile
}

Write-Host ""
Write-Host "  $GREEN$BOLD🎉 Installation complete! Your VS Code terminal looks awesome!$RESET"
Write-Host ""
Write-Host "  $BOLDQuick Start Commands:$RESET"
Write-Host "  $GRAY-------------------------------------------------------$RESET"
Write-Host "  $YELLOW  Set-TerminalTheme -Theme Cyberpunk$RESET  $GRAY# Switch theme$RESET"
Write-Host "  $YELLOW  Get-TerminalThemes                $RESET  $GRAY# List all 9 themes$RESET"
Write-Host "  $YELLOW  Show-ThemePreview -Theme Dracula  $RESET  $GRAY# Preview a theme$RESET"
Write-Host "  $YELLOW  Reset-TerminalTheme               $RESET  $GRAY# Restore default$RESET"
Write-Host "  $GRAY-------------------------------------------------------$RESET"
Write-Host ""
Write-Host "  $GRAYReload terminal anytime with: $YELLOW. `$PROFILE$RESET"
Write-Host ""

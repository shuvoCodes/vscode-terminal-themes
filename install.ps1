$DefaultTheme = 'Matrix'
# ==============================================================================
# shuvoCodes - VS Code Terminal Themes Installer
# Author: Shakhawat Hossain Shuvo (https://github.com/shakhawat-hossain-shuvo)
# Repository: https://github.com/shuvoCodes/vscode-terminal-themes
# ==============================================================================

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

$CHECK = [char]0x2714
$PARTY = [System.Char]::ConvertFromUtf32(0x1F389)

$Banner = @"
$CYAN
        __                     ______          __          
  _____/ /_  __  ___   _____  / ____/___  ____/ /__  _____ 
 / ___/ __ \/ / / / | / / _ \/ /   / __ \/ __  / _ \/ ___/ 
(__  ) / / / /_/ /| |/ / (_) / /___/ /_/ / /_/ /  __(__  )  
/____/_/ /_/\__,_/ |___/\___/\____/\____/\__,_/\___/____/   
$MAGENTA
           VS Code Terminal Themes - by shuvoCodes
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

Write-Host "  $CYAN`[1/4`]$RESET Creating shuvoCodes directories..."
if (-not (Test-Path $ThemesDir)) {
    New-Item -ItemType Directory -Path $ThemesDir -Force | Out-Null
}

# Determine if running locally from cloned repository or remotely via irm
$isLocal = $PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "prompt.ps1"))

if ($isLocal) {
    Write-Host "  $CYAN`[2/4`]$RESET Installing from local repository files..."
    Copy-Item -Path (Join-Path $PSScriptRoot "prompt.ps1") -Destination $PromptFile -Force
    if (Test-Path (Join-Path $PSScriptRoot "prompt.sh")) {
        Copy-Item -Path (Join-Path $PSScriptRoot "prompt.sh") -Destination (Join-Path $InstallDir "prompt.sh") -Force
    }

    $localThemes = Join-Path $PSScriptRoot "themes"
    if (Test-Path $localThemes) {
        Get-ChildItem -Path $localThemes -Filter "*.ps1" | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination (Join-Path $ThemesDir $_.Name) -Force
        }
    }
} else {
    Write-Host "  $CYAN`[2/4`]$RESET Downloading latest release from GitHub..."
    $baseUrl = "https://raw.githubusercontent.com/shuvoCodes/vscode-terminal-themes/main"

    try {
        Invoke-RestMethod -Uri "$baseUrl/prompt.ps1" -OutFile $PromptFile
        Invoke-RestMethod -Uri "$baseUrl/prompt.sh" -OutFile (Join-Path $InstallDir "prompt.sh") -ErrorAction SilentlyContinue
        foreach ($theme in $ThemeNames) {
            $dest = Join-Path $ThemesDir "$theme.ps1"
            Invoke-RestMethod -Uri "$baseUrl/themes/$theme.ps1" -OutFile $dest
        }
    } catch {
        Write-Warning "Could not download themes from GitHub: $_"
        Write-Host "  $YELLOW`[!`]$RESET Falling back to built-in themes."
    }
}

# Initialize default theme and branch indicator
if (-not (Test-Path $ConfigFile)) {
    Set-Content -Path $ConfigFile -Value $DefaultTheme -Force
}
$BranchConfigFile = Join-Path $InstallDir "branch.txt"
Set-Content -Path $BranchConfigFile -Value 'Status' -Force

Write-Host "  $CYAN`[3/4`]$RESET Configuring PowerShell & VS Code Profiles..."

# 1. Ensure execution policy allows loading user profile scripts
try {
    $currentPolicy = Get-ExecutionPolicy -ErrorAction SilentlyContinue
    if ($currentPolicy -in @('Restricted', 'Undefined')) {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue
        Write-Host "  $GREEN`[$CHECK`]$RESET Configured ExecutionPolicy to RemoteSigned (enables auto-load)"
    }
} catch {}

$hook = @"

# shuvoCodes START
if (Test-Path "`$HOME\.shuvoCodes\prompt.ps1") {
    . "`$HOME\.shuvoCodes\prompt.ps1"
}
# shuvoCodes END
"@

# 2. Gather all candidate profile paths across Windows PowerShell, PowerShell 7, and VS Code
$targetProfiles = @()

if ($PROFILE) {
    if ($PROFILE.CurrentUserCurrentHost -and (-not ($targetProfiles -contains $PROFILE.CurrentUserCurrentHost))) {
        $targetProfiles += $PROFILE.CurrentUserCurrentHost
    }
    if ($PROFILE.CurrentUserAllHosts -and (-not ($targetProfiles -contains $PROFILE.CurrentUserAllHosts))) {
        $targetProfiles += $PROFILE.CurrentUserAllHosts
    }
    if ($PROFILE -is [string] -and (-not ($targetProfiles -contains $PROFILE))) {
        $targetProfiles += $PROFILE
    }
}

$docRoots = @()
$myDocs = [Environment]::GetFolderPath('MyDocuments')
if ($myDocs -and (Test-Path $myDocs -ErrorAction SilentlyContinue)) { $docRoots += $myDocs }
$homeDocs = Join-Path $HOME "Documents"
if (Test-Path $homeDocs -ErrorAction SilentlyContinue) { $docRoots += $homeDocs }
$oneDriveDocs = Join-Path $HOME "OneDrive\Documents"
if (Test-Path $oneDriveDocs -ErrorAction SilentlyContinue) { $docRoots += $oneDriveDocs }

foreach ($docRoot in ($docRoots | Select-Object -Unique)) {
    foreach ($psDir in @('WindowsPowerShell', 'PowerShell')) {
        $fullPsDir = Join-Path $docRoot $psDir
        $candidates = @(
            (Join-Path $fullPsDir "profile.ps1"),
            (Join-Path $fullPsDir "Microsoft.PowerShell_profile.ps1"),
            (Join-Path $fullPsDir "Microsoft.VSCode_profile.ps1")
        )
        foreach ($cand in $candidates) {
            if (-not ($targetProfiles -contains $cand)) {
                $targetProfiles += $cand
            }
        }
    }
}

# 3. Inject hook into all profile files
$configuredCount = 0
foreach ($pPath in $targetProfiles) {
    try {
        $pDir = Split-Path -Parent $pPath
        if (-not (Test-Path $pDir -ErrorAction SilentlyContinue)) {
            New-Item -ItemType Directory -Path $pDir -Force -ErrorAction SilentlyContinue | Out-Null
        }
        if (-not (Test-Path $pPath -ErrorAction SilentlyContinue)) {
            New-Item -ItemType File -Path $pPath -Force -ErrorAction SilentlyContinue | Out-Null
        }
        $existing = Get-Content -Path $pPath -Raw -ErrorAction SilentlyContinue
        if ($existing -notmatch '# shuvoCodes START') {
            Add-Content -Path $pPath -Value $hook -ErrorAction SilentlyContinue
            $configuredCount++
        }
    } catch {}
}

if ($configuredCount -gt 0) {
    Write-Host "  $GREEN`[$CHECK`]$RESET Added shuvoCodes hook to $configuredCount PowerShell / VS Code profile(s)"
} else {
    Write-Host "  $GREEN`[$CHECK`]$RESET shuvoCodes hook is active in all PowerShell / VS Code profiles"
}

# 4. Also configure Git Bash profiles (~/.bashrc, ~/.bash_profile)
$bashHook = @"

# shuvoCodes START
if [ -f "`$HOME/.shuvoCodes/prompt.sh" ]; then
    source "`$HOME/.shuvoCodes/prompt.sh"
fi
# shuvoCodes END
"@

foreach ($bProfile in @((Join-Path $HOME ".bashrc"), (Join-Path $HOME ".bash_profile"))) {
    try {
        if (-not (Test-Path $bProfile -ErrorAction SilentlyContinue) -and ($bProfile -match '\.bashrc$')) {
            New-Item -ItemType File -Path $bProfile -Force -ErrorAction SilentlyContinue | Out-Null
        }
        if (Test-Path $bProfile -ErrorAction SilentlyContinue) {
            $bExisting = Get-Content -Path $bProfile -Raw -ErrorAction SilentlyContinue
            if ($bExisting -notmatch '# shuvoCodes START') {
                Add-Content -Path $bProfile -Value $bashHook -ErrorAction SilentlyContinue
                Write-Host "  $GREEN`[$CHECK`]$RESET Added shuvoCodes hook to Git Bash ($bProfile)"
            }
        }
    } catch {}
}

Write-Host "  $CYAN`[4/4`]$RESET Activating terminal themes..."
if (Test-Path $PromptFile) {
    . $PromptFile
}

Write-Host ""
Write-Host "  $GREEN$BOLD$PARTY Installation complete! Your VS Code terminal looks awesome!$RESET"
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

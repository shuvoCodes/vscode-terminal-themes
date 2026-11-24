#!/usr/bin/env bash
# ==============================================================================
# shuvoCodes - VS Code Terminal Themes Installer for Git Bash
# Author: Shakhawat Hossain Shuvo (https://github.com/shakhawat-hossain-shuvo)
# Repository: https://github.com/shuvoCodes/vscode-terminal-themes
# ==============================================================================

# Ensure UTF-8 locale
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

CYAN="\033[1;36m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
MAGENTA="\033[1;35m"
GRAY="\033[90m"
BOLD="\033[1m"
RESET="\033[0m"

printf "%b\n" "$CYAN"
cat << "EOF"
        __                     ______          __          
  _____/ /_  __  ___   _____  / ____/___  ____/ /__  _____ 
 / ___/ __ \/ / / / | / / _ \/ /   / __ \/ __  / _ \/ ___/ 
(__  ) / / / /_/ /| |/ / (_) / /___/ /_/ / /_/ /  __(__  )  
/____/_/ /_/\__,_/ |___/\___/\____/\____/\__,_/\___/____/   
EOF
printf "%b           VS Code Terminal Themes - by shuvoCodes%b\n\n" "$MAGENTA" "$RESET"

INSTALL_DIR="$HOME/.shuvoCodes"
CONFIG_FILE="$INSTALL_DIR/theme.txt"
ARROW_FILE="$INSTALL_DIR/arrow.txt"
BRANCH_FILE="$INSTALL_DIR/branch.txt"
PROMPT_SH="$INSTALL_DIR/prompt.sh"

printf "  %b[1/4]%b Creating shuvoCodes directories...\n" "$CYAN" "$RESET"
mkdir -p "$INSTALL_DIR"

# Clean stale Oh My Bash lock if present (fixes git bash lock warning)
[ -f "$HOME/.oh-my-bash/log/update.lock" ] && rm -f "$HOME/.oh-my-bash/log/update.lock" 2>/dev/null

# Determine if running locally or remotely
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
IS_LOCAL=0
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/prompt.sh" ]; then
    IS_LOCAL=1
fi

if [ "$IS_LOCAL" -eq 1 ]; then
    printf "  %b[2/4]%b Installing from local repository files...\n" "$CYAN" "$RESET"
    cp -f "$SCRIPT_DIR/prompt.sh" "$PROMPT_SH" 2>/dev/null
    [ -f "$SCRIPT_DIR/prompt.ps1" ] && cp -f "$SCRIPT_DIR/prompt.ps1" "$INSTALL_DIR/prompt.ps1" 2>/dev/null
else
    printf "  %b[2/4]%b Downloading latest release from GitHub...\n" "$CYAN" "$RESET"
    BASE_URL="https://raw.githubusercontent.com/shuvoCodes/vscode-terminal-themes/main"
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$BASE_URL/prompt.sh" -o "$PROMPT_SH" 2>/dev/null
        curl -fsSL "$BASE_URL/prompt.ps1" -o "$INSTALL_DIR/prompt.ps1" 2>/dev/null
    elif command -v wget >/dev/null 2>&1; then
        wget -qO "$PROMPT_SH" "$BASE_URL/prompt.sh" 2>/dev/null
        wget -qO "$INSTALL_DIR/prompt.ps1" "$BASE_URL/prompt.ps1" 2>/dev/null
    fi
fi

# Initialize defaults
[ ! -f "$CONFIG_FILE" ] && echo "Matrix" > "$CONFIG_FILE"
[ ! -f "$ARROW_FILE" ] && echo "Pointer" > "$ARROW_FILE"
echo "Status" > "$BRANCH_FILE"

printf "  %b[3/4]%b Configuring Git Bash Profiles (.bashrc)...\n" "$CYAN" "$RESET"

HOOK='
# shuvoCodes START
if [ -f "$HOME/.shuvoCodes/prompt.sh" ]; then
    source "$HOME/.shuvoCodes/prompt.sh"
fi
# shuvoCodes END'

for profile in "$HOME/.bashrc" "$HOME/.bash_profile"; do
    if [ -f "$profile" ] || [ "$profile" = "$HOME/.bashrc" ]; then
        touch "$profile"
        if ! grep -q "shuvoCodes START" "$profile" 2>/dev/null; then
            printf "%s\n" "$HOOK" >> "$profile"
            printf "  %b[✔]%b Added shuvoCodes to %s\n" "$GREEN" "$RESET" "$profile"
        else
            printf "  %b[✔]%b shuvoCodes hook already configured in %s\n" "$GREEN" "$RESET" "$profile"
        fi
    fi
done

printf "  %b[4/4]%b Activating terminal theme in current session...\n" "$CYAN" "$RESET"
if [ -f "$PROMPT_SH" ]; then
    # shellcheck disable=SC1090
    source "$PROMPT_SH"
fi

printf "\n  %b🎉 Installation complete! Your Git Bash terminal looks awesome!%b\n\n" "${GREEN}${BOLD}" "$RESET"
printf "  %bQuick Start Commands:%b\n" "$BOLD" "$RESET"
printf "  %b-------------------------------------------------------%b\n" "$GRAY" "$RESET"
printf "  %b  Set-TerminalTheme Cyberpunk%b  %b# Switch theme%b\n" "$YELLOW" "$RESET" "$GRAY" "$RESET"
printf "  %b  Get-TerminalThemes         %b  %b# List all 9 themes%b\n" "$YELLOW" "$RESET" "$GRAY" "$RESET"
printf "  %b  Show-ThemePreview Dracula  %b  %b# Preview a theme%b\n" "$YELLOW" "$RESET" "$GRAY" "$RESET"
printf "  %b  Reset-TerminalTheme        %b  %b# Restore default%b\n" "$YELLOW" "$RESET" "$GRAY" "$RESET"
printf "  %b-------------------------------------------------------%b\n\n" "$GRAY" "$RESET"
printf "  %bReload terminal anytime with: %bsource ~/.bashrc%b\n\n" "$GRAY" "$YELLOW" "$RESET"

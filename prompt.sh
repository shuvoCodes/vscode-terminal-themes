#!/usr/bin/env bash
# ==============================================================================
# shuvoCodes - VS Code Terminal Themes for Git Bash
# Author: Shakhawat Hossain Shuvo (https://github.com/shakhawat-hossain-shuvo)
# Repository: https://github.com/shuvoCodes/vscode-terminal-themes
# ==============================================================================

# Ensure UTF-8 locale
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

# Paths
SHUVO_CONFIG_DIR="$HOME/.shuvoCodes"
SHUVO_THEME_FILE="$SHUVO_CONFIG_DIR/theme.txt"
SHUVO_ARROW_FILE="$SHUVO_CONFIG_DIR/arrow.txt"
SHUVO_BRANCH_FILE="$SHUVO_CONFIG_DIR/branch.txt"

# Helper to convert Hex (#RRGGBB) to PS1-wrapped ANSI 24-bit TrueColor
shuvo_hex_to_ps1() {
    local hex="${1#\#}"
    if [ ${#hex} -ne 6 ]; then
        printf "\[\033[0m\]"
        return
    fi
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    printf "\[\033[38;2;%d;%d;%dm\]" "$r" "$g" "$b"
}

# Helper to convert Hex (#RRGGBB) to raw ANSI for Write-Host/echo
shuvo_hex_to_ansi() {
    local hex="${1#\#}"
    if [ ${#hex} -ne 6 ]; then
        printf "\033[0m"
        return
    fi
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    printf "\033[38;2;%d;%d;%dm" "$r" "$g" "$b"
}

# Theme Definitions
shuvo_load_theme_colors() {
    local query="${1:-Matrix}"
    local lower_query
    lower_query="$(echo "$query" | tr '[:upper:]' '[:lower:]')"

    case "$lower_query" in
        cyberpunk)
            THEME_NAME="Cyberpunk"
            THEME_COLORS="Cyan on Dark"
            THEME_VIBE="Futuristic Neon"
            HEX_ACCENT="#00F0FF"
            HEX_FRAME="#00F0FF"
            HEX_BRACKET="#00F0FF"
            HEX_SEP="#00F0FF"
            HEX_USER="#00F0FF"
            HEX_PATH="#FF0055"
            HEX_VENV="#FFE600"
            HEX_BRANCH="#52EBF9"
            HEX_CLEAN="#00F0FF"
            HEX_DIRTY="#FF0055"
            HEX_CURSOR="#00F0FF"
            ;;
        dracula)
            THEME_NAME="Dracula"
            THEME_COLORS="Magenta & Purple"
            THEME_VIBE="Gothic Dark"
            HEX_ACCENT="#FF79C6"
            HEX_FRAME="#FF79C6"
            HEX_BRACKET="#FF79C6"
            HEX_SEP="#6272A4"
            HEX_USER="#8BE9FD"
            HEX_PATH="#BD93F9"
            HEX_VENV="#F1FA8C"
            HEX_BRANCH="#F8F8F2"
            HEX_CLEAN="#FF79C6"
            HEX_DIRTY="#FF5555"
            HEX_CURSOR="#FF79C6"
            ;;
        onedarkpro)
            THEME_NAME="OneDarkPro"
            THEME_COLORS="Yellow & Orange"
            THEME_VIBE="Warm Dark"
            HEX_ACCENT="#E5C07B"
            HEX_FRAME="#E5C07B"
            HEX_BRACKET="#E5C07B"
            HEX_SEP="#5C6370"
            HEX_USER="#61AFEF"
            HEX_PATH="#98C379"
            HEX_VENV="#E5C07B"
            HEX_BRANCH="#ABB2BF"
            HEX_CLEAN="#E5C07B"
            HEX_DIRTY="#E06C75"
            HEX_CURSOR="#E5C07B"
            ;;
        nord)
            THEME_NAME="Nord"
            THEME_COLORS="Blue & White"
            THEME_VIBE="Arctic Minimal"
            HEX_ACCENT="#88C0D0"
            HEX_FRAME="#88C0D0"
            HEX_BRACKET="#88C0D0"
            HEX_SEP="#4C566A"
            HEX_USER="#81A1C1"
            HEX_PATH="#D8DEE9"
            HEX_VENV="#EBCB8B"
            HEX_BRANCH="#ECEFF4"
            HEX_CLEAN="#88C0D0"
            HEX_DIRTY="#BF616A"
            HEX_CURSOR="#88C0D0"
            ;;
        tokyonight)
            THEME_NAME="TokyoNight"
            THEME_COLORS="Purple & Pink"
            THEME_VIBE="Synthwave City"
            HEX_ACCENT="#BB9AF7"
            HEX_FRAME="#BB9AF7"
            HEX_BRACKET="#BB9AF7"
            HEX_SEP="#565F89"
            HEX_USER="#7AA2F7"
            HEX_PATH="#7DCFFF"
            HEX_VENV="#E0AF68"
            HEX_BRANCH="#C0CAF5"
            HEX_CLEAN="#BB9AF7"
            HEX_DIRTY="#F7768E"
            HEX_CURSOR="#BB9AF7"
            ;;
        minimaldark)
            THEME_NAME="MinimalDark"
            THEME_COLORS="White on Black"
            THEME_VIBE="Clean & Simple"
            HEX_ACCENT="#FFFFFF"
            HEX_FRAME="#FFFFFF"
            HEX_BRACKET="#FFFFFF"
            HEX_SEP="#4B5563"
            HEX_USER="#9CA3AF"
            HEX_PATH="#E5E7EB"
            HEX_VENV="#FACC15"
            HEX_BRANCH="#FFFFFF"
            HEX_CLEAN="#FFFFFF"
            HEX_DIRTY="#EF4444"
            HEX_CURSOR="#E5E7EB"
            ;;
        solarizeddark)
            THEME_NAME="SolarizedDark"
            THEME_COLORS="Teal & Green"
            THEME_VIBE="Retro Warm"
            HEX_ACCENT="#2AA198"
            HEX_FRAME="#2AA198"
            HEX_BRACKET="#2AA198"
            HEX_SEP="#586E75"
            HEX_USER="#268BD2"
            HEX_PATH="#839496"
            HEX_VENV="#B58900"
            HEX_BRANCH="#93A1A1"
            HEX_CLEAN="#2AA198"
            HEX_DIRTY="#DC322F"
            HEX_CURSOR="#2AA198"
            ;;
        retrogreen)
            THEME_NAME="RetroGreen"
            THEME_COLORS="Bright Green"
            THEME_VIBE="Old-school CRT"
            HEX_ACCENT="#00FF00"
            HEX_FRAME="#00FF00"
            HEX_BRACKET="#00FF00"
            HEX_SEP="#008800"
            HEX_USER="#33FF33"
            HEX_PATH="#00FF00"
            HEX_VENV="#FFFF00"
            HEX_BRANCH="#00FF00"
            HEX_CLEAN="#00FF00"
            HEX_DIRTY="#FF2200"
            HEX_CURSOR="#00FF00"
            ;;
        matrix|*)
            THEME_NAME="Matrix"
            THEME_COLORS="Green on Black"
            THEME_VIBE="Hacker / Classic"
            HEX_ACCENT="#00FF41"
            HEX_FRAME="#00FF41"
            HEX_BRACKET="#00FF41"
            HEX_SEP="#00FF41"
            HEX_USER="#53FEA7"
            HEX_PATH="#FFFFFF"
            HEX_VENV="#FFFF00"
            HEX_BRANCH="#53FEA7"
            HEX_CLEAN="#00FF41"
            HEX_DIRTY="#FF3333"
            HEX_CURSOR="#00FF41"
            ;;
    esac

    # Cache PS1-wrapped colors
    C_RST="\[\033[0m\]"
    C_FRAME="$(shuvo_hex_to_ps1 "$HEX_FRAME")"
    C_BRK="$(shuvo_hex_to_ps1 "$HEX_BRACKET")"
    C_SEP="$(shuvo_hex_to_ps1 "$HEX_SEP")"
    C_USER="$(shuvo_hex_to_ps1 "$HEX_USER")"
    C_PATH="$(shuvo_hex_to_ps1 "$HEX_PATH")"
    C_VENV="$(shuvo_hex_to_ps1 "$HEX_VENV")"
    C_BRANCH="$(shuvo_hex_to_ps1 "$HEX_BRANCH")"
    C_CLEAN="$(shuvo_hex_to_ps1 "$HEX_CLEAN")"
    C_DIRTY="$(shuvo_hex_to_ps1 "$HEX_DIRTY")"
}

# Main Prompt Builder function for PROMPT_COMMAND
shuvo_build_prompt() {
    # 1. Load active settings from file if available
    local active_theme="Matrix"
    [ -f "$SHUVO_THEME_FILE" ] && active_theme="$(cat "$SHUVO_THEME_FILE" 2>/dev/null | tr -d '\r\n')"
    [ -z "$active_theme" ] && active_theme="Matrix"

    local active_arrow="Pointer"
    [ -f "$SHUVO_ARROW_FILE" ] && active_arrow="$(cat "$SHUVO_ARROW_FILE" 2>/dev/null | tr -d '\r\n')"
    [ -z "$active_arrow" ] && active_arrow="Pointer"

    local active_branch="Status"
    [ -f "$SHUVO_BRANCH_FILE" ] && active_branch="$(cat "$SHUVO_BRANCH_FILE" 2>/dev/null | tr -d '\r\n')"
    [ -z "$active_branch" ] && active_branch="Status"

    # Reload theme colors
    shuvo_load_theme_colors "$active_theme"

    # 2. User & Machine
    local u="${USER:-$(whoami 2>/dev/null)}"
    local h="${HOSTNAME:-$(hostname 2>/dev/null)}"
    local user_host="${u}@${h}"

    # 3. Current Folder
    local folder="${PWD##*/}"
    [ -z "$folder" ] && folder="/"

    # 4. Python Virtual Environment
    local venv_part=""
    if [ -n "$VIRTUAL_ENV" ]; then
        local venv_name="${VIRTUAL_ENV##*/}"
        venv_part="${C_SEP}-${C_BRK}[ ${C_VENV}(${venv_name}) ${C_BRK}]"
    elif [ -n "$CONDA_DEFAULT_ENV" ]; then
        venv_part="${C_SEP}-${C_BRK}[ ${C_VENV}(${CONDA_DEFAULT_ENV}) ${C_BRK}]"
    fi

    # 5. Git Branch & Status
    local git_part=""
    local is_dirty=0

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch
        branch="$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo "detached")"
        
        local status_out
        status_out="$(git status --porcelain -b 2>/dev/null)"
        local line_count
        line_count="$(printf "%s\n" "$status_out" | grep -v '^$' | wc -l)"
        local header
        header="$(printf "%s\n" "$status_out" | head -n 1)"

        if [ "$line_count" -gt 1 ] || echo "$header" | grep -q '\[ahead'; then
            is_dirty=1
        fi

        local b_icon=""
        local b_icon_color="$C_BRANCH"
        local lower_branch
        lower_branch="$(echo "$active_branch" | tr '[:upper:]' '[:lower:]')"

        case "$lower_branch" in
            leaf)
                b_icon="🌿"
                b_icon_color="$C_BRANCH"
                ;;
            symbol)
                b_icon="⎇"
                b_icon_color="$C_BRANCH"
                ;;
            nerdfont)
                b_icon="$(printf '\uf418')"
                b_icon_color="$C_BRANCH"
                ;;
            none)
                b_icon=""
                b_icon_color="$C_BRANCH"
                ;;
            status|*)
                if [ "$is_dirty" -eq 1 ]; then
                    b_icon="✗"
                    b_icon_color="$C_DIRTY"
                else
                    b_icon="✔"
                    b_icon_color="$C_CLEAN"
                fi
                ;;
        esac

        local spacer=""
        [ -n "$b_icon" ] && spacer=" "
        git_part="${C_SEP}-${C_BRK}[ ${b_icon_color}${b_icon}${spacer}${C_BRANCH}${branch} ${C_BRK}]"
    fi

    # 6. Bottom Line Arrow
    local arrow_color="$C_CLEAN"
    [ "$is_dirty" -eq 1 ] && arrow_color="$C_DIRTY"

    local arrow_sym="►"
    local lower_arrow
    lower_arrow="$(echo "$active_arrow" | tr '[:upper:]' '[:lower:]')"
    case "$lower_arrow" in
        angle)    arrow_sym="❯" ;;
        triangle) arrow_sym="▸" ;;
        greater)  arrow_sym=">" ;;
        arrow)    arrow_sym="→" ;;
        pointer|*) arrow_sym="►" ;;
    esac

    # 7. Construct 2-line PS1
    PS1="${C_RST}${C_FRAME}┌─${C_BRK}[${C_USER}${user_host}${C_BRK}]${C_SEP}-${C_BRK}[ ${C_PATH}${folder} ${C_BRK}]${venv_part}${git_part}\n${C_RST}${C_FRAME}└─${arrow_color}${arrow_sym} ${C_RST}"
}

# Apply PROMPT_COMMAND
PROMPT_COMMAND="shuvo_build_prompt"

# ==============================================================================
# USER COMMANDS
# ==============================================================================

# 1. Switch Theme
Set-TerminalTheme() {
    local theme=""
    local arrow=""
    local branch=""

    while [ $# -gt 0 ]; do
        case "$1" in
            -Theme|-theme)
                theme="$2"
                shift 2
                ;;
            -ArrowStyle|-arrowstyle)
                arrow="$2"
                shift 2
                ;;
            -BranchIcon|-branchicon)
                branch="$2"
                shift 2
                ;;
            *)
                if [ -z "$theme" ]; then
                    theme="$1"
                fi
                shift
                ;;
        esac
    done

    mkdir -p "$SHUVO_CONFIG_DIR" 2>/dev/null

    if [ -n "$branch" ]; then
        echo "$branch" > "$SHUVO_BRANCH_FILE"
        printf "\n  \033[1;32m✔ Branch icon set to: %s\033[0m\n" "$branch"
    fi

    if [ -n "$arrow" ]; then
        echo "$arrow" > "$SHUVO_ARROW_FILE"
        printf "\n  \033[1;32m✔ Arrow style set to: %s\033[0m\n" "$arrow"
    fi

    if [ -n "$theme" ]; then
        shuvo_load_theme_colors "$theme"
        echo "$THEME_NAME" > "$SHUVO_THEME_FILE"
        local accent_color
        accent_color="$(shuvo_hex_to_ansi "$HEX_ACCENT")"
        printf "\n  \033[1m%s✔ Theme switched to: %s\033[0m\n" "$accent_color" "$THEME_NAME"
        printf "  \033[90m Colors: %s  |  Vibe: %s\033[0m\n\n" "$THEME_COLORS" "$THEME_VIBE"
    elif [ -z "$arrow" ] && [ -z "$branch" ]; then
        printf "\n\033[1;33mPlease specify a theme name. Example: Set-TerminalTheme Cyberpunk\033[0m\n\n"
        Get-TerminalThemes
    fi
}
set-terminal-theme() { Set-TerminalTheme "$@"; }
set-theme() { Set-TerminalTheme "$@"; }

# 2. List All Themes
Get-TerminalThemes() {
    local active_theme="Matrix"
    [ -f "$SHUVO_THEME_FILE" ] && active_theme="$(cat "$SHUVO_THEME_FILE" 2>/dev/null | tr -d '\r\n')"
    [ -z "$active_theme" ] && active_theme="Matrix"

    local themes=("Matrix" "Cyberpunk" "Dracula" "OneDarkPro" "Nord" "TokyoNight" "MinimalDark" "SolarizedDark" "RetroGreen")

    printf "\n  \033[1;36m🎨 shuvoCodes - Available Themes\033[0m\n"
    printf "  \033[90m-----------------------------------------------------------------\033[0m\n"
    printf "  \033[1m STATUS   THEME             COLORS                VIBE\033[0m\n"
    printf "  \033[90m-----------------------------------------------------------------\033[0m\n"

    for t in "${themes[@]}"; do
        shuvo_load_theme_colors "$t"
        local status_mark="      "
        local active_badge=""
        if [ "$(echo "$t" | tr '[:upper:]' '[:lower:]')" = "$(echo "$active_theme" | tr '[:upper:]' '[:lower:]')" ]; then
            status_mark="\033[1;32m   ✔  \033[0m"
            active_badge=" \033[1;32m[active]\033[0m"
        fi
        local acc
        acc="$(shuvo_hex_to_ansi "$HEX_ACCENT")"
        printf "%b %b%-16s\033[0m %-22s \033[90m%s\033[0m%b\n" "$status_mark" "$acc" "$THEME_NAME" "$THEME_COLORS" "$THEME_VIBE" "$active_badge"
    done

    printf "  \033[90m-----------------------------------------------------------------\033[0m\n"
    printf "  \033[90m Change theme with:  \033[1;33mSet-TerminalTheme <ThemeName>\033[0m\n"
    printf "  \033[90m Preview theme with: \033[1;33mShow-ThemePreview <ThemeName>\033[0m\n\n"
}
get-terminal-themes() { Get-TerminalThemes "$@"; }
get-themes() { Get-TerminalThemes "$@"; }

# 3. Preview Theme
Show-ThemePreview() {
    local target="$1"
    local themes=()

    if [ -n "$target" ]; then
        themes=("$target")
    else
        themes=("Matrix" "Cyberpunk" "Dracula" "OneDarkPro" "Nord" "TokyoNight" "MinimalDark" "SolarizedDark" "RetroGreen")
    fi

    for t in "${themes[@]}"; do
        shuvo_load_theme_colors "$t"
        local acc
        acc="$(shuvo_hex_to_ansi "$HEX_ACCENT")"
        local frm
        frm="$(shuvo_hex_to_ansi "$HEX_FRAME")"
        local brk
        brk="$(shuvo_hex_to_ansi "$HEX_BRACKET")"
        local sep
        sep="$(shuvo_hex_to_ansi "$HEX_SEP")"
        local usr
        usr="$(shuvo_hex_to_ansi "$HEX_USER")"
        local pth
        pth="$(shuvo_hex_to_ansi "$HEX_PATH")"
        local vnv
        vnv="$(shuvo_hex_to_ansi "$HEX_VENV")"
        local brn
        brn="$(shuvo_hex_to_ansi "$HEX_BRANCH")"
        local cln
        cln="$(shuvo_hex_to_ansi "$HEX_CLEAN")"
        local drt
        drt="$(shuvo_hex_to_ansi "$HEX_DIRTY")"
        local cur
        cur="$(shuvo_hex_to_ansi "$HEX_CURSOR")"

        printf "\n  %s● %s Style\033[0m  \033[90m(%s - %s)\033[0m\n" "$acc" "$THEME_NAME" "$THEME_COLORS" "$THEME_VIBE"
        printf "  %s┌─%s[%sshuvoCodes@Windows%s]%s-%s[ %smy-project %s]%s-%s[ %s(.venv) %s]%s-%s[ %s✔ %smain %s]\033[0m\n" \
            "$frm" "$brk" "$usr" "$brk" "$sep" "$brk" "$pth" "$brk" "$sep" "$brk" "$vnv" "$brk" "$sep" "$brk" "$cln" "$brn" "$brk"
        printf "  %s└─%s► %s█\033[0m  \033[90m(clean / uploaded)\033[0m\n" "$frm" "$cln" "$cur"
        printf "  %s┌─%s[%sshuvoCodes@Windows%s]%s-%s[ %smy-project %s]%s-%s[ %s(.venv) %s]%s-%s[ %s✗ %smain %s]\033[0m\n" \
            "$frm" "$brk" "$usr" "$brk" "$sep" "$brk" "$pth" "$brk" "$sep" "$brk" "$vnv" "$brk" "$sep" "$brk" "$drt" "$brn" "$brk"
        printf "  %s└─%s► %s█\033[0m  \033[90m(uncommitted / not uploaded)\033[0m\n" "$frm" "$drt" "$cur"
    done
    printf "\n"
}
show-theme-preview() { Show-ThemePreview "$@"; }
show-preview() { Show-ThemePreview "$@"; }

# 4. Reset Theme
Reset-TerminalTheme() {
    PROMPT_COMMAND=""
    PS1='\u@\h \w\$ '
    printf "\n  \033[1;32m[✔] Restored default Bash prompt for current session.\033[0m\n"
    printf "      \033[90mRun: source ~/.bashrc to reload your saved theme.\033[0m\n\n"
}
reset-terminal-theme() { Reset-TerminalTheme "$@"; }
reset-theme() { Reset-TerminalTheme "$@"; }

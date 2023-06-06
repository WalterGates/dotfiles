if status --is-login
    # Add to the PATH
    fish_add_path $HOME/.local/bin/ $HOME/.cargo/bin
end

fish_vi_key_bindings
starship init fish | source
# enable_transience   # TODO: I would like this if it inserted a blank like after each shortened prompt.

# Source private environment variables. These are not publicly synced
source ~/.config/fish/private.fish

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Set custom colors
set fish_color_quote CE9178

# Set a default version for node/npm
set -U nvm_default_version v20.2.0

# Set manpage colors
set -gx LESS_TERMCAP_mb "$(tput bold; tput setaf 4)"
set -gx LESS_TERMCAP_md "$(tput bold; tput setaf 4)"
set -gx LESS_TERMCAP_so "$(tput bold; tput setaf 2)"
set -gx LESS_TERMCAP_se "$(tput sgr0)"
set -gx LESS_TERMCAP_ue "$(tput sgr0)"
set -gx LESS_TERMCAP_us "$(tput bold; tput smul; tput sitm; tput setaf 6)"
set -gx LESS_TERMCAP_me "$(tput sgr0)"

# Set environment variables
set -gx EDITOR lvim
set -gx VISUAL lvim
set -gx GTK_USE_PORTAL 1
set -gx CLANGD_FLAGS "--completion-style=detailed --header-insertion=never --function-arg-placeholders=true"

# TODO: Set your own api key for ChatGPT
# set -gx OPENAI_API_KEY "private key"

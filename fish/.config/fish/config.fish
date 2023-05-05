if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings
starship init fish | source

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block
set -gx EDITOR nvim


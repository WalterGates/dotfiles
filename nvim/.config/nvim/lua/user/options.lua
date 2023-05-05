-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    -- set to true or false etc.
    relativenumber = false, -- sets vim.opt.relativenumber
    number = true,          -- sets vim.opt.number
    spell = false,          -- sets vim.opt.spell
    signcolumn = "auto",    -- sets vim.opt.signcolumn to auto
    wrap = true,            -- sets vim.opt.wrap
    linebreak = true,
    shiftwidth = 4,
    tabstop = 4,
  },
  g = {
    mapleader = " ",                 -- sets vim.g.mapleader
    autoformat_enabled = false,      -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true,              -- enable completion at start
    autopairs_enabled = true,        -- enable autopairs at start
    diagnostics_mode = 3,            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements

    neovide_fullscreen = false,
    neovide_hide_mouse_when_typing = true,
    neovide_scroll_animation_length = 0.3,
    neovide_cursor_animation_length = 0.1,
    neovide_cursor_trail_size = 0.5,
    neovide_refresh_rate_idle = 60,
    neovide_remember_window_size = true,

    terminal_color_0 = "#0d0d0d",
    terminal_color_1 = "#FF301B",
    terminal_color_2 = "#80E521",
    terminal_color_3 = "#FFC620",
    terminal_color_4 = "#1BA6FA",
    terminal_color_5 = "#8763B8",
    terminal_color_6 = "#21DEEF",
    terminal_color_7 = "#EBEBEB",

    terminal_color_8 = "#6D7070",
    terminal_color_9 = "#FF4352",
    terminal_color_10 = "#98E466",
    terminal_color_11 = "#FFD750",
    terminal_color_12 = "#1BA6FA",
    terminal_color_13 = "#A578EA",
    terminal_color_14 = "#73FBF1",
    terminal_color_15 = "#FEFEF8",
  },
  o = {
    guifont = "CaskaydiaCove Nerd Font:h13",
    termguicolors = true,
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end

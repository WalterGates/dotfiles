--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

lvim.builtin.dap.active = true
local dap = require("dap")
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "/home/raul/.local/share/nvim/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "darkplus"
-- lvim.colorscheme = "dracula"
lvim.transparent_window = false
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Set neovide options
vim.g.neovide_fullscreen = false
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_scroll_animation_length = 0.3
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_refresh_rate_idle = 60
vim.g.neovide_remember_window_size = true

-- vim.o.guifont = "minecraft enchantment"
vim.o.guifont = "CaskaydiaCove Nerd Font:h13"
vim.o.termguicolors = true

-- Set terminal colors for neovide
local set_term_colors = function()
	vim.g.terminal_color_0 = "#0d0d0d"
	vim.g.terminal_color_1 = "#FF301B"
	vim.g.terminal_color_2 = "#80E521"
	vim.g.terminal_color_3 = "#FFC620"
	vim.g.terminal_color_4 = "#1BA6FA"
	vim.g.terminal_color_5 = "#8763B8"
	vim.g.terminal_color_6 = "#21DEEF"
	vim.g.terminal_color_7 = "#EBEBEB"

	vim.g.terminal_color_8 = "#6D7070"
	vim.g.terminal_color_9 = "#FF4352"
	vim.g.terminal_color_10 = "#98E466"
	vim.g.terminal_color_11 = "#FFD750"
	vim.g.terminal_color_12 = "#1BA6FA"
	vim.g.terminal_color_13 = "#A578EA"
	vim.g.terminal_color_14 = "#73FBF1"
	vim.g.terminal_color_15 = "#FEFEF8"
end

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["x"] = '"_x'
lvim.keys.normal_mode["dd"] = '"_dd'
lvim.keys.normal_mode["`"] = function() print("Hello") end
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- overrie a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
lvim.keys.normal_mode["<S-u>"] = ":redo<CR>"
lvim.keys.normal_mode["<C-r>"] = nil
-- vim.keymap.del('n', '<C-r>')
lvim.keys.normal_mode["<F11>"] = function()
	vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	},
}
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.current_line_blame_opts.delay = 50
lvim.builtin.gitsigns.opts.current_line_blame_formatter_opts.relative_time = true
lvim.builtin.indentlines.options = {
	char = "┆",
	use_treesitter = false,
	show_current_context = true,
	show_current_context_start = false,
	show_trailing_blankline_indent = false,
}
-- lvim.builtin.gitsigns.opts.signs = {
-- 	add          = { text = '│' },
-- 	change       = { text = '│' },
-- 	delete       = { text = '_' },
-- 	topdelete    = { text = '‾' },
-- 	changedelete = { text = '~' },
-- 	untracked    = { text = '┆' },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope find_files<CR>", "Find file" }
lvim.builtin.which_key.mappings["f"] = nil
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
lvim.builtin.which_key.mappings["w"] = {
	name = "+Save",
	w = { ":w!<CR>", "Save current file" },
	a = { ":wa!<CR>", "Save all files" },
	s = { ":w !sudo tee >/dev/null %:p:S<CR><CR>", "Save current file with sudo" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

vim.o.timeoutlen = 300

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"cpp",
	"cmake",
	"rust",
	"java",
	"lua",
	"python",
	"css",
	"html",
	"javascript",
	"tsx",
	"typescript",
	"yaml",
	"json",
	"vim",
	"markdown",
	"markdown_inline",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow = {
	enable = true,
	-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
	extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	max_file_lines = nil, -- Do not enable for files with more than n lines, int
	colors = { "#FF79C6", "#A4FFFF", "#50fa7b", "#FFFFA5", "#FF92DF", "#5e81ac", "#b48ead" }, -- table of hex strings
}
lvim.builtin.cmp.experimental.ghost_text = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{ "lunarvim/darkplus.nvim" },
	-- { "Mofiqul/dracula.nvim" },
	{
		"Mofiqul/dracula.nvim",
		require("dracula").setup({
			italic_comment = true,
		}),
	},
	--[[ {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup {
        -- select_signature_key = '<M-n>',
      }
    end,
  }, ]]
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				-- mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
				mappings = { "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil, -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
			require("neoscroll.config").set_mappings({
				["<PageUp>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } },
				["<PageDown>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } },
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			-- require("colorizer").setup({ "css", "scss", "html", "javascript", "toml" }, {
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{
		"m00qek/baleia.nvim",
	},
}

set_term_colors()

local baleia = require("baleia").setup({})
vim.api.nvim_create_user_command("BaleiaColorize", function()
	baleia.once(vim.fn.bufnr(vim.fn.expand("%")))
end, {})

vim.api.nvim_create_user_command("CargoCheck", function()
	-- vim.api.nvim_command('vnew | :read !cargo --color=always check')
	-- vim.api.nvim_command('0d_')
	-- vim.api.nvim_command('BaleiaColorize')
	vim.api.nvim_command('silent "!cargo --color=always check &> target/build.log"')
	vim.api.nvim_command("vnew target/build.log")
	-- vim.api.nvim_command('vnew target/build.log | BaleiaColorize')
	-- vim.api.nvim_command('write')
end, {})
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

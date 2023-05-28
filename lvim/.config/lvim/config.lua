-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.linebreak = true
vim.opt.wrap = true
vim.o.timeoutlen = 300

-- lvim.colorscheme = 'darkplus'
lvim.format_on_save = false
lvim.builtin.treesitter.ensure_installed = { "markdown_inline", "regex" }

lvim.keys.normal_mode['<S-u>'] = '<cmd>redo<cr>'
lvim.keys.normal_mode['<C-q>'] = '<cmd>q<cr>' -- or vim.keymap.set('n', '<C-q>', ':q<cr>' )
lvim.keys.normal_mode['<S-h>'] = '<cmd>BufferLineCyclePrev<cr>'
lvim.keys.normal_mode['<S-l>'] = '<cmd>BufferLineCycleNext<cr>'
lvim.keys.normal_mode['j'] = 'gj'
lvim.keys.normal_mode['k'] = 'gk'
lvim.keys.normal_mode['<C-space>'] = '<cmd>ToggleTerm direction=float<cr>'
lvim.keys.visual_mode['<C-space>'] = '<cmd>ToggleTerm direction=float<cr>'
lvim.keys.insert_mode['<C-space>'] = '<cmd>ToggleTerm direction=float<cr>' -- TODO: conflict with cmp enable
lvim.keys.term_mode['<C-space>'] = '<cmd>ToggleTerm direction=float<cr>'
lvim.keys.term_mode['<M-esc>'] = '<C-\\><C-n>'

lvim.builtin.which_key.mappings["S"] = {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

lvim.builtin.nvimtree.setup.view.side = 'right'
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.cmp.experimental.ghost_text = true
lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.current_line_blame_opts.delay = 50

lvim.builtin.indentlines.options = {
    enabled = true,
    buftype_exclude = { 'terminal', 'nofile' },
    filetype_exclude = {
        'help',
        'startify',
        'dashboard',
        'lazy',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'text',
    },
    char = '┆',
    context_char = '┆',
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = true,
}

-- Additional Plugins
lvim.plugins = {
    { 'lunarvim/darkplus.nvim' },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            -- require('colorizer').setup({ 'css', 'scss', 'html', 'javascript', 'toml' }, {
            require('colorizer').setup({ '*' }, {
                RGB = true,      -- #RGB hex codes
                RRGGBB = true,   -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true,   -- CSS rgb() and rgba() functions
                hsl_fn = true,   -- CSS hsl() and hsla() functions
                css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end,
    },
    {
        'ggandor/leap.nvim',
        name = 'leap',
        config = function()
            require('leap').add_default_mappings()
        end,
    },
    {
        'mrjones2014/nvim-ts-rainbow',
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        config = function()
            require("persistence").setup {
                dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
                options = { "buffers", "curdir", "tabpages", "winsize" },
            }
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true,
            keywords = {
                FIX = { icon = ' ', alt = { 'FIXME', 'BUG', 'ISSUE' } },
                WARN = { icon = ' ', alt = { 'WARNING', 'XXXX' } },
                HACK = { icon = ' ' },
                TODO = { icon = ' ', alt = { 'Todo' } },
                NOTE = { icon = '󰆉 ', alt = { 'INFO' } },
                PERF = { icon = '󰓅 ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
                TEST = { icon = ' ', alt = { 'TESTING', 'PASSED', 'FAILED' } },
            },
            gui_style = {
                fg = 'NONE',
                bg = 'BOLD'
            },
            merge_keywords = true,
            highlight = {
                multiline = true,
                before = '',
                keyword = 'bg',
                after = 'fg',
                comments_only = true,
            },
        },
    },
    {
        "nvim-telescope/telescope-project.nvim",
        -- event = "BufWinEnter",
        -- setup = function()
        --     vim.cmd [[packadd telescope.nvim]]
        -- end,
    },
    -- { 'hrsh7th/cmp-nvim-lsp-signature-help' },
}

-- require 'cmp'.setup {
--     sources = {
--         { name = 'nvim_lsp_signature_help' }
--     }
-- }
-- table.insert(lvim.builtin.cmp.sources, {
--     name = 'nvim_lsp_signature_help',
-- })

require('nvim-treesitter.configs').setup({
    rainbow = {
        colors = {
            -- '#C94F68', '#84b050', '#D29052', -- '#14788C',
            -- '#F7768E', '#9ECE6A', '#FF9E64', '#2AC3DE',
        },
    },
})

lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "project")
end

local function hex_to_rgb(hex_color)
    return {
        r = tonumber(hex_color:sub(2, 3), 16),
        g = tonumber(hex_color:sub(4, 5), 16),
        b = tonumber(hex_color:sub(6, 7), 16),
    }
end

local function blend_colors(hex_color1, hex_color2, t)
    t = math.min(math.max(t, 0), 1)

    local a = hex_to_rgb(hex_color1)
    local b = hex_to_rgb(hex_color2)

    local result = {}
    for key, _ in pairs(a) do
        result[key] = math.floor(a[key] + (b[key] - a[key]) * t)
    end

    return {
        fg = hex_color1,
        bg = string.format("#%02x%02x%02x", result.r, result.g, result.b),
    }
end

lvim.autocommands = { {
    "ColorScheme",
    {
        pattern = "*",
        callback = function()
            vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
            vim.api.nvim_set_hl(0, "@lsp.mod.constructorOrDestructor.cpp", { link = "Function" })
            -- vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
            --
            vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {})
            vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Keyword" })
            vim.api.nvim_set_hl(0, "@storageclass", { link = "Keyword" })
            vim.api.nvim_set_hl(0, "PreProc", { link = "Include" })
            vim.api.nvim_set_hl(0, "Define", { link = "Include" })
            vim.api.nvim_set_hl(0, "@lsp.mod.readonly", { underline = true })
            -- vim.api.nvim_set_hl(0, "@lsp.mod.constant", { underline = true })
            vim.api.nvim_set_hl(0, "@lsp.mod.mutable", { underline = true })
            vim.api.nvim_set_hl(0, "Constant", { fg = '#e0af68', underline = true })
            vim.api.nvim_set_hl(0, "@lsp.typemod.variable.fileScope", { link = "@variable.builtin" })
            vim.api.nvim_set_hl(0, "@lsp.type.builtinType", { link = "type" })

            vim.api.nvim_set_hl(0, "Delimiter", { link = "Operator" })
            -- vim.api.nvim_set_hl(0, "@lsp.type.variable.rust", { underline = true })
            -- vim.api.nvim_set_hl(0, "@lsp.type.parameter.rust", { link = 'Parameter', underline = true })
            vim.api.nvim_set_hl(0, "@include.rust", { link = "Keyword" })

            vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Operator" })
            vim.api.nvim_set_hl(0, "@constructor.lua", {})

            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceText" })
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceText" })

            vim.api.nvim_set_hl(0, "TodoFgFIX", { link = 'DiagnosticError' })
            vim.api.nvim_set_hl(0, "TodoFgWARN", { link = 'DiagnosticWarn' })
            vim.api.nvim_set_hl(0, "TodoFgHACK", { link = 'DiagnosticWarn' })
            vim.api.nvim_set_hl(0, "TodoFgTODO", { link = 'DiagnosticInfo' })
            vim.api.nvim_set_hl(0, "TodoFgNOTE", { link = 'DiagnosticHint' })
            vim.api.nvim_set_hl(0, "TodoFgPERF", { fg = '#bb9af7' })
            vim.api.nvim_set_hl(0, "TodoFgTEST", { fg = '#bb9af7' })

            vim.api.nvim_set_hl(0, "TodoBgFIX", blend_colors('#db4b4b', '#1A1B26', 0.8))
            vim.api.nvim_set_hl(0, "TodoBgWARN", blend_colors('#e0af68', '#1A1B26', 0.8))
            vim.api.nvim_set_hl(0, "TodoBgHACK", blend_colors('#e0af68', '#1A1B26', 0.8))
            vim.api.nvim_set_hl(0, "TodoBgTODO", blend_colors('#0db9df', '#1A1B26', 0.8))
            vim.api.nvim_set_hl(0, "TodoBgNOTE", blend_colors('#1abc9c', '#1A1B26', 0.8))
            vim.api.nvim_set_hl(0, "TodoBgPERF", blend_colors('#bb9af7', '#1A1B26', 0.8))
            vim.api.nvim_set_hl(0, "TodoBgTEST", blend_colors('#bb9af7', '#1A1B26', 0.8))
        end,
    },
} }

local dap = require('dap')
dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'codelldb',
        args = { '--port', '${port}' },
    }
}

dap.configurations.cpp = {
    {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- dap.configurations.rust = {
--     {
--         unpack(dap.configurations.cpp),
--         initCommands = function()
--             -- Find out where to look for the pretty printer Python module
--             local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

--             local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
--             local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

--             local commands = {}
--             local file = io.open(commands_file, 'r')
--             if file then
--                 for line in file:lines() do
--                     table.insert(commands, line)
--                 end
--                 file:close()
--             end
--             table.insert(commands, 1, script_import)

--             return commands
--         end,
--     }
-- }

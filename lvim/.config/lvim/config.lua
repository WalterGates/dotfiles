-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.linebreak = true
vim.o.timeoutlen = 300

-- iamcco/markdown-preview.nvim plugin settings
vim.g.mkdp_auto_close = 0
vim.g.mkdp_theme = 'dark'
vim.g.mkdp_markdown_css = '/home/raul/.dotfiles/lvim/.config/lvim/github-markdown.css'

-- lvim.colorscheme = 'darkplus'
lvim.format_on_save = false
lvim.builtin.treesitter.ensure_installed = { "markdown_inline", "regex" }

-- FIXME: lvim doesn't alow for this customization, fix later in astronvim config
-- lvim.icons.ui.BoldLineLeft = '┃'
-- lvim.icons.ui.Folder = '󰉖'
-- lvim.icons.ui.FolderOpen = '󰷏'
lvim.builtin.gitsigns.opts.signs.add.text = '┃'
lvim.builtin.gitsigns.opts.signs.change.text = '┃'
lvim.builtin.gitsigns.opts.signs.changedelete.text = '┃'
lvim.builtin.gitsigns.opts.sign_priority = 6

lvim.keys.normal_mode['<S-u>'] = '<cmd>redo<cr>'
lvim.keys.normal_mode['<C-q>'] = '<cmd>q<cr>' -- or vim.keymap.set('n', '<C-q>', ':q<cr>' )
lvim.keys.normal_mode['<S-h>'] = '<cmd>BufferLineCyclePrev<cr>'
lvim.keys.normal_mode['<S-l>'] = '<cmd>BufferLineCycleNext<cr>'
lvim.keys.normal_mode['j'] = 'gj'
lvim.keys.normal_mode['k'] = 'gk'
lvim.keys.insert_mode['<C-v>'] = '<C-r>+'
lvim.keys.command_mode['<C-v>'] = '<C-r>+'
lvim.keys.insert_mode['<C-bs>'] = '<C-W>'
lvim.keys.insert_mode['<C-del>'] = '<C-o>diw'
lvim.keys.term_mode['<M-esc>'] = '<C-\\><C-n>'
lvim.keys.normal_mode['<M-z>'] = '<cmd>set wrap!<cr>'
lvim.keys.visual_mode['p'] = '"_dP'
lvim.keys.insert_mode['<A-h>'] = '<Left>'
lvim.keys.insert_mode['<A-l>'] = '<Right>'
lvim.keys.normal_mode['<leader>dh'] = '<cmd>lua require"dap.ui.widgets".hover()<cr>'
lvim.keys.visual_mode['<leader>dh'] = '<cmd>lua require"dap.ui.widgets".visual_hover()<cr>'

lvim.keys.normal_mode['s'] = function()
    local focusable_windows_on_tabpage = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
    )
    require('leap').leap { target_windows = focusable_windows_on_tabpage }
end
lvim.keys.visual_mode['s'] = lvim.keys.normal_mode['s']

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

-- Additional Plugins
lvim.plugins = {
    -- {
    --     'lunarvim/darkplus.nvim'
    -- },
    {
        'nmac427/guess-indent.nvim',
        opts = {},
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
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
        opts = {
            safe_labels = {},
        }
    },
    {
        'ggandor/flit.nvim',
        dependencies = {
            'ggandor/leap.nvim',
        },
        config = function()
            require('flit').setup {
                labeled_modes = "nvo",
            }
        end,
    },
    -- {
    --     'mrjones2014/nvim-ts-rainbow',
    --     require('nvim-treesitter.configs').setup({
    --         rainbow = {
    --             colors = {
    --                 '#C94F68', '#84b050', '#D29052', -- '#14788C',
    --                 -- '#F7768E', '#9ECE6A', '#FF9E64', '#2AC3DE',
    --             },
    --         },
    --     })

    -- },
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
            sign_priority = 8,
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
                multiline = false,
                before = '',
                keyword = 'bg',
                after = '',
                comments_only = true,
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        'petertriho/nvim-scrollbar',
        opts = {
            handle = {
                highlight = 'LspReferenceText',
                blend = 0,
            },
            handlers = {
                cursor = false,
                diagnostic = true,
                gitsigns = true,
                handle = true,
                search = false, -- Requires hlslens
                ale = false,    -- Requires ALE
            },
        },
    },
    {
        "Bryley/neoai.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = {
            "NeoAI",
            "NeoAIOpen",
            "NeoAIClose",
            "NeoAIToggle",
            "NeoAIContext",
            "NeoAIContextOpen",
            "NeoAIContextClose",
            "NeoAIInject",
            "NeoAIInjectCode",
            "NeoAIInjectContext",
            "NeoAIInjectContextCode",
        },
        keys = {
            { "<leader>as", desc = "summarize text" },
            { "<leader>ag", desc = "generate git message" },
        },
        config = function()
            require("neoai").setup({
                -- Options go here
            })
        end,
    },
    -- TODO:
    -- {
    --     'nvim-telescope/telescope-ui-select.nvim',
    -- },
    {
        "nvim-telescope/telescope-project.nvim",
        -- event = "BufWinEnter",
        -- setup = function()
        --     vim.cmd [[packadd telescope.nvim]]
        -- end,
    },
    -- FIXME:
    -- {
    --     'hrsh7th/cmp-nvim-lsp-signature-help'
    -- },
}

-- require 'cmp'.setup {
--     sources = {
--         { name = 'nvim_lsp_signature_help' }
--     }
-- }
-- table.insert(lvim.builtin.cmp.sources, {
--     name = 'nvim_lsp_signature_help',
-- })

-- TODO:
-- This is your opts table
-- require("telescope").setup {
--     extensions = {
--         ["ui-select"] = {
--             require("telescope.themes").get_dropdown {
--                 -- even more opts
--             }

--             -- pseudo code / specification for writing custom displays, like the one
--             -- for "codeactions"
--             -- specific_opts = {
--             --   [kind] = {
--             --     make_indexed = function(items) -> indexed_items, width,
--             --     make_displayer = function(widths) -> displayer
--             --     make_display = function(displayer) -> function(e)
--             --     make_ordinal = function(e) -> string
--             --   },
--             --   -- for example to disable the custom builtin "codeactions" display
--             --      do the following
--             --   codeactions = false,
--             -- }
--         }
--     }
-- }
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- require("telescope").load_extension("ui-select")

lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "project")
    -- pcall(telescope.load_extension, "ui-select")
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
            vim.api.nvim_set_hl(0, "Macro", { link = "Constant" })
            -- vim.api.nvim_set_hl(0, "@lsp.mod.readonly", { underline = true })
            -- vim.api.nvim_set_hl(0, "@lsp.mod.constant", { underline = true })
            vim.api.nvim_set_hl(0, "@lsp.mod.mutable", { underline = true })
            -- vim.api.nvim_set_hl(0, "Constant", { fg = '#e0af68', underline = true })
            vim.api.nvim_set_hl(0, "@lsp.typemod.variable.fileScope", { link = "@variable.builtin" })
            vim.api.nvim_set_hl(0, "@lsp.typemod.variable.globalScope", { link = "@variable.builtin" })
            vim.api.nvim_set_hl(0, "@lsp.type.builtinType", { link = "type" })

            vim.api.nvim_set_hl(0, "Delimiter", { link = "Operator" })
            -- vim.api.nvim_set_hl(0, "@lsp.type.variable.rust", { underline = true })
            -- vim.api.nvim_set_hl(0, "@lsp.type.parameter.rust", { link = 'Parameter', underline = true })
            vim.api.nvim_set_hl(0, "@include.rust", { link = "Keyword" })

            vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Operator" })
            vim.api.nvim_set_hl(0, "@constructor.lua", {})

            vim.api.nvim_set_hl(0, "@variable.cmake", { link = "@variable.builtin" })
            vim.api.nvim_set_hl(0, "@label.json", { link = "@field" })

            vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = '#FA973A' })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = '#FA973A', undercurl = true })
            vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", blend_colors('#FA973A', '#1A1B26', 0.9))

            vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = '#487E02' })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = '#1B81A8' })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = '#F14C4C' })

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
            vim.api.nvim_set_hl(0, "TodoBgWARN", blend_colors('#FA973A', '#1A1B26', 0.8))
            vim.api.nvim_set_hl(0, "TodoBgHACK", blend_colors('#FA973A', '#1A1B26', 0.8))
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

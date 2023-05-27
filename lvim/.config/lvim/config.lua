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

lvim.keys.normal_mode['<S-u>'] = ':redo<CR>'
lvim.keys.normal_mode['<C-q>'] = ':q<cr>' -- or vim.keymap.set('n', '<C-q>', ':q<cr>' )
lvim.keys.normal_mode['<S-h>'] = ':BufferLineCyclePrev<CR>'
lvim.keys.normal_mode['<S-l>'] = ':BufferLineCycleNext<CR>'
lvim.keys.normal_mode['j'] = 'gj'
lvim.keys.normal_mode['k'] = 'gk'

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
    -- {
    --     "folke/todo-comments.nvim",
    --     -- event = "BufRead",
    --     -- config = function()
    --     --     require("todo-comments").setup()
    --     -- end,
    --     opts = {
    --         signs = false,
    --         keywords = {
    --             FIX = { color = 'red', alt = { 'FIXME', 'BUG', 'ISSUE' } },               -- FIX:
    --             TODO = { color = 'orange', alt = { 'Todo' } },                            -- TODO:
    --             WARN = { color = 'orange', alt = { 'WARNING', 'XXXX' } },                 -- WARN:
    --             HACK = { color = 'green', },                                              -- HACK:
    --             NOTE = { color = 'green', alt = { 'INFO' } },                             -- NOTE:
    --             PERF = { color = 'green', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } }, -- PERF:
    --             TEST = { color = 'green', alt = { 'TESTING', 'PASSED', 'FAILED' } }       -- TEST:
    --         },
    --         gui_style = {
    --             fg = 'NONE',
    --             bg = 'BOLD'
    --         },
    --         merge_keywords = true,
    --         highlight = {
    --             multiline = true,
    --             before = '',
    --             keyword = 'bg',
    --             after = 'fg',
    --             comments_only = true,
    --         },
    --         colors = {
    --             green = { '#57A64A' },
    --             orange = { '#e68630' },
    --             red = { '#ff4c52' },
    --         },
    --     },
    -- },
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
            '#C94F68', '#84b050', '#D29052', -- '#14788C',
            -- '#F7768E', '#9ECE6A', '#FF9E64', '#2AC3DE',
        },
    },
})

lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "project")
end

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

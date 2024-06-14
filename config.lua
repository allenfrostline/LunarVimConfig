-------------------------------------------------------------------------------------------------
-------------------------------------- GLOBAL OPTIONS -------------------------------------------
-------------------------------------------------------------------------------------------------

vim.opt.fillchars = "eob: " -- avoid the ~ fillchars at the borders
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

lvim.format_on_save.enabled = true
lvim.transparent_window = false









-------------------------------------------------------------------------------------------------
-------------------------------- FORMATTERS AND LANGUAGE SERVERS --------------------------------
-------------------------------------------------------------------------------------------------

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { command = "black",        filetypes = { "python" } },
    { command = "isort",        filetypes = { "python" } },
    { command = "clang-format", filetypes = { "cpp", "c", "java" } },
    { command = "markdownlint", filetypes = { "markdown" } },
    { command = "prettier",     filetypes = { "css" },             args = { "--tab-width", 4 } }
}

require("lvim.lsp.manager").setup("marksman", {})   -- md
require("lvim.lsp.manager").setup("jdtls", {})      -- java
require("lvim.lsp.manager").setup("clangd", {})     -- cpp
require("lvim.lsp.manager").setup("pyright", {})    -- py






-------------------------------------------------------------------------------------------------
---------------------------------------- KEYBINDINGS --------------------------------------------
-------------------------------------------------------------------------------------------------

lvim.keys.normal_mode["<Tab>"] = "<Cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = "<Cmd>BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"

lvim.keys.visual_mode["<C-[>"] = ":SimpleAlign \\\\\\\\\\\\@<!|<CR>"
lvim.keys.visual_mode["<C-]>"] = ":SimpleAlign \\\\\\\\\\\\@<!| -justify right<CR>"

lvim.builtin.which_key.mappings["e"] = { "<Cmd>Neotree toggle<CR>", "Toggle File Explorer" }
lvim.keys.normal_mode["<C-e>"] = "<Cmd>Neotree toggle<CR>"

lvim.builtin.which_key.mappings["tt"] = { "<Cmd>ToggleWrapMode<CR>", "Toggle Wrap Mode" }

lvim.builtin.which_key.mappings["x"] = { ":bp<bar>sp<bar>bn<bar>bd<CR>", "Close Buffer" }

lvim.keys.normal_mode["<C-p>"] = "\"0p"

lvim.keys.normal_mode["<C-b>"] = ":ene <BAR> startinsert <CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"

lvim.builtin.which_key.mappings["p"] = {
    name = "Project",
    p = { "<Cmd>SessionManager load_session<CR>", "Load Project" },
    l = { "<Cmd>SessionManager load_last_session<CR>", "Load Last Project" },
    s = { "<Cmd>SessionManager save_current_session<CR>", "Save Current Project" },
    d = { "<Cmd>SessionManager delete_session<CR>", "Delete Project" },
}

lvim.builtin.which_key.mappings["c"] = {
    name = "ChatGPT",
    c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
    t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
    a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
}





-------------------------------------------------------------------------------------------------
--------------------------------------- AUTOCOMMANDS --------------------------------------------
-------------------------------------------------------------------------------------------------

lvim.autocommands = {
    {
        "ColorScheme",
        {
            callback = function()
                vim.cmd("hi WinSeparator guifg=#666666")
                vim.cmd("hi AlphaBanner guifg=#ffd042")
                vim.cmd("hi DiagnosticVirtualTextHint guifg=#444444")
            end
        }
    }
}






-------------------------------------------------------------------------------------------------
------------------------------------ PLUGINS AND STYLING ----------------------------------------
-------------------------------------------------------------------------------------------------

lvim.plugins = {
    { -- for multi-cursor
        "mg979/vim-visual-multi",
    },

    { -- for python docstring
        "pixelneo/vim-python-docstring"
    },

    { -- for cmake-tools
        'Civitasv/cmake-tools.nvim',
    },

    { -- dependency of cmake-tools
        'stevearc/overseer.nvim',
    },

    { -- dependency of cmake-tools
        'nvim-lua/plenary.nvim',
    },

    { -- for telescope selection instead of native UI
        "nvim-telescope/telescope-ui-select.nvim",
    },

    -- { -- for colorful split window borders
    --     'nvim-zh/colorful-winsep.nvim',
    --     config = true,
    --     event = { "WinNew" },
    -- },

    { -- for add/delete/change surrounding pairs (of quotes and brackets etc)
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    },

    { -- for color highlighting on hex strings (see below)
        "nvchad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                RGB = true,          -- #RGB hex codes e.g. #30c
                RRGGBB = true,       -- #RRGGBB hex codes e.g. #3300cc
                names = false,       -- "Name" codes e.g. Blue or blue
                RRGGBBAA = false,    -- #RRGGBBAA hex codes e.g. #3300cc11
                AARRGGBB = false,    -- 0xAARRGGBB hex codes
                rgb_fn = false,      -- CSS rgb() and rgba() functions
                hsl_fn = false,      -- CSS hsl() and hsla() functions
                mode = "background", -- foreground, background, virtualtext
                virtualtext = "■",
            }
        }
    },

    { -- for GPT support
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },

    { -- for text wrapping
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
        end
    },

    { -- for file explorer
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },

    { -- for python venv
        'linux-cultist/venv-selector.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-telescope/telescope.nvim',
            'mfussenegger/nvim-dap-python'
        },
        branch = "regexp",
        lazy = false,
        opts = { name = ".venv", auto_refresh = true },
        event = 'VeryLazy',
        keys = {
            { '<leader>vs', '<Cmd>VenvSelect<CR>' },
            { '<leader>vc', '<Cmd>VenvSelectCached<CR>' },
        },
    },

    { -- for git diff
        "sindrets/diffview.nvim",
        event = "BufRead",
    },

    { -- for by-project sessions
        "shatur/neovim-session-manager",
    },

    { -- for colorscheme
        "jacoborus/tender.vim",
    },

    { -- for consistent colorscheme between vim and terminal
        "typicode/bg.nvim",
        lazy = false,
    },

    { -- for java support
        "mfussenegger/nvim-jdtls",
    },

    { -- for access to a library of ascii arts
        "MaximilianLloyd/ascii.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim"
        },
    },

    { -- for searching nerd glyphs
        '2kabhishek/nerdy.nvim',
        event = "VeryLazy",
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
    },

    { -- for markdown preview
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    { -- for formula and table alignment
        'kg8m/vim-simple-align'
    },

    { -- for a bunch of good snippets
        'honza/vim-snippets'
    },
}


-- jdtls extend
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

-- set up cmake-tools
require("cmake-tools").setup {

}


-- fixing encoding for clangd
require("lspconfig").clangd.setup {
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    },
}


-- turn off netrw when neo-tree is the file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
lvim.builtin.nvimtree.active = false
require("neo-tree").setup({
    window = {
        width = 25,
    }
})


-- turn off treesitter smart indentation (buggy)
lvim.builtin.treesitter.indent.enable = false


-- color schemes
lvim.colorscheme = "tender"

lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.theme = "powerline"
lvim.builtin.lualine.sections.lualine_x = { "encoding" }
lvim.builtin.lualine.sections.lualine_y = { "filetype" }
lvim.builtin.lualine.sections.lualine_z = { "location" }


-- config for colorful-winsep
-- require("colorful-winsep").setup({
--     highlight = { fg = "#ffc24b" },
-- })



-- config for session manager
local _ = require('plenary.path')
local config = require('session_manager.config')
require('session_manager').setup({
    autoload_mode = config.AutoloadMode.Disabled, -- Disabled|CurrentDir|LastSession
    autosave_last_session = true,                 -- autosave on exit and switch
})



-- config for markdown preview
local g = vim.g
g.mkdp_theme = 'light'
g.mkdp_markdown_css = vim.fn.expand('~/.config/lvim/css/markdown.css')
g.mkdp_highlight_css = vim.fn.expand('~/.config/lvim/css/highlight.css')
g.mkdp_port = '8842'

g.mkdp_preview_options = { toc = { level = 2 } }

-- config for telescope selection
lvim.builtin.telescope.extensions = {
    ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
    }
}
require("telescope").load_extension("ui-select")



-- config for native terminal
lvim.builtin.terminal.direction = "horizontal" -- default to be horizontal
lvim.builtin.terminal.size = 30                -- <not> in percentage of screen



-- config for telescope ascii art
-- require("telescope").load_extension("ascii")
lvim.builtin.alpha.dashboard.section.header.val = {
"                       ▓▓▓▓",
"                     ▓▓▒▒▒▒▓█▓",
"                    ▒▓▓▒▒▓▓████▓",
"                    ▓▒░▒▓▓▓▓▓▓████▓",
"                   ▓▓░▒▓▓▓▓▓▓▓▓█████▓",
"                  ░▓▒░▒▓▓▓▓▓▓▓▓▓▓████▓▒▒▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▒",
"                  ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████▓▓▓▒▓▓▓▓▓▓▓▓",
"                 ▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▓",
"              ▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████▓",
"         ▓█▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████",
"    ▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▒",
"▒▓▓▓▓▓▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████",
"▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████",
"     ▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███",
"             ░▓▓████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██",
"                ▓███▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█",
"                ▓███▒▒▓▓▓▓▓▓▓▓█▓██████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓░",
"                ▓██▓▓▓▓▓▓▓▓▓▓██████         ░░░░▒▒▓▓▓▓▓▓▓▓▓▓▒░",
"               ▒▓██▓▓▓▓▓▓▓▓████▓",
"               ▒██▓▓▓▓▓▓▓▓▓█▓",
"               ▓▓█▓▓▓▓▓▓▓▓",
"               ▓▓▓▓▓▓",
"               ▒▓▓▓",
}

lvim.builtin.alpha.dashboard.section.header.opts.hl = "AlphaBanner"
lvim.builtin.alpha.dashboard.section.buttons.opts.hl = "String"
lvim.builtin.alpha.dashboard.section.footer.opts.hl = "Constant"


-- config for alpha dashboard buttons
lvim.builtin.alpha.dashboard.section.buttons.entries[1] = {
    "b", "  Open New Buffer", ":ene <BAR> startinsert <CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[2] = {
    "r", "  Open Recent File", ":Telescope oldfiles <CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[3] = {
    "f", "  Find Files", "<Cmd>Telescope find_files<CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[4] = {
    "p", "  Load Project", ":SessionManager load_session<CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[5] = {
    "t", "  Find Text", ":Telescope live_grep <CR>"
}
local config_path = require("lvim.config"):get_user_config_path()
lvim.builtin.alpha.dashboard.section.buttons.entries[6] = {
    "c", "  Configuration", "<Cmd>edit " .. config_path .. " <CR>",
}
lvim.builtin.alpha.dashboard.section.buttons.entries[7] = {
    "q", "  Quit", ":qa<CR>"
}

-- config for alpha dashboard footer
local function footer()
    ---@diagnostic disable-next-line: param-type-mismatch
    local plugins_paths = vim.fn.globpath("~/.local/share/nvim/lazy", "*.nvim", false, true)
    local plugins_count = vim.fn.len(plugins_paths)
    local datetime_str = os.date("  %Y-%m-%d       %H:%M:%S")
    local plugins_str = "  " .. plugins_count .. " Plugins"
    local version = vim.version()
    local nvim_version_str = (
        "  v" .. version.major .. "." ..
        version.minor .. "." .. version.patch
    )
    return (
        datetime_str .. "     " .. plugins_str .. "     " .. nvim_version_str
    )
end

lvim.builtin.alpha.dashboard.section.footer.val = footer()
lvim.builtin.alpha.dashboard.section.buttons.opts.width = 61

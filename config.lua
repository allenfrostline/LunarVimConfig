-------------------------------------------------------------------------------------------------
-------------------------------------- GLOBAL OPTIONS -------------------------------------------
-------------------------------------------------------------------------------------------------

vim.opt.fillchars = "eob: " -- avoid the ~ fillchars at the borders
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

lvim.format_on_save.enabled = true
lvim.transparent_window = false









-------------------------------------------------------------------------------------------------
---------------------------------------- FORMATTERS ---------------------------------------------
-------------------------------------------------------------------------------------------------

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { command = "black",        filetypes = { "python" } },
    { command = "isort",        filetypes = { "python" } },
    { command = "clang-format", filetypes = { "cpp", "c" } },
    { command = "markdownlint", filetypes = { "markdown" } },
    { command = "prettier",     filetypes = { "css" },     args = { "--tab-width", 4 } }
}






-------------------------------------------------------------------------------------------------
---------------------------------------- KEYBINDINGS --------------------------------------------
-------------------------------------------------------------------------------------------------

lvim.keys.normal_mode["<Tab>"] = "<Cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = "<Cmd>BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"

lvim.keys.visual_mode["<C-[>"] = ":SimpleAlign \\\\\\\\\\\\@<!|<CR>"
lvim.keys.visual_mode["<C-]>"] = ":SimpleAlign \\\\\\\\\\\\@<!| -justify right<CR>"

lvim.builtin.which_key.mappings["e"] = { "<Cmd>Neotree toggle<CR>", "Toggle file explorer" }
lvim.keys.normal_mode["<C-e>"] = "<Cmd>Neotree toggle<CR>"

lvim.keys.normal_mode["<C-p>"] = "\"0p"

lvim.keys.normal_mode["<C-b>"] = ":ene <BAR> startinsert <CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"

lvim.builtin.which_key.mappings["p"] = {
    name = "Project",
    p = { "<Cmd>SessionManager load_session<CR>", "Load project" },
    l = { "<Cmd>SessionManager load_last_session<CR>", "Load last project" },
    s = { "<Cmd>SessionManager save_current_session<CR>", "Save current project" },
    d = { "<Cmd>SessionManager delete_session<CR>", "Delete project" },
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
                vim.cmd("hi AlphaBanner guifg=#444444")
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
        config = function()
            require('colorizer').setup()
        end
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


-- config for colorizer
require("colorizer").setup {
    user_default_options = {
        mode = "virtualtext", -- foreground, background, virtualtext
        virtualtext = "■",
    },
}


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
    "                       ▓▄█▒▄                      ",
    "               ░▓▓▒░   ██████░▒▓░▄                ",
    "          ░ ░▒▓██░█░█ ▄████▓▓▒█▓█░░░              ",
    "           ▒▒▒██▒███░▒▒▒█░█████▓███▓▒             ",
    "         ▄▄██▒█░  ██▒▒██▓▓▓░░▒█░▓██   ░░░▄▄       ",
    "     ▄▒▄ ░██░▒█▒▓████▓▒▒▒░░▒░▒▓▓█░█▓█████▒█░░▒░   ",
    "    ▀███░░█░███▓▓███▓░░░░░░░▒▒░░▒▒████▓▓▒█▓▓██▒█  ",
    "  ▄   ████░▒░█▓▓█▓▓▒░▒▒░░▓██ ▓█▒▒▓█▓▓▒▓▓░░░█▓▓▒▀  ",
    " ▄░▒█░▓██▓▓▓█████▓▓████████▄▓▓ ▒▒▒▒▓██▓▓▓█▓██▒▄   ",
    " ▀█▒░▓░▒▓█▒░███▓▓▓███████▓░██▒▒░█████░░▒▓▓▓▒█▀▀   ",
    "     ██████████▀▀▓▀▓█████░▓██▓█████▓▓▒▓▓▒▓█       ",
    "   ▄▄█░▓▓▒▒▒   ▄   █░█████▒▒██░▓██▀ ▓▒▓▓▒▒▓██▓▓   ",
    "▄▄██▒▒▒░░░███ ███▄▄██▓▒█▓▒▒▒█▒▓▓▒   ▓▓▓▓██▒▒▓█▒▒▒ ",
    "█████░ ░▒████████▓▓█▓▒░▓█▓█▓▓░▒▒░▒ ░▒▒▒▒▓▓▒▓█▒░▒█▒",
    " ▀▒▒░░  ░▓█████░▒█▓████▒▓░░░░▒▒███▒▒▓▓█████▓█░████",
    "       ░▒▒▓███▓▓▓▓▓▒▀▀█▒▒░▒▓▒  ░░▀░▒▓▓▒███░██▒▒█  ",
    "      ░▓▓▓▒░▒██▓▀█▄▄ ░██▒▓░▓  ▄█▀   ░▒▓▒█  ██▓▀   ",
    "        ░▒██▒     ▀█████▒▒░▒▄██             ▀     ",
    "                    ██▒███░▒░▀                    ",
    "                    █▒▒▒▒▒▒░█▓                    ",
    "                   ▄█▒▒▒▒▓▒░█                     ",
    "                   █▒▒░█░▒▓░░░                    ",
    "                  ▄█▓  ▀▓▓▓▒▓▓░░                  ",
    "               ▄▄░▀       ▀▀▀▀░░░░░░▄             ",
    "            ▀▀▀▀                 ▀▀▀▀▀▀           ",
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

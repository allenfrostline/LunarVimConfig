-------------------------------------------------------------------------------------------------
-------------------------------------- GLOBAL OPTIONS -------------------------------------------
-------------------------------------------------------------------------------------------------

vim.opt.fillchars = "eob: " -- avoid the ~ fillchars at the borders
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false

lvim.format_on_save.enabled = true
lvim.transparent_window = false





-------------------------------------------------------------------------------------------------
---------------------------------------- KEYBINDINGS --------------------------------------------
-------------------------------------------------------------------------------------------------

lvim.keys.normal_mode["<Tab>"] = "<CMD>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = "<CMD>BufferLineCyclePrev<CR>"

lvim.builtin.which_key.mappings["e"] = { "<CMD>Neotree toggle<CR>", "Toggle file explorer" }
lvim.keys.normal_mode["<C-e>"] = "<CMD>Neotree toggle<CR>"

lvim.keys.normal_mode["<C-p>"] = "<CMD>SessionManager load_session<CR>"

lvim.keys.normal_mode["<C-b>"] = ":ene <BAR> startinsert <CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.normal_mode["<C-w>"] = ":BufferKill<CR>"

lvim.builtin.which_key.mappings["p"] = {
    name = "Project",
    p = { "<CMD>SessionManager load_session<CR>", "Load project" },
    l = { "<CMD>SessionManager load_last_session<CR>", "Load last project" },
    s = { "<CMD>SessionManager save_current_session<CR>", "Save current project" },
    d = { "<CMD>SessionManager delete_session<CR>", "Delete project" },
}




-------------------------------------------------------------------------------------------------
------------------------------------ PLUGINS AND STYLING ----------------------------------------
-------------------------------------------------------------------------------------------------

lvim.plugins = {
    { -- for multi-cursor
        "mg979/vim-visual-multi",
    },

    { -- for telescope selection instead of native UI
        "nvim-telescope/telescope-ui-select.nvim",
    },

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
            { '<leader>vs', '<CMD>VenvSelect<CR>' },
            { '<leader>vc', '<CMD>VenvSelectCached<CR>' },
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




-- config for session manager
local _ = require('plenary.path')
local config = require('session_manager.config')
require('session_manager').setup({
    autoload_mode = config.AutoloadMode.Disabled, -- Disabled|CurrentDir|LastSession
    autosave_last_session = true,                 -- autosave on exit and switch
})




-- config for telescope selection
lvim.builtin.telescope.extensions = {
    ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
    }
}
require("telescope").load_extension("ui-select")



-- config for terminal
lvim.builtin.terminal.direction = "horizontal" -- default to be horizontal
lvim.builtin.terminal.size = 30                -- <not> in percentage of screen



-- config for telescope ascii art
require("telescope").load_extension("ascii")



-- lvim.builtin.alpha.dashboard.section.header.val = require('ascii').art.anime.onepiece.nami
lvim.builtin.alpha.dashboard.section.header.val = {
    "                       ░░                                  ",
    "                  ░ ░░░░  ░                                ",
    "                       ░░  ░ ░ ░                           ",
    "                   ░░░ ░░░░░ ░  ░                          ",
    "                     ░░░░░░░░░░░░░                         ",
    "                      ░░░░░▒▓▓▒░░                          ",
    "                       ░░░░░▓▒▒░░                          ",
    "                       ░░░░░░░░░░                          ",
    "                       ░░░░░░▒░░         ░░░               ",
    "                       ░░░░░░░░░       ░░░▒░░░░            ",
    "                       ░░░░░░░░░    ░░░░▓▓▒░░░░            ",
    "            ░░▓▓░░░    ░░░░░░░░  ░░░░░▒▓▓░░░░              ",
    "           ░░░░▒▓░░     ░░░░░░  ░░░░░░░░░                  ",
    "         ░░ ░░░▓░░░   ░ ░░░░░░░░░░░                        ",
    "           ░░░░░░     ░ ░░░░░░░░░                          ",
    "          ░░░░░░       ░░░░░░░░░                           ",
    "         ░░░░░░       ░░░░░░░░░░░  ░                       ",
    "         ░░          ░░░░░░░ ░░▒▒░░ ░░                     ",
    "                  ░░░░░░░░   ░░░▒▓▒░░░                     ",
    "                ░░░░░░ ░        ░░▒▓▒░░░░ ░                ",
    "            ░░░░░░░            ░░░░░░▒▓▓░░░░░░░░░░░░       ",
    "░░   ░░░░░░░░░░                    ░ ░░░▒▓▓▓▒░▒░░░░░░ ░░ ░░",
    "   ░░░ ░░░                            ░░░░░░░░░░░░░░░░░  ░ ",
    "                                         ░░░   ░ ░  ░░     ",
    "                                                 ░░░    ░  ",
}

lvim.builtin.alpha.dashboard.section.header.opts.hl = "DiagnosticError"
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
    "f", "  Find Files", "<CMD>Telescope find_files<CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[4] = {
    "p", "  Load Project", ":SessionManager load_session<CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[5] = {
    "t", "  Find Text", ":Telescope live_grep <CR>"
}
local config_path = require("lvim.config"):get_user_config_path()
lvim.builtin.alpha.dashboard.section.buttons.entries[6] = {
    "c", "  Configuration", "<CMD>edit " .. config_path .. " <CR>",
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

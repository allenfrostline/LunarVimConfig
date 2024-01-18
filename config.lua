-- OPTIONS

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false





-- KEYBINDINGS

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
    s = { "<CMD>SessionManager save_current_session<CR><CMD>Neotree filesystem<CR>", "Save current project" },
    d = { "<CMD>SessionManager delete_session<CR>", "Delete project" },
}





-- LINTING AND FORMATTING

lvim.format_on_save.enabled = true
lvim.transparent_window = false -- NOTE: overriden by onedark theme











-- PLUGINS AND STYLING

vim.g.loaded_netrw = 1               -- using neo-tree
vim.g.loaded_netrwPlugin = 1         -- using neo-tree
lvim.builtin.nvimtree.active = false -- using neo-tree

lvim.builtin.lualine.style = "default"

lvim.plugins = {
    {
        "mg979/vim-visual-multi",
    },

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    },

    {
        "nvchad/nvim-colorizer.lua",
        config = function()
            require('colorizer').setup()
        end
    },

    {
        "rrethy/nvim-base16",
        config = function()
            require("base16-colorscheme").setup({
                base00 = '#1b1a1a',
                base01 = '#111111',
                base02 = '#272d38',
                base03 = '#3e4b59',
                base04 = '#bfbdb6',
                base05 = '#e6e1cf',
                base06 = '#e6e1cf',
                base07 = '#f3f4f5',
                base08 = '#b8cc52',
                base09 = '#ff8f40',
                base0A = '#3CA2B4',
                base0B = '#b8cc52',
                base0C = '#3EE2FF',
                base0D = '#fbdf51',
                base0E = '#ea5f49',
                base0F = '#e6b673'
            })
        end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },

    {
        'linux-cultist/venv-selector.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
        opts = { name = ".venv", auto_refresh = true },
        event = 'VeryLazy',
        keys = {
            { '<leader>vs', '<CMD>VenvSelect<CR>' },
            { '<leader>vc', '<CMD>VenvSelectCached<CR>' },
        },
    },

    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },

    {
        "shatur/neovim-session-manager",
    },
}

lvim.colorscheme = "base16"

lvim.builtin.lualine.options.theme = "powerline"
lvim.builtin.lualine.sections.lualine_x = { "filetype" }
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_z = { "progress" }





local Path = require('plenary.path')
local config = require('session_manager.config')
require('session_manager').setup({
    sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
    -- session_filename_to_dir = session_filename_to_dir,           -- Function that replaces symbols into separators and colons to transform filename into a session directory.
    -- dir_to_session_filename = dir_to_session_filename,           -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
    autoload_mode = config.AutoloadMode.CurrentDir,           -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = true,                             -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = true,                        -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_dirs = {},                                -- A list of directories where the session will not be autosaved.
    autosave_ignore_filetypes = { 'gitcommit', 'gitrebase' }, -- All buffers of these file types will be closed before the session is saved.
    autosave_ignore_buftypes = {},                            -- All buffers of these bufer types will be closed before the session is saved.
    autosave_only_in_session = false,                         -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 80,                                     -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})







lvim.builtin.alpha.dashboard.section.buttons.entries[1] = {
    "f", "  Find Files", "<CMD>Telescope find_files<CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[2] = {
    "b", "  New Buffer", ":ene <BAR> startinsert <CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[3] = {
    "p", "  Load Project", ":SessionManager load_session<CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[4] = {
    "r", "  Recently Files", ":Telescope oldfiles <CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[5] = {
    "t", "  Find Text", ":Telescope live_grep <CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[6] = {
    "u", "  Update Plugins", ":Lazy update <CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[7] = {
    "c", "  Configuration", ":e ~/.config/nvim/lua/config.lua <CR>"
}
lvim.builtin.alpha.dashboard.section.buttons.entries[8] = {
    "q", "  Quit", ":qa<CR>"
}

lvim.builtin.alpha.dashboard.section.header.val = {
    [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
    [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
    [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
    [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
    [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
    [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}

local function footer()
    local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/lazy", "*", 0, 1))
    local datetime = os.date("  %Y-%m-%d   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. "   Plugins " .. plugins_count .. nvim_version_info
end

lvim.builtin.alpha.dashboard.section.footer.val = footer()
lvim.builtin.alpha.dashboard.section.footer.opts.hl = "GruvboxGreen"
lvim.builtin.alpha.dashboard.section.header.opts.hl = "GruvboxBlue"
lvim.builtin.alpha.dashboard.section.buttons.opts.hl = "GruvboxGreen"

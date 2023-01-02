local fn = vim.fn

local is_nvim = function()
  return not vim.g.vscode
end

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  max_jobs = 10,
  compile_path = vim.fn.stdpath('config') .. '/lua/user/' .. 'packer_compiled.lua',
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

local use = require('packer').use

use({ "wbthomason/packer.nvim" }) -- Have packer manage itself

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

-- Install your plugins here
-- return packer.startup(function(use)
  -- My plugins here
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
--  use({ 
--    "windwp/nvim-autopairs",
--    cond = is_nvim,
--  }) -- Autopairs, integrates with both cmp and treesitter
--  use({ 
--    "numToStr/Comment.nvim",
--    cond = is_nvim,
--  })
--  use({ 
--    "JoosepAlviste/nvim-ts-context-commentstring",
--    cond = is_nvim,
--  })
  use({ "kyazdani42/nvim-web-devicons" })
  use { 
    'akinsho/bufferline.nvim',
    tag = "v2.*", 
    requires = 'kyazdani42/nvim-web-devicons',
    cond = is_nvim,
  }
  -- use({ "moll/vim-bbye" })
  use({ 
    "nvim-lualine/lualine.nvim",
    cond = is_nvim,
  })
  -- use { "akinsho/toggleterm.nvim" }
  -- use({ "ahmedkhalf/project.nvim" })
  -- use({ "lewis6991/impatient.nvim" })
  -- use({ "lukas-reineke/indent-blankline.nvim" })
  -- use({ "goolord/alpha-nvim" })
  -- use "b0o/schemastore.nvim"
  --
  -- -- use 'j-hui/fidget.nvim'
  --
  -- -- Colorschemes
  -- use({ "folke/tokyonight.nvim" })
  -- use("bluz71/vim-nightfly-guicolors")
  use({
    "rebelot/kanagawa.nvim",
    cond = is_nvim,
  })
  -- use {
  --   'lalitmee/cobalt2.nvim',
  --   requires = 'tjdevries/colorbuddy.nvim',
  -- }
  -- use({
  --   "catppuccin/nvim",
  --   as = "catppuccin"
  -- })
  --
  use({
    "kyazdani42/nvim-tree.lua",
    cond = is_nvim,
    config = function()
      require "user.nvim-tree"
    end
  })
  --
  -- -- Vim Wiki
  -- --[[ use "vimwiki/vimwiki" ]]
  --
  -- -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
-- use({
--   'tzachar/cmp-tabnine',
--   after = 'nvim-cmp',
--   cond = is_nvim, 
--   run = './install.sh',
--   requires = 'hrsh7th/nvim-cmp',
--   config = function()
--     require "user.tabnine"
--   end
-- })
  use({
    'hrsh7th/cmp-cmdline', 
    cond = is_nvim, 
  }) 
  use({ 
    "hrsh7th/cmp-buffer", 
    cond = is_nvim, 
  }) -- buffer completions
  use({ 
    "hrsh7th/cmp-path",   
    cond = is_nvim, 
  }) -- path completions
  use({ 
    "saadparwaiz1/cmp_luasnip",   
    cond = is_nvim, 
  }) -- snippet completions
  use({ 
    "hrsh7th/cmp-nvim-lsp",  
    cond = is_nvim, 
  })
  use({ 
    "hrsh7th/cmp-nvim-lua",  
    cond = is_nvim, 
  })
  -- -- snippets
  use({ 
    "L3MON4D3/LuaSnip",   
    cond = is_nvim, 
  }) --snippet engine
  use({
    "rafamadriz/friendly-snippets",
    event = "InsertCharPre"
  }) -- a bunch of snippets to use
  -- use({ "folke/trouble.nvim",
  --   cmd = "TroubleToggle",
  --   config = function()
  --     require "user.trouble"
  --   end
  -- })
  -- -- Lua
  -- use {
  --   "folke/todo-comments.nvim",
  --   requires = "nvim-lua/plenary.nvim",
  --   config = function()
  --     require("user.todo-comment")
  --   end
  -- }
  --
  -- -- LSP
  -- use { 
  --    "ray-x/lsp_signature.nvim",
  --    cond = is_nvim,
   -- }
  -- use({ "neovim/nvim-lspconfig" }) -- enable LSP
  -- use 'tamago324/nlsp-settings.nvim'
  -- use {
  --   "williamboman/mason.nvim",
  --   "williamboman/mason-lspconfig.nvim",
  --   "jayp0521/mason-null-ls.nvim",
  --   "jayp0521/mason-nvim-dap.nvim",
  -- }
  -- -- DAP
  -- use({ "mfussenegger/nvim-dap" })
  -- use({
  --   "rcarriga/nvim-dap-ui",
  --   "theHamsta/nvim-dap-virtual-text",
  -- })
  --
  -- use({ "RRethy/vim-illuminate" })
  -- use({
  --   "rmagatti/goto-preview",
  --   config = function()
  --     require "user.preview"
  --   end
  -- })
  -- use({
  --   "glepnir/lspsaga.nvim",
  -- })
  -- use "onsails/lspkind.nvim"
  --
  -- -- Flutter
  -- use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
  -- use "sidlatau/lsp-fastaction.nvim"
  -- use { 'sidlatau/dart-lsp-refactorings.nvim' }
  -- use "dart-lang/dart-vim-plugin"
  -- use({ "chrisbra/Colorizer", as = "ansicolor" })
  -- use 'MTDL9/vim-log-highlighting'
  -- use({
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require "user.colorizer"
  --   end,
  -- })
  --
  -- -- GO
  -- use 'ray-x/go.nvim'
  -- use 'ray-x/guihua.lua'
  --
  -- use {
  --   "nvim-neotest/neotest",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "sidlatau/neotest-dart",
  --   },
  -- }
  --
  -- use {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   cmd = "Neotree",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --     {
  --       -- only needed if you want to use the commands with "_with_window_picker" suffix
  --       's1n7ax/nvim-window-picker',
  --       tag = "v1.*",
  --       config = function()
  --         require 'window-picker'.setup({
  --           autoselect_one = true,
  --           include_current = false,
  --           filter_rules = {
  --             -- filter using buffer options
  --             bo = {
  --               -- if the file type is one of following, the window will be ignored
  --               filetype = { 'neo-tree', "neo-tree-popup", "notify" },
  --
  --               -- if the buffer type is one of following, the window will be ignored
  --               buftype = { 'terminal', "quickfix" },
  --             },
  --           },
  --           other_win_hl_color = '#e35e4f',
  --         })
  --       end,
  --     }
  --   },
  --   config = function()
  --     require "user.neotree"
  --   end
  -- }
  --
  -- -- Telescope
  use({ "nvim-telescope/telescope.nvim",
    config = function()
      require "user.telescope"
    end
  })
  -- use {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   after = { "telescope.nvim" },
  --   config = function()
  --     require("user.telescope").telescope.load_extension("frecency")
  --   end,
  --   requires = {
  --     { "kkharji/sqlite.lua", module = "sqlite_frecency" },
  --   },
  -- }
  -- use {
  --   'nvim-telescope/telescope-fzf-native.nvim',
  --   after = "telescope.nvim",
  --   run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  -- }
  -- use({
  --   "AckslD/nvim-neoclip.lua",
  --   after = { "telescope.nvim" },
  --   requires = {
  --     { "tami5/sqlite.lua", module = "sqlite" },
  --   },
  --   config = function()
  --     require("user.neoclip")
  --   end
  -- })
  -- use { "smartpde/telescope-recent-files" }
  -- use {
  --   'debugloop/telescope-undo.nvim',
  --   requires = { 'nvim-telescope/telescope.nvim' },
  --   config = function()
  --     require("user.telescope").telescope.load_extension("undo")
  --   end,
  -- }
  --
  -- -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    cond = is_nvim,
    config = function()
      require "user.treesitter"
    end
  }
  --
--  use({
--    "nvim-treesitter/nvim-treesitter-context",
--    cond = is_nvim,
--    config = function()
--      require "user.treesitter-context"
--    end
--  })
  -- use({ "nvim-treesitter/nvim-treesitter-textobjects" })
  --
  -- -- Quickfix
  -- use {
  --   'kevinhwang91/nvim-bqf',
  --   ft = 'qf',
  --   config = function()
  --     require 'user.bqf'
  --   end
  -- }
  --
  -- use { 'junegunn/fzf', run = function()
  --   vim.fn['fzf#install']()
  -- end
  -- }
  -- -- Git
  -- use({ "lewis6991/gitsigns.nvim" })
  -- use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  -- --  use({
  -- --    "ThePrimeagen/git-worktree.nvim",
  -- --    config = function()
  -- --      require "user.git-worktree"
  -- --    end
  -- --  })
  --
  --
  -- -- Frontend
  -- use "windwp/nvim-ts-autotag"
  -- -- use('MunifTanjim/prettier.nvim')
  --
  -- -- Editing {{{
  -- use {
  --   "bkad/camelcasemotion",
  --   config = function()
  --     vim.g["camelcasemotion_key"] = "\\"
  --   end,
  -- }
  use({
    "Mephistophiles/surround.nvim",
    config = function()
      require "user.surround"
    end
  })
  use("tpope/vim-repeat")
  -- use({
  --   "petertriho/nvim-scrollbar",
  --   config = function()
  --     require("user.scrollbar")
  --   end
  -- })
  -- use({
  --   'kevinhwang91/nvim-hlslens',
  --   config = function()
  --     require("scrollbar.handlers.search").setup()
  --   end
  -- })
  --
  -- -- Misc
  use {
    "monaqa/dial.nvim",
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool, -- boolean value (true <-> false)
        },
      }
    end,
  }
  -- use 'karb94/neoscroll.nvim'
  -- use({
  --   "folke/noice.nvim",
  --   requires = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   },
  -- })
  use({
    "folke/which-key.nvim",
    cond = is_nvim,
  })
  -- use("p00f/nvim-ts-rainbow")
  -- use({
  --   "ThePrimeagen/harpoon",
  --   after = { "telescope.nvim" },
  --   config = function()
  --     require "user.harpoon"
  --   end,
  -- })
  use({
    "Shatur/neovim-session-manager",
    cond = is_nvim,
    setup = function()
      require "user.session"
    end,
  })
  -- use({
  --   "chentoast/marks.nvim",
  --   config = function()
  --     require "user.marks"
  --   end,
  -- })
  use({
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end,
  })
  use({
    "rcarriga/nvim-notify",
  }) 
  -- use { "dstein64/vim-startuptime" }
  --
  -- use({
  --   'kazhala/close-buffers.nvim',
  --   config = function()
  --     require "user.buffer-close"
  --   end
  -- })
  -- use {
  --   'stevearc/overseer.nvim',
  --   cmd = { 'OverseerToggle', 'OverseerRunCmd' },
  --   config = function()
  --     require('user.overseer')
  --   end
  -- }
  -- use 'wakatime/vim-wakatime'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
-- end)

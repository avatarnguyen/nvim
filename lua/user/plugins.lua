local fn = vim.fn

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
  max_jobs = 20,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" })  -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" })  -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "kyazdani42/nvim-web-devicons" })
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use { "akinsho/toggleterm.nvim" }
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  -- use({ "goolord/alpha-nvim" })
  use "b0o/schemastore.nvim"
  use { "ray-x/lsp_signature.nvim" }

  -----------------
  -- Colorschemes
  -----------------
  use({ "folke/tokyonight.nvim" })
  use("bluz71/vim-nightfly-guicolors")
  use("rebelot/kanagawa.nvim")
  use {
    'lalitmee/cobalt2.nvim',
    requires = 'tjdevries/colorbuddy.nvim',
  }
  use { "catppuccin/nvim", as = "catppuccin" }
  -- use {
  --   'svrana/neosolarized.nvim',
  --   requires = { 'tjdevries/colorbuddy.nvim' }
  -- }
  use({ "Shatur/neovim-ayu" })

  ------------------------
  -- File Tree
  ------------------------
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "user.nvim-tree"
    end
  })
  use {
    'antosha417/nvim-lsp-file-operations',
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "kyazdani42/nvim-tree.lua" },
    },
    config = function()
      require("lsp-file-operations").setup()
    end
  }

  ------------------------
  -- CMP plugins
  ------------------------
  use({ "hrsh7th/nvim-cmp" })         -- The completion plugin
  use 'hrsh7th/cmp-cmdline'
  use({ "hrsh7th/cmp-buffer" })       -- buffer completions
  use({ "hrsh7th/cmp-path" })         -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({
    "rafamadriz/friendly-snippets",
    event = "InsertCharPre"
  }) -- a bunch of snippets to use
  use({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require "user.trouble"
    end
  })
  -- TAB-NINE --
  -- use({
  --   'tzachar/cmp-tabnine',
  --   after = 'nvim-cmp',
  --   run = './install.sh',
  --   requires = 'hrsh7th/nvim-cmp',
  --   config = function()
  --     require "user.tabnine"
  --   end
  -- })

  -- CO-PILOT --
  use "github/copilot.vim"
  -- use {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   -- event = "InsertEnter",
  --   config = function()
  --     require "user.copilot"
  --   end,
  -- }
  -- use {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua", "nvim-cmp" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- }

  ------------------------
  -- LSP
  ------------------------
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  -- use 'tamago324/nlsp-settings.nvim'
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
    "jayp0521/mason-nvim-dap.nvim",
  }

  ------------------------
  -- LSP Extra
  ------------------------
  use({ "RRethy/vim-illuminate" })
  use({
    "rmagatti/goto-preview",
    config = function()
      require "user.preview"
    end
  })
  use({
    "glepnir/lspsaga.nvim",
  })
  use "onsails/lspkind.nvim"

  ------------------------
  -- DAP
  ------------------------
  use({ "mfussenegger/nvim-dap" })
  use({
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  })

  ------------------------
  -- Flutter
  ------------------------
  use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
  use "sidlatau/lsp-fastaction.nvim"
  use "dart-lang/dart-vim-plugin"
  use 'MTDL9/vim-log-highlighting'
  -- use {'sidlatau/dart-lsp-refactorings.nvim' }
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "user.colorizer"
    end,
  })

  ------------------------
  -- GO
  ------------------------
  use "olexsmir/gopher.nvim"
  use "leoluz/nvim-dap-go"
  -- use('crispgm/nvim-go')
  -- use "lvimuser/lsp-inlayhints.nvim"
  use('simrat39/inlay-hints.nvim')

  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "sidlatau/neotest-dart",
    },
  }

  -- use {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   cmd = "Neotree",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require "user.neotree"
  --   end
  -- }

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    after = "telescope.nvim",
    run =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  }
  use({
    "AckslD/nvim-neoclip.lua",
    after = { "telescope.nvim" },
    requires = {
      { "tami5/sqlite.lua", module = "sqlite" },
    },
    config = function()
      require("user.neoclip")
    end
  })
  use {
    "smartpde/telescope-recent-files",
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require("user.telescope").telescope.load_extension("recent_files")
    end,
  }
  use {
    'debugloop/telescope-undo.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require("user.telescope").telescope.load_extension("undo")
    end,
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    after = { "telescope.nvim" },
    requires = { "kkharji/sqlite.lua" },
    config = function()
      require("user.telescope").telescope.load_extension("frecency")
    end,
  }

  --------------------
  -- Treesitter
  --------------------
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require "user.treesitter"
    end
  }

  use({
    "nvim-treesitter/nvim-treesitter-context",
  })
  use({ "nvim-treesitter/nvim-treesitter-textobjects" })

  -- Quickfix
  use {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require 'user.bqf'
    end
  }

  use { 'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
  end
  }
  -- Git
  -- use "tpope/vim-fugitive"
  use({ "lewis6991/gitsigns.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })


  --------------------
  -- Frontend
  --------------------
  use "windwp/nvim-ts-autotag"
  -- use('MunifTanjim/prettier.nvim')

  -- Editing {{{
  use {
    "bkad/camelcasemotion",
    config = function()
      vim.g["camelcasemotion_key"] = "\\"
    end,
  }
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

  -- Misc
  use {
    "monaqa/dial.nvim",
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex,     -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool,   -- boolean value (true <-> false)
        },
      }
    end,
  }

  ------------------------
  -- Extra UI Plugins
  ------------------------
  -- use 'mbbill/undotree'
  use "opalmay/vim-smoothie"
  use "alexghergh/nvim-tmux-navigation"
  use 'christoomey/vim-tmux-runner'
  -- use 'j-hui/fidget.nvim'
  use({
    "folke/noice.nvim",
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use "rcarriga/nvim-notify"
  use { "dstein64/vim-startuptime" }

  use "folke/zen-mode.nvim"

  use("folke/which-key.nvim")
  use("p00f/nvim-ts-rainbow")

  use({
    "ThePrimeagen/harpoon",
    after = { "telescope.nvim" },
    config = function()
      require "user.harpoon"
    end,
  })
  use({
    "Shatur/neovim-session-manager",
    config = function()
      require "user.session"
    end,
  })
  use({
    "chentoast/marks.nvim",
    config = function()
      require "user.marks"
    end,
  })
  use({
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end,
  })
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require('user.todo-comment')
    end
  }

  use({
    'kazhala/close-buffers.nvim',
    config = function()
      require "user.buffer-close"
    end
  })
  use {
    'stevearc/overseer.nvim',
    cmd = { 'OverseerToggle', 'OverseerRunCmd' },
    config = function()
      require('user.overseer')
    end
  }
  use 'wakatime/vim-wakatime'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

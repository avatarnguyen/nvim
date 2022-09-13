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
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "kyazdani42/nvim-web-devicons" })
  -- use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ 'arkav/lualine-lsp-progress' })
  use { "akinsho/toggleterm.nvim" }
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "goolord/alpha-nvim" })
  use "b0o/schemastore.nvim"

  -- Colorschemes
  -- use({ "folke/tokyonight.nvim" })
  -- use("bluz71/vim-nightfly-guicolors")
  -- use("rebelot/kanagawa.nvim")
  use {
    'lalitmee/cobalt2.nvim',
    requires = 'tjdevries/colorbuddy.nvim',
    config = function()
      require('colorbuddy').colorscheme('cobalt2')
    end
  }
  --[[ use("Tsuzat/NeoSolarized.nvim") ]]
  --[[ use({ ]]
  --[[   "catppuccin/nvim", ]]
  --[[   as = "catppuccin" ]]
  --[[ }) ]]

  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "user.nvim-tree"
    end
  })
  -- use {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   as = "neotree",
  --   branch = "v2.x",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --   }
  -- }
  -- use {
  --   's1n7ax/nvim-window-picker',
  --   tag = 'v1.*',
  --   after = 'neotree',
  --   config = function()
  --     require 'window-picker'.setup()
  --   end,
  -- }

  -- Vim Wiki
  use "vimwiki/vimwiki"

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp',
    config = function()
      require "user.tabnine"
    end
  })
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "folke/trouble.nvim", cmd = "TroubleToggle" })
  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
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

  -- Flutter
  -- use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim",
  --   commit = "3c2b196de3a7f62247d50fe63e596b0884d6156a" })
  use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
  use "sidlatau/lsp-fastaction.nvim"
  use "dart-lang/dart-vim-plugin"
  -- use({ "chrisbra/Colorizer", as = "ansicolor" })
  --[[ use 'MTDL9/vim-log-highlighting' ]]

  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "sidlatau/neotest-dart",
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-dart') {
            command = 'flutter',
          },
        }
      })
    end
  }
  --  use 'nvim-lua/lsp_extensions.nvim'
  --[[ use({ ]]
  --[[   'ray-x/navigator.lua', ]]
  --[[   requires = { ]]
  --[[     { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }, ]]
  --[[     { 'neovim/nvim-lspconfig' }, ]]
  --[[   }, ]]
  --[[ }) ]]
  --[[ use { 'camspiers/snap', rocks = {'fzy'}} ]]
  --[[ use ({ ]]
  --[[   'camspiers/snap', ]]
  --[[   config = function() ]]
  --[[     require "user.snap" ]]
  --[[   end ]]
  --[[ }) ]]
  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require "user.telescope"
    end
  })
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    after = "telescope.nvim",
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  }

  use({
    "AckslD/nvim-neoclip.lua",
    requires = {
      { "tami5/sqlite.lua", module = "sqlite" },
    },
  })

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require "user.treesitter"
    end
  }

  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require "user.treesitter-context"
    end
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use({
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require "user.git-worktree"
    end
  })

  -- DAP
  use({
    "mfussenegger/nvim-dap",
    module = "dap",
    config = function()
      require "user.dap-config"
    end
  })
  use({ "rcarriga/nvim-dap-ui" })
  --[--[[ [ use({ "Pocco81/dap-buddy.nvim" }) ] ]]]

  --[[ use ({ ]]
  --[[   "williamboman/mason.nvim", ]]
  --[[   config = function () ]]
  --[[     require("mason").setup() ]]
  --[[   end ]]
  --[[ }) ]]

  -- Editing {{{
  use {
    "bkad/camelcasemotion",
    config = function()
      vim.g["camelcasemotion_key"] = "\\"
    end,
  }
  use({
    "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  })
  use({
    "Mephistophiles/surround.nvim",
    config = function()
      require "user.surround"
    end
  })
  use("tpope/vim-repeat")

  -- Misc
  use("folke/which-key.nvim")
  use("p00f/nvim-ts-rainbow")
  use({ "ThePrimeagen/harpoon" })
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
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "user.colorizer"
    end,
  })
  use({
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end,
  })
  use "rcarriga/nvim-notify"
  --[[ use { "dstein64/vim-startuptime" } ]]

  use({
    'kazhala/close-buffers.nvim',
    config = function()
      require "user.buffer-close"
    end
  })
  use {
    'jedrzejboczar/toggletasks.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'akinsho/toggleterm.nvim',
      'nvim-telescope/telescope.nvim/',
    },
    -- To enable YAML config support
    --[[ rocks = 'lyaml', ]]
  }
  -- use {
  --   'jghauser/kitty-runner.nvim',
  --   config = function()
  --     require('kitty-runner').setup({
  --       use_keymaps = false,
  --     })
  --   end
  -- }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

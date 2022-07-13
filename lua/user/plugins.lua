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
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use { "akinsho/toggleterm.nvim" }
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "goolord/alpha-nvim" })
  use "b0o/schemastore.nvim"
  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use("bluz71/vim-nightfly-guicolors")
  use("rebelot/kanagawa.nvim")

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
  use {
    's1n7ax/nvim-window-picker',
    tag = 'v1.*',
    config = function()
      require 'window-picker'.setup()
    end,
  }

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "folke/trouble.nvim", cmd = "TroubleToggle" })
  use("filipdutescu/renamer.nvim")

  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ "RRethy/vim-illuminate" })
  use({
    "rmagatti/goto-preview",
  })
  use("j-hui/fidget.nvim")
  -- use("glepnir/lspsaga.nvim")

  -- Flutter
  use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim",
    commit = "3c2b196de3a7f62247d50fe63e596b0884d6156a" })
  use("dart-lang/dart-vim-plugin")
  -- use("avatarnguyen/lsp-fastaction.nvim")
  use "sidlatau/lsp-fastaction.nvim"
  -- use({ "chrisbra/Colorizer", as = "ansicolor" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use("nvim-telescope/telescope-ui-select.nvim")
  -- use "tom-anders/telescope-vim-bookmarks.nvim"

  use({
    "AckslD/nvim-neoclip.lua",
    requires = {
      { "tami5/sqlite.lua", module = "sqlite" },
    },
  })

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use("nvim-treesitter/nvim-treesitter-context")

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use("ThePrimeagen/git-worktree.nvim")

  -- DAP
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "ravenxrz/DAPInstall.nvim" })

  -- Editing
  use({
    "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  })
  use("Mephistophiles/surround.nvim")
  use("tpope/vim-repeat")

  -- Misc
  use("abecodes/tabout.nvim")
  use("folke/which-key.nvim")
  use("karb94/neoscroll.nvim")
  use("p00f/nvim-ts-rainbow")
  use("ThePrimeagen/harpoon")
  use "Shatur/neovim-session-manager"
  use("chentoast/marks.nvim")
  use("norcalli/nvim-colorizer.lua")
  use({
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end,
  })
  use "rcarriga/nvim-notify"
  use { "christianchiarulli/nvim-gps", branch = "text_hl" }
  use "dstein64/vim-startuptime"


  use 'kazhala/close-buffers.nvim'
  -- UML
  -- use "aklt/plantuml-syntax"
  -- use { "weirongxu/plantuml-previewer.vim" }
  -- use { "tyru/open-browser.vim" } --  opt = true

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

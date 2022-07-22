-- local colorscheme = "kanagawa"
-- local colorscheme = "tokyonight"
-- local colorscheme = "cobalt2"
-- local colorscheme = "material"
-- local colorscheme = "nightfly"
local colorscheme = "catppuccin"

-- catppuccin
if colorscheme == "catppuccin" then
  vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
  -- vim.g.catppuccin_flavour = "mocha" -- darker theme

  require("catppuccin").setup({
    -- dim_inactive = {
    --   enabled = false,
    --   shade = "dark",
    --   percentage = 0.15,
    -- },
    -- transparent_background = false,
    term_colors = false,
    compile = {
      enabled = true,
      path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
    -- styles = {
    --   comments = { "italic" },
    --   conditionals = { "italic" },
    --   loops = {},
    --   functions = {},
    --   keywords = {},
    --   strings = {},
    --   variables = {},
    --   numbers = {},
    --   booleans = {},
    --   properties = {},
    --   types = {},
    --   operators = {},
    -- },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          -- errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      coc_nvim = false,
      lsp_trouble = false,
      cmp = true,
      lsp_saga = false,
      gitgutter = true,
      gitsigns = true,
      -- leap = false,
      telescope = true,
      -- nvimtree = {
      --   enabled = true,
      --   show_root = true,
      --   transparent_panel = false,
      -- },
      neotree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
      },
      dap = {
        enabled = false,
        enable_ui = false,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = true,
      notify = true,
      telekasten = true,
      symbols_outline = true,
      mini = false,
      aerial = false,
      vimwiki = false,
      beacon = false,
    },
  })
end

-- nightfly
if colorscheme == "nightfly" then
 vim.g.nightflyTransparent = 1
 vim.g.nightflyItalics = 1
 vim.g.nightflyNormalFloat = 1
 vim.g.nightflyCursorColor = 0
 vim.g.nightflyUnderlineMatchParen = 1
 vim.g.nightflyUndercurls = 1
end

if colorscheme == "cobalt2" then
  -- require('colorbuddy').setup()
  require('colorbuddy').colorscheme('cobalt2')
  -- Group.new('italicBoldFunction', colors.green, groups.Function, styles.bold + styles.italic)
end

-- Kanagawa Colorscheme:
if colorscheme == "kanagawa" then
  require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = { bold = true },
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
  })
end

if colorscheme == "tokyonight" then
  -- Tokyonight Storm Colorscheme
  -- vim.g.tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
  -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
  -- vim.g.tokyonight_transparent_sidebar = 0

  -- Current Use Option
  vim.g.tokyonight_style = "night"
  -- vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_italic_variables = 1
  vim.g.tokyonight_italic_keywords = 1
  vim.g.tokyonight_lualine_bold = 1
  vim.g.tokyonight_italic_functions = 1
  vim.g.tokyonight_transparent = 0
  vim.g.tokyonight_dark_sidebar = 1
end

if colorscheme == "material" then
  vim.g.material_style = "deep ocean"
  require('material').setup({
    contrast = {
      sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = false, -- Enable contrast for floating windows
      line_numbers = false, -- Enable contrast background for line numbers
      sign_column = false, -- Enable contrast background for the sign column
      cursor_line = false, -- Enable darker background for the cursor line
      non_current_windows = false, -- Enable darker background for non-current windows
      popup_menu = false, -- Enable lighter background for the popup menu
    },

    italics = {
      comments = true, -- Enable italic comments
      keywords = false, -- Enable italic keywords
      functions = false, -- Enable italic functions
      strings = false, -- Enable italic strings
      variables = true -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
      "terminal", -- Darker terminal background
      "packer", -- Darker packer background
      "qf" -- Darker qf list background
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = false -- Enable higher contrast text for darker style
    },

    disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = false, -- Disable borders between verticaly split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false -- Hide the end-of-buffer lines
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_highlights = {
      -- CursorLine = { fg = '#0000FF', underline = false },
    }, -- Overwrite highlights with your own

    plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
      trouble = true,
      nvim_cmp = true,
      neogit = true,
      gitsigns = true,
      git_gutter = true,
      telescope = true,
      nvim_tree = true,
      sidebar_nvim = true,
      lsp_saga = true,
      nvim_dap = true,
      nvim_navic = true,
      which_key = true,
      sneak = true,
      hop = true,
      indent_blankline = true,
      nvim_illuminate = true,
      mini = true,
    }
 --    custom_highlights = {
	-- 	LineNr = { bg = '#FF0000' }
	-- 	CursorLine = { fg = '#0000FF', underline = true },
	--
	-- 	-- This is a list of possible values
	-- 	YourHighlightGroup = {
	-- 		fg = "#SOME_COLOR", -- foreground color
	-- 		bg = "#SOME_COLOR", -- background color
	-- 		sp = "#SOME_COLOR", -- special color (for colored underlines, undercurls...)
	-- 		bold = false, -- make group bold
	-- 		italic = false, -- make group italic
	-- 		underline = false, -- make group underlined
	-- 		undercurl = false, -- make group undercurled
	-- 		underdot = false, -- make group underdotted
	-- 		underdash = false -- make group underdotted
	-- 		striketrough = false, -- make group striked trough
	-- 		reverse = false, -- reverse the fg and bg colors
	-- 		link = "SomeOtherGroup" -- link to some other highlight group
	-- 	}
	-- }
  })
end


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

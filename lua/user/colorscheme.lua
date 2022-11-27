-- local colorscheme = "kanagawa"
--[[ local colorscheme = "tokyonight" ]]
local colorscheme = "cobalt2"
--[[ local colorscheme = "catppuccin" ]]
-- local colorscheme = "material"
--[[ local colorscheme = "nightfly" ]]
--[[ local colorscheme = "NeoSolarized" ]]
--[[ local colorscheme = "night-owl" ]]

-- NeoSolarized
if colorscheme == "NeoSolarized" then
  vim.g.NeoSolarized_italics = 1 -- 0 or 1
  vim.g.NeoSolarized_visibility = 'normal' -- low, normal, high
  vim.g.NeoSolarized_diffmode = 'normal' -- low, normal, high
  vim.g.NeoSolarized_termtrans = 1 -- 0(default) or 1 -> Transparency
  vim.g.NeoSolarized_lineNr = 0 -- 0 or 1 (default) -> To Show backgroung in LineNr
end

-- catppuccin
if colorscheme == "catppuccin" then
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

  require("catppuccin").setup({
    -- dim_inactive = {
    --   enabled = false,
    --   shade = "dark",
    --   percentage = 0.15,
    -- },
    transparent_background = false,
    --[[ term_colors = false, ]]
    compile = {
      enabled = true,
      path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
    styles = {
      comments = { "italic" },
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
    },
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
      lsp_saga = true,
      gitgutter = true,
      gitsigns = true,
      -- leap = false,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
      },
      --[[ neotree = { ]]
      --[[   enabled = false, ]]
      --[[   show_root = true, ]]
      --[[   transparent_panel = false, ]]
      --[[ }, ]]
      dap = {
        enabled = true,
        enable_ui = true,
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
      telekasten = false,
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
  vim.g.nightflyTransparent = 0
  vim.g.nightflyTerminalColors = 1
  vim.g.nightflyItalics = 1
  vim.g.nightflyNormalFloat = 1
  vim.g.nightflyCursorColor = 1
  vim.g.nightflyUnderlineMatchParen = true
  vim.g.nightflyWinSeparator = 2
end

if colorscheme == "cobalt2" then
  -- require('colorbuddy').setup()
  require('colorbuddy').colorscheme('cobalt2')
  require("cobalt2.utils").Group.new("Cursor", require("cobalt2.utils").colors.cobalt_bg,
    require("cobalt2.utils").colors.yellow, nil)
  -- Group.new('italicBoldFunction', colors.green, groups.Function, styles.bold + styles.italic)
end

-- Kanagawa Colorscheme:
if colorscheme == "kanagawa" then
  require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = { bold = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = { bold = true },
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = true, -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {},
  })
end

if colorscheme == "tokyonight" then
  require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = { bold = true },
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "transparent", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    --- param colors ColorScheme
    -- on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    --- param highlights Highlights
    --- param colors ColorScheme
    -- on_highlights = function(highlights, colors) end,
  })
end


if colorscheme ~= "cobalt2" then
  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not status_ok then
    return
  end
end

if colorscheme == "NeoSolarized" then
  vim.cmd [[
      highlight FloatBorder guibg=NONE ctermbg=NONE  " Removes the border of float menu (LSP and Autocompletion uses it)
      highlight link NormalFloat Normal
      highlight NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
      highlight Pmenu ctermbg=NONE guibg=NONE
  ]]
end

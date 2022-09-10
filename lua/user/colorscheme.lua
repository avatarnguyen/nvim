-- local colorscheme = "kanagawa"
-- local colorscheme = "tokyonight"
--[[ local colorscheme = "cobalt2" ]]
-- local colorscheme = "material"
-- local colorscheme = "nightfly"
local colorscheme = "catppuccin"
--[[ local colorscheme = "NeoSolarized" ]]

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
  vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
  -- vim.g.catppuccin_flavour = "mocha" -- darker theme

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

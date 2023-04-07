local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = "all", -- one of "all" or a list of languages
  -- ensure_installed = { "dart", "lua", "go", "help" },
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gn", -- set to `false` to disable one of the mappings
      node_incremental = "]v",
      node_decremental = "[v",
      scope_incremental = ";n",
    },
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "css" }, -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = true,
  },
  autotag = {
    enable = true,
    disable = { "xml" },
  },
  rainbow = {
    enable = true,
    colors = {
      "Gold",
      "Orchid",
      "DodgerBlue",
      -- "Cornsilk",
      -- "Salmon",
      -- "LawnGreen",
    },
    -- disable = { "html" },
  },
})

require "user.treesitter_object"
require "user.treesitter-context"


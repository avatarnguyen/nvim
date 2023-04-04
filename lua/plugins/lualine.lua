return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    require('user.lualine')
  end
}

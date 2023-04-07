return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    "kyazdani42/nvim-web-devicons",
		"folke/noice.nvim",
  },
  config = function()
    require('user.lualine')
  end
}

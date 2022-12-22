local cmp_status_ok, neoclip = pcall(require, "neoclip")
if not cmp_status_ok then
  return
end


neoclip.setup({
  history = 100,
  enable_persistent_history = true,
  length_limit = 1048576,
  continious_sync = true,
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
  filter = nil,
  preview = true,
  default_register = '"',
  default_register_macros = 'q',
  enable_macro_history = true,
  content_spec_column = false,
  on_paste = {
    set_reg = false,
  },
  on_replay = {
    set_reg = false,
  },
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-P>',
        replay = '<c-q>',
        delete = '<c-d>',
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = 'p',
        paste_behind = 'P',
        replay = 'q',
        custom = {},
      },
    },
  },
  fzf = {
    select = 'default',
    paste = 'ctrl-p',
    paste_behind = 'ctrl-k',
    custom = {},
  }
})

local telescope = require('user.telescope').telescope
telescope.load_extension('neoclip')

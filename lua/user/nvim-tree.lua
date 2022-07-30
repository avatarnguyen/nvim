local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  hijack_directories = {
    enable = true,
  },
  disable_netrw = true,
  hijack_netrw = false,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "alpha",
  },
  update_cwd = true,
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    -- highlight_opened_files = "none",
    root_folder_modifier = ":t",
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 34,
    height = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "O", cb = tree_cb "system_open" },
        { key = "P", cb = tree_cb "parent_node" },
        { key = "<", cb = tree_cb "prev_sibling" },
        { key = ">", cb = tree_cb "next_sibling" },
        { key = "K", cb = tree_cb "first_sibling" },
        { key = "J", cb = tree_cb "last_sibling" },
        { key = "<Tab>", cb = tree_cb "preview" },
        { key = "a", cb = tree_cb "create" },
        { key = "y", cb = tree_cb "copy_name" },
        { key = "Y", cb = tree_cb "copy_path" },
        { key = "gy", cb = tree_cb "copy_absolute_path" },
        { key = "g?", cb = tree_cb "toggle_help" },
        { key = "D", cb = tree_cb "trash" },
        { key = "d", cb = tree_cb "remove" },
        { key = "r", cb = tree_cb "rename" },
        { key = "R", cb = tree_cb "refresh" },
        { key = "<C-r>", cb = tree_cb "full_rename" },

      },
    },
  },
}

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then return end
          if stat.size > 20000 then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
        -- previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    color_devicons = true,

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules", "gen_l10n/", "analytics", ".pub-cache/", "flutter/packages/" },

    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },

    buffer_previewer_maker = new_maker,

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-c>"] = actions.close,
        ["<Esc>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        -- ["<Right>"] = actions.toggle_selection + actions.move_selection_worse,
        -- ["<Left>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["Right"] = actions.toggle_selection + actions.move_selection_worse,
        ["Left"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    lsp_references = {
      search_dirs = 'CWD',
    },
    old_files = {
      search_dirs = 'CWD',
    }
  },
  extensions = {
    fzf = {
      -- default
      -- fuzzy = true, -- false will only do exact matching
      -- override_generic_sorter = true, -- override the generic sorter
      -- override_file_sorter = true, -- override the file sorter
      -- case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    -- ["ui-select"] = {
    --   require("telescope.themes").get_cursor({}),
    -- },
    frecency = {
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*",  '*.pub-cache/*',  '*packages/*', 'pub.dartlang.org/*', '*/ios/*', '*/windows/*', '*/web/*', '*/android/*', '*/assets/*', '*/fonts/*', '*/doc/*', '*/l10n/*' },
      disable_devicons = false,
      search_dirs = 'CWD',
      workspaces = {
        --[[ 'CWD', ]]
        --[[ ["project"] = "/home/my_username/projects", ]]
        --[[ ["wiki"]    = "/home/my_username/wiki" ]]
      }
    },
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
      search_dirs = 'CWD',
      --[[ mappings = { ]]
      --[[   ["i"] = { ]]
      --[[     -- your custom insert mode mappings ]]
      --[[   }, ]]
      --[[   ["n"] = { ]]
      --[[     -- your custom normal mode mappings ]]
      --[[   }, ]]
      --[[ }, ]]
    },
  },
}

--[[ telescope.load_extension("git_worktree") ]]
telescope.load_extension('neoclip')
telescope.load_extension('harpoon')
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension("frecency")
--[[ return telescope ]]

local M = {}

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

M.telescope = telescope

telescope.setup {
  defaults = {

    color_devicons = true,

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { "%.g.dart", "%.freezed.dart", ".git/", "node_modules", "gen_l10n/", "analytics",
      ".pub-cache/", "flutter/packages/" },

    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      width = 0.9,
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
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
    },
    grep_string = {
      only_sort_text = true,
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    lsp_references = {
      search_dirs = 'CWD',
      -- layout_config = {
      --   width = 0.7,
      -- }
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
      show_unindexed = false,
      ignore_patterns = { "*.git/*", "*/tmp/*", '*.pub-cache/*', '*packages/*', 'pub.dartlang.org/*', '*/ios/*',
        '*/windows/*', '*/web/*', '*/android/*', '*/assets/*', '*/fonts/*', '*/doc/*', '*/l10n/*' },
      disable_devicons = false,
      search_dirs = 'CWD',
      workspaces = {
        'CWD',
        --[[ ["project"] = "/home/my_username/projects", ]]
        --[[ ["wiki"]    = "/home/my_username/wiki" ]]
      }
    },
    recent_files = {
      only_cwd = true,
      -- ignore_patterns = {"/tmp/"}
    },
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.7,
      },
    },
  },
}

-- M.getMyToDos = function()
--
-- end

telescope.load_extension("noice")
telescope.load_extension("recent_files")
telescope.load_extension('fzf')

local action_state = require "telescope.actions.state"

M.sorted_buffers = function(opts)
  opts = opts or {}
  opts.attach_mappings = function(prompt_bufnr, map)
    local delete_buf = function()
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)
      vim.api.nvim_buf_delete(selection.bufnr, { force = true })
    end
    map("i", "<c-x>", delete_buf)
    return true
  end
  opts.previewer = false
  -- define more opts here
  -- opts.show_all_buffers = true
  opts.sort_mru = true
  -- opts.shorten_path = false
  require("telescope.builtin").buffers(
    require("telescope.themes").get_dropdown(opts)
  )
end

return M

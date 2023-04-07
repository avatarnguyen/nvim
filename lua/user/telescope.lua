local M = {}

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local builtin = require("telescope.builtin")
-- local conf = require('telescope.config')
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
          if not stat then
            return
          end
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
    end,
  }):sync()
end

local actions = require("telescope.actions")

local windows_picker = function(prompt_bufnr)
          -- Use nvim-window-picker to choose the window by dynamically attaching a function
          local action_set = require("telescope.actions.set")
          local action_state = require("telescope.actions.state")

          local picker = action_state.get_current_picker(prompt_bufnr)
          ---@diagnostic disable-next-line: unused-local
          picker.get_selection_window = function(picker, entry)
            local picked_window_id = require("window-picker").pick_window()
                or vim.api.nvim_get_current_win()
            -- Unbind after using so next instance of the picker acts normally
            picker.get_selection_window = nil
            return picked_window_id
          end

          return action_set.edit(prompt_bufnr, "edit")
        end

M.telescope = telescope

telescope.setup({
  defaults = {
    color_devicons = true,
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = {
      "%.g.dart",
      "%.freezed.dart",
      ".git/",
      "node_modules",
      "gen_l10n/",
      "analytics",
      ".pub-cache/",
      "flutter/packages/",
    },
    buffer_previewer_maker = new_maker,
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-c>"] = actions.close,
        ["<Esc>"] = actions.close,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
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
        ["<C-g>"] = windows_picker,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-g>"] = windows_picker,
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
          ["<C-x>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    lsp_document_symbols = {
      theme = "dropdown",
      layout_config = {
        width = 0.6,
      },
    },
    lsp_references = {
      search_dirs = "CWD",
      theme = "dropdown",
      fname_width = 50,
      initial_mode = "normal",
      layout_config = {
        width = 0.6,
      },
    },
    lsp_dynamic_workspace_symbols = {
      search_dirs = "CWD",
      theme = "dropdown",
      fname_width = 70,
      layout_config = {
        width = 0.7,
      },
    },
    old_files = {
      search_dirs = "CWD",
      initial_mode = "normal",
    },
    current_buffer_fuzzy_find = {
      theme = "dropdown",
      fname_width = 50,
      layout_config = {
        width = 0.6,
      },
    },
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
    harpoon = {
      theme = "dropdown",
      initial_mode = "normal",
      layout_config = {
        width = 0.6,
      },
    },
    frecency = {
      -- db_root = "home/my_username/path/to/db_root",
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = {
        "*.git/*",
        "*/tmp/*",
        "*/packages/*",
        "*/test/*",
        "*/ios/*",
        "*/android/*",
        "*/windows/*",
        "*/linux/*",
        "*/assets/*",
        "*/macos/*",
        "*/web/*",
      },
      disable_devicons = false,
      workspaces = {
        -- ["conf"]    = "/home/my_username/.config",
        -- ["data"]    = "/home/my_username/.local/share",
        -- ["project"] = "/home/my_username/projects",
        -- ["wiki"]    = "/home/my_username/wiki"
      },
    },
  },
})

-- telescope.load_extension("noice")
telescope.load_extension("undo")
telescope.load_extension("recent_files")
telescope.load_extension("harpoon")

local action_state = require("telescope.actions.state")

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
  require("telescope.builtin").buffers(require("telescope.themes").get_dropdown(opts))
end

-- Implement delta as previewer for diffs
local delta = previewers.new_termopen_previewer({
  get_command = function(entry)
    -- this is for status
    -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
    -- just do an if and return a different command
    if entry.status == "??" or "A " then
      return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value }
    end

    -- note we can't use pipes
    -- this command is for git_commits and git_bcommits
    return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
  end,
})

-- local delta = previewers.new_termopen_previewer {
--   get_command = function(entry)
--     return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!', '--',
--       entry.current_file }
--   end
-- }

M.delta_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_commits(opts)
end

M.delta_git_status = function(opts)
  opts = opts or {}

  opts.previewer = delta
  opts.initial_mode = "normal"
  opts.layout_strategy = "vertical"
  opts.layout_config = {
    height = 0.98,
    preview_height = 0.75,
  }

  builtin.git_status(opts)
end

M.delta_git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = {
    delta,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  builtin.git_bcommits(opts)
end

-- local conf = require("telescope.config").values
-- local themes = require("telescope.themes")
-- local builtin = require("telescope.builtin")
-- local action_state = require("telescope.actions.state")



-- local function chained_live_grep(opts)
--   opts = opts or themes.get_ivy {}
--   builtin.live_grep(vim.tbl_deep_extend("force", {
--     prompt_title = "Search",
--     attach_mappings = function(_, map)
--       local fuzzy_filter_results = function()
--         local query = action_state.get_current_line()
--         if not query then
--           print "no matching results"
--           return
--         end
--         opts.search = query
--         opts.prompt_title = "Filter"
--         opts.prompt_prefix = "/" .. query .. " >> "
--         builtin.grep_string(opts)
--       end
--
--       local dynamic_filetype = function()
--         local entry = action_state.get_selected_entry()
--         local onlytype = vim.fn.fnamemodify(entry.filename, ":e")
--         opts.vimgrep_arguments = vim.deepcopy(conf.vimgrep_arguments)
--         opts.prompt_prefix = opts.prompt_prefix or "*." .. onlytype .. " >> "
--         opts.prompt_title = "Scoped Results"
--         vim.list_extend(opts.vimgrep_arguments, { "--type=" .. onlytype })
--         builtin.live_grep(opts)
--       end
--
--       local dynamic_filetype_skip = function()
--         local entry = action_state.get_selected_entry()
--         local skiptype = vim.fn.fnamemodify(entry.filename, ":e")
--         opts.vimgrep_arguments = vim.deepcopy(conf.vimgrep_arguments)
--         opts.prompt_prefix = opts.prompt_prefix or "!*." .. skiptype .. " >> "
--         opts.prompt_title = "Scoped Results"
--         vim.list_extend(opts.vimgrep_arguments, { "--type-not=" .. skiptype })
--         builtin.live_grep(opts)
--       end
--
--       map("i", "<C-space>", fuzzy_filter_results)
--       map("n", "<C-space>", fuzzy_filter_results)
--       map("i", "<C-b>", dynamic_filetype)
--       map("n", "<C-b>", dynamic_filetype)
--       map("i", "<M-b>", dynamic_filetype_skip)
--       map("n", "<M-b>", dynamic_filetype_skip)
--       return true
--     end,
--   }, opts))
-- end
--
-- chained_live_grep()

-- Picker:new{
--    prompt_title = "Prompt1",
--    finder = finders.new_table {
--      results = (function()
--        return func1()
--      end)()
--    },
--    sorter = sorters.get_generic_fuzzy_sorter(),
--    attach_mappings = function(prompt_bufnr)
--      actions.select_default:replace(function()
--        local selection = action_state.get_selected_entry()
--        local val1 = selection.value
--        actions._close(prompt_bufnr, true)
--        Picker:new{
--          prompt_title = "Prompt2",
--          finder = finders.new_table {
--            results = (function()
--              return func2()
--            end)()
--          },
--          sorter = sorters.get_generic_fuzzy_sorter(),
--          attach_mappings = function(prompt_bufnr)
--            actions.select_default:replace(
--                function()
--                  selection = action_state.get_selected_entry()
--                  actions._close(prompt_bufnr, true)
--                  local val2 = selection.value
--                  fun(val1, val2)
--                end)
--            return true
--          end
--        }:find()
--      end)
--      return true
--    end
--  }:find()

return M

local status_ok, overseer = pcall(require, "overseer")
if not status_ok then
  vim.api.nvim_err_writeln "Failed to load overseer"
  return
end

overseer.setup({
  -- Configure the floating window used for confirmation prompts
  confirm = {
    border = "rounded",
    zindex = 40,
    -- Dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_X and max_X can be a single value or a list of mixed integer/float types.
    min_width = 20,
    max_width = 0.5,
    width = nil,
    min_height = 6,
    max_height = 0.9,
    height = nil,
    -- Set any window options here (e.g. winhighlight)
    win_opts = {
      winblend = 10,
    },
  },
  -- Configuration for task floating windows
  task_win = {
    -- How much space to leave around the floating window
    padding = 2,
    border = "rounded",
    -- Set any window options here (e.g. winhighlight)
    win_opts = {
      winblend = 10,
    },
  },
})

-- TODO: set up template
-- overseer.register_template({
--   {
--     -- Required fields
--     name = "Some Task",
--     builder = function(params)
--       -- This must return an overseer.TaskDefinition
--       return {
--         -- cmd is the only required field
--         cmd = {'echo'},
--         -- additional arguments for the cmd
--         args = {"hello", "world"},
--         -- the name of the task (defaults to the cmd of the task)
--         name = "Greet",
--         -- set the working directory for the task
--         cwd = "CWD",
--         -- additional environment variables
--         --[[ env = { ]]
--         --[[   VAR = "FOO", ]]
--         --[[ }, ]]
--         -- the list of components or component aliases to add to the task
--         --[[ components = {"my_custom_component", "default"}, ]]
--         -- arbitrary table of data for your own personal use
--         --[[ metadata = { ]]
--         --[[   foo = "bar", ]]
--         --[[ }, ]]
--       }
--     end,
--     -- Optional fields
--     desc = "Optional description of task",
--     -- Tags can be used in overseer.run_template()
--     tags = {overseer.TAG.BUILD},
--     params = {
--       -- See :help overseer.params
--     },
--     -- Determines sort order when choosing tasks. Lower comes first.
--     priority = 50,
--     -- Add requirements for this template. If they are not met, the template will not be visible.
--     -- All fields are optional.
--     condition = {
--       -- A string or list of strings
--       -- Only matches when current buffer is one of the listed filetypes
--       filetype = {"dart"},
--       -- A string or list of strings
--       -- Only matches when cwd is inside one of the listed dirs
--       --[[ dir = "/home/user/my_project", ]]
--       -- Arbitrary logic for determining if task is available
--       callback = function(search)
--         print(vim.inspect(search))
--         return true
--       end,
--     },
--   }
-- })

local status_ok, autosave = pcall(require, "autosave")
if not status_ok then
  return
end

autosave.setup(
  {
    enabled = true,
    execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    events = { "WinEnter" }, -- , "InsertLeave", "TextChanged"
    conditions = {
      exists = true,
      filename_is_not = {},
      filetype_is_not = { 'lua' },
      modifiable = true
    },
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 0,
    debounce_delay = 135
  }
)

autosave.hook_before_saving = function()
  -- vim.lsp.buf.format({ async = true })
  -- if <condition> then
  --     vim.g.auto_save_abort = true -- Save will be aborted
  -- end
end

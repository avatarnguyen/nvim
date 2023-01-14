local status_ok, inlay_hints = pcall(require, "inlay-hints")
if not status_ok then
  return
end

local M = {}

inlay_hints.setup({
  only_current_line = true,

  -- eol = {
  --   right_align = true,
  -- }
})

M.on_attach = function(client, bufnr)
  inlay_hints.on_attach(client, bufnr)
end

return M

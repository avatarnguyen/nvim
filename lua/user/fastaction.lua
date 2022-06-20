local status_ok, fastaction = pcall(require, "lsp-fastaction")
if not status_ok then
  return
end

fastaction.setup({
  hide_cursor = true,
  action_data = {
    --- action for filetype dart
    ['dart'] = {
      -- pattern is a lua regex with lower case
      { pattern = 'import library', key = 'i', order = 1 },
      { pattern = 'wrap with widget', key = 'w', order = 2 },
      { pattern = 'wrap with column', key = 'c', order = 3 },
      { pattern = 'wrap with row', key = 'r', order = 3 },
      { pattern = 'wrap with sizedbox', key = 's', order = 3 },
      { pattern = 'wrap with container', key = 'C', order = 4 },
      { pattern = 'wrap with center', key = 'E', order = 4 },
      { pattern = 'padding', key = 'P', order = 4 },
      { pattern = 'wrap with streambuilder', key = 'S', order = 5 },
      { pattern = 'remove', key = 'R', order = 5 },
      { pattern = "add 'const' modifier", key = 'd', order = 6 },
      { pattern = 'extract widget', key = 'e', order = 7 },
      { pattern = 'extract method', key = 'M', order = 7 },

      --range code action
      { pattern = "surround with %'if'", key = 'i', order = 2 },
      { pattern = 'try%-catch', key = 't', order = 2 },
      { pattern = 'for%-in', key = 'f', order = 2 },
      { pattern = 'setstate', key = 's', order = 2 },
    },
  },
})


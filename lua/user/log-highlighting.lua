-- does not work
vim.cmd [[
  augroup _log
    autocmd! 
    autocmd rc Syntax log syn keyword logLevelError MY_CUSTOM_ERROR_KEYWORD
  augroup end
]]

  -- au rc Syntax log syn match logLevelDebug '[32mD * [0m'

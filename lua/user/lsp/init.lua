local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- require "user.lsp.lsp-installer"
require "user.lsp.flutter"
-- require "user.lsp.go"
require "user.lsp.mason"
require "user.lsp.lsp-signature"
--[[ require "user.lsp.navigator" ]]
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

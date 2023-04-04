local servers = {
  -- "cssls",
  -- "html",
  -- "tsserver",
  -- "pyright",
  -- "bashls",
  "lua_ls",
  "jsonls",
  -- "gopls",
  -- "yamlls",
  -- "ruby-lsp"
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

-- local configs = require 'lspconfig/configs'
-- if not configs.golangcilsp then
--  	configs.golangcilsp = {
-- 		default_config = {
-- 			cmd = {'golangci-lint-langserver'},
--             -- make rootdir .golangcilint with config for linter
-- 			root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
-- 			init_options = {
-- 					command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json" };
-- 			}
-- 		};
-- 	}
-- end


for _, server in pairs(servers) do

  -- Go Setup
  if server == 'gopls' then
    require "user.go_minimal"
    lspconfig.golangci_lint_ls.setup {}
    -- require "user.lsp.go"
    -- opts = require 'go.lsp'.config()

    local util = require "lspconfig/util"
    opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      cmd = { "gopls", "serve" },
      filetypes = { "go", "gomod" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = false,
            compositeLiteralTypes = false,
            constantValues = false,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = false,
            useany = false,
            unreachable = false, -- Disable the unreachable analyzer.
          },
          gofumpt = true,
          experimentalPostfixCompletions = true,
          staticcheck = false,
          usePlaceholders = true,
        },
      },
      --   -- flags = {
      --   --   debounce_text_changes = 150,
      --   -- },
    }
  elseif server == 'sumneko_lua' then
    require "user.lsp.inlay"
    opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      settings = {
        Lua = {
          hint = {
            enable = true,
          },
        },
      },
    }
  else
    opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }
  end

  server = vim.split(server, "@")[1]

  lspconfig[server].setup(opts)
  -- use vscode jsonls lsp instead
  -- local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  -- if require_ok then
  --   opts = vim.tbl_deep_extend("force", conf_opts, opts)
  -- end
end

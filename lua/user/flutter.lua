local status_ok, flutter = pcall(require, "flutter-tools")
if not status_ok then
  return
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight and client.name == "dartls" then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

flutter.setup{
  flutter_path = "$HOME/fvm/default", -- <-- this takes priority over the lookup
  fvm = true, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  dev_log = {
    open_cmd = "tabedit",
  },
  outline = {
    open_cmd = "60vnew", -- command to use to open the outline buffer
    auto_open = false -- if true this will open the outline automatically when it is first populated
  },
  decorations = {
    statusline = {
      app_version = false,
      device = false,
    }
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
    register_configurations = function(_)
      require("dap").configurations.dart = {
        -- <put here config that you would find in .vscode/launch.json>
      }
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      background = true, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    on_attach = function (client, bufnr)
      -- on_attach = on_attach,
     lsp_highlight_document(client)
    end,
   -- capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
   --- OR you can specify a function to deactivate or change or control how the config is created
   capabilities = function(config)
     -- config.flags.debounce_did_change_notify = 250
     return config
   end,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/flutter/.pub-cache"),
        vim.fn.expand("$HOME/fvm"),
        vim.fn.expand("$HOME/flutter/packages")
      },
      lineLength = 300,
    }
  }
}

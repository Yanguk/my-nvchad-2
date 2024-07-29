local map = vim.keymap.set
local lsp_zero = require("lsp-zero")

local capabilities = lsp_zero.get_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })

  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  if client.server_capabilities.inlayHintProvider then
    map("n", "<leader>ih", function()
      local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

      vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
    end, opts("Lsp toggle inlay hints"))
  end
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "tsserver", "rust_analyzer" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_init = on_init,
      })
    end,
    rust_analyzer = lsp_zero.noop,
    tsserver = lsp_zero.noop,
  },
})

--------
vim.g.rustaceanvim = {
  server = {
    on_init = on_init,
    capabilities = capabilities,
    default_settings = {
      ["rust-analyzer"] = {
        command = "clippy",
      },
    },
  },
}

require("typescript-tools").setup({
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      importModuleSpecifierPreference = "non-relative",
    },
  },
})

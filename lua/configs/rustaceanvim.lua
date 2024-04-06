local default_config = require("configs.default-lsp")

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_init = default_config.on_init,
    on_attach = default_config.on_attach,
    capabilities = default_config.capabilities,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        command = "clippy",
      },
    },
  },
  -- DAP configuration
  dap = {},
}

local default_config = require("configs.default-lsp")

return {
  on_init = default_config.on_init,
  on_attach = default_config.on_attach,
  capabilities = default_config.capabilities,
  settings = {
    tsserver_file_preferences = {
      importModuleSpecifierPreference = "non-relative",
    },
  },
}

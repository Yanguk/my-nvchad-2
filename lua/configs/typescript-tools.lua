local default_config = require("configs.default-lsp")
local lspconfig = require("lspconfig")

return {
  on_init = default_config.on_init,
  on_attach = default_config.on_attach,
  capabilities = default_config.capabilities,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      importModuleSpecifierPreference = "non-relative",
    },
  },
  root_dir = lspconfig.util.root_pattern("package.json"),
}

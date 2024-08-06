---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack

local lspconfig = require("lspconfig")
local default_config = require("configs.default-lsp")

local server_configs = {
  "yamlls",
  "tailwindcss",
  "graphql",
  "kotlin_language_server",

  ["eslint"] = {
    on_attach = function(client, bufnr)
      default_config.on_attach(client, bufnr)

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    settings = (function()
      local config = {}

      local yarn_path = vim.fn.getcwd() .. "/.yarn"
      local is_yarn_pnp = vim.fn.isdirectory(yarn_path) == 1

      if is_yarn_pnp then
        config.nodePath = vim.fn.getcwd() .. "/.yarn/sdks"
      end

      return config
    end)(),
  },
  ["bashls"] = {
    filetypes = { "sh", "zsh", "bash" },
  },
  ["clangd"] = {
    capabilities = vim.tbl_extend("force", default_config.capabilities, {
      offsetEncoding = "utf-16",
    }),
  },
}

for k, v in pairs(server_configs) do
  local server, config = table.unpack(
    type(k) == "number" and { v, default_config } or { k, vim.tbl_deep_extend("force", default_config, v) }
  )

  lspconfig[server].setup(config)
end

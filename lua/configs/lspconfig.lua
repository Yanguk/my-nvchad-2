local map = vim.keymap.set
local nomap = vim.keymap.del
---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack

local lspconfig = require("lspconfig")
local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

-- nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local default_config = {
  on_init = on_init,
  on_attach = function(client, bufnr)
    nomap("n", "gr")
    nomap("n", "gd")
    on_attach(client, bufnr)
    nomap("n", "gr")
    nomap("n", "gd")
  end,
  capabilities = capabilities,
}

local server_configs = {
  "yamlls",

  ["tsserver"] = {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "non-relative",
      },
    },
  },
  ["eslint"] = {
    on_attach = function(client, bufnr)
      default_config.on_attach(client, bufnr)

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    settings = (function()
      local yarn_path = vim.fn.getcwd() .. "/.yarn"
      local is_yarn_pnp = vim.fn.isdirectory(yarn_path) == 1
      local nodePath = is_yarn_pnp and vim.fn.getcwd() .. "/.yarn/sdks" or nil

      return { nodePath }
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
  ["rust_analyzer"] = {
    settings = {
      ["rust-analyzer"] = {
        command = "clippy",
      },
    },
  },
}

for k, v in pairs(server_configs) do
  local server, config = table.unpack(
    type(k) == "number" and { v, default_config } or { k, vim.tbl_deep_extend("force", default_config, v) }
  )

  if server == "rust_analyzer" then
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = config,
      -- DAP configuration
      dap = {},
    }
  else
    lspconfig[server].setup(config)
  end
end

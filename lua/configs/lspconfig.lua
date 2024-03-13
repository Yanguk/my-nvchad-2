-- cSpell:disable
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
    on_attach(client, bufnr)

    -- Instead of using 'gr', trouble is used.
    map("n", "<leader>D", "<cmd>TroubleToggle lsp_type_definition<CR>", { desc = "trouble lsp_references", buffer = bufnr })
    map("n", "gr", "<cmd>TroubleToggle lsp_implementations<CR>", { desc = "trouble lsp_references", buffer = bufnr })
    map("n", "gl", "<cmd>TroubleToggle lsp_references<CR>", { desc = "trouble lsp_references", buffer = bufnr })
    map("n", "gd", "<cmd>TroubleToggle lsp_definitions<CR>", { desc = "trouble lsp_references", buffer = bufnr })
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
  ["rust_analyzer"] = {
    settings = {
      ["rust-analyzer"] = {
        command = "clippy",
      },
    },
  },
  ["lua_ls"] = {
    on_attach = default_config.on_attach,
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

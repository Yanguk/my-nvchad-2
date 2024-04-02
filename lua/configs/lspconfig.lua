-- cSpell:disable
local map = vim.keymap.set

---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack

local lspconfig = require("lspconfig")
local configs = require("nvchad.configs.lspconfig")

local nvchad_on_attach = configs.on_attach
local nvchad_on_init = configs.on_init
local nvchad_capabilities = configs.capabilities

local default_config = {
  on_init = nvchad_on_init,
  on_attach = function(client, bufnr)
    nvchad_on_attach(client, bufnr)

    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    -- Instead of using 'gr', trouble is used.
    map("n", "<leader>D", "<cmd>Trouble lsp_type_definition<CR>", opts("Trouble lsp_type_definition"))
    map("n", "gi", "<cmd>Trouble lsp_implementations<CR>", opts("Trouble lsp_implementations"))
    map("n", "gr", "<cmd>Trouble lsp_references<CR>", opts("Trouble lsp_references"))
    map("n", "gd", "<cmd>Trouble lsp_definitions<CR>", opts("Trouble lsp_definitions"))
  end,
  capabilities = nvchad_capabilities,
}

-- nvim-ufo (ts 에서 배열을 폴드할려면 lsp로 해야함)
default_config.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local server_configs = {
  "yamlls",
  "lua_ls",

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
}

for k, v in pairs(server_configs) do
  local server, config = table.unpack(
    type(k) == "number" and { v, default_config } or { k, vim.tbl_deep_extend("force", default_config, v) }
  )

  lspconfig[server].setup(config)
end

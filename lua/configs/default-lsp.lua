-- cSpell:disable
local map = vim.keymap.set
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

    if client.server_capabilities.inlayHintProvider then
      map("n", "<leader>ih", function()
        local current_setting = vim.lsp.inlay_hint.is_enabled(bufnr)
        vim.lsp.inlay_hint.enable(bufnr, not current_setting)
      end, opts("Lsp toggle inlay hints"))
    end
  end,
  capabilities = nvchad_capabilities,
}

-- nvim-ufo (ts 에서 배열을 폴드할려면 lsp로 해야함)
default_config.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

return default_config

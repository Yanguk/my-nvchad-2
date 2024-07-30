-- cSpell:disable
local map = vim.keymap.set
local configs = require("nvchad.configs.lspconfig")

local nvchad_on_attach = configs.on_attach
local nvchad_on_init = configs.on_init
local nvchad_capabilities = configs.capabilities

local default_config = {
  capabilities = nvchad_capabilities,
  on_init = nvchad_on_init,
  on_attach = function(client, bufnr)
    nvchad_on_attach(client, bufnr)

    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    -- Instead of using 'gr', trouble is used.
    map(
      "n",
      "<leader>D",
      "<cmd>Trouble lsp_type_definition toggle focus=true auto_refresh=false<CR>",
      opts("Trouble lsp_type_definition")
    )
    map(
      "n",
      "gi",
      "<cmd>Trouble lsp_implementations toggle focus=true auto_refresh=false<CR>",
      opts("Trouble lsp_implementations")
    )
    map(
      "n",
      "gr",
      "<cmd>Trouble lsp_references toggle focus=true auto_refresh=false<CR>",
      opts("Trouble lsp_references")
    )
    map(
      "n",
      "gd",
      "<cmd>Trouble lsp_definitions toggle focus=true auto_refresh=false<CR>",
      opts("Trouble lsp_definitions")
    )

    if client.server_capabilities.inlayHintProvider then
      map("n", "<leader>th", function()
        local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end, opts("[T]oggle inlay [H]ints"))
    end
  end,
}

-- nvim-ufo (ts 에서 배열을 폴드할려면 lsp로 해야함)
default_config.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

return default_config

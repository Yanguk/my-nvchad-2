local null_ls = require("null-ls")

local cspell_path = vim.fn.expand "$HOME/.config/nvim/cspell/cspell.json"
local cspell_config = {
  find_json = function()
    return cspell_path
  end,
}

local cspell = require "cspell"

local sources = {
  cspell.diagnostics.with { config = cspell_config },
  cspell.code_actions.with { config = cspell_config },
}

null_ls.setup {
  sources = sources,
}


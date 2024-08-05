-- cSpell:disable
local nvim_lint = require("lint")

nvim_lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

local origin_cspell = nvim_lint.linters.cspell

table.insert(origin_cspell.args, "--config")
table.insert(origin_cspell.args, vim.fn.expand("$HOME/.config/nvim/cspell/cspell.json"))

local callback = function()
  nvim_lint.try_lint()
  nvim_lint.try_lint("cspell")
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = callback,
})

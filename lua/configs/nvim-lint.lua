local nvim_lint = require("lint")

nvim_lint.linters_by_ft = {
  ["typescript"] = { "cspell" },
  ["json"] = { "cspell" },
  ["rust"] = { "cspell" },
  ["toml"] = { "cspell" },
  ["lua"] = { "cspell" },
  ["yaml"] = { "cspell" },
}

local origin_cspell = nvim_lint.linters.cspell

table.insert(origin_cspell.args, "--config")
table.insert(origin_cspell.args, vim.fn.expand("$HOME/.config/nvim/cspell/cspell.json"))

local callback = function()
  nvim_lint.try_lint()
end

vim.schedule(callback)

vim.api.nvim_create_autocmd({ "BufRead" }, {
  callback = callback,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = callback,
})

local nvim_lint = require("lint")

nvim_lint.linters_by_ft = {}

local callback = function()
  nvim_lint.try_lint()
  nvim_lint.try_lint("codespell")
end

vim.schedule(callback)

vim.api.nvim_create_autocmd({ "BufRead" }, {
  callback = callback,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = callback,
})

-- cSpell:disable
require("nvchad.options")

-- add yours here!
local opt = vim.opt
local o = vim.o
local autocmd = vim.api.nvim_create_autocmd

----------- default options -----------
o.termguicolors = true
opt.wrap = false
opt.swapfile = false -- don't create backup files

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- add filetype --
vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

----------- plugin -----------

-- UFO folding
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

--------- rustaceanvim ---------
require("configs.rustaceanvim")

-- 자동포멧 비활성화
vim.g.disable_autoformat = true
-- conform toggle --
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- ts 프로젝트에서는 자동포멧 비활성화
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "typescript", "typescriptreact", "javascript" },
--   callback = function()
--   end,
-- })

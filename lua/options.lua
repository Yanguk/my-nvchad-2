-- cSpell:disable
require("nvchad.options")

-- add yours here!
local opt = vim.opt
local o = vim.o
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

----------- default options -----------
o.termguicolors = true
opt.wrap = false
opt.swapfile = false -- don't create backup files

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

-- conform toggle --
command("FormatDisable", function(args)
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

command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- ts 프로젝트에서는 자동포멧 비활성화
autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript" },
  command = "FormatDisable",
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

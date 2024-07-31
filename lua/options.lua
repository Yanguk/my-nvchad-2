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

----------- plugin -----------
-- UFO folding
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

--------- rustaceanvim ---------
require("configs.rustaceanvim")

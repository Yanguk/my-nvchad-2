-- cSpell:disable
local opt = vim.opt
local o = vim.o
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = " "
vim.cmd.colorscheme "gruvbox-baby"

------
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

----------- default options -----------
-- vim.loader.enable()
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

o.termguicolors = true
opt.wrap = false
opt.whichwrap:append "<>[]hl"

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

vim.treesitter.language.register("markdown", "mdx")

--- backup ---
require("backup")

-- cSpell:disable
local opt = vim.opt
local o = vim.o
local autocmd = vim.api.nvim_create_autocmd

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
vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

o.termguicolors = true
opt.wrap = false

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- 주석처리 에 대한 포멧팅 옵션
-- vim.cmd([[autocmd FileType * set formatoptions-=cro]])

----------- fileTypes -----------
-- autocmd("FileType", {
--   pattern = { "typescriptreact", "typescript" },
--   callback = function()
--     opt.tabstop = 4
--     opt.shiftwidth = 4
--     opt.softtabstop = 4
--     opt.expandtab = false
--   end,
-- })

-- autocmd("FileType", {
--   pattern = "yaml",
--   callback = function()
--     opt.tabstop = 2
--     opt.shiftwidth = 2
--     opt.softtabstop = 2
--     opt.expandtab = true
--   end,
-- })

vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

vim.treesitter.language.register("markdown", "mdx")

----------- plugin -----------
-- UFO folding
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

--------- rustaceanvim ---------
-- require("configs.rustaceanvim")

--- backup ---
require("backup")

vim.cmd.colorscheme "gruvbox-baby"

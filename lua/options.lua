-- cSpell:disable
require("nvchad.options")

-- add yours here!
local opt = vim.opt
local o = vim.o
local autocmd = vim.api.nvim_create_autocmd

----------- default options -----------
vim.loader.enable()
o.termguicolors = true
opt.wrap = false
opt.swapfile = false -- don't create backup files

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

autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true
  end,
})

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
require("configs.rustaceanvim")

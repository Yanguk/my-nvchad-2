require "nvchad.options"

-- add yours here!

-- cSpell:disable
local opt = vim.opt
local o = vim.o
local autocmd = vim.api.nvim_create_autocmd

vim.loader.enable()

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- goToTab
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- tab
autocmd("FileType", {
  pattern = { "typescriptreact", "typescript" },
  callback = function()
    -- opt.tabstop = 4
    -- opt.shiftwidth = 4
    -- opt.softtabstop = 4
    opt.expandtab = false
  end,
})

o.termguicolors = true
opt.wrap = false

-- don't create backup files
opt.swapfile = false

-- UFO folding
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.cmd [[autocmd FileType * set formatoptions-=cro]]

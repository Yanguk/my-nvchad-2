-- cSpell:disable
require("nvchad.mappings")

local map = vim.keymap.set
local nomap = vim.keymap.del

-- delete default map nvcahd terminal
nomap("n", "<C-n>")
nomap("n", "<leader>e")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<leader>/")
nomap("n", "<leader>b")
nomap("n", "<leader>rn")

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- add yours here

-- Trailing Space 플러그인 관련 매핑
map(
  "n",
  "<leader>ts",
  (function()
    local isHighlightEnabled = false

    return function()
      if isHighlightEnabled then
        vim.cmd("highlight clear ExtraWhitespace")
        vim.cmd("match none")
      else
        vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
        vim.cmd("match ExtraWhitespace /\\s\\+$/")
      end

      isHighlightEnabled = not isHighlightEnabled
    end
  end)(),
  { desc = "[T]oggle trailing [S]pace" }
) -- 뒤에 공백 토글

-- buffer
map("n", "<leader>tx", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close Buffer" })

-- codeRunner
map("n", "<leader>cr", function()
  local current_file = vim.fn.expand("%:p")
  local compiled_file = vim.fn.expand("%:t:r")

  local ft_cmds = {
    python = "python3 " .. current_file,
    racket = "csi -script " .. current_file,
    c = "gcc " .. current_file .. " -o " .. compiled_file .. " && " .. "./" .. compiled_file,
    cpp = "g++ " .. current_file .. " -o " .. compiled_file .. " && " .. "./" .. compiled_file,
  }

  if ft_cmds[vim.bo.filetype] == nil then
    vim.notify("No runner for " .. vim.bo.filetype)

    return
  end

  require("nvchad.term").runner({
    id = "runner",
    pos = "sp",
    cmd = ft_cmds[vim.bo.filetype],
  })
end, { desc = "codeRunner run" })

-- resize window
map("n", "<A-=>", ":vertical resize +5<CR>") -- make the window biger vertically
map("n", "<A-->", ":vertical resize -5<CR>") -- make the window smaller vertically
map("n", "<A-+>", ":resize +2<CR>") -- make the window bigger horizontally by pressing shift and =
map("n", "<A-_>", ":resize -2<CR>") -- make the window smaller horizontally by pressing shift and -

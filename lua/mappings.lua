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
nomap("n", "<leader>th")
nomap("n", "<leader>rn")

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- add yours here

-- Spectre 플러그인 관련 매핑
map("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", { desc = "Open Spectre" }) -- Spectre 열기
map(
  "n",
  "<leader>sw",
  "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
  { desc = "Search current word" }
) -- 현재 단어 검색
map(
  "n",
  "<leader>sp",
  "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
  { desc = "Search on current file" }
) -- 현재 파일에서 검색
map("v", "<leader>sw", "<esc><cmd>lua require('spectre').open_visual()<CR>", { desc = "Search current word" }) -- 현재 선택한 단어 검색
map("n", "<leader>sc", function()
  local current_dir = vim.fn.expand("%:p:h")
  local splited_dir = vim.split(current_dir, "/src")
  local project_dir = vim.split(splited_dir[1], "/")

  local target_project = table.remove(project_dir)

  require("spectre").open({
    is_insert_mode = true,
    is_close = true,
    path = "**/" .. target_project .. "/src/**",
  })
end, { desc = "Search on current project" }) -- 현재 프로젝트에서 검색

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

-- Diffview 플러그인 관련 매핑
map("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "Diffview open" }) -- Diffview 열기
map("n", "<leader>dv", ":DiffviewFileHistory %<CR>", { desc = "Diffview file %" }) -- Diffview 파일 열기
map("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Diffview close" }) -- Diffview 닫기

-- Zen Mode 플러그인 관련 매핑
map("n", "<leader>zm", ":ZenMode<CR>", { desc = "ZenMode" }) -- ZenMode 활성화

-- -- LazyGit 플러그인 관련 매핑
map("n", "<leader>gg", ":LazyGit <CR>", { desc = "Open lazyGit" }) -- LazyGit 열기

-- Aerial 플러그인 관련 매핑
map("n", "<leader>a", "<cmd>AerialToggle<CR>", { desc = "Aerial Toggle", silent = true })

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

-- nvim-ufo
map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "ufo open All Folds" })
map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "ufo close All Folds" })

-- debugprint
map("n", "g?d", "<cmd>DeleteDebugPrints<cr>", { desc = "debugPrint DeleteDebugPrints" })

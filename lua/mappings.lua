-- cSpell:disable
require("nvchad.mappings")

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

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

-- Markdown Preview 플러그인 관련 매핑
map("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Open preview" }) -- 미리보기 열기
map("n", "<leader>mc", "<cmd>MarkdownPreviewStop<CR>", { desc = "Markdown Close preview" }) -- 미리보기 닫기

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
  { desc = "Toggle trailing space" }
) -- 뒤에 공백 토글

-- Diffview 플러그인 관련 매핑
map("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "Diffview open" }) -- Diffview 열기
map("n", "<leader>dv", ":DiffviewFileHistory %<CR>", { desc = "Diffview file %" }) -- Diffview 파일 열기
map("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Diffview close" }) -- Diffview 닫기

-- Zen Mode 플러그인 관련 매핑
map("n", "<leader>zm", ":ZenMode<CR>", { desc = "ZenMode" }) -- ZenMode 활성화

-- NvimTree 플러그인 관련 매핑
map(
  "n",
  "<leader>tt",
  (function()
    local isWide = true

    return function()
      if isWide then
        vim.cmd(":NvimTreeResize +15")
      else
        vim.cmd(":NvimTreeResize -15")
      end

      isWide = not isWide
    end
  end)(),
  { desc = "Resize nvimtree toggle" }
)

-- -- LazyGit 플러그인 관련 매핑
map("n", "<leader>gg", ":LazyGit <CR>", { desc = "Open lazyGit" }) -- LazyGit 열기

-- Aerial 플러그인 관련 매핑
map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Aerial Toggle", silent = true }) -- Aerial 토글

-- buffer
map("n", "<leader>tx", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close Buffer" })

-- trouble
map("n", "<leader>lx", "<cmd>TroubleToggle<CR>", { desc = "trouble toggle" })
map("n", "<leader>lw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "trouble workspace_diagnostics" })
map("n", "<leader>ld", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "trouble document_diagnostics" })
map("n", "<leader>lq", "<cmd>TroubleToggle quickfix<CR>", { desc = "trouble quickfix" })

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

-- rest nvim
map("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "RestNvim Run request under the cursor" })
map("n", "<leader>rl", "<cmd>Rest run last<cr>", { desc = "RestNvim Re-run latest request" })

-- nvim-ufo
map("n", "zR", require("ufo").openAllFolds, { desc = "ufo open All Folds" })
map("n", "zM", require("ufo").closeAllFolds, { desc = "ufo close All Folds" })

-- debugprint
map("n", "g?d", require("debugprint").deleteprints, { desc = "debugPrint DeleteDebugPrints" })

-- delete default map nvcahd terminal
nomap("n", "<leader>h")
nomap("n", "<leader>v")

-- goToTab
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

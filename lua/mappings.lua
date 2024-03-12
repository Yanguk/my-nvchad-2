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
map("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Open preview" }) -- 미리보기 열기
map("n", "<leader>mc", "<cmd>MarkdownPreviewStop<CR>", { desc = "Close preview" }) -- 미리보기 닫기

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

-- Icon Picker 플러그인 관련 매핑
map("n", "<leader>ip", "<cmd>IconPickerNormal emoji nerd_font symbols<CR>", { desc = "Open icon picker" }) -- 아이콘 선택기 열기

-- Zen Mode 플러그인 관련 매핑
map("n", "<leader>zm", ":ZenMode<CR>", { desc = "ZenMode" }) -- ZenMode 활성화

-- Gitsigns 플러그인 관련 매핑
map("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle line blame" }) -- 현재 줄 블레임 토글

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
) -- NvimTree 크기 조절 토글

-- Rest Nvim 플러그인 관련 매핑
map("n", "<leader>ru", "<Plug>RestNvim", { desc = "Rest under cursor" }) -- 커서 아래의 휴식
map("n", "<leader>rp", "<Plug>RestNvimPreview", { desc = "Rest preview" }) -- 미리보기 휴식
map("n", "<leader>rl", "<Plug>RestNvimLast", { desc = "Rest last" }) -- 마지막 휴식

-- -- LazyGit 플러그인 관련 매핑
map("n", "<leader>gg", ":LazyGit <CR>", { desc = "Open lazyGit" }) -- LazyGit 열기

-- Aerial 플러그인 관련 매핑
map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial", silent = true }) -- Aerial 토글

-- GitSigns
map("n", "]c", function()
  require("gitsigns").next_hunk()
end)

map("n", "[c", function()
  require("gitsigns").prev_hunk()
end)

-- buffer
nomap("n", "<leader>x")
nomap("n", "<leader>b")
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New Buffer" })
map("n", "<leader>bx", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "New Buffer" })

-- trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "trouble toggle" })

map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "trouble workspace_diagnostics" })

map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "trouble document_diagnostics" })

map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "trouble quickfix" })

map("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "trouble loclist" })

-- codeRunner
map("n", "<leader>cr", function()
  local ft_cmds = {
    python = "python3 " .. vim.fn.expand("%"),
    racket = "csi -script " .. vim.fn.expand("%"),
    c = "gcc " .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r") .. " && ./" .. vim.fn.expand("%:r"),
  }

  if ft_cmds[vim.bo.filetype] == nil then
    vim.notify("No runner for " .. vim.bo.filetype)

    return
  end

  require("nvchad.term").runner({
    id = "runner",
    pos = "sp",
    cmd = ft_cmds[vim.bo.filetype]
  })
end, { desc = "code runner" })

-- resize window
map("n", "<A-=>", ":vertical resize +5<CR>") -- make the window biger vertically
map("n", "<A-->", ":vertical resize -5<CR>") -- make the window smaller vertically
map("n", "<A-+>", ":resize +2<CR>") -- make the window bigger horizontally by pressing shift and =
map("n", "<A-_>", ":resize -2<CR>") -- make the window smaller horizontally by pressing shift and -

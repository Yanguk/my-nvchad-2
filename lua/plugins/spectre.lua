local map = vim.keymap.set

require("spectre").setup()

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

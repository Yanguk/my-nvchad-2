-- cSpell:disable
local nvim_back_dir = os.getenv("HOME") .. "/.config/nvim/.back"

local SWAPDIR = nvim_back_dir .. "/swap//"
local BACKUPDIR = nvim_back_dir .. "/backup//"
local UNDODIR = nvim_back_dir .. "/undo//"

if vim.fn.isdirectory(SWAPDIR) == 0 then
  vim.fn.mkdir(SWAPDIR, "p", "0o700")
end

if vim.fn.isdirectory(BACKUPDIR) == 0 then
  vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
  vim.fn.mkdir(UNDODIR, "p", "0o700")
end

-- Enable swap, backup, and persistant undo
vim.opt.directory = SWAPDIR
vim.opt.backupdir = BACKUPDIR
vim.opt.undodir = UNDODIR
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")

    vim.o.backupext = extension
  end,
})

local function get_directory_size(directory)
  local total_size = 0
  local files = vim.fn.split(vim.fn.glob(directory .. "/*"), "\n")

  for _, file in ipairs(files) do
    total_size = total_size + vim.fn.getfsize(file)
  end

  return total_size
end

local function delete_old_files(directory)
  local one_day_ago = os.time() - (24 * 60 * 60) -- 하루 전 시간 계산 (초 단위)
  local files = vim.fn.split(vim.fn.glob(directory .. "/*"), "\n")

  for _, file in ipairs(files) do
    local modtime = vim.fn.getftime(file)

    if modtime < one_day_ago then
      os.remove(file)
      print("삭제된 파일:", file)
    end
  end
end

local function clean_backup_files()
  local MAX_TOTAL_SIZE_MB = 500

  local backupdir = vim.fn.expand(BACKUPDIR)
  local directory_size = get_directory_size(backupdir)

  if directory_size > MAX_TOTAL_SIZE_MB * 1024 * 1024 then
    delete_old_files(backupdir)
  end
end

vim.schedule(function()
  clean_backup_files()
end)

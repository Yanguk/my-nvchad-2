-- cSpell:disable
local slow_format_filetypes = {}

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = {
      -- "prettierd" ,
      "eslint_d",
    },
    typescript = {
      -- "prettierd",
      "eslint_d",
    },
    javascriptreact = {
      -- "prettierd",
      "eslint_d",
    },
    typescriptreact = {
      -- "prettierd",
      "eslint_d",
    },
    markdown = { "prettierd" },
    html = { "prettierd" },

    racket = { "raco" },
    sh = { "shfmt" },
    rust = { "rustfmt" },
    c = { "clang_format" },

    toml = { "taplo" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    yaml = { "yamlfmt" },
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    if slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end

    local function on_format(err)
      if err and err:match("timeout$") then
        slow_format_filetypes[vim.bo[bufnr].filetype] = true
      end
    end

    return { timeout_ms = 300, lsp_format = "fallback" }, on_format
  end,
  format_after_save = function(bufnr)
    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end

    return { lsp_format = "fallback" }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

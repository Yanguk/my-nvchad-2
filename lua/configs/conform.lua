-- cSpell:disable
local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
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
}

require("conform").setup(options)

-- cSpell:disable
local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "deno_fmt" },
    typescript = { "deno_fmt" },
    javascriptreact = { "deno_fmt" },
    typescriptreact = { "deno_fmt" },
    markdown = { "deno_fmt" },

    racket = { "raco" },
    sh = { "shfmt" },
    rust = { "rustfmt" },
    c = { "clang_format" },

    toml = { "taplo" },
    json = { "deno_fmt" },
    yaml = { "yamlfmt" },
  },
}

require("conform").setup(options)

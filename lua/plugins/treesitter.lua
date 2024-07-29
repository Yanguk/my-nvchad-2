require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "vim",
    "lua",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "json",
    "rust",
    "http",
    "toml",
    "graphql",
  },
  indent = { enable = true },
  highlight = {
    enable = true,
  },
})

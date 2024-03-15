local M = {}

M.ui = {
  theme = "gruvchad",
  transparency = true,

  term = {
    sizes = { sp = 0.3, vsp = 0.2 },
    float = {
      relative = "editor",
      row = 0.02,
      col = 0.048,
      width = 0.905,
      height = 0.9,
    },
  },

  nvdash = {
    load_on_startup = true,
  },

  hl_override = {
    ["@comment"] = {
      italic = true,
    },
    FoldColumn = {
      link = "UfoFoldedEllipsis",
    },
  },
}

return M

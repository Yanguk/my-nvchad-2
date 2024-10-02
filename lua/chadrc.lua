local M = {}

M.nvdash = {
  load_on_startup = true,
}

M.base46 = {
  theme = "gruvbox",
  -- transparency = true,

  hl_override = {
    ["@comment"] = {
      italic = true,
    },
    FoldColumn = {
      link = "UfoFoldedEllipsis",
    },
  },
}

M.term = {
  sizes = { sp = 0.3, vsp = 0.2 },
  float = {
    relative = "editor",
    row = 0.02,
    col = 0.048,
    width = 0.905,
    height = 0.9,
  },
}

return M

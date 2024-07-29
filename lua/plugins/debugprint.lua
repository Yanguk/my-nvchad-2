local js = {
  left = 'console.log("',
  right = '")',
  mid_var = '", ',
  right_var = ")",
}

local opts = {
  print_tag = "DEBUG_💥",
  filetypes = {
    ["typescript"] = js,
    ["typescriptreact"] = js,
    ["tsx"] = js,
    ["javascript"] = js,
    ["javascriptreact"] = js,
    ["jsx"] = js,
  },
}

require('debugprint').setup(opts)

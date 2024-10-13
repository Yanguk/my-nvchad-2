-- cSpell:disable
local WEB_FT_LIST = {
  "html",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "vue",
  "markdown",
}

return {
  -- enabled false
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  --------------------

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
      vim.g.mkdp_theme = "dark"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("configs.conform")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
        use_languagetree = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    version = "*",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true
      })

      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufRead",
    config = function()
      require("configs.nvim-lint")
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>lx",
        "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>lX",
        "<cmd>Trouble diagnostics toggle focus=true<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        -- https://github.com/NvChad/NvChad/discussions/2662
        "hrsh7th/cmp-cmdline",
        event = { "CmdLineEnter" },
        opts = {
          history = true,
          updateevents = "CmdlineEnter,CmdlineChanged",
        },
        config = function()
          local cmp = require("cmp")

          cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
              { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
              { name = "buffer" },
            }),
          })

          cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = "buffer" },
            },
          })

          -- `:` cmdline setup.
          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = "path" },
            }, {
              {
                name = "cmdline",
                option = {
                  ignore_cmds = { "Man", "!" },
                },
              },
            }),
          })
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        config = true,
      },
      {
        "hrsh7th/cmp-emoji",
      },
    },
    config = function(_, opts)
      local cmp = require("cmp")

      opts.preselect = cmp.PreselectMode.None

      opts.mapping["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      })

      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }

      cmp.setup(opts)
    end,
    opts = {
      sources = {
        { name = "copilot",  group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path",     group_index = 2 },
        { name = "emoji",    group_index = 2 },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
        oldfiles = {
          cwd_only = true,
        },
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
        end,
      },
    },
    keys = {
      { "gcc", mode = "n",          desc = "comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "comment toggle linewise" },
      { "gc",  mode = "x",          desc = "comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      require("Comment").setup(opts)
    end,
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      stages = "static",
      background_colour = "#1a1b26",
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enable = false,
      },
      panel = {
        enable = false,
      },
      filetypes = { ["*"] = true },
    },
    config = true,
  },

  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>zm", "<cmd>ZenMode<CR>", desc = "ZenMode" } },
  },

  {
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<leader>S",
        "<cmd>lua require('spectre').toggle()<CR>",
        desc = "[S]earch current word",
      },
      {
        "<leader>sw",
        "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
        desc = "[S]earch current [W]ord",
      },
      {
        "<leader>sw",
        "<esc><cmd>lua require('spectre').open_visual()<CR>",
        desc = "[S]earch current [W]ord",
        mode = "v",
      },
      {
        "<leader>sp",
        "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
        desc = "[S]earch on current file",
      },
    },
    opts = {
      default = {
        replace = {
          cmd = "oxi",
        },
      },
      is_block_ui_break = true,
    },
    config = true,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = WEB_FT_LIST,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },

  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<CR>",          desc = "Diffview open" },
      { "<leader>dv", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview file %" },
      { "<leader>dc", "<cmd>DiffviewClose<CR>",         desc = "Diffview close" },
    },
  },

  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "kdheepak/lazygit.nvim",
    keys = { { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" } },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    keys = {
      { "zR", "<cmd>lua require('ufo').openAllFolds()<CR>",  desc = "ufo open All Folds" },
      { "zm", "<cmd>lua require('ufo').closeAllFolds()<CR>", desc = "ufo close All Folds" },
    },
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
              { text = { "%s" },                  click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    config = true,
  },

  {
    "kylechui/nvim-surround",
    keys = { "ys", "ds", "cs" },
    version = "*",
    config = true,
  },

  {
    "andrewferrier/debugprint.nvim",
    keys = {
      { "g?",  mode = "n" },
      { "g?",  mode = "x" },
      { "g?d", "<cmd>DeleteDebugPrints<CR>", desc = "debugPrint DeleteDebugPrints" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local js = {
        left = 'console.log("',
        right = '")',
        mid_var = '", ',
        right_var = ")",
      }

      return {
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
    end,
    version = "*",
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local nvchad_opts = require("nvchad.configs.gitsigns")

      nvchad_opts.on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set

        local function opts(desc)
          return { buffer = bufnr, desc = desc }
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, {
          expr = true,
          buffer = bufnr,
          desc = "Next Hunk",
        })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, {
          expr = true,
          buffer = bufnr,
          desc = "Prev Hunk",
        })

        map("n", "<leader>hs", gs.stage_hunk, opts("GitSigns Stage Hunk"))
        map("n", "<leader>hr", gs.reset_hunk, opts("GitSigns Reset Hunk"))

        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, opts("GitSigns Stage Hunk"))
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, opts("GitSigns Reset Hunk"))

        map("n", "<leader>hS", gs.stage_buffer, opts("GitSigns Stage Buffer"))
        map("n", "<leader>hu", gs.undo_stage_hunk, opts("GitSigns Undo Stage Hunk"))
        map("n", "<leader>hR", gs.reset_buffer, opts("GitSigns Reset Buffer"))
        map("n", "<leader>hp", gs.preview_hunk, opts("GitSigns Preview Hunk"))
        map("n", "<leader>hb", gs.blame_line, opts("GitSigns Blame Line"))
        map("n", "<leader>hB", function()
          gs.blame_line({ full = true })
        end, opts("GitSigns Blame Line (full)"))

        map("n", "<leader>tb", gs.toggle_current_line_blame, opts("GitSigns Toggle Blame Line"))
        map("n", "<leader>td", gs.toggle_deleted, opts("GitSigns Toggle Deleted"))

        map("n", "<leader>hd", gs.diffthis, opts("GitSigns Diff This"))
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, opts("GitSigns Diff This (cached)"))
      end

      nvchad_opts.current_line_blame_opts = {
        delay = 200,
      }

      return nvchad_opts
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = require("configs.typescript-tools"),
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false,   -- This plugin is already lazy
  },

  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    keys = { { "-", "<CMD>Oil<CR>", mode = { "n" }, { desc = "Open parent directory" } } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("configs.oil"),
  },

  {
    "stevearc/aerial.nvim",
    keys = { { "<leader>ta", "<cmd>AerialToggle<CR>", desc = "[T]oggle [A]erial", silent = true } },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "S", desc = "Leap" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<C-N>",
        function()
          require("harpoon"):list():next()
        end,
        desc = "harpoon [T]ab [N]ext",
      },
      {
        "<C-P>",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "harpoon [T]ab [P]rev",
      },
      {
        "<C-e>",
        function()
          local harpoon = require("harpoon")

          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpoon [E]xplorer",
      },
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
        desc = "harpoon [A]dd",
      },
      {
        "<A-1>",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "harpoon select [1]",
      },
      {
        "<A-2>",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "harpoon select [1]",
      },
      {
        "<A-3>",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "harpoon select [1]",
      },
      {
        "<A-4>",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "harpoon select [1]",
      },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  {
    "mistweaverco/kulala.nvim",
    ft = { "http" },
    config = function()
      require("kulala").setup()
    end,
  },

  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
}

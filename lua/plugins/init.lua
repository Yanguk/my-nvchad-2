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
  {
    "stevearc/conform.nvim",
    config = function()
      require("configs.conform")
    end,
  },

  -- override
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filesystem_watchers = {
        ignore_dirs = {
          "node_modules",
        },
      },
    },
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
      },
      indent = { enable = true },
      autotag = { enable = true },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
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
    cmd = "TroubleToggle",
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lsp
        "lua-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "rust-analyzer",
        "clangd",
        "yaml-language-server",
        "bash-language-server",

        -- format
        "shfmt",
        "clang-format",
        "stylua",
        "deno",
        "yamlfmt",

        -- util
        "cspell",
        -- "codespell",
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
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
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "emoji", group_index = 2 },
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
          vim.g.skip_ts_context_commentstring_module = true
          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
        end,
      },
    },
    config = function(_, opts)
      opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      require("Comment").setup(opts)
    end,
  },

  -- add Plugin
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
    cmd = { "ZenMode" },
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    opts = {
      default = {
        replace = {
          cmd = "oxi",
        },
      },
    },
    config = true,
  },

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
    "windwp/nvim-ts-autotag",
    ft = WEB_FT_LIST,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewFileHistory", "DiffviewOpen" },
  },

  {
    "antosha417/nvim-lsp-file-operations",
    event = "InsertEnter",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-tree.lua" },
    },
    config = true,
  },

  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
  },

  {
    "kylechui/nvim-surround",
    keys = { "ys", "ds", "cs" },
    version = "*",
    config = true,
  },

  {
    "andrewferrier/debugprint.nvim",
    keys = { "g?" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function ()
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
          ["javascript"] = js,
          ["javascriptreact"] = js,
        },
      }
    end,
    version = "*",
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "S", desc = "Leap" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "lbrayner/vim-rzip",
    ft = {
      "zip",
      "typescript",
      "javascript",
      "typescriptreact",
      "typescriptreact",
    },
  },

  {
    "cameron-wags/rainbow_csv.nvim",
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    config = true,
  },

  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle" },
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      local crates = require("crates")
      crates.setup()

      vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, {
        silent = true,
        desc = "Crates Show Versions",
      })

      vim.keymap.set("n", "<leader>cf", crates.show_features_popup, {
        silent = true,
        desc = "Crates Show Features",
      })

      vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, {
        silent = true,
        desc = "Crates Show Dependencies",
      })
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
    config = true,
  },

  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup()
    end,
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

        -- Actions
        map("n", "<leader>rh", gs.reset_hunk, opts("GitSings Reset Hunk"))
        map("n", "<leader>ph", gs.preview_hunk, opts("GitSings Preview Hunk"))
        map("n", "<leader>gb", gs.blame_line, opts("GitSings Blame Line"))
        map("n", "<leader>gl", gs.toggle_current_line_blame, opts("GitSings toggle_current_line_blame"))
      end

      return nvchad_opts
    end,
  },
}

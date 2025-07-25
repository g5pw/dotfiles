return {
  { "actionshrimp/direnv.nvim", opts = {} },
  {
    "rhysd/committia.vim", -- Nice UI for git commit
    config = function()
      vim.g.committia_hooks = {
        edit_open = function()
          vim.opt_local.spell = true
          vim.opt_local.spelllang = "en"
          local num_bytes = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

          if #num_bytes == 0 then
            vim.cmd("startinsert")
          end
        end,
      }
    end,
  },
  {
    "rgroli/other.nvim",
    main = "other-nvim",
    opts = {
      mappings = {
        { -- C++
            pattern = "src/(.*)%.cpp",
            target = "include/%1.hpp",
            context = "header",
        },
        { -- C++
            pattern = "include/(.*)%.hpp",
            target = "src/%1.cpp",
            context = "source_file",
        },
        "c",
        "golang",
        "python",
        "rust",
      },
    },
    cmd = "Other",
    keys = {
      { "<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true } },
      { "<leader>ltn", "<cmd>:OtherTabNew<CR>", { noremap = true, silent = true } },
      { "<leader>lp", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true } },
      { "<leader>lv", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true } },
      { "<leader>lc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true } },

      -- Context specific bindings
      { "<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true } },
      { "<leader>ls", "<cmd>:Other scss<CR>", { noremap = true, silent = true } },
    },
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.diff").setup()
      require("mini.jump2d").setup({ labels = "asdfjkl;gh", })
      require("mini.sessions").setup()
    end,
  },
  -- Operators
  {
    "kylechui/nvim-surround",
    version = "*",
    config = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
    opts = {
      disable_hint = true,
      graph_style = "kitty",
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Neogit",
      },
      {
        "<leader>gl",
        function()
          require("neogit").open({ "log" })
        end,
        desc = "Neogit log",
      },
    },
  },
  -- Add git related info in the signs columns and popups
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
  'rhysd/conflict-marker.vim',
  {
      "rachartier/tiny-code-action.nvim",
      dependencies = {
          {"nvim-lua/plenary.nvim"},
          {
            "folke/snacks.nvim",
            opts = {
              terminal = {},
            }
          }
      },
      event = "LspAttach",
      opts = {
        backend = "difftastic",
        picker = "snacks",
      },
      keys = {
        { "<leader>ca", function() require("tiny-code-action").code_action() end, desc = "Run code actions" },
      }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    config = true,
  },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
    },

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
      },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer"},
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
          },
        },
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
    },
    config = function()
      require("aerial").setup()
    end,
    keys = { -- Example mapping to toggle outline
      { "<leader>oo", "<cmd>AerialToggle<CR>", desc = "Toggle outline" },
    },
  },
  "Einenlum/yaml-revealer",
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "LnL7/vim-nix",
    ft = "nix",
  },
  {
    "stevearc/overseer.nvim",
    opts = {
        strategy = "jobstart",
    },
    keys = {
      {
        "<leader>r.",
        function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], "restart")
          end
        end,
        mode = "n",
        desc = "Run current/last overseer task",
      },
      { "<leader>rr", "<cmd>OverseerRun<cr>", mode = "n", desc = "Run overseer task", },
      { "<leader>rt", "<cmd>OverseerToggle<cr>", mode = "n", desc = "Show all overseer tasks", },
    },
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
      "stevearc/aerial.nvim",
      "stevearc/overseer.nvim",
    },
    opts = {
      theme = "auto",
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_c = { "filename", "aerial" },
        lualine_x = { "overseer" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)", },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)", },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)", },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)", },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODO List (Trouble)", },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)", },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
    },
  },
  "RaafatTurki/hex.nvim",
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
      },
      keymaps = {
        ["<C-s>"] = { "actions.select", opts = { vertical = false } },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["h"] = "actions.parent",
        ["l"] = "actions.select",
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
      },
    },
    keys = {
      { "-", function() require("oil").open_float() end, desc = "Open parent directory", },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        python = { "ruff", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
      }
    },
  },
  {
    "IndianBoy42/tree-sitter-just",
    config = true,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "ravitemer/mcphub.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true
          }
        }
      }
    },
  },
}

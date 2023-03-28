
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = " "

local lsp_servers = { 'clangd', 'lua_ls', 'ruff_lsp' }

require("lazy").setup({
  'tpope/vim-fugitive',
  {
    'liangxianzhe/nap.nvim',
    config = {
      next_prefix = ']',
      prev_prefix = '[',
    },
  },
  {
    'rhysd/committia.vim', -- Nice UI for git commit
    config = function()
      vim.g.committia_hooks = {
        edit_open = function()
          vim.opt_local.spell = true
          vim.opt_local.spelllang = "en"
          local num_bytes = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

          if #num_bytes == 0 then
            vim.cmd('startinsert')
          end
        end
      }
    end
  },
  'tpope/vim-commentary', -- "gc" to comment visual regions/lines
  -- Operators
  {
    'kylechui/nvim-surround',
    version = "*",
    config = true,
  },
  -- UI to select things (files, grep results, open buffers...)
  {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require("telescope").setup({
          defaults = {
              mappings = {
                  i = {
                      ['<C-u>'] = false,
                      ['<C-d>'] = false,
                  },
              },
          },
        })

        vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { silent = true })
        vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files{previewer = false} end, { silent = true })
        vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find, { silent = true })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { silent = true })
        vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags, { silent = true })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string, { silent = true })
        vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep, { silent = true })
        vim.keymap.set('n', '<leader>so', function() require('telescope.builtin').tags{ only_current_buffer = true } end, { silent = true })
        vim.keymap.set('n', '<leader>?',  require('telescope.builtin').oldfiles, { silent = true })
      end
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = true,
  },
  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = {
      filetype_exclude = { 'help', 'packer' },
      buftype_exclude = { 'terminal', 'nofile' },
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = true,
    },
  },
  -- Add git related info in the signs columns and popups
  {
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup()
        require('nap').nap('c', "Gitsigns next_hunk", "Gitsigns prev_hunk", "Next diff", "Previous diff")
      end,
  },
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup {
          highlight = {
            enable = true, -- false will disable the whole extension
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = 'gnn',
              node_incremental = 'grn',
              scope_incremental = 'grc',
              node_decremental = 'grm',
            },
          },
          indent = {
            enable = true,
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
          },
        }
    end
  },
  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
      'williamboman/mason.nvim',
      config = {
          ui = {
              icons = {
                  package_installed = "✓",
                  package_pending = "➜",
                  package_uninstalled = "✗"
              }
          }
      },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = {
        ensure_installed = lsp_servers,
    }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('nap').nap('d', 'vim.lsp.diagnostic.goto_prev', 'vim.lsp.diagnostic.goto_next')
      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>so', function() require('telescope.builtin').lsp_document_symbols() end, opts)
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
      end

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
      vim.keymap.set('n', '<leader>E', vim.diagnostic.show, opts)

      -- nvim-cmp supports additional completion capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Enable the following language servers
      for _, lsp in ipairs(lsp_servers) do
        local settings = {}
        if lsp == "lua_ls" then
          settings = {
            Lua = { diagnostics = { globals = {'vim'} } }
          }
        end
        require("lspconfig")[lsp].setup {
          settings = settings,
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end
    end
  }, -- Collection of configurations for built-in LSP client
  {
      'L3MON4D3/LuaSnip', -- Snippets plugin
      version = "v1.*",
  },
  {
      "hrsh7th/nvim-cmp",  -- Autocompletion plugin
      -- load cmp on InsertEnter
      event = "InsertEnter",
      -- these dependencies will only be loaded when cmp loads
      -- dependencies are always lazy-loaded unless specified otherwise
      dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
      },
      config = function()
          -- luasnip setup
          local luasnip = require 'luasnip'

          -- nvim-cmp setup
          local cmp = require 'cmp'
          cmp.setup {
              snippet = {
                  expand = function(args)
                      luasnip.lsp_expand(args.body)
                  end,
              },
              mapping = {
                  ['<C-p>'] = cmp.mapping.select_prev_item(),
                  ['<C-n>'] = cmp.mapping.select_next_item(),
                  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.close(),
                  ['<CR>'] = cmp.mapping.confirm {
                      behavior = cmp.ConfirmBehavior.Replace,
                      select = true,
                  },
                  ['<Tab>'] = function(fallback)
                      if cmp.visible() then
                          cmp.select_next_item()
                      elseif luasnip.expand_or_jumpable() then
                          luasnip.expand_or_jump()
                      else
                          fallback()
                      end
                  end,
                  ['<S-Tab>'] = function(fallback)
                      if cmp.visible() then
                          cmp.select_prev_item()
                      elseif luasnip.jumpable(-1) then
                          luasnip.jump(-1)
                      else
                          fallback()
                      end
                  end,
              },
              sources = {
                  { name = 'nvim_lsp' },
                  { name = 'luasnip' },
              },
          }
      end
  },
  {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup()
      require('telescope').load_extension('aerial')
      require('nap').nap("o", "AerialNext", "AerialPrev", "Next outline symbol", "Previous outline symbol")
    end,
  },
  'saadparwaiz1/cmp_luasnip',
  {
      'stevearc/dressing.nvim',
      config = true,
  },
  'Einenlum/yaml-revealer',
  {
      'kevinhwang91/nvim-bqf',
      ft = 'qf'
  },
  'simrat39/symbols-outline.nvim',
  {
      'LnL7/vim-nix',
      ft = 'nix'
  },
  {
      url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = true,
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    version = "*",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neorg/neorg-telescope',
      "folke/zen-mode.nvim",
    },
    config = {
        load = {
            ["core.defaults"] = {},
            -- ["core.gtd.base"] = {  -- https://github.com/nvim-neorg/neorg/issues/695
            --     config = {
            --         workspace = "gtd"
            --     }
            -- },
            ["core.norg.completion"] = { config = { engine = "nvim-cmp" }},
            ["core.norg.concealer"] = {},
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        gtd = "~/Documents/norg/gtd",
                        default = "~/Documents/norg/default",
                    }
                }
            },
            ["core.integrations.telescope"] = {},
            ["core.presenter"] = {
              config = {
                zen_mode = "zen-mode",
              },
            },
        }
    }
  },
  {
      'stevearc/overseer.nvim',
      config = true
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = {'InsertEnter','CmdlineEnter'},
    config = true,
  },
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { {'kyazdani42/nvim-web-devicons', lazy = true }, 'stevearc/aerial.nvim'},
      config = {
          theme = 'auto',
          sections = {
              lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
              lualine_c = { "filename", "aerial" },
          }
      }
  },
  {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
          local null_ls = require("null-ls")

          -- check https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
          null_ls.setup({
              sources = {
                  null_ls.builtins.code_actions.gitsigns,
                  null_ls.builtins.code_actions.statix,
                  null_ls.builtins.completion.luasnip,
                  null_ls.builtins.diagnostics.ansiblelint,
                  null_ls.builtins.diagnostics.commitlint,
                  null_ls.builtins.diagnostics.pylama,
                  null_ls.builtins.diagnostics.statix,
                  null_ls.builtins.formatting.stylua,
              },
          })
      end,
      requires = { "nvim-lua/plenary.nvim" },
  },
  {
      "chrisgrieser/nvim-various-textobjs",
      config = { useDefaultKeymaps = true }
  },
  {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = {
      direction = 'float',
      open_mapping = "<leader>ot",
      insert_mappings = false,
    },
  },
  'RaafatTurki/hex.nvim',
  {
    'stevearc/oil.nvim',
    config = {
      columns = {
        "icon",
        "permissions",
        "size"
      },
      keymaps = {
        ["h"] = "actions.parent",
        ["l"] = "actions.select",
        ["q"] = "actions.close",
      },
    },
    keys = {
      {"-", function() require("oil").open_float() end, desc = "Open parent directory" },
    },
  },
  {
    '/IndianBoy42/tree-sitter-just',
    config = true,
  },
  {
    'simrat39/rust-tools.nvim',
    config = {
      server = {
        on_attach = function(_, bufnr)
                -- Hover actions
          vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
          vim.keymap.set("n", "<Leader>a", require("rust-tools").code_action_group.code_action_group, { buffer = bufnr })
        end
      }
    },
  },
})

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd[[colorscheme bluloco-dark]]

vim.o.expandtab = true
vim.o.shiftwidth = 4

--Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Y yank until the end of line  (note: this is now a default on master)
vim.keymap.set('n', 'Y', 'y$')

vim.keymap.set('n', '<leader>fs', "<cmd>:w<CR>")

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})

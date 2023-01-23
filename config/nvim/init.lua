
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

require("lazy").setup({
  'tpope/vim-fugitive',
  'rhysd/committia.vim', -- Nice UI for git commit
  'tpope/vim-commentary', -- "gc" to comment visual regions/lines
  -- Operators
  'machakann/vim-sandwich', -- bigger, better vim-surround
  -- UI to select things (files, grep results, open buffers...)
  {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = {
          defaults = {
              mappings = {
                  i = {
                      ['<C-u>'] = false,
                      ['<C-d>'] = false,
                  },
              },
          },
      }
  },
  "nvim-telescope/telescope-file-browser.nvim" ,
  'joshdick/onedark.vim', -- Theme inspired by Atom
  'folke/tokyonight.nvim',
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Add git related info in the signs columns and popups
  {
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = {
          signs = {
              add = { hl = 'GitGutterAdd', text = '+' },
              change = { hl = 'GitGutterChange', text = '~' },
              delete = { hl = 'GitGutterDelete', text = '_' },
              topdelete = { hl = 'GitGutterDelete', text = '‾' },
              changedelete = { hl = 'GitGutterChange', text = '~' },
          },
      }
  },
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
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
    config = {
        ensure_installed = { "sumneko_lua", "rust_analyzer", "pyright" },
    }
  },
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
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
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'nvim-neorg/neorg-telescope'},
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
        }
    }
  },
  {
      'stevearc/overseer.nvim',
      config = true
  },
  {
      'windwp/nvim-autopairs',
      config = true
  },
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
      config = {
          theme = 'tokyonight',
          sections = {
              lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
          }
      }
  },
  {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
          local null_ls = require("null-ls")

          null_ls.setup({
              sources = {
                  null_ls.builtins.code_actions.gitsigns,
                  null_ls.builtins.formatting.stylua,
                  null_ls.builtins.completion.spell,
                  null_ls.builtins.code_actions.statix,
                  null_ls.builtins.diagnostics.ansiblelint,
              },
          })
      end,
      requires = { "nvim-lua/plenary.nvim" },
  },
  {
      "chrisgrieser/nvim-various-textobjs",
      config = { useDefaultKeymaps = true }
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
vim.cmd[[colorscheme tokyonight]]

vim.o.expandtab = true
vim.o.shiftwidth = 4

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

require("telescope").load_extension "file_browser"
vim.api.nvim_set_keymap('n', '-', [[:Telescope file_browser path=%:p:h<CR>]], {noremap = true, silent = true })

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', [[<cmd>:w<CR>]], { noremap = true })



-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
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

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


-- committia setup
vim.g.committia_hooks = {
  edit_open = function(info)
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en"
    local num_bytes = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

    if #num_bytes == 0 then
      vim.cmd('startinsert')
    end
  end
}

vim.api.nvim_set_keymap("n", "]q", "<cmd>:cnext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[q", "<cmd>:cprev<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]b", "<cmd>:bnext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[b", "<cmd>:bprev<CR>", {noremap = true, silent = true})


-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})

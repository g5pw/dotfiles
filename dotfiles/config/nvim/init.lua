-- vim:
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

local lsp_servers = { "clangd", "lua_ls", "ruff_lsp" }

require("lazy").setup({
	{
		"liangxianzhe/nap.nvim",
		opts = {
			next_prefix = "]",
			prev_prefix = "[",
		},
	},
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
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.ai").setup()
			require("mini.diff").setup()
			require("mini.git").setup()
			require("mini.comment").setup()
		end,
	},
	-- Operators
	{
		"kylechui/nvim-surround",
		version = "*",
		config = true,
	},
	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})

			vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { silent = true })
			vim.keymap.set("n", "<leader>ff", function()
				require("telescope.builtin").find_files({ previewer = true })
			end, { silent = true })
			vim.keymap.set("n", "<leader>sb", require("telescope.builtin").current_buffer_fuzzy_find, { silent = true })
			vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { silent = true })
			vim.keymap.set("n", "<leader>st", require("telescope.builtin").tags, { silent = true })
			vim.keymap.set("n", "<leader>sd", require("telescope.builtin").grep_string, { silent = true })
			vim.keymap.set("n", "<leader>sp", require("telescope.builtin").live_grep, { silent = true })
			vim.keymap.set("n", "<leader>so", function()
				require("telescope.builtin").tags({ only_current_buffer = true })
			end, { silent = true })
			vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { silent = true })
		end,
	},
        {
            "scottmckendry/cyberdream.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("cyberdream").setup({
                    -- Recommended - see "Configuring" below for more config options
                    transparent = true,
                    italic_comments = true,
                    hide_fillchars = true,
                    borderless_telescope = true,
                    terminal_colors = true,
                })
                vim.cmd("colorscheme cyberdream") -- set the colorscheme
            end,
        },
	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	-- Add git related info in the signs columns and popups
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"liangxianzhe/nap.nvim",
		},
		config = function()
			require("gitsigns").setup()
			require("nap").operator("h", require("nap").gitsigns())
		end,
	},
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true, -- false will disable the whole extension
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
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
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
	-- Additional textobjects for treesitter
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"roobert/tabtree.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = lsp_servers,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"liangxianzhe/nap.nvim",
		},
		config = function()
			local on_attach = function(_, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>so", function()
					require("telescope.builtin").lsp_document_symbols()
				end, opts)
				vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
			end

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
			vim.keymap.set("n", "<leader>E", vim.diagnostic.show, opts)

			-- nvim-cmp supports additional completion capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Enable the following language servers
			for _, lsp in ipairs(lsp_servers) do
				local settings = {}
				if lsp == "lua_ls" then
					settings = {
						Lua = { diagnostics = { globals = { "vim" } } },
					}
				end
				require("lspconfig")[lsp].setup({
					settings = settings,
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
		end,
	}, -- Collection of configurations for built-in LSP client
	{
		"L3MON4D3/LuaSnip", -- Snippets plugin
		version = "v1.*",
	},
	{
		"hrsh7th/nvim-cmp", -- Autocompletion plugin
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
			local luasnip = require("luasnip")

			-- nvim-cmp setup
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
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
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"liangxianzhe/nap.nvim",
		},
		config = function()
			require("aerial").setup()
			require("telescope").load_extension("aerial")
			require("nap").operator("o", require("nap").aerial())
		end,
	},
	"saadparwaiz1/cmp_luasnip",
	{
		"stevearc/dressing.nvim",
		config = true,
	},
	"Einenlum/yaml-revealer",
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
	{
		"LnL7/vim-nix",
		ft = "nix",
	},
	{
		"stevearc/overseer.nvim",
		opts = {
			strategy = "toggleterm",
		},
		keys = {
			{
				"<leader>rr",
				"<cmd>OverseerRun<cr>",
				mode = "n",
				desc = "Run Overseer task",
			},
			{
				"<leader>rt",
				"<cmd>OverseerToggle<cr>",
				mode = "n",
				desc = "Show all Overseer tasks",
			},
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
				lualine_a = { {
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				} },
				lualine_c = { "filename", "aerial" },
				lualine_x = { "overseer" },
			},
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		opts = { useDefaultKeymaps = true },
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			direction = "float",
			open_mapping = "<leader>ot",
			insert_mappings = false,
		},
	},
	"RaafatTurki/hex.nvim",
	{
		"FeiyouG/commander.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>p",
				function()
					require("commander").show()
				end,
				mode = "n",
				desc = "Open commander prompt",
			},
		},
		opts = {
			components = {
				"DESC",
				"KEYS",
				"CAT",
			},
			sort_by = {
				"DESC",
				"KEYS",
				"CAT",
				"CMD",
			},
			integration = {
				telescope = {
					enable = true,
				},
				lazy = {
					enable = true,
				},
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			columns = {
				"icon",
				"permissions",
				"size",
			},
			keymaps = {
				["h"] = "actions.parent",
				["l"] = "actions.select",
				["q"] = "actions.close",
				["<esc>"] = "actions.close",
			},
		},
		keys = {
			{
				"-",
				function()
					require("oil").open_float()
				end,
				desc = "Open parent directory",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			nix = { "nixfmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "ruff", "black" },
		},
	},
	{
		"/IndianBoy42/tree-sitter-just",
		config = true,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3", -- Recommended
		ft = { "rust" },
	},
})

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Set colorscheme (order is important here)
vim.o.termguicolors = true

vim.o.expandtab = true
vim.o.shiftwidth = 4

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- Y yank until the end of line  (note: this is now a default on master)
vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "<leader>fs", "<cmd>:w<CR>")

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
})

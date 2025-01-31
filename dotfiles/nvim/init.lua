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

local lsp_servers = { "clangd", "lua_ls", "ruff", "rust_analyzer" }
require("lazy").setup({
        { "actionshrimp/direnv.nvim", opts = {} },
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				config = {
					week_header = {
						enable = false,
					},
					shortcut = {
						{
							desc = "󰊳 Update",
							group = "@property",
							action = "Lazy update",
							key = "u",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Apps",
							group = "DiagnosticHint",
							action = "Telescope app",
							key = "a",
						},
						{
							desc = " dotfiles",
							group = "Number",
							action = "Telescope dotfiles",
							key = "d",
						},
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
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

			vim.keymap.set("n", "<leader>,", require("telescope.builtin").buffers, { silent = true })
			vim.keymap.set("n", "<leader>ff", function()
				require("telescope.builtin").find_files({ previewer = true })
			end, { silent = true })
			vim.keymap.set("n", "<leader>fr", function()
				require("telescope.builtin").oldfiles({ previewer = true })
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

			vim.keymap.set("n", "<leader>gl", require("telescope.builtin").git_commits, { silent = true })
			vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches, { silent = true })
		end,
	},
	{
		"0xstepit/flow.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("flow").setup({
				transparent = false, -- Set transparent background.
				fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
				mode = "normal", -- Intensity of the palette: normal, bright, desaturate, or dark. Notice that dark is ugly!
				aggressive_spell = false, -- Display colors for spell check.
			})

			vim.cmd("colorscheme flow")
		end,
	},
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
            },
            config = true,
            keys = {
                {"<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit"},
            }
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
                                ensure_installed = { "c", "lua", "vim", "python", "rust" },
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
                        'saghen/blink.cmp',
		},
		config = function()
                        local lspconfig = require('lspconfig')
			local on_attach = function(_, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				local key_opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, key_opts)
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, key_opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, key_opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, key_opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, key_opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, key_opts)
				vim.keymap.set({"v", "n"}, "<leader>ca", vim.lsp.buf.code_action, key_opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, key_opts)
				vim.keymap.set("n", "<leader>so", function()
					require("telescope.builtin").lsp_document_symbols()
				end, key_opts)
				vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
			end

			local key_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, key_opts)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, key_opts)
			vim.keymap.set("n", "<leader>E", vim.diagnostic.show, key_opts)

			-- Enable the following language servers
			for _, lsp in ipairs(lsp_servers) do
				local settings = {}
				if lsp == "lua_ls" then
					settings = {
						Lua = { diagnostics = { globals = { "vim" } } },
					}
				end
				lspconfig[lsp].setup({
					settings = settings,
					on_attach = on_attach,
					capabilities = require('blink.cmp').get_lsp_capabilities(),
				})
			end
		end,
	}, -- Collection of configurations for built-in LSP client
	{
		"L3MON4D3/LuaSnip", -- Snippets plugin
		version = "v1.*",
	},
        {
                'saghen/blink.cmp',
                -- optional: provides snippets for the snippet source
                dependencies = {
                    'rafamadriz/friendly-snippets',
                    'mikavilpas/blink-ripgrep.nvim',
                },

                -- use a release tag to download pre-built binaries
                version = '*',
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
                        keymap = { preset = 'super-tab' },

                        appearance = {
                            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                            -- Useful for when your theme doesn't support blink.cmp
                            -- Will be removed in a future release
                            use_nvim_cmp_as_default = true,
                            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                            -- Adjusts spacing to ensure icons are aligned
                            nerd_font_variant = 'mono'
                        },

                        -- Default list of enabled providers defined so that you can extend it
                        -- elsewhere in your config, without redefining it, due to `opts_extend`
                        sources = {
                                default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
                                providers = {
                                        ripgrep = {
                                                module = "blink-ripgrep",
                                                name = "Ripgrep",
                                        },
                                },
                        },
                },
                opts_extend = { "sources.default" }
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
		opts = { keymaps = { useDefaults = true }},
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
                lazy = false,
		opts = {
                        default_file_explorer = true,
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
                dependencies = { { "echasnovski/mini.icons", opts = {} } },
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
		"IndianBoy42/tree-sitter-just",
		config = true,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
        {
                'saecki/crates.nvim',
                event = { "BufRead Cargo.toml" },
                config = function()
                    require('crates').setup()
                end,
        },
	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = false,
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

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.keymap.set("n", "<leader>fs", "<cmd>:w<CR>")

vim.keymap.set("n", "<leader>w/", "<cmd>:vsplit<cr>")
vim.keymap.set("n", "<leader>w-", "<cmd>:split<cr>")

vim.keymap.set("n", "<leader>bd", "<cmd>:bdelete<cr>")


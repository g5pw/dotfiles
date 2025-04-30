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

require("lazy").setup({
        { "actionshrimp/direnv.nvim", opts = {} },
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
                config = {
                    theme = 'hyper',
                    config = {
                      week_header = {
                       enable = false,
                      },
                      shortcut = {
                        {
                          desc = '󰊳 Update',
                          group = '@property',
                          action = 'Lazy update',
                          key = 'u',
                        },
                        {
                          icon = ' ',
                          icon_hl = '@variable',
                          desc = 'Files',
                          group = 'Label',
                          action = 'Telescope find_files',
                          key = 'f',
                        },
                        {
                          desc = '󰞋 Help',
                          group = 'DiagnosticHint',
                          action = 'Telescope help_tags',
                          key = 'h',
                        },
                        {
                          desc = ' dotfiles',
                          group = 'Number',
                          action = 'Telescope find_files cwd=~/.config/nix-darwin/dotfiles/',
                          key = 'd',
                        },
                      },
                    },
                  },
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
                "rgroli/other.nvim",
                main = 'other-nvim',
                opts = {
                    mappings = {
                        "c",
                        "golang",
                        "python",
                        "rust",
                    },
                },
                cmd = "Other",
                keys = {
                    {"<leader>ll", "<cmd>:Other<CR>", { noremap = true, silent = true }},
                    {"<leader>ltn", "<cmd>:OtherTabNew<CR>", { noremap = true, silent = true }},
                    {"<leader>lp", "<cmd>:OtherSplit<CR>", { noremap = true, silent = true }},
                    {"<leader>lv", "<cmd>:OtherVSplit<CR>", { noremap = true, silent = true }},
                    {"<leader>lc", "<cmd>:OtherClear<CR>", { noremap = true, silent = true }},

                    -- Context specific bindings
                    {"<leader>lt", "<cmd>:Other test<CR>", { noremap = true, silent = true }},
                    {"<leader>ls", "<cmd>:Other scss<CR>", { noremap = true, silent = true }},
                },
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
                opts = {
                        defaults = {
                                mappings = {
                                        i = {
                                                ["<C-u>"] = false,
                                                ["<C-d>"] = false,
                                        },
                                },
                        },
                },
                keys = {
			{"<leader>,", function() require("telescope.builtin").buffers() end, { silent = true }},
			{"<leader>ff", function() require("telescope.builtin").find_files({ previewer = true }) end, { silent = true }},
			{"<leader>fr", function() require("telescope.builtin").oldfiles({ previewer = true }) end, { silent = true }},
			{"<leader>sb", function() require("telescope.builtin").current_buffer_fuzzy_find() end, { silent = true }},
			{"<leader>sh", function() require("telescope.builtin").help_tags() end, { silent = true }},
			{"<leader>st", function() require("telescope.builtin").tags() end, { silent = true }},
			{"<leader>sd", function() require("telescope.builtin").grep_string({initial_mode = "normal"}) end, { silent = true }},
			{"<leader>sp", function() require("telescope.builtin").live_grep() end, { silent = true }},
			{"<leader>so", function() require("telescope.builtin").tags({ only_current_buffer = true }) end, { silent = true }},
			{"<leader>?", function() require("telescope.builtin").oldfiles() end, { silent = true }},

			{"<leader>gl", function() require("telescope.builtin").git_commits() end, { silent = true }},
			{"<leader>gb", function() require("telescope.builtin").git_branches() end, { silent = true }},
                        {"<leader>'", function() require("telescope.builtin").resume() end, {silent = true}},

                },
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

			vim.cmd.colorscheme("flow")
		end,
	},
	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
                ---@module "ibl"
                ---@type ibl.config
		opts = {
                    exclude = {
                        filetypes = {"dashboard"}
                    },
                },
	},
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
            },
            opts = {
                disable_hint = true,
                graph_style = "kitty",
            },
            keys = {
                {"<leader>gg", function() require('neogit').open() end, desc = "Neogit"},
                {"<leader>gl", function() require('neogit').open({'log'}) end, desc = "Neogit log"},
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
        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {
            }
        },
	-- Additional textobjects for treesitter
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"roobert/tabtree.nvim",
		config = true,
	},
	{
		"L3MON4D3/LuaSnip", -- Snippets plugin
		version = "v2.*",
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
                cmd = "Trouble",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
                keys = {
                    {
                        "<leader>xx",
                        "<cmd>Trouble diagnostics toggle<cr>",
                        desc = "Diagnostics (Trouble)",
                    },
                    {
                        "<leader>xX",
                        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                        desc = "Buffer Diagnostics (Trouble)",
                    },
                    {
                        "<leader>cs",
                        "<cmd>Trouble symbols toggle focus=false<cr>",
                        desc = "Symbols (Trouble)",
                    },
                    {
                        "<leader>cl",
                        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                        desc = "LSP Definitions / references / ... (Trouble)",
                    },
                    {
                        "<leader>xL",
                        "<cmd>Trouble loclist toggle<cr>",
                        desc = "Location List (Trouble)",
                    },
                    {
                        "<leader>xQ",
                        "<cmd>Trouble qflist toggle<cr>",
                        desc = "Quickfix List (Trouble)",
                    },
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
                    desc = "Open the file manager in nvim's working directory" ,
                },
                {
                    -- NOTE: this requires a version of yazi that includes
                    -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                    '<c-up>',
                    "<cmd>Yazi toggle<cr>",
                    desc = "Resume the last yazi session",
                },
            },
            ---@type YaziConfig
            opts = {
                -- if you want to open yazi instead of netrw, see below for more info
                open_for_directories = false,
                keymaps = {
                    show_help = '<f1>',
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
vim.wo.relativenumber = true

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
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    desc = "Briefly highlight yanked text",
    callback = function()
        vim.hl.on_yank {higroup='Visual', timeout=100}
    end
})

vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "help,lspinfo,qf,startuptime",
    desc = "Quick exit for readonly windows",
    callback = function()
        vim.api.nvim_set_keymap(
            "n",
            "q",
            "<cmd>close<CR>",
            { noremap = true, silent = true }
        )
    end,
})

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.keymap.set("n", "<leader>fs", "<cmd>:w<CR>")

vim.keymap.set("n", "<leader>w/", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>w-", vim.cmd.split)

vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "Delete current buffer" })

---@type rustaceanvim.Opts
vim.g.rustaceanvim = {
    ---@type rustaceanvim.tools.Opts
    tools = {
        -- ...
    },
    ---@type rustaceanvim.lsp.ClientOpts
    server = {
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
                files = {
                    excludeDirs = {
                        ".cargo",
                        ".direnv",
                        ".devenv",
                        ".git",
                        "target",
                    }
                }
            },
        },
        -- ...
    },
    ---@type rustaceanvim.dap.Opts
    dap = {
        -- ...
    },
}

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.foldlevelstart = 99

vim.lsp.enable({'luals', 'clangd', 'cmake-language-server', 'tinymist'})

vim.o.tildeop = true

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
vim.o.softtabstop = -1

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,popup,noinsert"
vim.o.wildmode = "longest,list"

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.foldlevelstart = 99

vim.o.guifont = "MonaspiceAr Nerd Font:h10"

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 5

vim.o.timeoutlen = 300

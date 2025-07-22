-- Options {{{
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
vim.o.wildmode = "list:longest"

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.foldlevelstart = 99

vim.o.guifont = "MonaspiceAr Nerd Font:h10"
-- }}}

-- Autocmds {{{
-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 100 })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "help,lspinfo,qf,startuptime",
  desc = "Quick exit for readonly windows",
  callback = function()
    vim.api.nvim_set_keymap("n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})
-- }}}

-- Keymaps {{{
--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>fs", "<cmd>:w<CR>")

vim.keymap.set("n", "<leader>w/", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>w-", vim.cmd.split)

vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "Delete current buffer" })

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {desc = 'LSP Rename'})
-- }}}

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
      ["rust-analyzer"] = {
        files = {
          excludeDirs = {
            ".cargo",
            ".direnv",
            ".devenv",
            ".git",
            "target",
          },
        },
      },
    },
    -- ...
  },
  ---@type rustaceanvim.dap.Opts
  dap = {
    -- ...
  },
}

vim.lsp.enable({ "luals", "clangd", "cmake-language-server", "tinymist" })

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

require("lazy").setup("plugins")


vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
    end
end, vim.api.nvim_create_namespace "auto_hlsearch")

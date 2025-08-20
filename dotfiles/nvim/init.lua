require("options")

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

require("keymaps")

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

require("lazy-bootstrap")
require("lazy").setup("plugins")

vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
    end
end, vim.api.nvim_create_namespace "auto_hlsearch")

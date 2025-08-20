--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>fs", "<cmd>:w<CR>")

vim.keymap.set("n", "<leader>w/", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>w-", vim.cmd.split)

vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "Delete current buffer" })

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "LSP Hover" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

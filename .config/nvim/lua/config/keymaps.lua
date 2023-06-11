local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)



-- Telescope
--
vim.keymap.set('n', '<leader>gs', '<cmd>Telescope grep_string<CR>', opts)
vim.keymap.set("n", "<leader>gco", "<cmd>Telescope git_branches<CR>", opts)

---------------------
--- General Keymaps
---------------------
vim.keymap.set('n', '<leader>b', "<cmd>Buffers<CR>", opts)


vim.keymap.set('n', '<leader>co', "<cmd>CSToggle<CR>", opts)

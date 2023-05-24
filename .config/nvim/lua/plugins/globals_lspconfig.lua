-- Setup lspconfig
--
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-------------------------
----- Native LSP
-------------------------
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)


return {
  capabilities = capabilities
}

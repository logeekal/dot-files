---@type lsp.ClientCapabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local search_utils = require('utils.search')
-- local capabilities = vim.lsp.protocol.make_client_capabilities()


local format = function()
  vim.lsp.buf.format()
end

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

---Use an on_attach function to only map the following keys
---after the language server attaches to the current buffer
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)

    vim.api.nvim_create_user_command('LspInlayHint', function()
      local enabled = vim.lsp.inlay_hint.is_enabled()
      vim.lsp.inlay_hint.enable(not enabled)
    end, { desc = 'Toggling inlay_hint feature' })
  end

  if client:supports_method('textDocument/formatting', bufnr) then
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = false })
    end)
  end

  local bufOpts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufOpts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufOpts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufOpts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufOpts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufOpts)
  vim.keymap.set('n', '<leader>fr', format, bufOpts)
  -- code action

  -- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  --   buffer = bufnr,
  --   callback = format,
  -- })
end

---@type vim.lsp.config
return {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = { '.git' },
}

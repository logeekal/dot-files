local lspconfig = require('lspconfig')
local globals_lspconfig = require('plugins.globals_lspconfig')

-----------------------
---      Mason
-----------------------

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})


local format = function()
  vim.lsp.buf.format()
end

local on_attach = function(client, bufnr)
  local bufOpts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufOpts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufOpts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufOpts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufOpts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufOpts)
  vim.keymap.set("n", "gr",
    "<CMD>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({layout_config={width=0.9,prompt_position=top,mirror=true,anchor='N',height=0.5}}))<CR>",
    bufOpts)
  vim.keymap.set('n', '<leader>fr', format, bufOpts)
  vim.keymap.set('n', '<leader>ds', "<cmd>Telescope lsp_document_symbols<CR>", bufOpts)
  vim.keymap.set("n", "<leader>b",
    "<CMD>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({layout_config={width=0.9,prompt_position=top,mirror=true,anchor='N',height=0.5}}))<CR>"
    , bufOpts)

  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    buffer = bufnr,
    callback = format
  })
end

local lsp_flags = {
  debounce_text_changes = 150
}


local lsp_handlers = {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = globals_lspconfig.capabilities,
      on_attach = on_attach,
      flags = lsp_flags
    }
  end,

  ['svelte'] = function()
    require("lspconfig").svelte.setup { filetypes = { "svelte", "html" }, on_attach = on_attach }
  end,
  ['eslint'] = function()
    lspconfig.eslint.setup({
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
        on_attach(client, bufnr)
      end,
    })
  end,

}

require("mason-lspconfig").setup({
  ensure_installed = { "luau_lsp", "tsserver", "eslint", "yamlls", "lua_ls", "rust_analyzer", "bashls", "vimls",
    "emmet_ls", "cssls", 'graphql', "jsonls", "svelte", "tailwindcss" },
  automatic_installation = true,
  handlers = lsp_handlers
})

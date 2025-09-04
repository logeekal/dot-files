return {
  -- customize handlers for commands
  handlers = {
    source_definition = function(err, locations) end,
    file_references = function(err, locations) end,
    code_action = function(err, actions) end,
  },
  -- automatically trigger renaming of extracted symbol
  refactor_auto_rename = true,
  refactor_move_to_file = {
    -- If dressing.nvim is installed, telescope will be used for selection prompt. Use this to customize
    -- the opts for telescope picker.
    telescope_opts = function(items, default) end,
  },
  root_markers = { 'tsconfig.json', 'jsonconfig.json', 'package.json', '.git' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  settings = {
    vtsls = { autoUseWorkspaceTsdk = true },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = false },
        variableTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = false },
        functionLikeReturnTypes = { enabled = false },
        enumMemberValues = { enabled = true },
      },
      tsserver = {
        maxTsServerMemory = 8192,
        globalPlugins = {},
      },
    },
  },
}

-- local util = require('lspconfig.util')
-- return {
--   cmd = { 'vtsls', '--stdio' },
--   filetypes = {
--     'javascript',
--     'javascriptreact',
--     'javascript.jsx',
--     'typescript',
--     'typescriptreact',
--     'typescript.tsx',
--   },
--   root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
--   root_dir = util.root_pattern('.git'),
--   settings = {
--     vtsls = {
--       tsserver = { globalPlugins = {} },
--       autoUseWorkspaceTsdk = true,
--     },
--     typescript = {
--       tsserver = {
--         maxTsServerMemory = 8192,
--         globalPlugins = {},
--       },
--       inlayHints = {
--         parameterNames = { enabled = 'literals' },
--         parameterTypes = { enabled = true },
--         variableTypes = { enabled = true },
--         propertyDeclarationTypes = { enabled = true },
--         functionLikeReturnTypes = { enabled = true },
--         enumMemberValues = { enabled = true },
--       },
--     },
--   },
--   before_init = function(_, config)
--     table.insert(config.settings.vtsls.tsserver.globalPlugins, {
--       name = '@vue/typescript-plugin',
--       languages = { 'vue' },
--       enableForWorkspaceTypeScriptVersions = true,
--     })
--   end,
--   on_attach = function(client)
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.documentRangeFormattingProvider = false
--   end,
-- }

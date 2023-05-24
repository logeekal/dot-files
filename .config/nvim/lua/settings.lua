require('plugins.nvim-tree')
local lspconfig = require('lspconfig')
-----------------------
--   vars
-----------------------

local dropDownTheme = require('telescope.themes').get_dropdown({
  layout_config = {
    width = 0.9,
    preview_cutoff = 1,
    height = 0.5,
    mirror = true,
    anchor = 'N',
    prompt_position = 'top'
  }
})

local telescope = require('telescope.builtin')

-----------------------
---  Themes
-----------------------
local od = require("onedark")
od.setup {
  style = 'cool',
  transparent = 'false'
}

od.load()

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


-----------------------
----- NVIM CMP LSM
-----------------------
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
    { name = 'window' }
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})


---- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline('/', {
--mapping = cmp.mapping.preset.cmdline(),
--sources = {
--{ name = 'buffer' }
--}
--})

---- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline(':', {
--mapping = cmp.mapping.preset.cmdline(),
--sources = cmp.config.sources({
--{ name = 'path' }
--}, {
--{ name = 'cmdline' }
--})
--})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-------------------------
----- Native LSP
-------------------------
local opts = { noremap = true, silent = true }

local format = function()
  vim.lsp.buf.format()
end

vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

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
    print('Setting up : ', server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
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



----------------------------
--    Telescope
----------------------------


require('telescope').setup {
  defaults = {
    dynamic_preview_title = true,
    layout_config = {
      vertical = {
        mirror = true,
        prompt_position = 'top'
      }
    }
  },
  pickers = {
    --find_files = {
    --theme = "dropdown",
    --},
    --git_files = {
    --theme = "dropdown"
    --}
  }
}


require('telescope').load_extension('fzf')
vim.keymap.set('n', "<leader>rg", function() telescope.live_grep(dropDownTheme) end, opts)
vim.keymap.set('n', "<leader>pa", function() telescope.find_files(dropDownTheme) end, opts)
vim.keymap.set('n', "<leader>p", function() telescope.git_files(dropDownTheme) end, opts)
--vim.keymap.set('n', "<leader>gr", function() telescope.lsp_references(dropDownTheme) end, opts)
--require('telescope').load_extension('media_files')

----------------------------
--    Treesitter
----------------------------
require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "rust", "javascript", "typescript", "lua", "python", "bash", "html", "css", "graphql", "go",
    "json", "yaml", "svelte", "scss", "vim", "svelte" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    --disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
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
}



-----------------------
---    AutCmds
-----------------------


--vim.api.nvim_create_autocmd(
--{ "BufWritePre" },
--{ pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.json" }, command = "EslintFixAll" }
--)

vim.api.nvim_create_autocmd(
  { "BufReadPost" },
  {
    pattern = "*.svelte",
    command = "syntax on | set syntax=html"
  }
)

--vim.api.nvim_create_autocmd(
--{ "BufWritePre" },
--{
--pattern = { "*" },
--callback = function()
--if vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" or vim.bo.filetype == "javascriptreact" or
--vim.bo.filetype == "typescriptreact"
--then
--print('eslint---->')
---- NOTE: don't format javascript files
--vim.lsp.buf.format({ name = eslint })
--return
--else
----require("lvim.lsp.utils").format { timeout_ms = 2000, filter = require("lvim.lsp.utils").format_filter }
--print('Not eslint---->')
--vim.lsp.buf.format() -- careful, this overrides null-ls preferences
--return
--end
--end,
--}
--)

------------------------
---   LuaSnip Config
------------------------

require("luasnip.loaders.from_vscode").lazy_load()


---------------------
--- General Keymaps
---------------------
vim.keymap.set("n", "<leader>gco", "<cmd>Telescope git_branches<CR>", opts)
vim.keymap.set('n', '<leader>b', "<cmd>Buffers<CR>", opts)

vim.api.nvim_create_user_command(
  'CSToggle',
  function()
    local current_theme = vim.g.colors_name
    require(current_theme).toggle()
  end,
  {}
)

vim.keymap.set('n', '<leader>co', "<cmd>CSToggle<CR>", opts)

vim.keymap.set({ 'n', 'i' }, '<c-e>', '<cmd>NvimTreeToggle %:p:h<CR>', opts)

-----------------------
--  Lua line
-----------------------

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'auto',
    section_separators = '',
    component_separators = '',
  }
}


----------------------------
---     Bufline
----------------------------
vim.opt.termguicolors = true
require("bufferline").setup {}

vim.keymap.set("n", "H", '<cmd>BufferLineCycleNext<CR>', opts)
vim.keymap.set("n", "L", '<cmd>BufferLineCyclePrev<CR>', opts)


------------------------
--- OCto
------------------------
require "octo".setup({
  default_remote = { "upstream", "origin" }, -- order to try remotes
  ssh_aliases = {},                          -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
  reaction_viewer_hint_icon = "",         -- marker for user reactions
  user_icon = " ",                        -- user icon
  timeline_marker = "",                   -- timeline marker
  timeline_indent = "2",                     -- timeline indentation
  right_bubble_delimiter = "",            -- Bubble delimiter
  left_bubble_delimiter = "",             -- Bubble delimiter
  github_hostname = "",                      -- GitHub Enterprise host
  snippet_context_lines = 4,                 -- number or lines around commented lines
  file_panel = {
    size = 10,                               -- changed files panel rows
    use_icons = true                         -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
  },
  mappings = {
    issue = {
      close_issue = { lhs = "<space>ic", desc = "close issue" },
      reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload issue" },
      open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    pull_request = {
      checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
      merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
      squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
      list_commits = { lhs = "<space>pc", desc = "list PR commits" },
      list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
      show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
      add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
      remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
      close_issue = { lhs = "<space>ic", desc = "close PR" },
      reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload PR" },
      open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      goto_file = { lhs = "gf", desc = "go to file" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    review_thread = {
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    submit_win = {
      approve_review = { lhs = "<C-a>", desc = "approve review" },
      comment_review = { lhs = "<C-m>", desc = "comment review" },
      request_changes = { lhs = "<C-r>", desc = "request changes review" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    },
    review_diff = {
      add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
      add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      next_thread = { lhs = "]t", desc = "move to next thread" },
      prev_thread = { lhs = "[t", desc = "move to previous thread" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    },
    file_panel = {
      next_entry = { lhs = "j", desc = "move to next changed file" },
      prev_entry = { lhs = "k", desc = "move to previous changed file" },
      select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
      refresh_files = { lhs = "R", desc = "refresh changed files panel" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    }
  }
})

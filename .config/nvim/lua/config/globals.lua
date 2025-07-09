-- Reference :  https://github.com/LazyVim/LazyVim/blob/6b68378c2c5a6d18b1b4c5ca4c71441997921200/lua/lazyvim/config/options.lua
local opt = vim.opt

opt.autowrite = true           -- Enable auto write
opt.clipboard = 'unnamedplus'  -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 3           -- Hide * markup for bold and italic
opt.confirm = true             -- Confirm to save changes before exiting modified buffer
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = true           -- Use spaces instead of tabs
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99             -- By default unfolded code
opt.foldmethod = 'indent'
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true      -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 0
opt.list = true            -- Show some invisible characters (tabs...
opt.mouse = ''             -- Disable mouse mode
opt.number = true          -- Print line number
opt.pumblend = 10          -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
opt.relativenumber = true  -- Relative line numbers
opt.scrolloff = 4          -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true      -- Round indent
opt.shiftwidth = 2         -- Size of an indent
opt.shortmess:remove("F")
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false     -- Dont show mode since we have a statusline
opt.sidescrolloff = 8    -- Columns of context
opt.signcolumn = 'yes'   -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true     -- Don't ignore case with capitals
opt.smartindent = true   -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true    -- Put new windows below current
opt.splitright = true    -- Put new windows right of current
opt.tabstop = 2          -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap
opt.swapfile = false               -- Disable Swap file

vim.o.winborder = "bold"

require('tokyonight').load()
-- require('onedark').load()
--
require('nightfox.config').set_fox('dayfox')
require('nightfox.config').set_fox('nightfox')
require('nightfox.config').set_fox('terafox')
require('nightfox.config').set_fox('carbonfox')
-- require('carboxfox').load()
-- require('nightfox').load()

local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'single'
  return opts
end

------
--- Markdown
vim.filetype.add({ extension = { mdx = 'markdown' } })

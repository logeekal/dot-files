"""basic options

set autoindent
set history=50
set number
set relativenumber
set mouse=
set ruler
set showcmd
set incsearch
set nofoldenable
set nowrap
set showtabline=2
set encoding=UTF-8
"set guifont=DejaVu\ Sans:s12
set guifont=Ubuntu\ Nerd\ Font\ Complete\ 12
set foldmethod=indent
set number
set noswapfile
set termguicolors
set t_Co=256

filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
set nobackup

let mapleader=";"
  
"""Vim-Plug
call plug#begin()

"Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'mattn/emmet-vim'
Plug 'jparise/vim-graphql'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'heavenshell/vim-jsdoc', {'do' :'npm install -g lehre' } 

Plug 'jiangmiao/auto-pairs'
Plug 'lilydjwg/colorizer'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'powerline/powerline-fonts'
Plug 'sheerun/vim-polyglot'

"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

""""""""""""""""
" nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
""""""""""""""""
""""""""""""""""
"   Telescope
""""""""""""""""
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': ' arch -arm64 make' }
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
""""""""""""""""""""
Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdcommenter'

Plug 'tpope/vim-surround'

:nmap <leader>t :TagbarToggle<CR>

"""""""""
"" Themes
"""""""""
Plug 'navarasu/onedark.nvim' 
Plug 'rose-pine/neovim'
Plug 'folke/tokyonight.nvim'

""""""""""""""
"  Octo-git client
""""""""""""""
Plug 'pwntester/octo.nvim'

Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'
Plug 'akinsho/bufferline.nvim', {'tag': 'v2.*' }

call plug#end()

"""
lua require("settings")
"""

"General bindings
vnoremap <F5> "+y<CR>

""" Settings for FZF
map <C-f> :FZF<CR>
imap <C-f> <c-o>:FZF<CR>
map <leader>g :BLines<CR>
imap <leader>g <c-o>:BLines<CR>

"""""""
"JSDoc
"
"""""""
let g:jsdoc_lehre_path="/usr/lib/node_modules/lehre/bin/lehre"
nnoremap jsd :call jsdoc#insert()<CR>

let g:vim_home = get(g:, 'vim_home', expand('~/dotfiles/'))

let config_list = [
      \ 'plugin-settings/*.vim'
      \ ]


for files in config_list
  for f in glob(g:vim_home.files,1,1)
    exec 'source' f
  endfor
endfor

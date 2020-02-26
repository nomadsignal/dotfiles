if &compatible
  set nocompatible
endif

call plug#begin('~/.config/nvim/plugins')

"""""""""""""""""""""
" Code completion
"""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Omnisharp/omnisharp-vim'

"""""""""""""""""""""
" UI 
"""""""""""""""""""""
" Colorscheme
Plug 'chriskempson/base16-vim'
" Statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Project overview
Plug 'preservim/nerdtree'
" Handling codebase
Plug 'junegunn/fzf', {'do': './install --bin'}
Plug 'junegunn/fzf.vim'
" Surround
Plug 'tpope/vim-surround'
" Auto Pairs
Plug 'jiangmiao/auto-pairs'

call plug#end()

filetype plugin on
syntax enable

let mapleader=","
let maplocalleader="\\"
set shell=/usr/bin/zsh
set noswapfile        " Disable swapfiles"
set backspace=2       " make backspace work like most other apps
set ruler             " show the cursor position all the time
set showcmd           " display incomplete commands
set history=1000      " sets how many lines of history VIM has to remember
" If you want normal yanks to use the system clipboard too
set clipboard=unnamedplus 
set showmatch         " highlight matching brackets
set lazyredraw        " redraw only when we need to"
set number            " show numbers
set ttimeout          " remove the delay of pressing ESC in insertmode
set ttimeoutlen=1
set autoread          " automaticly refresh changed files

set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set shiftwidth=4        " Indentation amount for < and > commands.

set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" Set encoding
set encoding=UTF-8
" Set proper tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

""""""" Search
set ignorecase        " make searching case insensitive
set smartcase         " .. unless the query has capital letters
set incsearch

nnoremap <CR> :nohlsearch <CR><CR> 

""""""" Copy/Paste 
" Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
" Paste to clipboard
vnoremap <leader>p "+p
nnoremap <leader>p "+p

""""""" Folds
set foldmethod=indent
set foldnestmax=3
set nofoldenable

""""""" Indentation
set autoindent 
set smartindent
set smarttab
set shiftwidth=2
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

"""""" Colorscheme
syntax on
set t_Co=256

" Plugin Settings
"{
  "Omnisharp {
  let g:Omnisharp_server_stdio = 1
  let g:Omnisharp_selector_ui = 'fzf'
  "}
  "COC {
  set hidden
  set nobackup
  set nowritebackup
  set cmdheight=2
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes
  "}
  "FZF {
  let g:fzf_nvim_statusline = 0 "disable statusline overwriting

  let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit',
        \ 'ctrl-t': 'tabnew'
        \ }
  nnoremap <c-p> :FZF<cr>

  augroup fzf
    autocmd!
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  augroup END
  "}
  "NERDtree {
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  "}
  "AIRLINE {
  set laststatus=2
  let g:airline_detect_paste=1
  let g:airline#extensions#tabline#enabled=1
  let g:airline_theme='base16color' 
  "}
  "COLORSCHEME{
  if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
  endif
  "}
"}

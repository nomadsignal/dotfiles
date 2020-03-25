if &compatible
	set nocompatible
endif

call plug#begin('~/.config/nvim/plugins')

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Colorscheme
Plug 'chriskempson/base16-vim'
" Statusbar
Plug 'itchyny/lightline.vim'
" Handling codebase
Plug 'junegunn/fzf', {'do': './install --bin'}
Plug 'junegunn/fzf.vim'
" Surround
Plug 'tpope/vim-surround'
" Auto Pairs
Plug 'jiangmiao/auto-pairs'

call plug#end()

filetype indent plugin on
syntax enable

let mapleader=","
let maplocalleader="\\"
set shell=/usr/bin/zsh
set noswapfile        " Disable swapfiles"
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

set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" Set encoding
set encoding=UTF-8

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

set nolist                " Show problematic characters.

""""""" Search
set ignorecase        " make searching case insensitive
set smartcase         " .. unless the query has capital letters
set incsearch

""""""" Folds
set foldmethod=indent
set foldnestmax=3
set nofoldenable

""""""" Indentation
set autoindent 
set smartindent
set smarttab
set shiftwidth=2
set tabstop=2

"""""" Colorscheme
syntax on
set t_Co=256
set cursorline
let base16colorspace=256

if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

" Plugin Settings
" CoC {
" Install extensions 
let g:coc_global_extensions=['coc-omnisharp',  ]
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Documenthighlight
au CursorHold * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')



" }
"FZF {

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit' }

" Default fzf layout
let g:fzf_layout = { 'window': {'width': 1, 'height': 0.38, 'yoffset': 0.98 } }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
			\ { 'fg':      ['fg', 'Normal'],
			\ 'bg':      ['bg', 'Normal'],
			\ 'hl':      ['fg', 'Comment'],
			\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+':     ['fg', 'Statement'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! FZF_search_gitproject()
	
	" Check if you are in a git repository
	if (system('git status') !~ '^fatal')
		let wd = fnamemodify(system('git rev-parse --show-toplevel'), ':r')
		let ripgrep = '
				\ rg --hidden     
				\ --glob "*.{cs,csproj}"
				\ --glob "!{*/obj/**,*/bin/**}"
				\ --files 
				\ '
		call fzf#run(fzf#wrap(fzf#vim#with_preview({
				\ 'source': wd . ripgrep 
				\ })))
	else 
		let wd = expand("%:r")

		call fzf#run(fzf#wrap('source': wd . ripgrep)) 
	endif
endfunction

command! -bang -complete=dir F call FZF_search_gitproject()


autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
			\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"}

"LIGHTLINE {
set laststatus=2

let g:lightline = {
			\ 'colorscheme': 'darcula',
			\ 'active': {
			\   'left': [ 
			\			[ 'mode', 'paste'  ],
			\			[ 'cocstatus', 'git', 'diagnostics',  'filename', 'method'  ]
			\ 	],
			\ 	'right': [
			\			[ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
			\			[ 'cocgitstatus', 'cocgitstatuschanged' ]
			\		],
			\ },
			\ 'component_function': {
			\		'blame': 'LightLineGitBlame',
			\ 	'cocstatus': 'coc#status',
			\		'cocgitstatus': 'CocGitStatus',
			\ 	'cocgitstatuschanged': 'CocGitChanged'
			\ },
			\ }

function! CocCurrentFunction()
	return get(b: 'coc_current_function', '')
endfunction
"}

"}
"""""""" Keybindings
"{
nnoremap <CR> :nohlsearch <CR><CR> 
" Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
" Paste to clipboard
vnoremap <leader>p "+p
nnoremap <leader>p "+p
" Terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <leader>t :sp<CR>:res 10<CR>:term<CR> 
" Tabs
nnoremap <silent> <leader>nt :tabnew<CR>
nnoremap <silent> <leader>gtn :tabnext<CR>
nnoremap <silent> <leader>gtp :tabprev<CR>
" Vimrc
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>
" Fzf
nnoremap <c-p> :F<CR>
" Coc
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>
"}


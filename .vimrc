"Use pathogen to modify the runtime path to include plugins under
"~/.vim/bundle directory
execute pathogen#infect()
call pathogen#helptags()

"""Coding
set nocompatible	"No compatibility with vi
syntax on
set background=dark
let g:solarized_termcolors = 256
colorscheme solarized



set showcmd		"Display incomplete commands
set number 		"Show line number
filetype plugin indent on 	"Load file type plugins + indentation

set noshowmode
set showmatch
set autoread                    "Auto read changed files

set hidden                      "Allow buffers to exist without being in window (i.e. in background
set wildmenu

set ofu=syntaxcomplete#Complete
"""Whitespace
set nowrap			"Don't wrap
set expandtab			"Use spaces not tabs
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set smarttab

"""Searching
set hlsearch			"Highlight search
set incsearch			"Make search incremental
set ignorecase			"Search is case insensitive
set smartcase			"Unless at least one capital letter
"Let's remove the highlighting after the search with 'esc'
nnoremap <esc> :noh<return><esc> 


set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc

set backupdir=~/.vim/backup 
set directory=~/.vim/tmp
"""Shit above does fa it seems
set nobackup
set nowritebackup
set noswapfile
set splitright
set splitbelow

set wrap
set linebreak

"No using arrow keys!
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"No bells
set visualbell 
set noerrorbells

"CtrlP mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
:nmap ; :CtrlPBuffer<CR>
:let g:ctrlp_match_window_bottom = 0
:let g:ctrlp_match_window_reversed = 0
:let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|zip|jar|par|pdf)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
:let g:ctrlp_working_path_mode = ''
:let g:ctrlp_dotfiles = 0
:let g:ctrlp_switch_buffer = 0

"NERDTree
:nmap ,t :NERDTreeToggle<CR>

"No mouse
set mousehide

"BufExplorer mapping
:map ,b :BufExplorer<CR>

set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=b


source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set encoding=utf-8
set guifont=Inconsolata\ for\ Powerline:h13
let g:Powerline_symbols = 'fancy'
set laststatus=2


"Markdown"
let g:vim_markdown_folding_disabled=1

"Scratch"
if argc() == 0
    au VimEnter * ScratchOpen
endif


"Spelling"
autocmd BufEnter,BufNewFile,BufRead *.{txt,md} setlocal spell spelllang=en_gb

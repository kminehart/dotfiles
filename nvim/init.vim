call plug#begin('~/.config/nvim/plugged')

" Ctrl+P = fast file browser
Plug 'kien/ctrlp.vim'
Plug 'dracula/vim'

" Colorizing
Plug 'lilydjwg/colorizer'

" Golang
Plug 'fatih/vim-go'

" Linting
Plug 'w0rp/ale'

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

Plug 'joshdick/onedark.vim'

call plug#end()

filetype plugin on

" Autocompletion via Deoplete
let g:deoplete#enable_at_startup = 1
set omnifunc=syntaxcomplete#Complete

" " Use <TAB>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Show tabs
set list

" let s:hidden_all = 1
set noshowmode
set noruler
" set laststatus=0
set statusline+=%F
set noshowcmd

" ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|vendor\|\.git'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Syntax Highlighting
syntax on

" Color overrides
highlight LineNr ctermfg=darkgray
highlight Pmenu ctermbg=darkgray
highlight Pmenu ctermfg=white

" File Explorer (netrw)
" let g:netrw_special_syntax = 1
" let g:netrw_liststyle = 1


" Line numbers
set number
set numberwidth=5

" Syntax, spacing
set expandtab
set smarttab
set smartindent
set autoindent

set shiftwidth=2
set tabstop=2
set softtabstop=2

set showmatch
set scrolloff=5
set sidescrolloff=5

set nowrap

" set list
set listchars=tab:→\ ,trail:~,extends:>,precedes:<

set backspace=2

" Searching
set smartcase 
set ignorecase
set nohlsearch
set incsearch

" Misc
set visualbell

" Swapfile
set noswapfile

" delete trailing whitespace on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.htm,*.html,*.css,*.js,*.php :call DeleteTrailingWS()

" PHP Indentation
autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType typescript setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType typescript.tsx setlocal shiftwidth=4 softtabstop=4 expandtab

" Undos
set undodir=~/.vim/undo
set undofile

" hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

" set foldcolumn=3

" f u mouse
autocmd BufEnter * set mouse=

set backupdir=~/.nvim/tmp,.
set directory=~/.nvim/tmp,.

" vim-go
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

" Ale
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

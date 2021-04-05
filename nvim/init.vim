" -------------------------------------------------------------------------------------------------
" Plugins
" -------------------------------------------------------------------------------------------------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')
" General Autocompletion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Ctrl+P = fast file browser
Plug 'kien/ctrlp.vim'
" Golang
Plug 'fatih/vim-go'
" typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()

filetype plugin on

" -------------------------------------------------------------------------------------------------
" General Settings
" -------------------------------------------------------------------------------------------------
" Use <TAB>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Show tabs
set list
set noshowmode
set noruler
set statusline+=%F
set noshowcmd
" Syntax Highlighting
syntax on
" Color overrides
colorscheme pablo
highlight LineNr ctermfg=darkgray
hi StatusLine ctermbg=black ctermfg=darkgray
hi FoldColumn ctermbg=black guibg=black
hi SignColumn ctermbg=black
hi Pmenu ctermbg=gray
hi PmenuSel ctermbg=white
hi PmenuSbar ctermbg=white
hi Tabs ctermfg=darkgray
hi SpellBad ctermfg=red ctermbg=white
hi SpellCap ctermfg=red ctermbg=white

" coc-nvim color fixes
hi CocErrorFloat ctermbg=red ctermfg=black
hi CocErrorHighlight cterm=underline ctermbg=none ctermfg=red

hi CocWarnFloat ctermbg=yellow ctermfg=black
hi CocWarnHighlight cterm=underline ctermbg=none ctermfg=yellow

hi CocInfoFloat ctermbg=blue ctermfg=black
" hi CocInfoHighlight ctermbg=none ctermfg=blue

hi CocFloating ctermbg=black

match Tabs /\t/

" Line numbers
set number
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
" Undos
set undodir=~/.config/nvim/undo
set undofile
" f u mouse
autocmd BufEnter * set mouse=
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.

" -------------------------------------------------------------------------------------------------
" Language-specific settings
" -------------------------------------------------------------------------------------------------
" PHP
autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4

" -------------------------------------------------------------------------------------------------
" ctrl-p
" -------------------------------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|vendor\|\.git'

" -------------------------------------------------------------------------------------------------
" vim-go
" -------------------------------------------------------------------------------------------------
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
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_jump_to_error = 0
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" -------------------------------------------------------------------------------------------------
" ale
" -------------------------------------------------------------------------------------------------
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

" -------------------------------------------------------------------------------------------------
" Conquer of Completion
" -------------------------------------------------------------------------------------------------
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
set signcolumn=auto

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Auto run prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" -------------------------------------------------------------------------------------------------
" Plugins
" -------------------------------------------------------------------------------------------------
call plug#begin('~/.config/nvim/bundle')
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'kien/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'sbdchd/neoformat'
Plug 'cappyzawa/starlark.vim'
Plug 'sainnhe/everforest'
Plug 'google/vim-jsonnet'

"" <Org Mode>
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'
"" </Org Mode>
Plug 'sotte/presenting.vim'
call plug#end()

filetype plugin on

" -------------------------------------------------------------------------------------------------
" General Settings
" -------------------------------------------------------------------------------------------------
" Show tabs
set list
set noshowmode
set noruler
" Show a simple statusline
set statusline+=%F
" Don't show that ugly bar at the bottom
set noshowcmd
" Syntax Highlighting
syntax on

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

if has('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme everforest

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
" Conquer of Completion (coc)
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

"" use <tab> for trigger completion and navigate to the next complete item
"function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
""" use <tab> for trigger completion and navigate to the next complete item
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? coc#_select_confirm() :
"      \ coc#expandableOrJumpable() ?
"      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"      \ CheckBackspace() ? "\<TAB>" :
"      \ coc#refresh()
"
"let g:coc_snippet_next = '<tab>'

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" use <c-space>for trigger completion
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

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_config_files = ['.prettierrc.js']

let g:coc_data_home = '~/.config/coc/'
"let g:coc_config_home = '~/.config/'
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

function! Gofmt()
    silent !goimports -w %
    silent edit
    redraw!
    silent CocRestart
endfunction

augroup gofmt
    autocmd!
    autocmd BufWritePost *.go call Gofmt()
augroup END

"""
" <Org Mode>
"""
lua << EOF

require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Work/org/*.org'},
  org_default_notes_file = '',
})

EOF

"""
" </Org Mode>
"""

" Auto run gofmt
" autocmd BufWritePost *.go silent! !goimports -w <afile>
" autocmd BufWritePost *.go edit
" autocmd BufWritePost *.go redraw!

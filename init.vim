" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'
Plug 'luochen1990/rainbow'
Plug 'prabirshrestha/async.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'dense-analysis/ale'
let g:rainbow_active = 1

Plug 'ekalinin/Dockerfile.vim'
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'editorconfig/editorconfig-vim'

Plug 'fatih/vim-go'

Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'honza/vim-snippets'

call plug#end()
" }}}

" GUI configuration {{{
if has("gui_running")
    set guioptions -=m
    set guioptions -=T
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif
" }}}

" General settings {{{
filetype plugin indent on
set background=dark
set autoread
color nord
set number relativenumber
set hidden
set completeopt=noinsert,menuone,noselect
" }}}

" Global mappings {{{
let mapleader = "\\"
let maplocalleader = ";"
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>
" }}}

" fzf configuration {{{
let $FZF_DEFAULT_COMMAND="fd --type f"
nnoremap <c-p> :FZF<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/flow-typed/*
" }}}

" ALE config {{{
let g:ale_fix_on_save = 1
let g:ale_fixers = {
						\'*': ['trim_whitespace'],
						\'python': ['autopep8', 'isort']
						\}
" }}}

" CoC configuration {{{
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Using CocList
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

" }}}

" Language specific configurations {{{
augroup javascript
    autocmd!
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType javascript setlocal smartindent
augroup END

augroup python
    autocmd!
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal smartindent
    autocmd FileType python setlocal expandtab
augroup END

augroup typescript
    autocmd!
    autocmd FileType typescript,typescript.tsx setlocal shiftwidth=2
    autocmd FileType typescript,typescript.tsx setlocal softtabstop=2
    autocmd FileType typescript,typescript.tsx setlocal tabstop=2
    autocmd FileType typescript,typescript.tsx setlocal smartindent
augroup END

augroup vimscript
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal shiftwidth=4
    autocmd FileType vim setlocal softtabstop=4
    autocmd FileType vim setlocal tabstop=2
    autocmd FileType vim setlocal smartindent
augroup END

augroup json
    autocmd!
    autocmd FileType json setlocal shiftwidth=2
    autocmd FileType json setlocal softtabstop=2
    autocmd FileType json setlocal tabstop=2
    autocmd FileType json setlocal smartindent
augroup END

augroup yaml
    autocmd!
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd FileType yaml setlocal tabstop=2
    autocmd FileType yaml setlocal smartindent
augroup END

augroup c_language
    autocmd!
    autocmd FileType c,h,cpp,hpp setlocal shiftwidth=4
    autocmd FileType c,h,cpp,hpp setlocal softtabstop=4
    autocmd FileType c,h,cpp,hpp setlocal tabstop=4
    autocmd FileType c,h,cpp,hpp setlocal smartindent
augroup END

augroup rust
    autocmd!
    autocmd FileType rust setlocal shiftwidth=2
    autocmd FileType rust setlocal softtabstop=2
    autocmd FileType rust setlocal tabstop=2
    autocmd FileType rust setlocal smartindent
augroup END

augroup css
    autocmd!
    autocmd FileType css setlocal shiftwidth=2
    autocmd FileType css setlocal softtabstop=2
    autocmd FileType css setlocal tabstop=2
    autocmd FileType css setlocal smartindent
augroup END

augroup html
    autocmd!
    autocmd FileType html setlocal shiftwidth=2
    autocmd FileType html setlocal softtabstop=2
    autocmd FileType html setlocal tabstop=2
    autocmd FileType html setlocal smartindent
augroup END

augroup shellscript
    autocmd!
    autocmd FileType sh setlocal shiftwidth=4
    autocmd FileType sh setlocal softtabstop=4
    autocmd FileType sh setlocal tabstop=4
    autocmd FileType sh setlocal smartindent
augroup END

augroup golang
    autocmd!
    autocmd FileType go setlocal shiftwidth=4
    autocmd FileType go setlocal softtabstop=4
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal smartindent
augroup END

augroup haskell
    autocmd FileType haskell setlocal shiftwidth=2
    autocmd FileType haskell setlocal softtabstop=2
    autocmd FileType haskell setlocal tabstop=2
    autocmd FileType haskell setlocal smartindent
augroup END
" }}}

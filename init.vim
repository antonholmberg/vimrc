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
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:rainbow_active = 1

Plug 'ekalinin/Dockerfile.vim'
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'Shougo/neco-vim'
Plug 'editorconfig/editorconfig-vim'

Plug 'fatih/vim-go'

Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'davidhalter/jedi-vim'
let g:jedi#popup_on_dot = 0

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

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

" LSP configuration {{{
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'python': ['pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:LanguageClient_diagnosticsEnable = 0

" }}}

" fzf configuration {{{
let $FZF_DEFAULT_COMMAND="fd --type f"
nnoremap <c-p> :FZF<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/flow-typed/*
" }}}

" Language specific configurations {{{
augroup javascript
    autocmd!
    if executable('typescript-language-server')
        autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
    endif
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
    if executable('autopep8')
        autocmd FileType python nnoremap <silent> <buffer> <localleader>f :!autopep8 -i -a %<cr>
    endif
		if executable('pylint')
				autocmd FileType python nnoremap <localleader>l :new <bar> 0read ! pylint #<cr>
		endif
augroup END

augroup typescript
    autocmd!
    if executable('typescript-language-server')
        autocmd FileType typescript,typescript.tsx setlocal omnifunc=LanguageClient#complete
    endif
    if executable('prettier')
        autocmd FileType typescript,typescript.tsx nnoremap <silent> <buffer> <localleader>f :!prettier --write %<cr>
    endif
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
    if executable('rls')
        autocmd FileType rust setlocal omnifunc=LanguageClient#complete
    endif
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

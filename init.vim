call plug#begin('~/.local/share/nvim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

Plug 'ekalinin/Dockerfile.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-path'
Plug 'Shougo/neco-vim'
Plug 'editorconfig/editorconfig-vim'

Plug 'fatih/vim-go'
let g:go_def_mapping_enabled = 0

Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND="fd --type f"

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

filetype plugin indent on

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


set background=dark
color nord

let g:ale_linters = {
            \ 'haskell': ['hie'],
            \'cpp': ['clangtidy', 'clangcheck'],
            \'javascript': ['eslint'],
            \'python': ['flake8']
            \}
let g:ale_fixers = {
            \'haskell': ['hfmt'],
            \'*': ['remove_trailing_lines', 'trim_whitespace'],
            \'cpp': ['clangtidy'],
            \'typescript': ['prettier', 'eslint'],
            \'javascript': ['prettier', 'eslint'],
            \'python': ['autopep8']
            \}
let g:ale_fix_on_save = 1

set number relativenumber

nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <leader>nt :NERDTreeToggle<CR>

" ---------
" LSP Stuff
" ---------

set hidden
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let g:LanguageClient_rootMarkers = {
            \ 'haskell': ['*.cabal', 'stack.yaml']
            \ }

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'haskell': ['hie-wrapper'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
let g:LanguageClient_diagnosticsEnable = 0

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ----------
" /LSP Stuff
" ----------

augroup auto_complete
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  autocmd TextChangedI * call ncm2#auto_trigger()
augroup END

set completeopt=noinsert,menuone,noselect
set shortmess+=c

inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"


" Press enter key to trigger snippet expansion
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsRemoveSelectModeMappings = 0

" -------
" Rg stuff
" -------
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --glob="!*.lock" --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <leader>rg :Rg<CR>

nnoremap <leader>bd :bd<cr>
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>

let g:ale_fix_on_save = 1

nnoremap <c-p> :FZF<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/flow-typed/*

au FileType javascript call SetUpJavascript()
fun! SetUpJavascript()
    setlocal sw=2 sts=2 ts=2 et si
endfun

au FileType typescript call SetUpTypescript()
fun! SetUpTypescript()
    setlocal sw=2 sts=2 ts=2 et si
endfun

au FileType vim call SetUpVimScript()
fun! SetUpVimScript()
    setlocal sw=4 sts=4 ts=2 et si
endfun

au FileType json call SetUpJson()
fun! SetUpJson()
    setlocal sw=2 sts=2 ts=2 et si
endfun

au FileType yaml call SetUpYaml()
fun! SetUpYaml()
    setlocal sw=2 sts=2 ts=2 et si
endfun

au FileType c call SetUpC()
fun! SetUpC()
    setlocal sw=4 sts=4 ts=4 et si
endfun

au FileType rust call SetUpRust()
fun! SetUpRust()
    setlocal sw=2 sts=2 ts=2 et si
endfun

au FileType css call SetUpCss()
fun! SetUpCss()
    setlocal sw=2 sts=2 ts=2 et si
endfun

au FileType html call SetUpHtml()
fun! SetUpHtml()
    setlocal sw=2 sts=2 ts=2 et si
endfun

au FileType sh call SetUpShell()
fun! SetUpShell()
    setlocal sw=4 sts=4 ts=4 et si
endfun'

au FileType go call SetUpGo()
fun! SetUpGo()
    setlocal sw=4 sts=4 ts=4 si
endfun

au FileType haskell call SetUpHaskell()
fun! SetUpHaskell()
    setlocal sw=2 sts=2 ts=2 si
endfun

au FileType cpp call SetUpC()
au FileType hpp call SetUpC()
au FileType c call SetUpC()
au FileType h call SetUpC()
fun! SetUpC()
    setlocal sw=4 sts=4 ts=4 si et
endfun

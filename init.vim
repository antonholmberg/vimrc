call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'
Plug 'luochen1990/rainbow'
Plug 'ekalinin/Dockerfile.vim'
Plug 'junegunn/goyo.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:rainbow_active = 1

Plug 'metakirby5/codi.vim'

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

set background=dark
color nord

let g:ale_linters = {
            \'cpp': ['clangtidy', 'clangcheck'],
            \'javascript': ['eslint'],
            \'python': ['flake8']
            \}
let g:ale_fixers = {
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

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")


" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger	= "<c-j>"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"<Paste>

" ----------
" /LSP Stuff
" ----------

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
function! SetUpJavascript()
    setlocal sw=2 sts=2 ts=2 et si
endfunction

au FileType typescript call SetUpTypescript()
function! SetUpTypescript()
    setlocal sw=2 sts=2 ts=2 et si
endfunction

au FileType vim call SetUpVimScript()
function! SetUpVimScript()
    setlocal sw=4 sts=4 ts=2 et si
endfunction

au FileType json call SetUpJson()
function! SetUpJson()
    setlocal sw=2 sts=2 ts=2 et si
endfunction

au FileType yaml call SetUpYaml()
function! SetUpYaml()
    setlocal sw=2 sts=2 ts=2 et si
endfunction

au FileType c call SetUpC()
function! SetUpC()
    setlocal sw=4 sts=4 ts=4 et si
endfunction

au FileType rust call SetUpRust()
function! SetUpRust()
    setlocal sw=2 sts=2 ts=2 et si
endfunction

au FileType css call SetUpCss()
function! SetUpCss()
    setlocal sw=2 sts=2 ts=2 et si
endfunction

au FileType html call SetUpHtml()
function! SetUpHtml()
    setlocal sw=2 sts=2 ts=2 et si
endfunction

au FileType sh call SetUpShell()
function! SetUpShell()
    setlocal sw=4 sts=4 ts=4 et si
endfunction'

au FileType go call SetUpGo()
function! SetUpGo()
    setlocal sw=4 sts=4 ts=4 si
endfunction

au FileType cpp call SetUpC()
au FileType hpp call SetUpC()
au FileType c call SetUpC()
au FileType h call SetUpC()
function! SetUpC()
    setlocal sw=4 sts=4 ts=4 si et
endfunction

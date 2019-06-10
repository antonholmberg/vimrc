call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
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
let g:rainbow_active = 1

Plug 'airblade/vim-gitgutter'

Plug 'editorconfig/editorconfig-vim'

Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND="fd --type f"

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

filetype plugin indent on

set background=dark
color nord

let g:ale_linters = {
            \'javascript': ['eslint'],
            \'python': ['flake8']
            \}
let g:ale_fixers = {
            \'typescript': ['prettier', 'eslint'],
            \'javascript': ['prettier', 'eslint'],
            \'python': ['autopep8']
            \}
let g:ale_fix_on_save = 1

set number relativenumber

nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <leader>nt :NERDTreeToggle<CR>

let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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


" ---------
" Coc Stuff
" ---------
" if hidden is not set, TextEdit might fail.
set hidden

" Smaller updatetime for CursorHold & CursorHoldI
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

" Remap keys for gotos
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ---------
" /Coc Stuff
" ---------

nnoremap <leader>bd :bd<cr>
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>

let g:ale_fix_on_save = 1

nnoremap <c-p> :FZF<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/flow-typed/*

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger = '<c-y>'
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

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

au FileType sh call SetUpShell()
function! SetUpShell()
    setlocal sw=4 sts=4 ts=4 et si
endfunction'

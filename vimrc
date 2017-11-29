set nocompatible

let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-bundler'
Plug 'pangloss/vim-javascript'
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-endwise'
Plug 'elzr/vim-json'
Plug 'tpope/vim-haml'
Plug 'ervandew/supertab'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'tpope/vim-rails'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline-themes'
Plug 'wakatime/vim-wakatime'
Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rizzatti/dash.vim'
Plug 'KabbAmine/zeavim.vim', {'on': [
      \ 'Zeavim', 'Docset',
      \ '<Plug>Zeavim',
      \ '<Plug>ZVVisSelection',
      \ '<Plug>ZVKeyDocset',
      \ '<Plug>ZVMotion'
      \ ]}

call plug#end()

filetype plugin on

set t_Co=256
set bg=dark
let g:jellybeans_background_color_256=232
let g:jellybeans_background_color="181818"
let g:jellybeans_overrides = {
  \ 'LineNr': { 'guifg': '605958', 'guibg': '000000', 'ctermfg': 'Grey', 'ctermbg': '', 'attr': 'none' },
  \ 'CursorLineNr': { 'guifg': 'ccc5c4', 'guibg': '323232', 'ctermfg': 'White', 'ctermbg': '', 'attr': 'none' },
\}

colorscheme jellybeans

" set the leader
let mapleader = " "
nnoremap <space> <nop>

let g:ctrlp_max_files = 0 " unlimited number of files
let g:ctrlp_custom_command = ""
let g:ctrlp_lazy_update = 0
unlet g:ctrlp_custom_command
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co -X .gitignore -X ~/.gitignore_global $(test -e ._vimignore && echo "-X ._vimignore")', 'find %s -type f']
let g:user_command_async = 1
"unlet g:ctrlp_custom_ignore
"let g:ctrlp_custom_ignore = {
"  \ dir: '\.git$\|\.hg$\|\.svn$\|\.idea$\|\.vscode$\|\.yardoc$\|\.docker$\|log$\|tmp$\|bower_components$\|node_modules$',
"  \ file: '\.sql$\|\.log$\|\.js\.map$\|\.png$\|\.jpg$\|\.gif$\|\.tiff$\|\.pdf$\|\.xls$\|\.xlsx$' }
"let g:ctrlp_map = '<C-p>'
"let g:ctrlp_abbrev = {
"    \ 'gmode': 't',
"    \ 'abbrevs': [
"        \ {
"        \ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
"        \ 'expanded': '_',
"        \ 'mode': 'pfrz',
"        \ },
"        \ ]
"    \ }
set ai
set lazyredraw
set ttyfast
set noerrorbells
set tabstop=2
set expandtab
set number
set encoding=utf-8
set fileencoding=utf-8
set list
set listchars=trail:·,precedes:«,extends:»,eol:\ ,tab:▸\ "
set cursorline
set shiftwidth=2
set nobackup
set nowb
set autoread
au CursorHold,CursorHoldI * :checktime
set noswapfile
set ttymouse=sgr
set mouse=a
set backspace=2

" better search in current file
set ignorecase
set smartcase
set incsearch

" wrap
set wrap
set textwidth=0
set wrapmargin=0
set breakindent
set showbreak=\ \ " two space, and this is a comment... space cannot be the last char in a line

" remove trailing whitespaces
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" <Ctrl-C> -- copy selected to system clipboard (see: http://vim.wikia.com/wiki/Quick_yank_and_paste)
vmap <M-C> "*y

" <Ctrl-A> -- visually select all and copy to system clipboard
nmap <M-A> ggvG$"*y<C-o><C-o>

" ,cp copies path to clipboard
nmap <leader>cp :let @" = expand("%:p")<cr><cr>

if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
  set guioptions-=T  " no toolbar
  set guioptions-=r
  set guioptions-=L
  set guioptions-=m
  " <Ctrl-Backspace> delete the previous word
  imap <C-BS> <C-W>
endif

" go to first/last char of current line maps
imap <C-E> <ESC>$i<Right>
imap <C-A> <ESC>^i
nmap <C-E> $
nmap <C-A> ^

" visual mode with shift
imap <S-End> <C-[>v$
imap <S-Home> <C-[>v^
imap <S-Right> <C-[>v<Right>
imap <S-Left> <C-[>v<Left>
imap <S-Down> <C-[>v<Down>
imap <S-Up> <C-[>v<Up>
nmap <S-End> <C-[>v$
nmap <S-Home> <C-[>v^
nmap <S-Right> <C-[>v<Right>
nmap <S-Left> <C-[>v<Left>
nmap <S-Down> <C-[>v<Down>
nmap <S-Up> <C-[>v<Up>
vmap <S-Down> <Down>
vmap <S-Up> <Up>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
vmap <BS> d

" Undo feature
if version > 703
  set undofile
  set undodir=/tmp/$USER/.vimundo
  set undolevels=1000         " How many undos
  set undoreload=10000        " number of lines to save for undo
  set cryptmethod=blowfish
endif

if has("autocmd")
  " repositioning cursor to last edited line
  augroup resCur
    autocmd!
    if has("folding")
      autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
    else
      autocmd BufWinEnter * call ResCur()
    endif
  augroup END

  " session restore on working directory
"  augroup sessionMng
"    autocmd BufWritePost * :mksession! .saved_session.vim
"    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && filereadable(".saved_session.vim") | :source .saved_session.vim | endif
"  augroup END
"  autocmd BufWritePre * :%s/\s\+$//e
endif

syntax on

let g:NERDTreeWinPos = "left"
nnoremap <C-k><C-b> :NERDTreeToggle<CR>

set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    execute "normal! g`\""
    return 1
  endif
endfunction

if has("folding")
  function! UnfoldCur()
    if ! &foldenable | return | endif

    let l:pline = line(".")

    if l:pline > 1
      let l:pfold = foldlevel(l:pline)
      let l:ufold = foldlevel(l:pline - 1)

      if l:ufold > 0
        execute "normal!" (l:pfold > l:ufold ? l:ufold : l:pfold) . "zo"
        return 1
      endif
    endif
  endfunction
endif

function! GetRunningOS()
  if has("win32")
    return "win"
  endif
  if has("unix")
    if system('uname')=~'Darwin'
      return "mac"
    else
      return "linux"
    endif
  endif
endfunction
let os=GetRunningOS()

" split buffer navigation using <ctrl-arrow> on Linux
" and ctrl+alt+arrow on MAC OS X
inoremap <C-A-Left> <C-[><C-w><Left>
inoremap <C-A-Right> <C-[><C-w><Right>
inoremap <C-A-Down> <C-[><C-w><Down>
inoremap <C-A-Up> <C-[><C-w><Up>
nnoremap <C-A-Left> <C-w><Left>
nnoremap <C-A-Right> <C-w><Right>
nnoremap <C-A-Down> <C-w><Down>
nnoremap <C-A-Up> <c-w><Up>

nnoremap <Leader>a <C-w><Left>
nnoremap <Leader>d <C-w><Right>
nnoremap <Leader>s <C-w><Down>
nnoremap <Leader>w <c-w><Up>

if os == "linux"
  inoremap <C-Left> <C-[><C-w><Left>
  inoremap <C-Right> <C-[><C-w><Right>
  inoremap <C-Down> <C-[><C-w><Down>
  inoremap <C-Up> <C-[><C-w><Up>
  nnoremap <C-Left> <C-w><Left>
  nnoremap <C-Right> <C-w><Right>
  nnoremap <C-Down> <C-w><Down>
  nnoremap <C-Up> <c-w><Up>
endif

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes=['help','nerdtree']
hi IndentGuidesOdd ctermbg=black
hi IndentGuidesEven ctermbg=233
hi Normal ctermbg=black
hi NonText ctermbg=black


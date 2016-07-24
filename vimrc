execute pathogen#infect('bundle/{}', 'colors/{}')
call pathogen#helptags()
set t_Co=256
set bg=dark
let g:jellybeans_background_color_256=232
let g:jellybeans_background_color="181818"
let g:jellybeans_overrides = {
  \ 'LineNr': { 'guifg': '605958', 'guibg': '000000', 'ctermfg': 'Grey', 'ctermbg': '', 'attr': 'none' },
  \ 'CursorLineNr': { 'guifg': 'ccc5c4', 'guibg': '323232', 'ctermfg': 'White', 'ctermbg': '', 'attr': 'none' },
\}

colorscheme jellybeans
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let mapleader = "\\"
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
set noswapfile

" better search in current file
set ignorecase
set smartcase
set incsearch

" no wrap
set nowrap
set textwidth=0
set wrapmargin=0

" <Ctrl-C> -- copy selected to system clipboard (see: http://vim.wikia.com/wiki/Quick_yank_and_paste)
vmap <C-C> "*y

" <Ctrl-A> -- visually select all and copy to system clipboard
nmap <C-A> ggvG$"*y<C-o><C-o>

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
  " Drupal *.module and *.install files.
  augroup drupal
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.thtml set filetype=php
  augroup END

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

let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_new_tab = 0
let g:NERDTreeWinPos = "right"
nnoremap <space> :NERDTreeTabsToggle<CR>

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

inoremap <Leader>a <C-[><C-w><Left>
inoremap <Leader>d <C-[><C-w><Right>
inoremap <Leader>s <C-[><C-w><Down>
inoremap <Leader>w <C-[><C-w><Up>
nnoremap <Leader>a <C-w><Left>
nnoremap <Leader>d <C-w><Right>
nnoremap <Leader>s <C-w><Down>
nnoremap <Leader>w <c-w><Up>

inoremap <Leader><Left> <C-[><C-w><Left>
inoremap <Leader><Right> <C-[><C-w><Right>
inoremap <Leader><Down> <C-[><C-w><Down>
inoremap <Leader><Up> <C-[><C-w><Up>
nnoremap <Leader><Left> <C-w><Left>
nnoremap <Leader><Right> <C-w><Right>
nnoremap <Leader><Down> <C-w><Down>
nnoremap <Leader><Up> <c-w><Up>

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


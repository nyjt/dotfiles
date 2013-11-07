execute pathogen#infect('bundle/{}', 'colors/{}')
call pathogen#helptags()
set t_Co=256
set bg=dark
colorscheme jellybeans
let mapleader = ","
let g:ctrlp_map = '<c-p>'
set enc=utf-8
set ai
set lazyredraw
set noerrorbells
set tabstop=2
set expandtab
set number
set undofile
set undodir=$TEMP
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

" <Ctrl-Backspace> delete the previous word
imap <C-BS> <C-W>

set undofile
set undodir=/tmp/$USER/.vimundo
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup drupal
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.thtml set filetype=php
  augroup END

  augroup resCur
    autocmd!
    if has("folding")
      autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
    else
      autocmd BufWinEnter * call ResCur()
    endif
  augroup END
endif

syntax on

let g:nerdtree_tabs_open_on_console_startup=0
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


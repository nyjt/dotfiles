set enc=utf-8
set tabstop=2
set expandtab
set number
set undofile
set undodir=$TEMP
set encoding=utf-8
set fileencoding=utf-8
set list
set listchars=trail:·,precedes:«,extends:»,eol:\ ,tab:▸\ 
set cursorline

if has("autocmd") 
  " Drupal *.module and *.install files.
  augroup module 
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.thtml set filetype=php
  augroup END
endif
syntax on

set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
    if line("'\"") <= line("$")
        execute "normal! g`\""
        return 1
    endif
endfunction


if has("folding")
    function! UnfoldCur()
        if ! &foldenable
            return
        endif

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

augroup resCur
    autocmd!
    if has("folding")
        autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
    else
        autocmd BufWinEnter * call ResCur()
    endif
augroup END

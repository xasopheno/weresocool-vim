" weresocool.vim
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

" Set the basic indentation size
setlocal shiftwidth=4
setlocal softtabstop=4

" Use spaces instead of tabs
setlocal expandtab

" Use the script to determine indentation
setlocal indentexpr=GetWereSoCoolIndent(v:lnum)

" Enable auto-indenting on new lines
setlocal autoindent

" Helper function to calculate indent
function! GetWereSoCoolIndent(lnum)
    let l:prev_line = getline(a:lnum - 1)
    let l:curr_line = getline(a:lnum)

    " Ignore lines that start with --
    if l:prev_line =~ '^\s*--' || l:curr_line =~ '^\s*--'
        return -1
    endif

    " Increase indent after an opening brace or bracket
    if l:prev_line =~ '[{[]\s*$'
        return indent(a:lnum - 1) + &shiftwidth
    endif

    " Decrease indent after a closing brace or bracket
    if l:curr_line =~ '^\s*[}\]]'
        return indent(a:lnum - 1) - &shiftwidth
    endif

    " Otherwise, keep the same indent as the previous line
    return indent(a:lnum - 1)
endfunction

augroup weresocool_autocmds
    autocmd!
    autocmd BufWritePre *.socool execute "normal! mzgg=G`z"

let b:did_indent = 1

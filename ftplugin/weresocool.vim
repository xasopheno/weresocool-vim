setlocal commentstring=--%s

setlocal formatoptions-=t formatoptions+=croqnl
" j was only added in 7.3.541, so stop complaints about its nonexistence
silent! setlocal formatoptions+=j

" smartindent will be overridden by indentexpr if filetype indent is on, but
" otherwise it's better than nothing.
" setlocal smartindent nocindent

setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
setlocal textwidth=99
setlocal completefunc=syntaxcomplete#Complete

" Format the current buffer using weresocool fmt
function! s:WereSoCoolFormat() abort
  let l:view = winsaveview()

  " Write to temp file and format
  let l:tmpfile = tempname() . '.socool'
  call writefile(getline(1, '$'), l:tmpfile)
  let l:output = systemlist('weresocool fmt ' . shellescape(l:tmpfile) . ' 2>/dev/null')
  call delete(l:tmpfile)

  if v:shell_error != 0
    echohl ErrorMsg
    echomsg 'weresocool fmt error: ' . join(l:output, "\n")
    echohl None
    return
  endif

  " Check if content actually changed
  let l:old_lines = getline(1, '$')
  if l:old_lines ==# l:output
    return
  endif

  " Only modify lines that differ - undo will jump to first changed line
  let l:old_len = len(l:old_lines)
  let l:new_len = len(l:output)
  let l:min_len = min([l:old_len, l:new_len])

  " Update changed lines
  for l:i in range(l:min_len)
    if l:old_lines[l:i] !=# l:output[l:i]
      call setline(l:i + 1, l:output[l:i])
    endif
  endfor

  " Handle length difference
  if l:new_len > l:old_len
    call append(l:old_len, l:output[l:old_len:])
  elseif l:old_len > l:new_len
    silent execute (l:new_len + 1) . ',$delete _'
  endif

  " Restore view
  let l:view.lnum = min([l:view.lnum, l:new_len])
  let l:view.topline = min([l:view.topline, l:new_len])
  call winrestview(l:view)
endfunction

command! -buffer WereSoCoolFormat call s:WereSoCoolFormat()
nnoremap <buffer> <silent> gq :WereSoCoolFormat<CR>

" Set undo settings
let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
let b:undo_ftplugin .= '|setlocal commentstring< formatoptions< tabstop< shiftwidth< softtabstop< expandtab< autoindent< indentexpr< textwidth< completefunc<'

" weresocool.vim – structural indent for .socool (handles blank lines)
" -----------------------------------------------------------------------------
"  • Structural matching for `}`, `]`, and `)` → aligns closers with opener.
"  • Pipes `|` align with previous line.
"  • Parentheses continuation for multiline calls (bounce).
"  • **NEW:** Blank lines are skipped when looking at the “previous line”, so a
"    blank line right after an opening `{` or `[` no longer breaks the indent.
" -----------------------------------------------------------------------------

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal autoindent
setlocal indentexpr=GetWereSoCoolIndent(v:lnum)
setlocal indentkeys+=0{,0},0[,0],0(,0)

function! s:StripNoise(line) abort
  let l:s = substitute(a:line, '\(--\|//\).*$', '', '')
  let l:s = substitute(l:s, "'[^']*'", '', 'g')
  let l:s = substitute(l:s, '"[^"]*"', '', 'g')
  let l:s = substitute(l:s, '`[^`]*`', '', 'g')
  return l:s
endfunction

function! s:Delta(line, open, close) abort
  let l:d = 0
  for l:c in split(a:line, '\zs')
    if l:c == a:open
      let l:d += 1
    elseif l:c == a:close
      let l:d -= 1
    endif
  endfor
  return l:d
endfunction

function! s:MatchIndent(lnum, open, close) abort
  let l:bal = -1
  let l:ln = a:lnum - 1
  while l:ln >= 1
    let l:line = s:StripNoise(getline(l:ln))
    let l:bal += s:Delta(l:line, a:open, a:close)
    if l:bal == 0
      return indent(l:ln)
    endif
    let l:ln -= 1
  endwhile
  return 0
endfunction

function! s:PrevNonBlank(lnum) abort
  let l:ln = a:lnum - 1
  while l:ln >= 1 && getline(l:ln) =~ '^\s*$'
    let l:ln -= 1
  endwhile
  return l:ln
endfunction

function! s:ParenContIndent(lnum) abort
  let l:bal = 0
  let l:ln = a:lnum - 1
  while l:ln >= 1 && l:ln > a:lnum - 120
    let l:line = s:StripNoise(getline(l:ln))
    let l:bal += s:Delta(l:line, '(', ')')
    if l:bal > 0
      return indent(l:ln) + &shiftwidth
    endif
    let l:ln -= 1
  endwhile
  return -1
endfunction

function! GetWereSoCoolIndent(lnum) abort
  if a:lnum == 1 | return 0 | endif

  let l:curr = getline(a:lnum)
  let l:curr_trim = substitute(l:curr, '^\s*', '', '')

  " Structural closers
  if l:curr_trim =~ '^}'
    return s:MatchIndent(a:lnum, '{', '}')
  elseif l:curr_trim =~ '^]'
    return s:MatchIndent(a:lnum, '[', ']')
  elseif l:curr_trim =~ '^)'
    return s:MatchIndent(a:lnum, '(', ')')
  endif

  " Find previous non-blank line
  let l:prev_ln = s:PrevNonBlank(a:lnum)
  if l:prev_ln < 1
    return 0
  endif
  let l:prev = getline(l:prev_ln)
  let l:prev_trim = substitute(l:prev, '^\s*', '', '')
  let l:prev_clean = s:StripNoise(l:prev)
  let l:indent = indent(l:prev_ln)

  " Pipe alignment
  if l:curr_trim =~ '^|'
    return l:indent
  endif

  " Brace/bracket delta (ignore negative if prev line ends with comma)
  let l:delta_br = s:Delta(l:prev_clean, '{', '}') + s:Delta(l:prev_clean, '[', ']')
  if l:delta_br > 0 || (l:delta_br < 0 && l:prev_trim !~ ',\s*$')
    let l:indent += &shiftwidth * l:delta_br
  endif

  " Parenthesis opens
  let l:delta_par = s:Delta(l:prev_clean, '(', ')')
  if l:delta_par > 0
    let l:indent += &shiftwidth * l:delta_par
  endif

  " Continuation inside open (
  let l:cont = s:ParenContIndent(a:lnum)
  if l:cont > l:indent
    let l:indent = l:cont
  endif

  return l:indent
endfunction

augroup weresocool_autocmds
  autocmd!
  " Format with weresocool fmt on save
  autocmd BufWritePre *.socool WereSoCoolFormat
augroup END

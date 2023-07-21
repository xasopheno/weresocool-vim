" Clear existing links
" highlight clear
syntax reset

command! SetupWereSoCoolColorscheme augroup weresocool_colorscheme | autocmd! | autocmd BufLeave * if exists("b:current_syntax") && b:current_syntax == "weresocool" | colorscheme default | endif | augroup END

if exists("b:current_syntax")
    finish
endif

echom "Welcome to WereSoCool"
syntax keyword wscKeyword AsIs Tm Ta PanM PanA Gain Length
syntax keyword wscGroup Seq Overlay Sequence
syntax keyword wscEffect ModulateBy FitLength Reverse Invert 
syntax keyword wscO O
syntax keyword wscRepeat Repeat
syntax keyword wscKeyword AD Portamento
syntax match wscOperator "\v\|"
syntax match wscOperator "\v\#"
syntax match wscOperator "\v\$"
syntax match wscOperator "\v\^"
syntax match wscOperator "\v\>"
syntax match wscComma "\v\,"
syntax match wscStructure "\v\{"
syntax match wscStructure "\v\}"
syntax match wscStructure "\v\="
syntax match wscMain "\v\:"
syntax keyword wscMain main 
syntax match wscSpecialChar "\v\("
syntax match wscSpecialChar "\v\)"
syntax match wscSpecialChar "\v\["
syntax match wscSpecialChar "\v\]"
syntax match wscBoolean "\v\/"
syntax match wscNumber "\v<\d+>"
syntax match wscZero "\v\0"
syn region wscCommentLine start="--"  end="$"

" Create new highlight groups for the plugin
highlight def link WscOperator Operator
highlight def link WscKeyword Keyword
highlight def link WscStructure Structure
highlight def link WscSpecialChar String
highlight def link WscNumber Number
highlight def link WscBoolean Boolean
highlight def link WscCommentLine Comment
highlight def link WscMain Main
highlight def link WscComma Comma
highlight def link WscRepeat Repeat
highlight def link WscGroup Group
highlight def link WscEffect Effect
highlight def link WscO O
highlight def link WscZero Zero

" Link syntax items to the new highlight groups
highlight link wscOperator WscOperator
highlight link wscKeyword WscKeyword
highlight link wscStructure WscStructure
highlight link wscSpecialChar WscSpecialChar
highlight link wscNumber WscNumber
highlight link wscBoolean WscBoolean
highlight link wscCommentLine WscCommentLine
highlight link wscMain WscMain
highlight link wscComma WscComma
highlight link wscRepeat WscRepeat
highlight link wscGroup WscGroup
highlight link wscEffect WscEffect
highlight link wscO WscO
highlight link wscZero WscZero

highlight WscOperator guifg=#789816
highlight WscKeyword guifg=#ef8168
highlight WscStructure guifg=mediumaquamarine
highlight WscSpecialChar guifg=#ee8241
highlight WscNumber guifg=cornsilk
highlight WscBoolean guifg=#df7198
highlight WscComment guifg=grey
highlight WscMain guifg=deeppink
highlight WscComma guifg=#C78AC7
highlight WscRepeat guifg=steelblue
highlight WscGroup guifg=#FFD866
highlight WscEffect guifg=#ff6168
highlight WscO guifg=#D54E53
highlight WscZero guifg=wheat

let b:current_syntax = "weresocool"

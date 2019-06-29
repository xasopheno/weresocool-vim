if exists("b:current_syntax")
    finish
endif

echom "Our syntax highlighting code will go here."
syntax keyword wscKeyword AsIs Tm Ta PanM PanA Gain Length
syntax keyword wscKeyword Seq Overlay Sequence ModulateBy FitLength O
syntax keyword wscKeyword Repeat Reverse Invert
syntax keyword wscKeyword AD Portamento
syntax match wscOperator "\v\|"
syntax match wscOperator "\v\#"
syntax match wscOperator "\v\$"
syntax match wscOperator "\v\^"
syntax match wscOperator "\v\>"
syntax match wscStructure "\v\{"
syntax match wscStructure "\v\}"
syntax match wscStructure "\v\="
syntax match wscStructure "\v\:"
syntax keyword wscStructure main 
syntax match wscSpecialChar "\v\("
syntax match wscSpecialChar "\v\)"
syntax match wscSpecialChar "\v\["
syntax match wscSpecialChar "\v\]"
syntax match wscNumber "\v<\d+>"
syntax match wscBoolean "\v\/"
syn region wscCommentLine start="--"  end="$"


highlight link wscOperator Operator
highlight link wscKeyword Keyword
highlight link wscStructure Structure
highlight link wscSpecial SpecialChar
highlight link wscSpecialChar String
highlight link wscNumber Character
highlight link wscBoolean Boolean
highlight link wscCommentLine Comment


let b:current_syntax = "weresocool"

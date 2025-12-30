" WereSoCool Syntax Highlighting
" Based on weresocool website editor theme

syntax clear

if exists("b:current_syntax")
    finish
endif

echom "Welcome to WereSoCool"

" ============================================================================
" KEYWORDS
" ============================================================================

" Core operations
syntax keyword wscKeyword AsIs Out

" Transpose (T)
syntax keyword wscT Tm Ta TransposeM TransposeA

" Frequency (F)
syntax keyword wscF Fm Fa

" Pan (P)
syntax keyword wscP PanM PanA Pm Pa

" Gain (G)
syntax keyword wscG Gain Gm Ga

" Length (L)
syntax keyword wscL Length Lm La

" Oscillators
syntax keyword wscOscillator Sine Triangle Tri Square Pulse Saw Noise FMOsc

" Effects/Filters
syntax keyword wscEffect Lowpass LowPass Highpass HighPass Bandpass BandPass
syntax keyword wscEffect Reverb Wavefolder SoftClip Overdrive Bitcrusher Tanh
syntax keyword wscEffect Silence Portamento

" Envelope
syntax keyword wscEnvelope AD

" Sequence/Overlay
syntax keyword wscGroup Seq Sequence
syntax keyword wscOverlay Overlay

" Modulation
syntax keyword wscModulate ModulateBy ModBy FitLength FitGain

" Transform
syntax keyword wscTransform Reverse Invert

" Repeat
syntax keyword wscRepeat Repeat

" Overtones
syntax keyword wscO O

" Generators
syntax keyword wscGenerator Gen Take Seed Poly Expr RR RC

" Lists
syntax keyword wscList List ET Random

" Color operations
syntax keyword wscColorOp Color Hue Saturation Brightness Vibrance Gamma
syntax keyword wscColorOp Blend AddColor Gradient Mix RandColor

" Control flow
syntax keyword wscControl Choose Follow

" Import/External
syntax keyword wscImport FromSound FromSoundYin Csv1d Csv2d Midi Lambda

" Main
syntax keyword wscMain main

" ============================================================================
" WGSL BLOCKS (must be before curly brace match)
" ============================================================================

" WGSL region (case insensitive) - must be defined FIRST
syntax region wscWGSLBlock matchgroup=wscImport start="\c\<wgsl\>\s*{" end="}" contains=wscWGSLX,wscWGSLY,wscWGSLZ,wscWGSLS,wscWGSLV,wscWGSLA,wscWGSLRot,wscWGSLDir,wscWGSLSeq,wscWGSLString,wscWGSLNumber,wscWGSLRational,wscWGSLOp,wscWGSLParen,wscWGSLBracket,wscL,wscG,wscT,wscF,wscP,wscNumber,wscPipe

" WGSL block contained items - grouped by first letter
syntax keyword wscWGSLX Xm Xa contained
syntax keyword wscWGSLY Ym Ya contained
syntax keyword wscWGSLZ Zm Za contained
syntax keyword wscWGSLS Sm Sa contained
syntax keyword wscWGSLV Vm Va contained
syntax keyword wscWGSLA Am Aa contained
syntax keyword wscWGSLRot Rx Ry Rz contained
syntax keyword wscWGSLDir Direction contained
syntax keyword wscWGSLSeq Seq contained
syntax match wscWGSLString +"[^"]*"+ contained
syntax match wscWGSLNumber +-\?\d\+\.\?\d*+ contained
syntax match wscWGSLRational +\d\+/\d\++ contained
syntax match wscWGSLOp +[|;]+ contained
syntax match wscWGSLParen +[()]+ contained
syntax match wscWGSLBracket +[\[\]]+ contained

" ============================================================================
" OPERATORS AND STRUCTURE
" ============================================================================

" Pipe operator
syntax match wscPipe "\v\|"

" Other operators
syntax match wscOperator "\v[>#$^@&*\\=]"

" Comma
syntax match wscComma "\v\,"

" Curly braces
syntax match wscCurly "\v[{}]"

" Colon
syntax match wscColon "\v\:"

" Parentheses
syntax match wscParen "\v[()]"

" Square brackets
syntax match wscBracket "\v[\[\]]"

" Slash (for rationals)
syntax match wscSlash "\v\/"

" Init field labels
syntax match wscInitLabel "\v(f|g|l|p)\:"
syntax match wscInitLabel "\vbackground_color\:"

" Numbers (integers, floats, rationals)
syntax match wscNumber "\v<-?\d+(\.\d+)?>"

" Hex colors
syntax match wscHexColor "\v#[0-9a-fA-F]{6}"

" Comments
syn region wscCommentLine start="--" end="$"

" Strings/imports
syntax match wscString "\v(\.?\./)+[a-zA-Z0-9_/\-\.]+\.(csv|wav|WAV)"

" Color names - handled by lua in neovim for actual color backgrounds
" In regular vim, falls back to single highlight group
syntax keyword wscColorName red blue green yellow orange purple pink cyan magenta
syntax keyword wscColorName white black grey gray brown gold silver coral salmon
syntax keyword wscColorName turquoise indigo violet crimson maroon navy teal olive
syntax keyword wscColorName lime aqua fuchsia lavender plum tan beige ivory azure
syntax keyword wscColorName khaki peach mint rust copper bronze firebrick steelblue
syntax keyword wscColorName tomato deeppink skyblue

" Color highlighting is loaded via plugin/colors.lua for neovim

" ============================================================================
" HIGHLIGHT GROUPS - Based on weresocool website editor theme
" ============================================================================

" Link syntax items to highlight groups (fallbacks for terminal vim)
highlight def link wscKeyword Keyword
highlight def link wscT Function
highlight def link wscF Function
highlight def link wscP Type
highlight def link wscG Number
highlight def link wscL Special
highlight def link wscOscillator Type
highlight def link wscEffect Special
highlight def link wscEnvelope PreProc
highlight def link wscGroup Structure
highlight def link wscOverlay Structure
highlight def link wscModulate Macro
highlight def link wscTransform Statement
highlight def link wscRepeat Repeat
highlight def link wscO Special
highlight def link wscGenerator Define
highlight def link wscList Type
highlight def link wscColorOp Constant
highlight def link wscColorName Constant
highlight def link wscHexColor Constant
highlight def link wscControl Conditional
highlight def link wscImport Include
highlight def link wscMain Identifier
highlight def link wscPipe Operator
highlight def link wscOperator Operator
highlight def link wscComma Delimiter
highlight def link wscCurly Delimiter
highlight def link wscColon Delimiter
highlight def link wscParen Delimiter
highlight def link wscBracket Delimiter
highlight def link wscSlash Operator
highlight def link wscNumber Number
highlight def link wscCommentLine Comment
highlight def link wscInitLabel Label
highlight def link wscString String
highlight def link wscWGSLX Type
highlight def link wscWGSLY Type
highlight def link wscWGSLZ Type
highlight def link wscWGSLS Type
highlight def link wscWGSLV Type
highlight def link wscWGSLA Type
highlight def link wscWGSLRot Function
highlight def link wscWGSLDir Structure
highlight def link wscWGSLSeq Structure
highlight def link wscWGSLString String
highlight def link wscWGSLNumber Number
highlight def link wscWGSLRational Number
highlight def link wscWGSLOp Operator
highlight def link wscWGSLParen Delimiter
highlight def link wscWGSLBracket Delimiter

" GUI colors (website theme)
highlight wscKeyword guifg=#789816 gui=bold
highlight wscT guifg=#FF6B6B gui=bold
highlight wscF guifg=#FFA500 gui=bold
highlight wscP guifg=#FF69B4 gui=bold
highlight wscG guifg=#FFD700 gui=bold
highlight wscL guifg=#DC143C gui=bold
highlight wscOscillator guifg=#cc99ff
highlight wscEffect guifg=blueviolet
highlight wscEnvelope guifg=#ffcc99
highlight wscGroup guifg=#FFD866 gui=bold
highlight wscOverlay guifg=steelblue gui=bold
highlight wscModulate guifg=#ff66cc gui=bold
highlight wscTransform guifg=#99ccff
highlight wscRepeat guifg=#A9DC76 gui=bold
highlight wscO guifg=#ff6168 gui=bold
highlight wscGenerator guifg=DarkRed gui=bold
highlight wscList guifg=orange
highlight wscColorOp guifg=#ff99cc gui=bold
highlight wscColorName guifg=#ff99cc
highlight wscHexColor guifg=#ff99cc
highlight wscControl guifg=#ffff66 gui=bold
highlight wscImport guifg=mediumaquamarine
highlight wscMain guifg=deeppink gui=bold
highlight wscPipe guifg=#D54E53
highlight wscOperator guifg=#789816
highlight wscComma guifg=#C78AC7
highlight wscCurly guifg=tomato gui=bold
highlight wscColon guifg=deeppink
highlight wscParen guifg=#ee8241
highlight wscBracket guifg=#7AA6DA
highlight wscSlash guifg=#df7198
highlight wscNumber guifg=cornsilk
highlight wscCommentLine guifg=grey gui=italic
highlight wscInitLabel guifg=#88ccff gui=bold
highlight wscString guifg=#99cc99

" WGSL GUI colors - cool/spacey palette, more distinct
highlight wscWGSLX guifg=#00FFFF gui=bold
highlight wscWGSLY guifg=#1E90FF gui=bold
highlight wscWGSLZ guifg=#9370DB gui=bold
highlight wscWGSLS guifg=#00FA9A gui=bold
highlight wscWGSLV guifg=#00CED1 gui=bold
highlight wscWGSLA guifg=#87CEEB gui=bold
highlight wscWGSLRot guifg=#DA70D6 gui=bold
highlight wscWGSLDir guifg=#6495ED gui=bold
highlight wscWGSLSeq guifg=#4682B4 gui=bold
highlight wscWGSLString guifg=#E0FFFF gui=italic
highlight wscWGSLNumber guifg=#B0E0E6
highlight wscWGSLRational guifg=#48D1CC
highlight wscWGSLOp guifg=#4169E1
highlight wscWGSLParen guifg=#87CEEB
highlight wscWGSLBracket guifg=#B0C4DE

" Sync settings for performance
syntax sync minlines=50
syntax sync maxlines=200

let b:current_syntax = "weresocool"

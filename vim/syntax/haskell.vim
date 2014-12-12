" Minimal syntax highlighting for Haskell.
"
" Aggressively chopped from the default Haskell syntax file.
"
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

" Backticked infix operators
syn match hsVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match hsConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Strings and constants
syn region  hsString        start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar
syn match   hsSpecialChar   contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   hsSpecialChar   contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   hsSpecialCharError  contained "\\&\|'''\+"
syn match   hsCharacter     "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syn match   hsCharacter     "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError

" Comments
syn keyword hsTodo             TODO FIXME XXX contained
syn match   hsLineComment      "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=hsTodo
syn match   hsHaddockComment    "^-- |.*\n\(--.*\n\)*" contains = hsTodo
syn region  hsBlockComment     start="{-"  end="-}" contains=hsBlockComment,hsTodo
syn region  hsPragma           start="{-#" end="#-}"

" Define the default highlighting.
hi! def link hsVarSym             Operator
hi! def link hsConSym             Operator
hi! def link hsString             Constant
hi! def link hsCharacter          Character
hi! def link hsSpecialChar        SpecialChar
hi! def link hsSpecialCharError   Error
hi! def link hsHaddockComment     Label
hi! def link hsBlockComment       Comment
hi! def link hsLineComment        Comment
hi! def link hsComment            Comment
hi! def link hsTodo               Todo
hi! def link hsPragma             Macro

if has('conceal')
    syntax match hsNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ
    set conceallevel=2
endif

let b:current_syntax = "haskell"

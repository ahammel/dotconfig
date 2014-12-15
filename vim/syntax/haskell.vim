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

if has('conceal')
    syntax match hsConcealedOperator /\s\.\s/ms=s+1,me=e-1 conceal cchar=∘
    syntax match hsConcealedOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ
    set conceallevel=2
endif

" Strings and constants
syn region  hsString        start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar
syn match   hsSpecialChar   contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   hsSpecialChar   contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   hsSpecialCharError  contained "\\&\|'''\+"
syn match   hsCharacter     "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syn match   hsCharacter     "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError

" Keyword definitions. These must be patters instead of keywords
" because otherwise they would match as keywords at the start of a
" "literate" comment (see lhs.vim).
syn match hsModule      "\<module\>"
syn match hsImport      "\<import\>.*"he=s+6 contains=hsImportMod
syn match hsImportMod   contained "\<\(as\|qualified\|hiding\)\>"
syn match hsInfix       "\<\(infix\|infixl\|infixr\)\>"
syn match hsStructure   "\<\(class\|data\|deriving\|instance\|default\|where\)\>"
syn match hsTypedef     "\<\(type\|newtype\)\>"
syn match hsStatement   "\<\(do\|case\|of\|let\|in\)\>"
syn match hsConditional "\<\(if\|then\|else\)\>"

" Comments
syn keyword hsTodo             TODO FIXME XXX contained
syn match   hsLineComment      "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=hsTodo
syn match   hsHaddockComment    "^-- |.*\n\(--.*\n\)*" contains = hsTodo
syn region  hsBlockComment     start="{-"  end="-}" contains=hsBlockComment,hsTodo
syn region  hsPragma           start="{-#" end="#-}"


" Define the default highlighting.
hi! def link hsVarSym             Operator
hi! def link hsConSym             Operator
hi! def link hsConcealedOperator  NONE
hi! def link hsString             Constant
hi! def link hsCharacter          Character
hi! def link hsSpecialChar        SpecialChar
hi! def link hsSpecialCharError   Error
hi! def link hsModule             Keyword
hi! def link hsImport             Keyword
hi! def link hsImportMod          Keyword
hi! def link hsInfix              Keyword
hi! def link hsStructure          Keyword
hi! def link hsTypedef            Keyword
hi! def link hsStatement          Keyword
hi! def link hsConditional        Keyword
hi! def link hsHaddockComment     Label
hi! def link hsBlockComment       Comment
hi! def link hsLineComment        Comment
hi! def link hsComment            Comment
hi! def link hsTodo               Todo
hi! def link hsPragma             Macro

let b:current_syntax = "haskell"

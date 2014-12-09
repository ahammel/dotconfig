" Minimal syntax highlighting for Haskell.
"
" Aggressively chopped from the default Haskell syntax file.
"
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

" Infix operators--most punctuation characters and any (qualified) identifier
" enclosed in `backquotes`. An operator starting with : is a constructor,
" others are variables (e.g. functions).
syn match hsVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
syn match hsConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
syn match hsVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match hsConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Strings and constants
syn region  hsString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar
syn match   hsSpecialChar	contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   hsSpecialChar	contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   hsSpecialCharError	contained "\\&\|'''\+"
syn match   hsCharacter		"[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syn match   hsCharacter		"^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError

" Comments
syn match   hsLineComment      "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
syn region  hsBlockComment     start="{-"  end="-}" contains=hsBlockComment
syn region  hsPragma	       start="{-#" end="#-}"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_hs_syntax_inits")
  if version < 508
    let did_hs_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink hsInfix			  PreProc
  HiLink hsVarSym			  hsOperator
  HiLink hsConSym			  hsOperator
  HiLink hsOperator			  Operator
  if exists("hs_highlight_delimiters")
    " Some people find this highlighting distracting.
    HiLink hsDelimiter			  Delimiter
  endif
  HiLink hsString			  String
  HiLink hsCharacter			  hsOperator
  HiLink hsBlockComment		  hsComment
  HiLink hsLineComment			  hsComment
  HiLink hsComment			  Comment
  HiLink hsPragma			  SpecialComment

  HiLink cCppString		hsString
  HiLink cCommentStart		hsComment
  HiLink cCommentError		hsError
  HiLink cCommentStartError	hsError
  delcommand HiLink
endif

if !has('conceal')
    finish
endif

syntax match hsNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ

set conceallevel=2

let b:current_syntax = "haskell"


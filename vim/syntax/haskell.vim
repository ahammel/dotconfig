" Minimal syntax highlighting for Haskell.
if has('conceal')
    syntax match hsConcealedOperator /\s\.\s/ms=s+1,me=e-1 conceal cchar=∘
    syntax match hsConcealedOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ
    set conceallevel=2
endif

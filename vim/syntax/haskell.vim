if !has('conceal')
    finish
endif

syntax match hsNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ

set conceallevel=2


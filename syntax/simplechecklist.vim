if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "simplechecklist"

syntax keyword schkKeyword TODO NOTE
highlight link schkKeyword Todo

syntax match schkTime "\v([Tt]oday)|([Tt]omorrow)"
highlight link schkTime Underlined

syntax match schkEmptyCheck "\[ \]"
highlight link schkEmptyCheck WarningMsg

hi filled ctermfg=green
syntax match schkFilledCheck "\[x\]"
highlight link schkFilledCheck filled


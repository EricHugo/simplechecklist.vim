if exists("b:current_syntax")
    finish
endif

syntax keyword schkKeyword TODO NOTE
highlight link schkKeyword Todo

syntax match schkEmptyCheck "\[ \]"
highlight link schkEmptyCheck WarningMsg

let b:current_syntax = "simplechecklist"

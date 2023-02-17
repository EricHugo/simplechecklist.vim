if exists("g:loaded_simplechecklist")
    finish
endif
let g:loaded_simplechecklist = 1

let s:simplechecklist_format = '-> [ ] '

function! SimplechecklistToggle(lineNum)
    let lineCheckAtt = s:simplechecklistCheck(a:lineNum)
    if lineCheckAtt
        let lineContent = getline(a:lineNum)
        if lineContent =~? '^\s*-> \[ \]'
            call setline(a:lineNum, substitute(lineContent, '-> \[ \]', '-> \[x\]', ""))
        elseif lineContent =~? '^\s*-> \[x\]'
            call setline(a:lineNum, substitute(lineContent, '-> \[x\]', '-> \[ \]', ""))
        endif
    endif
endfunction


function! s:simplechecklistCheck(lineNum)
    let lineContent = getline(a:lineNum)
    let prevLineContent = getline(a:lineNum - 1)
    echom prevLineContent
    if lineContent =~? '^\s*-> \['
        return 1
    else
        return 0
    endif
endfunction

function! s:simplechecklistSpawn(lineNum)
    let hasChecklistAtt = s:simplechecklistCheck(a:lineNum)
    if !hasChecklistAtt
        call s:simplechecklistCreateEntry(a:lineNum)
    endif
endfunction

function! s:simplechecklistCreateEntry(lineNum)
    let lineContent = getline(a:lineNum)
    let indentation = matchstr(lineContent, '^\s*')
    let lineContentNoindent = substitute(lineContent, '^\s*', '', '')
    let checkifiedLine = indentation . s:simplechecklist_format . lineContentNoindent 
    call setline(a:lineNum, checkifiedLine)
    call feedkeys("\<esc>A", "n")
endfunction


augroup SimpleChecklisAutocmds
    autocmd!
    autocmd BufEnter,InsertEnter *.chk call s:simplechecklistSpawn(line('.'))
augroup END

nnoremap <silent> <leader>z :call SimplechecklistToggle(line('.'))<CR>

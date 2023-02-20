if exists("g:loaded_simplechecklist")
    finish
endif
let g:loaded_simplechecklist = 1

let s:simplechecklist_format = '-> [ ] '

function! SimplechecklistToggle(lineNum, origLineIndentLen, task, reccount)
    let lineCheckAtt = s:simplechecklistCheck(a:lineNum)
    " check for child entries
    " should check next line for greater indent
    " if greater, keep checking for greater indents until same or larger
    " then finish
    if lineCheckAtt
        let lineIndentLen = len(s:simplechecklistGetIndent(a:lineNum))
        if !a:reccount 
            let origLineIdentLen = lineIndentLen
            let lineIndentLen = lineIndentLen + 1
        else
            let origLineIdentLen = a:origLineIndentLen
        endif
        if lineIndentLen > origLineIdentLen
            let lineContent = getline(a:lineNum)
            if lineContent =~? '^\s*-> \[ \]' && !(a:task == "toggleoff")
                call setline(a:lineNum, substitute(lineContent, '-> \[ \]', '-> \[x\]', ""))
                let task = 'toggleon'
            elseif lineContent =~? '^\s*-> \[x\]' && !(a:task == "toggleon")
                call setline(a:lineNum, substitute(lineContent, '-> \[x\]', '-> \[ \]', ""))
                let task = 'toggleoff'
            else
                let task = a:task
            endif
            " recursively identify child entries to toggle
            call SimplechecklistToggle(a:lineNum + 1, origLineIdentLen, task, 1)
        endif
    endif
endfunction

function! s:simplechecklistGetIndent(lineNum)
    let indentation = matchstr(getline(a:lineNum), '^\s*')
    return indentation
endfunction

function! s:simplechecklistCheck(lineNum)
    let lineContent = getline(a:lineNum)
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
    let indentation = s:simplechecklistGetIndent(a:lineNum)
    let lineContentNoindent = trim(lineContent)
    let checkifiedLine = indentation . s:simplechecklist_format . lineContentNoindent 
    call setline(a:lineNum, checkifiedLine)
    call feedkeys("\<esc>A", "n")
endfunction


augroup SimpleChecklisAutocmds
    autocmd!
    autocmd BufEnter,InsertEnter *.chk call s:simplechecklistSpawn(line('.'))
augroup END

nnoremap <silent> <leader>z :call SimplechecklistToggle(line('.'), 0, '', 0)<CR>
vnoremap <silent> <leader>z :call SimplechecklistToggle(line('.'), 0, '', 0)<CR>

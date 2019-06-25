function! s:checkTask()
    let l:line=getline('.')
    let l:cursor=winsaveview()
    if l:line=~?'\s*-\s*\[\s*\].*'
        s/\[\s*\]/[x]/
    elseif l:line=~?'\s*-\s*\[x\].*'
        s/\[x\]/[ ]/
    elseif l:line=~?'\s*-\s*✅.*'
        s/✅/🔴/
    elseif l:line=~?'\s*-\s*🔴.*'
        s/🔴/✅/
    endif
    call winrestview(l:cursor)
endfunction

command! MarkdownCheckTask call s:checkTask()

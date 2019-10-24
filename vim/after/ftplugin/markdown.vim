setlocal spell

nnoremap <Plug>(MarkdownCheckTask) :call <SID>checkTask()

nmap <silent> <buffer> - <Plug>(MarkdownCheckTask)<cr>

if exists('g:my_markdown_plugin_loaded')
  finish
end

function s:checkTask()
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

let g:my_markdown_plugin_loaded = 1

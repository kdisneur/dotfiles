command! PreviousFunction silent! ?^\([a-zA-Z0-9]\+()\|function [a-zA-Z0-9]\+\(()\)\{0,1\}\)\s\+{
command! NextFunction silent! /^\([a-zA-Z0-9]\+()\|function [a-zA-Z0-9]\+\(()\)\{0,1\}\)\s\+{

  nnoremap <silent> <buffer> [m :PreviousFunction<cr>
  nnoremap <silent> <buffer> ]m :NextFunction<cr>

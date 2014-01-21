" Skim Goodness
map <buffer> <silent> <LocalLeader>ls :silent
    \ !/Applications/Skim.app/Contents/SharedSupport/displayline -r -b
    \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
    \ "%:p" <CR>
imap <buffer> [[     \begin{
imap <buffer> ]]     <Plug>LatexCloseCurEnv
nmap <buffer> <F5>   <Plug>LatexChangeEnv
vmap <buffer> <F7>   <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
imap <buffer> ((     \eqref{

imap <c-Enter> <c-o>o\item<space>
nmap <c-Enter> o\item<space>

set expandtab
setlocal define=^\s*\\(def\\\\|class\\)

" Jesus, Python.  Five characters of punctuation for a damn string?
inoremap <buffer> <c-g> _(u'')<left><left>
inoremap <buffer> <c-b> """"""<left><left><left>

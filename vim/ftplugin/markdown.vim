" Use <localleader>1/2/3 to add headings.
nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
nnoremap <buffer> <localleader>3 mzI###<space>`zllll <ESC>

nnoremap <buffer> <silent> <localleader>v :!open -a Marked %<CR>

set spell

" Don't hard-wrap lines
set textwidth=0
set wrapmargin=0
set linebreak

call smartinput#map_to_trigger('i', '*', '*', '*')
call smartinput#define_rule({
	    \ 'at': '^\* .*',
	    \ 'char': '<Enter>',
	    \ 'input': '<cr>* ',
	    \ 'filetype': ['markdown'],
	    \})
call smartinput#define_rule({
	    \ 'at': '\%#',
	    \ 'char': '*',
	    \ 'input': '**<Left>',
	    \ 'filetype': ['markdown'],
	    \})
call smartinput#define_rule({
	    \ 'at': '^\* \%#',
	    \ 'char': '<Enter>',
	    \ 'input': '<c-o>cc<cr>',
	    \ 'filetype': ['markdown'],
	    \})

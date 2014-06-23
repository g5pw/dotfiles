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

" Continue on list with enter
call smartinput#define_rule({
	    \ 'at': '^\s\{2,}\* .\+\%#',
	    \ 'char': '<Enter>',
	    \ 'input': '<cr>* ',
	    \ 'filetype': ['markdown'],
	    \})
call smartinput#map_to_trigger('i', '*', '*', '*')
" Auto-align list
call smartinput#define_rule({
	    \ 'at': '^ \+\%#',
	    \ 'char': '*',
	    \ 'input': '* ',
	    \ 'filetype': ['markdown'],
	    \})
" Stop list on empty item
call smartinput#define_rule({
	    \ 'at': '^\s\{2,}\*\s*\%#$',
	    \ 'char': '<Enter>',
	    \ 'input': '<Esc>0C<cr>',
	    \ 'filetype': ['markdown'],
	    \})

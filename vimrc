set nocompatible
" Include VAM path
set runtimepath+=~/.vim/vim-addons/vim-addon-manager

fun AddSources()
    let d = vam#install#Pool()
    let d['numbers.vim'] = { 'type' : 'git', 'url' : 'git://github.com/myusuf3/numbers.vim.git' }
    let d['vim-indent-guides'] = { 'type' : 'git', 'url' : 'git://github.com/nathanaelkane/vim-indent-guides.git' }
    let d['mpvim'] = { 'type' : 'svn', 'url' : 'http://svn.macports.org/repository/macports/contrib/mpvim/' }
    let d['textobj-word-column.vim'] = { 'type' : 'git', 'url' : 'git://github.com/coderifous/textobj-word-column.vim.git' }
    return d
endf

let g:vim_addon_manager = {}
let g:vim_addon_manager.pool_fun = function('AddSources')

"Include my plugins
call vam#ActivateAddons([
	    \'snipmate-snippets',
	    \'ctrlp', 'LustyExplorer', 'The_NERD_tree', 'ack',
	    \'EasyMotion', 'camelcasemotion', 'unimpaired', 'repeat',
	    \'TaskList', 'VimOrganizer', 'editorconfig-vim',
	    \'OmniCppComplete', 'Tagbar', 'AutoComplPop',
	    \'YankRing', 'matchit.zip', 'Gundo',
	    \'vcscommand', 'fugitive', 'extradite',
	    \'SudoEdit',
	    \'FSwitch',
	    \'tComment', 'closetag',
	    \'cern_root', 'Markdown', 'mpvim',
	    \'delimitMate', 'Rainbow_Parenthsis_Bundle',
	    \'Syntastic', 'Powerline',
	    \'changesPlugin', 'numbers.vim', 'vim-indent-guides',
	    \'ZenCoding', 'visual-increment', 'surround',
	    \'wmgraphviz', 'textobj-word-column.vim',
	    \'Mustang2', 'wombat256', 'AnsiEsc',
	    \'LustyJuggler'
	    \], {'auto_install' : 0})

"Set Mapleader
let g:mapleader = ","
let mapleader = ","

set showmatch		" When a bracket is inserted, briefly jump to the matching one.
set hidden	  	" do not close buffers, but hide them!
set autoindent    	" always set autoindenting on
set copyindent    	" copy the previous indentation on autoindenting
set noexpandtab
set softtabstop=4
set shiftwidth=4
set shiftround		" use multiple of shiftwidth when indenting with '<' and '>'"
set ignorecase		" ignore case when searching
set smartcase   	" ignore case if search pattern is all lowercase,
			" case-sensitive otherwise
set smarttab    	" insert tabs on the start of a line according to
set hlsearch    	" highlight search terms
set incsearch   	" show search matches as you type"
set tildeop		" Use tilde as an operator
set ruler
set backspace=indent,eol,start
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set title               " change the terminal's title
set laststatus=2	" Always show statusline
set scrolloff=3		" Always keep 3 lines above/below cursor
set undofile		" Save undo tree in file
set undodir=~/.vim/undo//     " undo files

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Retain custom icons & stuff
set backupcopy=yes

set wildmenu
set wildmode=longest,list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store?                      " OSX bullshit

" Store swap files in fixed location, not current directory.
set dir=~/.vim/swap//,/var/tmp//,/tmp//,.

" Disable vim intro message
set shortmess+=I

set complete=.,b,u,]
set completeopt=menu,preview

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" Enable Doxygen auto-load
let g:load_doxygen_syntax=1

"TagList options and maps
let tagbar_autoclose = 1
let tagbar_autofocus = 1
let g:tagbar_singleclick = 1

"Settings for NERDTree
let NERDTreeIgnore=['\.o$', '\~$', '$']

" Enable space error highlighting for portfiles
let g:portfile_highlight_space_errors=1

"delimitMate options
let delimitMate_balance_matchpairs = 1

"YankRing options
let yankring_history_dir = "$HOME/.vim/yankring"
let g:yankring_clipboard_monitor = 0
let g:yankring_manual_clipboard_check = 0

" Set Syntastic style
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

let g:Powerline_symbols = 'fancy'

let g:extradite_showhash=1

"Useful mappings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Toggle folds with space bar
nmap <Space> za
nmap <Leader><tab> :TScratch<cr>
nmap <Leader>, :NERDTreeToggle<cr>
nmap <Leader>. :TagbarToggle<CR>
nmap <silent> <leader>/ :nohlsearch<CR>
" Parse file with astyle
nmap <silent> <Leader>as :%!astyle<CR>
" NERDTree Bookmarks
nmap <Leader>bm :NERDTreeFromBookmark 
" Parse dir with ctags
nmap <silent><leader>r :ToggleChangeView<CR>
nmap <silent><leader>c :ToggleRaibowParenthesis<CR>
nmap <silent> <Leader>ct :! ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<cr>
" FuGitive
nnoremap <silent><leader>gd :Gdiff<CR>
nnoremap <silent><leader>gc :Gcommit -a<CR>
nnoremap <silent><leader>gf :Gcommit %<CR>
nnoremap <silent><leader>gs :Gstatus<CR>
nnoremap <silent><leader>gw :Gwrite<CR>
nnoremap <silent><leader>gr :Gread<CR>
nnoremap <silent><leader>gb :Gblame<CR>
nnoremap <silent><leader>g0 :w <bar> Git diff -U0<CR>
nnoremap <silent><leader>g1 :w <bar> :Gdiff HEAD~1<CR>
" Extradite options
nnoremap <silent><leader>ge :Extradite<CR>
" FShere
nmap <silent> <leader>h		:FSHere<CR>
" LustyJuggler
nmap <silent> <leader>j :LustyJuggler<CR>
" TaskList
nmap <Leader>k <Plug>TaskList
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Gundo maps
nnoremap <Leader>u :GundoToggle<CR>
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>
" YankRing
nnoremap <silent> <leader>yr :YRShow<CR>
nnoremap <silent> <leader>ys :YRSearch 

filetype plugin indent on
"Filetype-dependant stuff
autocmd filetype python set expandtab
au FileType c,c++ let b:delimitMate_matchpairs = "(:),{:},[:],/*:*/"

" Save on focus lost.
au FocusLost * :wa

" boxes integration
nmap <silent> <leader>bf !!boxes -a l -d tjc -s 75<CR>
vmap <silent> <leader>bf !boxes -a l -d tjc -s 75<CR>
nmap <silent> <leader>mb !!boxes -a l -d c -s 75<CR>
vmap <silent> <leader>mb !boxes -a l -d c -s 75<CR>
nmap <silent> <leader>xb !!boxes -d c -r<CR>
vmap <silent> <leader>xb !boxes -d c -r<CR>

" CtrlP bindings
nmap <silent> <Leader>t :CtrlP<CR>

" Visual stuff
if has("gui_running")
    set ttyfast
    colorscheme wombat256mod
endif

if &t_Co >= 256
    colorscheme Mustang
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

set pastetoggle=<F2>	"Disable auto indent when pasting

" Ctrl + Arrow is for moving text around and relies on vim-unimpaired by Tim Pope.
nmap <C-Up>   [e
imap <C-Up>   <C-O><C-Up>
vmap <C-Up>   [egv
nmap <C-Down> ]e
imap <C-Down> <C-O><C-Down>
vmap <C-Down> ]egv
" Ctrl + Arrows: Indenting shortcuts
nmap <C-Left>   <<
imap <C-Left>   <C-O><C-Left>
vmap <C-Left>   <gv
nmap <C-Right>  >>
imap <C-Right>  <C-O><C-Right>
vmap <C-Right>  >gv
" Arrow is for moving around splits
nnoremap <Up>        <C-W>k
nnoremap <Down>      <C-W>j
nnoremap <Left>      <C-W>h
nnoremap <Right>     <C-W>l
" Shift + Arrow is for moving splits around
nnoremap <S-Up>      <C-W>K
nnoremap <S-Down>    <C-W>J
nnoremap <S-Left>    <C-W>H
nnoremap <S-Right>   <C-W>L
" Alt + Arrow is for minimizing/maximizing splits
nnoremap <M-Up>      <C-W>_
nnoremap <M-Down>    <C-W>=
nnoremap <M-Left>    <C-W>=
nnoremap <M-Right>   <C-W><Bar>
" Shift + Alt + Arrow is for minimizing/maximizing splits
nnoremap <S-M-Up>      <C-W>-
nnoremap <S-M-Down>    <C-W>+
nnoremap <S-M-Left>    <C-W><
nnoremap <S-M-Right>   <C-W>>

let snips_author = "Aljaž Srebrnič"

set guifont=Menlo\ for\ Powerline:h12

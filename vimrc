set nocompatible
"Include my plugins
set runtimepath+=~/.vim/vim-addons/vim-addon-manager
call vam#ActivateAddons([
	    \'snipmate-snippets', 'ZenCoding',
	    \'ctrlp', 'LustyExplorer', 'The_NERD_tree', 'ack',
	    \'EasyMotion', 'camelcasemotion',
	    \'repeat',
	    \'TaskList',
	    \'OmniCppComplete', 'TagBar', 'AutoComplPop',
	    \'YankRing', 'matchit.zip', 'Gundo',
	    \'surround',
	    \'vcscommand', 'fugitive', 'extradite',
	    \'SudoEdit',
	    \'FSwitch',
	    \'tComment',
	    \'cern_root', 'Markdown',
	    \'delimitMate',
	    \'svn:http://svn.macports.org/repository/macports/contrib/mpvim/',
	    \'Syntastic', 'PowerLine',
	    \'changesPlugin',
	    \'sparkup',
	    \'wmgraphviz',
	    \'Mustang2', 'wombat256',
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
			"    case-sensitive otherwise
set smarttab    	" insert tabs on the start of a line according to
			"    shiftwidth, not tabstop
set hlsearch    	" highlight search terms
set incsearch   	" show search matches as you type"

set tildeop		" Use tilde as an operator

set ruler
set backspace=indent,eol,start

set history=1000        " remember more commands and search history
set undolevels=1000     " use many muchos levels of undo
set title               " change the terminal's title
set laststatus=2	" Always show statusline

set scrolloff=3		" Always keep 3 lines above/below cursor

set undofile		" Save undo tree in file
set undodir=~/.vim/undo//     " undo files
"set visualbell          " don't beep
"set noerrorbells	 " don't beep

" Retain custim icons & stuff
set backupcopy=yes

set wildmenu
set wildmode=list:longest
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

set completeopt=longest,preview

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Enable Doxygen auto-load
let g:load_doxygen_syntax=1

" NeoComplCache options
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_min_syntax_length = 3

"TagList options and maps
let tagbar_autoclose = 1
let tagbar_autofocus = 1
let g:tagbar_singleclick = 1

"Settings for NERDTree
let NERDTreeIgnore=['\.o$', '\~$', '$']

"FuF Options
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400

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

"Useful mappings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nmap <Leader>, :NERDTreeToggle<cr>
nmap <Leader>/ :NERDTreeToggle<cr>:TlistToggle<cr>
nmap <Leader>. :TlistToggle<cr>
nmap <silent> <leader>/ :nohlsearch<CR>
" Parse file with astyle
nmap <silent> <Leader>as :%!astyle<CR>
" NERDTree Bookmarks
nmap <Leader>bm :NERDTreeFromBookmark 
" Parse dir with ctags
nmap <silent> <Leader>ct :! ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<cr>
" FuF
nnoremap <silent> <leader>ff     :FufFile<CR>
nnoremap <silent> <leader>fj     :FufBuffer<CR>
nnoremap <silent> <leader>fk     :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <leader>fK     :FufFileWithFullCwd<CR>
nnoremap <silent> <leader>fl     :FufCoverageFileChange<CR>
nnoremap <silent> <leader>fL     :FufCoverageFileChange<CR>
nnoremap <silent> <leader>f<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> <leader>fd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <leader>fD     :FufDirWithFullCwd<CR>
nnoremap <silent> <leader>f<C-d> :FufDir<CR>
nnoremap <silent> <leader>fn     :FufMruFile<CR>
nnoremap <silent> <leader>fN     :FufMruFileInCwd<CR>
nnoremap <silent> <leader>fm     :FufMruCmd<CR>
nnoremap <silent> <leader>fu     :FufBookmarkFile<CR>
nnoremap <silent> <leader>f<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> <leader>f<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> <leader>fi     :FufBookmarkDir<CR>
nnoremap <silent> <leader>f<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> <leader>ft     :FufTag<CR>
nnoremap <silent> <leader>fT     :FufTag!<CR>
nnoremap <silent> <leader>f<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> <leader>f,     :FufBufferTag<CR>
nnoremap <silent> <leader>f<     :FufBufferTag!<CR>
vnoremap <silent> <leader>f,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> <leader>f<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> <leader>f}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> <leader>f.     :FufBufferTagAll<CR>
nnoremap <silent> <leader>f>     :FufBufferTagAll!<CR>
vnoremap <silent> <leader>f.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> <leader>f>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> <leader>f]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> <leader>fg     :FufTaggedFile<CR>
nnoremap <silent> <leader>fG     :FufTaggedFile!<CR>
nnoremap <silent> <leader>fo     :FufJumpList<CR>
nnoremap <silent> <leader>fp     :FufChangeList<CR>
nnoremap <silent> <leader>fq     :FufQuickfix<CR>
nnoremap <silent> <leader>fy     :FufLine<CR>
nnoremap <silent> <leader>fh     :FufHelp<CR>
nnoremap <silent> <leader>fe     :FufEditDataFile<CR>
nnoremap <silent> <leader>fr     :FufRenewCache<CR>
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
let g:extradite_showhash=1
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
au FileType c let b:delimitMate_matchpairs = "(:),{:},[:],/*:*/"

" boxes integration
nmap <silent> <leader>bf !!boxes -a l -d tjc -s 75<CR>
vmap <silent> <leader>bf !boxes -a l -d tjc -s 75<CR>
nmap <silent> <leader>mb !!boxes -a l -d c -s 75<CR>
vmap <silent> <leader>mb !boxes -a l -d c -s 75<CR>
nmap <silent> <leader>xb !!boxes -d c -r<CR>
vmap <silent> <leader>xb !boxes -d c -r<CR>

nmap <silent> <Leader>t :CtrlP<CR>

" Visual stuff
if has("gui_running")
    set ttyfast
endif

if &t_Co >= 256 || has("gui_running")
    colorscheme wombat256mod
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

set pastetoggle=<F2>	"Disable auto indent when pasting

" Yes! make me suffer!
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

let snips_author = "Aljaž Srebrnič"

set guifont=Menlo\ for\ Powerline:h12

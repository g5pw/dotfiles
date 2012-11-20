set nocompatible

" VAM setup " -------------------------------------------------------- {{{
fun! SetupVAM()
  " YES, you can customize this vam_install_path path and everything still works!
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " * unix based os users may want to use this code checking out VAM
  " * windows users want to use http://mawercer.de/~marc/vam/index.php
  "   to fetch VAM, VAM-known-repositories and the listed plugins
  "   without having to install curl, unzip, git tool chain first
  " -> BUG [4] (git-less installation)
  if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
    exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
    " VAM run helptags automatically if you install or update plugins
    exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
  endif

  " Add custom sources
  fun! AddSources()
      let d = vam#install#Pool()
      let d['mpvim'] = { 'type' : 'svn', 'url' : 'http://svn.macports.org/repository/macports/contrib/mpvim/' }
      return d
  endf

  let g:vim_addon_manager = {}
  let g:vim_addon_manager.pool_fun = function('AddSources')


" Activated plugins -------------------------------------------------- {{{
  call vam#ActivateAddons([
	      \'snipmate-snippets',
	      \'ctrlp', 'LustyExplorer', 'The_NERD_tree', 'ack',
	      \'EasyMotion', 'camelcasemotion', 'unimpaired', 'repeat',
	      \'TaskList', 'VimOrganizer', 'editorconfig-vim',
	      \'OmniCppComplete', 'Tagbar', 'github:ervandew/supertab',
	      \'github:maxbrunsfeld/vim-yankstack', 'matchit.zip', 'Gundo',
	      \'vcscommand', 'fugitive', 'extradite',
	      \'SudoEdit', 'Clam',
	      \'FSwitch', 'github:skammer/vim-css-color',
	      \'tComment', 'ragtag', 'github:adinapoli/vim-markmultiple',
	      \'cern_root', 'Markdown', 'mpvim', 'github:hail2u/vim-css3-syntax', 'vim-dokuwiki', 'factor', 'octave%3600', 'rust',
	      \'delimitMate', 'Rainbow_Parenthsis_Bundle',
	      \'Syntastic', 'Powerline', 'dwm',
	      \'changesPlugin', 'github:myusuf3/numbers.vim', 'github:nathanaelkane/vim-indent-guides',
	      \'ZenCoding', 'visual-increment', 'surround',
	      \'wmgraphviz',
	      \'github:coderifous/textobj-word-column.vim', 'textobj-diff', 'textobj-comment', 'textobj-function', 'textobj-fold',
	      \'Mustang2', 'wombat256', 'AnsiEsc',
	      \'LustyJuggler'
	      \], {'auto_install' : 0})
" }}}
endf
call SetupVAM()

" }}}

" Basic options ------------------------------------------------------ {{{

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
set scrolloff=5		" Always keep 3 lines above/below cursor
set undofile		" Save undo tree in file
set undodir=~/.vim/undo//     " undo files

set splitright
set fillchars=diff:⣿,vert:│
set autowrite
set autoread

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Retain custom icons & stuff
set backupcopy=yes

" WildIgnore menu {{{
set wildmenu
set wildmode=longest,list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store?                      " OSX bullshit
" }}}

" Folding settings {{{
set foldmethod=syntax   "fold based on indent
set foldnestmax=4       "deepest fold is 10 levels
set foldenable          "fold by default
set foldlevel=1         "this is just what i use

" Custom folded text function by sjl
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

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

"Enable mouse support in terminal
set mouse=a
set ttymouse=xterm2

"Always use cscope
set cscopetag
set cscopeverbose
"}}}

" Plugin settings ---------------------------------------------------- {{{

" Enable context-aware superTab completions
let g:SuperTabDefaultCompletionType = "context"

" Enable Doxygen auto-load
let g:load_doxygen_syntax=1

"Tagbar options and maps
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

" Set Powerlyne style
let g:Powerline_symbols = 'fancy'

let g:extradite_showhash=1

" }}}

" Mappings ----------------------------------------------------------- {{{
" Made D behave
nnoremap D d$

" Toggle folds with space bar
nnoremap <Space> za
nnoremap <Leader><tab> :TScratch<cr>
nnoremap <Leader>, :NERDTreeToggle<cr>
nnoremap <Leader>. :TagbarToggle<CR>
nnoremap <silent> <leader>/ :nohlsearch<CR>:echo 'Search highlight cleared'<CR>
" Parse file with astyle
nnoremap <silent> <Leader>as :%!astyle<CR>
" NERDTree Bookmarks
nnoremap <Leader>bm :NERDTreeFromBookmark 
nnoremap <silent><leader>r :ToggleChangeView<CR>
nnoremap <silent><leader>c :ToggleRaibowParenthesis<CR>
" Parse dir with ctags
nnoremap <silent> <Leader>ct :! ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<cr>
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
nnoremap <silent> <leader>h	:FSHere<CR>
" LustyJuggler
nnoremap <silent> <leader>j :LustyJuggler<CR>
" TaskList
nnoremap <Leader>k <Plug>TaskList
" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
" Gundo maps
nnoremap <F5> :GundoToggle<CR>
" Quickly edit the vimrc file
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
" YankRing
nnoremap <silent> <leader>yr :YRShow<CR>
nnoremap <silent> <leader>ys :YRSearch 

" f7 toggles spelling on/off
nnoremap <F7> :setlocal spell! spell?<CR>

" boxes integration
nnoremap <silent> <leader>bf !!boxes -a l -d tjc -s 75<CR>
vnoremap <silent> <leader>bf !boxes -a l -d tjc -s 75<CR>
nnoremap <silent> <leader>mb !!boxes -a l -d c -s 75<CR>
vnoremap <silent> <leader>mb !boxes -a l -d c -s 75<CR>
nnoremap <silent> <leader>xb !!boxes -d c -r<CR>
vnoremap <silent> <leader>xb !boxes -d c -r<CR>

" CtrlP bindings
nnoremap <silent> <Leader>t :CtrlP<CR>

" Cscope command abbreviations
cnoreabbrev csa cs add
cnoreabbrev csf cs find
cnoreabbrev csk cs kill
cnoreabbrev csr cs reset
cnoreabbrev css cs show
cnoreabbrev csh cs help

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
" Shift + Alt + Arrow is for resizing splits
nnoremap <S-M-Up>      <C-W>-
nnoremap <S-M-Down>    <C-W>+
nnoremap <S-M-Left>    <C-W><
nnoremap <S-M-Right>   <C-W>>

" Mappings end }}}

" Autocmds ----------------------------------------------------------- {{{
autocmd FileType c,c++ let b:delimitMate_matchpairs = "(:),{:},[:],/*:*/"
autocmd FileType c setlocal foldmethod=marker foldmarker={,}

" Auto-reload vimrc on save
augroup vimrcEx
    autocmd!
    autocmd FileType text setlocal textwidth=78
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd BufReadPost *
        \if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \endif
augroup END

" CSS and LessCSS (from sjl) {{{
augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less

    au Filetype less,css setlocal foldmethod=marker
    au Filetype less,css setlocal foldmarker={,}
    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-

    " Use <leader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END
" }}}
" Haskell {{{
augroup ft_haskell
    au!
    au BufEnter *.hs compiler ghc
augroup END

" }}}
" HTML and HTMLDjango {{{
let g:html_indent_tags = ['p', 'li']

augroup ft_html
    au!

    au BufNewFile,BufRead *.html setlocal filetype=htmldjango
    au FileType html,jinja,htmldjango setlocal foldmethod=manual

    " Use <localleader>f to fold the current tag.
    au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

    " Use <localleader>t to fold the current templatetag.
    au FileType html,jinja,htmldjango nmap <buffer> <localleader>t viikojozf

    " Indent tag
    au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>= Vat=

    " Django tags
    au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

    " Django variables
    au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
augroup END

" }}}
" Java {{{
augroup ft_java
    au!

    au FileType java setlocal foldmethod=marker
    au FileType java setlocal foldmarker={,}
augroup END

" }}}
" Javascript {{{
augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" }}}
" Lisp {{{
augroup ft_lisp
    au!
    au FileType lisp call TurnOnLispFolding()
augroup END

" }}}
" Markdown {{{
augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space>`zllll <ESC>
augroup END

" }}}
" Mercurial {{{
augroup ft_mercurial
    au!

    au BufNewFile,BufRead *hg-editor-*.txt setlocal filetype=hgcommit
augroup END
" }}}
" Python {{{
augroup ft_python
    au!
    au FileType python set expandtab

    au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    au FileType man nnoremap <buffer> <cr> :q<cr>

    " Jesus, Python.  Five characters of punctuation for a damn string?
    au FileType python inoremap <buffer> <c-g> _(u'')<left><left>

    au FileType python inoremap <buffer> <c-b> """"""<left><left><left>
augroup END

" }}}
" Ruby {{{
augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax
augroup END

" }}}
" Vim {{{
augroup ft_vim
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}

" Save on focus lost.
autocmd FocusLost * :silent! :wall

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

autocmd InsertLeave * set nopaste

" text & mutt files
autocmd BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt set tw=72 noai noshowmatch
autocmd BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt syntax off

" git commits
autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG set tw=72 noai noshowmatch
autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG setlocal spell spelllang=en_us
" Autocmds end }}}

" Visual stuff
if has("gui_running")
    set ttyfast
    colorscheme Tomorrow-Night
endif

if &t_Co >= 256
    colorscheme wombat256mod
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

set pastetoggle=<F2>	"Disable auto indent when pasting

let snips_author = "Aljaž Srebrnič"

set guifont=Menlo\ for\ Powerline:h12

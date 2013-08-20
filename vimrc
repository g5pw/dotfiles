" vim: foldmethod=marker foldlevel=0
set nocompatible
let snips_author = "Aljaž Srebrnič"

" Use powerline {{{
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
" }}}
" VAM setup {{{
fun! SetupVAM()
    " YES, you can customize this vam_install_path path and everything still works!
    let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
    exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

    " Install VAM if not present {{{
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
    " }}}
    " Activated plugins -------------------------------------------------- {{{
    let addons = []
    " Text {{{
    call add(addons, 'UltiSnips')
    call add(addons, 'repeat')
    call add(addons, 'github:maxbrunsfeld/vim-yankstack')
    call add(addons, 'matchit.zip')
    call add(addons, 'Gundo')
    call add(addons, 'delimitMate')
    call add(addons, 'visual-increment')
    call add(addons, 'commentary')
    call add(addons, 'YouCompleteMe')
    call add(addons, 'Tabular')
    call add(addons, 'surround')
    call add(addons, 'abolish')
    call add(addons, 'multiselect')
    " }}}
    " Movement {{{
    call add(addons, 'EasyMotion')
    call add(addons, 'camelcasemotion')
    call add(addons, 'unimpaired')
    call add(addons, 'github:adinapoli/vim-markmultiple')
    call add(addons, 'TaskList')
    " }}}
    " File System/Integration {{{
    call add(addons, 'vimfiler')
    call add(addons, 'ctrlp')
    call add(addons, 'fugitive')
    call add(addons, 'extradite')
    call add(addons, 'FSwitch')
    call add(addons, 'VimOrganizer')
    call add(addons, 'editorconfig-vim')
    call add(addons, 'Tagbar')
    call add(addons, 'github:tpope/vim-foreplay')
    "}}}
    " Language support {{{
    call add(addons, 'cern_root')
    call add(addons, 'Markdown')
    call add(addons, 'github:hail2u/vim-css3-syntax')
    call add(addons, 'github:skammer/vim-css-color')
    call add(addons, 'vim-dokuwiki')
    call add(addons, 'octave%3600')
    call add(addons, 'github:guns/vim-clojure-static')
    call add(addons, 'haskellmode-vim')
    call add(addons, 'Haskell_Conceal')
    call add(addons, 'ragtag')
    call add(addons, 'wmgraphviz')
    call add(addons, 'ZenCoding')
    " }}}
    " Utilities {{{
    call add(addons, 'Syntastic')
    call add(addons, 'changesPlugin')
    call add(addons, 'github:myusuf3/numbers.vim')
    call add(addons, 'github:nathanaelkane/vim-indent-guides',)
    call add(addons, 'SudoEdit')
    call add(addons, 'Vitality')
    call add(addons, 'Splice')
    call add(addons, 'quickfixsigns')
    call add(addons, 'github:mhinz/vim-startify')
    call add(addons, 'unite')
    call add(addons, 'vimproc')
    " }}}
    " Themes {{{
    call add(addons, 'molokai')
    " }}}
    " TextObjects {{{
    call add(addons, 'github:coderifous/textobj-word-column.vim')
    call add(addons, 'textobj-diff')
    call add(addons, 'textobj-comment')
    call add(addons, 'textobj-function')
    call add(addons, 'textobj-fold')
    " }}}
    call vam#ActivateAddons(addons, {'auto_install' : 0})
" }}}
endf
call SetupVAM()
" }}}
" Basic options {{{

"Set Mapleader
let g:mapleader = ","
let mapleader = ","

filetype plugin indent on
set encoding=utf-8
set showmatch		" When a bracket is inserted, briefly jump to the matching one.
set hidden		" do not close buffers, but hide them!
set autoindent		" always set autoindenting on
set copyindent		" copy the previous indentation on autoindenting
set noexpandtab
set softtabstop=4
set shiftwidth=4
set shiftround		" use multiple of shiftwidth when indenting with '<' and '>'"
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,
			" case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to
set hlsearch		" highlight search terms
set incsearch		" show search matches as you type"
set tildeop		" Use tilde as an operator
set ruler
set backspace=indent,eol,start
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set title               " change the terminal's title
set laststatus=2	" Always show statusline
set scrolloff=5		" Always keep 3 lines above/below cursor
set undofile		" Save undo tree in file
set undodir=~/.vim/tmp/undo//     " undo files

set splitright
set fillchars=diff:⣿,vert:│,fold:-
set autowrite
set autoread

set virtualedit=block

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=400

" Retain custom icons & stuff
set backupcopy=yes

set pastetoggle=<F2>	"Disable auto indent when pasting
set guifont=Menlo\ for\ Powerline:h11 "Set GUI font

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
set foldmethod=syntax   " fold based on syntax
set foldnestmax=4       " deepest fold is 4 levels
set foldenable          " fold by default
set foldlevel=1         " this is just what i use

" Custom folded text function by sjl
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')
    let line = substitute(line, split(&foldmarker, ',')[0], '', '')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 7
    return line . ' ⤥ ' . repeat("…", fillcharcount) . ' (' . foldedlinecount .')'
endfunction " }}}
set foldtext=MyFoldText()
" }}}

" Store swap files in fixed location, not current directory.
set dir=~/.vim/tmp/swap//,/var/tmp//,/tmp//,.

" Disable vim intro message
set shortmess+=I

set complete=.,w,b,u,t
set completeopt=menu,preview

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=↪

set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=80

"Enable mouse support in terminal
set mouse=a
set ttymouse=xterm2

"Always use cscope
if filereadable("cscope.out")
    cscope add cscope.out
endif
set cscopetag
set cscopeverbose
"}}}
" Plugin settings {{{

" Haskell dirs
let g:haddock_browser = "elinks"
let g:haddock_docdir = "/opt/local/share/doc/ghc/html/"

" Unite stuff {{{
let g:unite_data_directory = '~/.vim/tmp/unite/'
let g:unite_source_process_enable_confirm = 1
let g:unite_enable_split_vertically = 0
let g:unite_winheight = 20
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opt = ''
let g:ref_use_vimproc = 1
let g:ref_open = 'vsplit'
let g:ref_cache_dir = expand('~/.vim/tmp/ref_cache/')
let g:unite_enable_start_insert = 1
let g:unite_enable_short_source_names = 1
let g:unite_prompt = '» '
" }}}

" UltiSnips settings

" YouCompleteMe settings
let g:ycm_key_invoke_completion = '<C-\>'
let g:ycm_extra_conf_globlist = ['~/Documents/Projects/*']

" Enable Doxygen auto-load
let g:load_doxygen_syntax=1

" CtrlP settings
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend|elf)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

"Tagbar options and maps
let tagbar_autoclose = 1
let tagbar_autofocus = 1
let g:tagbar_singleclick = 1

" VimFiler settings
let g:vimfiler_as_default_explorer=1
let g:vimfiler_data_directory = expand('~/.vim/tmp/vimfiler/')
let g:vimfiler_quick_look_command = 'qlmanage -p'
let g:vimfiler_ignore_pattern = '\(^\.\|.py[oc]$\)'

" Enable space error highlighting for portfiles
let g:portfile_highlight_space_errors=1

"delimitMate options
let delimitMate_balance_matchpairs = 1

" Startify options
let g:startify_bookmarks = [ '~/.vimrc', '~/.zsh/.zshrc' ]
let g:startify_skiplist = [
           \ 'COMMIT_EDITMSG',
           \ $VIMRUNTIME .'/doc',
           \ 'vim-addons/.*/doc'
           \ ]
let g:startify_custom_indices = ['f', 'j', 'd', 'k', 'g', 'h', 'r', 'u', 'v', 'n']

"Yankstack options
let g:yankstack_map_keys = 0

" Set Syntastic style
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" Set Powerlyne style
let g:Powerline_symbols = 'fancy'

let g:extradite_showhash=1


" }}}
" Mappings {{{
" Made D behave
nnoremap D d$

" Unite mappings
nnoremap <leader>a :<C-u>Unite grep -default-action=above<CR>
nnoremap <leader>A :<C-u>execute 'Unite grep:.::' . expand("<cword>") . ' -default-action=above -auto-preview'<CR>
nnoremap <leader>j :<C-u>Unite buffer<CR>

" YouCompleteMe mappings
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Toggle folds with space bar
nnoremap <Space> za
nnoremap <Leader><tab> :TScratch<cr>
nnoremap <Leader>, :TagbarToggle<CR>
nnoremap <silent> <leader>/ :nohlsearch<CR>:echo 'Search highlight cleared'<CR>
" Parse file with astyle
nnoremap <silent> <Leader>as :%!astyle<CR>

" VimFiler mappings
nnoremap <leader>cd :<C-u>:VimFilerBufferDir -buffer-name=explorer -toggle<CR>`
nnoremap <Leader>. :VimFiler<cr>


nnoremap <silent><leader>r :ToggleChangeView<CR>
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
" TaskList
nnoremap <Leader>k <Plug>TaskList
" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
" Gundo maps
nnoremap <leader>u :GundoToggle<CR>
" Quickly edit the vimrc file
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>

" f7 toggles spelling on/off
nnoremap <F7> :setlocal spell! spell?<CR>

" boxes integration
nnoremap <silent> <leader>bf !!boxes -a l -d tjc -s 75<CR>
vnoremap <silent> <leader>bf !boxes -a l -d tjc -s 75<CR>
nnoremap <silent> <leader>mb !!boxes -a l -d c -s 75<CR>
vnoremap <silent> <leader>mb !boxes -a l -d c -s 75<CR>
nnoremap <silent> <leader>xb !!boxes -d c -r<CR>
vnoremap <silent> <leader>xb !boxes -d c -r<CR>

" YankStack bindings
nmap <M-p> <Plug>yankstack_substitute_older_paste
nmap <M-P> <Plug>yankstack_substitute_newer_paste

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

" Remaps for iTerm. It won't show meta as M but as T
nmap <T-p> <Plug>yankstack_substitute_older_paste
nmap <T-P> <Plug>yankstack_substitute_newer_paste
nnoremap <S-T-Up>      <C-W>-
nnoremap <S-T-Down>    <C-W>+
nnoremap <S-T-Left>    <C-W><
nnoremap <S-T-Right>   <C-W>>
nnoremap <T-Up>      <C-W>_
nnoremap <T-Down>    <C-W>=
nnoremap <T-Left>    <C-W>=
nnoremap <T-Right>   <C-W><Bar>

" Mappings end }}}
" Autocmds {{{
autocmd FileType c,c++ let b:delimitMate_matchpairs = "(:),{:},[:],/*:*/"

" Auto-reload vimrc on save {{{
augroup vimrcEx
    autocmd!
    autocmd FileType text setlocal textwidth=78
    autocmd BufWritePost .vimrc source $HOME/.vimrc
    autocmd BufReadPost *
        \if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \endif
augroup END
" }}}
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
" Portfile {{{
autocmd FileType portfile set commentstring=#\ %s
" }}}
" Python {{{
augroup ft_python
    au!
    au FileType python set expandtab
    au FileType python set ofu=pythoncomplete#Complete

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
" Tex {{{
augroup ft_tex
    au FileType tex setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
    au FileType tex
		\if filereadable('Makefile') |
		\	setlocal makeprg=make |
		\else |
		\	exec "setlocal makeprg=make\\ -f\\ ~/Documents/Projects/Miscellaneous/latex.mk\\ " . substitute(bufname("%"),"tex$","pdf", "") |
		\endif

    au FileType tex nmap <leader>o :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR>
augroup END
" }}}
" txt & mutt files {{{
" autocmd BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt if &ft != 'help' | set tw=72 noai noshowmatch | endif
" autocmd BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt if &ft != 'help' | setlocal spell spelllang=en_us | endif
" autocmd BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt if &ft != 'help' | syntax off | endif
" }}}
" Git Commit msgs {{{
autocmd FileType gitcommit set noai noshowmatch
autocmd FileType gitcommit setlocal spell
" }}}
" SVN commit msgs {{{
autocmd FileType svn setlocal spell
" }}}
" Misc {{{
" Save on focus lost.
autocmd FocusLost * :silent! :wall

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Exit paste mode when exiting insert
autocmd InsertLeave * set nopaste
" }}}
" Autocmds end }}}
" Visual stuff {{{
if has("gui_running")
    set ttyfast
    colorscheme Tomorrow-Night
endif

if &t_Co >= 256
    colorscheme Tomorrow-Night
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif
" }}}

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

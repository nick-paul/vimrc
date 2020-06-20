set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","
set backspace=2

" Neovim Init Settings
if has('nvim')
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        let g:python3_host_prog = '/Users/npaul/anaconda/bin/python'
    else
        let g:python_host_prog  = glob('~/.pyenv/versions/neovim2/bin/python')
        let g:python3_host_prog = glob('~/.pyenv/versions/neovim3/bin/python')
    endif
end


" Quickly open/reload vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

set pumblend=24
set pumheight=10
set termguicolors


" VimPlug
"""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'nick-paul/aya-vim'
Plug 'scrooloose/nerdtree'  " Tree View
Plug 'vim-pandoc/vim-pandoc' " Markdown
Plug 'vim-pandoc/vim-pandoc-syntax' " Markdown
Plug 'vim-scripts/SearchComplete' " Tab completion when using '/'
Plug 'terryma/vim-multiple-cursors' " sublime text style multiple cursors
Plug 'nathanaelkane/vim-indent-guides' " View indent guides (:IndentGuides*)
Plug 'bling/vim-airline' " Better status bar
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter' " Git line modification ui
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree git ui
Plug 'octol/vim-cpp-enhanced-highlight' " Enhanced C++ highlighting
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'yuttie/comfortable-motion.vim' " Pyhsics based scrolling
Plug 'flazz/vim-colorschemes' " Colorscheme Management
Plug 'scrooloose/nerdcommenter' " Quickly comment selections
Plug 'lervag/vimtex' " Vim LaTeX
Plug 'alvan/vim-closetag' " Autoclose (X)HTML tags
Plug 'kien/rainbow_parentheses.vim'
Plug 'JuliaEditorSupport/julia-vim' " Julia Support
Plug 'rust-lang/rust.vim' " Rust Support
Plug 'dag/vim-fish'     " Fish Support
Plug 'majutsushi/tagbar'
Plug 'dyng/ctrlsf.vim'  " Async project searching
Plug 'ericcurtin/CurtineIncSw.vim' " Swap between cpp and h files quickly

" Plug 'mhinz/vim-startify' " Home Screen
" Plug 'godlygeek/tabular'   " Tab alignment for creating tables
" Plug 'junegunn/goyo.vim' " Distraction free writing

if has('nvim')
    "Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " use <tab> for trigger completion and navigate to the next complete item
    inoremap <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>my_check_back_space() ? "\<Tab>" :
          \ coc#refresh()

    function! s:my_check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

    " Neo Snippet
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'sbdchd/neoformat'
    " Plugin key-mappings.
    " Note: It must be 'imap' and 'smap'.  It uses <Plug> mappings.
    imap <C-j>     <Plug>(neosnippet_expand_or_jump)
    smap <C-j>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-j>     <Plug>(neosnippet_expand_target)

    " For conceal markers.
    "if has('conceal')
      "set conceallevel=2 concealcursor=niv
    "endif

    Plug 'kassio/neoterm' " Terminal helper tools
    Plug 'TaDaa/vimade'   " Inactive buffer fading

    " fzf
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    nnoremap <C-p> :FZF <CR>

    " undo files
    call mkdir(glob('~/') . '.var/neovim/undofiles', 'p')
    set undodir=$HOME/.var/neovim/undofiles " where to save undo histories

    " Enable sign column for auto-linted files
    autocmd BufRead,BufNewFile *.fish,*.cpp,*.hpp,*.lua,*.py,*.js setlocal signcolumn=yes
else

    Plug 'vim-syntastic/syntastic' " Linter
    Plug 'ervandew/supertab'  " Simple tab completions
    Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file search
endif

Plug 'ryanoasis/vim-devicons' "Icon support; must be LAST

call plug#end()

autocmd BufEnter *.* let b:term_title='foo'


let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang.so.1'


" COLOR / THEME
"""""""""""""""""""
syntax on
colorscheme Monokai         " :colorscheme <color>
let g:airline_theme='dark'  " :AirlineTheme <color>


" BASIC SETTINGS
""""""""""""""""""""

set clipboard=unnamedplus   " use system clipboard by default
set tabstop=4               " make tabsize 4 spaces
set expandtab               " use spaces instead of tabs
set softtabstop=4           " make <tab> and <bs> insert and del 4 spaces
set shiftwidth=4            " width when shifting
set cursorline              " Highlight current line
set mouse=a                 " Enable mouse support
set incsearch               " incremental 'live' search
scriptencoding utf-8        " invisible chars
set scrolloff=2             " two lines above and below the cursor when scrolling
set encoding=utf-8          " Unicode support
set spelllang=en_us         " Spellcheck dictionary
set whichwrap+=<,>,h,l,[,]  " Wrap when pressing arrow keys"
set list listchars=tab:»·,trail:·
" Spellcheck highlighting
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
set splitbelow
set splitright

" When the completion menu is shown, <CR> will select the
"   current item without inserting a newline
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
:set completeopt=longest,menuone

" Searching
" Ignore case by default, if upper is used, it won't match lower
set ignorecase
set smartcase

" Persistant Undo
set undofile                " Save undos after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


" PLUGIN SETTINGS
"""""""""""""""""

" CtrlP
set laststatus=2                        " vim-airline view
let ctrlp_show_hidden = 1               " ctrlp: show hidden files
let ctrlp_switch_buffer = 1             " switch to existing buffer if one is open
set wildignore+=*build/*,*.swp*.o,*.zip

" Tagbar quick search
nnoremap \ :TagbarOpenAutoClose <CR> /

" Minimap
let g:minimap_highlight='Visual'
nnoremap <leader>m :MinimapToggle<CR>

" Markdown
" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:pandoc#modules#disabled = ["folding"]

" Syntastic
let g:syntastic_python_checkers = ['pylint', 'mypy']
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'

" vim-pandoc
hi! link Conceal Special

" Rainbow Parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" CurtintIncSw (cpp/h switching)
map <leader><leader>c :call CurtineIncSw()<CR>

vnoremap <A-Enter> :TREPLSendSelection<CR>


" NERDTree
autocmd StdinReadPre * let s:std_in=1   " NERDTree autostart on directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" NERDTree exit vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1                " show hidden files
" Hide certain files
let NERDTreeIgnore=['\.pyc$']
let g:NERDTreeUpdateOnWrite = 0

if has('nvim')

    " Comfortable Motion
    nnoremap <silent> <PageDown> :call comfortable_motion#flick(100)<CR>
    nnoremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>
    nnoremap <silent> <S-Up> :call comfortable_motion#flick(-100)<CR>
    nnoremap <silent> <S-Down> :call comfortable_motion#flick(100)<CR>

    " Neoterm
    let g:neoterm_autoscroll = '1'
    let g:neoterm_size = 16
    command! -nargs=+ TT Topen | T
    nnoremap <leader>` :Ttoggle<CR>
    let g:neoterm_default_mod='belowright'
    nnoremap <leader><C-b> :TREPLSendFile<CR>
    vnoremap <leader><C-b> :TREPLSendSelection<CR>
endif

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" XHTML Autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.launch,*.js'
let g:closetag_shortcut = '>'


" CtrlSF
nnoremap <leader>F :CtrlSF
let g:ctrlsf_mapping = {"quit" : "Z"}

" TagBar, show tag in airline
command! -nargs=0 TagbarToggleStatusline call TagbarToggleStatusline()
nnoremap <silent> <c-h> :TagbarToggleStatusline<CR>
function! TagbarToggleStatusline()
   let tStatusline = '%{exists(''*tagbar#currenttag'')?
            \tagbar#currenttag(''     [%s] '',''''):''''}'
   if stridx(&statusline, tStatusline) != -1
      let &statusline = substitute(&statusline, '\V'.tStatusline, '', '')
   else
      let &statusline = substitute(&statusline, '\ze%=%-', tStatusline, '')
   endif
endfunction

" fugitive
nnoremap <leader>gs :Gstatus <CR>
nnoremap <leader>gd :Gdiff <CR>



" KEY MAPPINGS
""""""""""""""""


" Quick Settings
nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap ; :
inoremap <leader><leader> <Esc>
nnoremap <leader>n :set number!<CR>
nnoremap <leader>p :set paste<CR>p :set nopaste<CR>
" Window Navigation
map <C-Left> <C-w><Left>
map <C-Right> <C-w><Right>
map <C-Up> <C-w><Up>
map <C-Down> <C-w><Down>
" Toggle syntastic checking
nnoremap <leader><leader>s :SyntasticToggleMode<CR>
" move selected lines up one line
xnoremap <C-Up>  :m-2<CR>gv=gv
" move selected lines down one line
xnoremap <C-Down> :m'>+<CR>gv=gv
" Tab / untab lines
vnoremap > >gv
vnoremap < <gv
" Don't copy when deleting
nnoremap d "_d
" Toggle Line Comments
vmap <C-k> <leader>c<space>
nmap <C-k> <leader>c<space>
" Cursor Navigation
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
" Macros
nnoremap Q @q
" Spell check
nnoremap <leader>; ea<C-X>s
" Quick Tab Movements
nnoremap << gT
nnoremap >> gt

" Remaps
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
call SetupCommandAlias("Wa","wa")
call SetupCommandAlias("Qa","qa")
call SetupCommandAlias("Wq","wq")

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
end


" Running / Building Files
""""""""""""""""""""""""""""

" :make to compile .c and cpp files
au FileType cpp,c,rs setl mp=make\ %:t:r
let $CXXFLAGS='-std=c++14'
" python
nnoremap <silent> <leader>bp :w<CR>:!clear;python2 %<CR>
nnoremap <silent> <leader>bP :w<CR>:!clear;python3 %<CR>
" build and run
nnoremap <silent> <leader>br :w<CR>:!clear<CR>:make<CR>:!./%:r<CR>
nnoremap <leader>bc :w<CR>:make %:t:r<CR>
nnoremap <silent> <leader>ml :w<CR>:!latexmk -c %<CR>:!gnome-open %:r.pdf<CR><CR>
" pandoc
nnoremap <silent> <leader>pd :w<CR>:!pandoc --variable urlcolor=cyan % -o %:r.pdf<CR>:!open %:r.pdf<CR>
" run in browser
nnoremap <leader>ff :w<CR> :exe ':silent !firefox %'<CR><C-l>
"nnoremap <leader>ff :silent update<Bar>silent !open %:p &<CR><CR><C-l>
" preveew markdown in browser
nnoremap <leader>fm :w<CR> :! pandoc % -o %:r.html<CR> :exe ':silent !firefox %:r.html'<CR><C-l>

" AUTOCORRECT
"""""""""""""""
iabbrev feild field



" OTHER SETTINGS
""""""""""""""""""

" Gvim
if has('gui_running')
    " Hide Toolbar
    set guioptions-=T
endif

" ROS
autocmd BufNewFile,BufRead *.launch setf xml
autocmd BufNewFile,BufRead *.cfg setf python

" leave insert mode quickly
" disables iremap <Esc>...
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" MAC Settings
"""""""""""""""""""

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " use syetem clipboard
        set clipboard=unnamed
        nnoremap <silent> <leader>ml :w<CR>:!pdflatex -halt-on-error -output-directory %:p:h %<CR>:!open %:r.pdf<CR>
        let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'


        au BufEnter *.cpp set makeprg=c++\ --std=c++14\ -g\ %\ -o\ %<
    endif
endif


" Custom Functions
""""""""""""""""""""""

" Goyo Toggle
let is_using_goyo = 0
function! ToggleGoyoView ()
    if g:is_using_goyo == 1
        :Goyo!
        let g:is_using_goyo = 0
    else
        :Goyo 80%
        let g:is_using_goyo = 1
    endif
endfunction

nnoremap <leader>g :call ToggleGoyoView()<CR>

let python_console = 'python3'
if !empty(glob('~/.pyenv/shims/jupyter'))
    let g:python_console='python'
end



function! WSRemove ()
    :%s/\s\+$//
endfunction

command! WSRemove :call WSRemove()


" Toggle light and dark theme
let is_using_dark_theme = 1
function! ToggleLightDark ()
    if g:is_using_dark_theme == 1
        :colorscheme soda
        :AirlineTheme papercolor
        let g:is_using_dark_theme = 0
    else
        :colorscheme Monokai
        :AirlineTheme dark
        let g:is_using_dark_theme = 1
    endif
endfunction

nnoremap <leader><C-t> :call ToggleLightDark()<CR>

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()


" Tagbar Toggle
let is_tagbar_open = 0
function! ToggleTagbar ()
    if g:is_tagbar_open == 1
        :TagbarClose
        let g:is_tagbar_open = 0
    else
        :TagbarOpen
        let g:is_tagbar_open = 1
    endif
endfunction

nnoremap \ :call ToggleTagbar()<CR>

" Notes
" gg=G  Reindent the entire document
" :%s/\s\+$//e  Remove all trailing whitespace
"
"


let g:startify_custom_header = [
\ '    _   _                      _            ',
\ '   | \ | |                    (_)           ',
\ '   |  \| |  ___   ___  __   __ _  _ __ ___  ',
\ '   | . ` | / _ \ / _ \ \ \ / /| || `_ ` _ \ ',
\ '   | |\  ||  __/| (_) | \ V / | || | | | | |',
\ '   \_| \_/ \___| \___/   \_/  |_||_| |_| |_|',
\ ]



" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

" Remove arrow keys in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove arrow keys in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

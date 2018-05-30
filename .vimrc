set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","
set backspace=2

" Keep vim turds in one place
"set backupdir=~/.vim/backup//
"set directory=~/.vim/swap//
"set undodir=~/.vim/undo//

" Quickly open/reload vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Tags
set tags+=~/.vim/tags/cpp


" VimPlug
"""""""""""""


" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

call plug#begin('~/.vim/plugged')

Plug 'nick-paul/aya-vim'
" Tree view
Plug 'scrooloose/nerdtree'
" Alignment
Plug 'godlygeek/tabular'
" Markdown enable
"Plug 'plasticboy/vim-markdown'
"Plug 'gabrielelana/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Tab completions
Plug 'ervandew/supertab'
" Minimap
Plug 'severin-lemaignan/vim-minimap'
" sublime text style multiple cursors
Plug 'terryma/vim-multiple-cursors'
" View indent guides (:IndentGuides*)
Plug 'nathanaelkane/vim-indent-guides'
" Better status bar
Plug 'bling/vim-airline'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Python autocomplete
"Plug 'davidhalter/jedi-vim'
" Git line modification ui
Plug 'airblade/vim-gitgutter'
" Syntax checking
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
" NERDTree git ui
Plug 'Xuyuanp/nerdtree-git-plugin'
" Enhanced C++ highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" airline themes
Plug 'vim-airline/vim-airline-themes'
" Distraction free writing
Plug 'junegunn/goyo.vim'
" Pyhsics based scrolling

"Plug 'yuttie/comfortable-motion.vim'
" Colorscheme Management
Plug 'flazz/vim-colorschemes'
" Fuzzy file search
Plug 'ctrlpvim/ctrlp.vim'
" Quickly comment selections
Plug 'scrooloose/nerdcommenter'
" Vim LaTeX
Plug 'lervag/vimtex'
" Autocomplete braces
"Plug 'jiangmiao/auto-pairs'
"Plug 'Raimondi/delimitMate'
" Autoclose (X)HTML tage
Plug 'alvan/vim-closetag'
" Always show autocompletE
" Plug 'vim-scripts/autocomplpop'
Plug 'vim-scripts/taglist.vim'

" Other languages:
Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'

Plug 'majutsushi/tagbar'
Plug 'tacahiroy/ctrlp-funky'
"Plug 'davidhalter/jedi-vim'

"Plug 'vim-scripts/OmniCppComplete'

call plug#end()

"let g:jedi#force_py_version=3


" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled = 1

let g:pandoc#modules#disabled = ["folding"]

" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required

let g:syntastic_python_checkers = ['pylint']
"let g:ale_linters = {
"\   'python': ['pylint', 'flake8 --ignore=E303'],
"\}

" Omnicomplete cpp
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" COLOR / THEME
"""""""""""""""""""
syntax on
colorscheme monokai         " :colorscheme <color>
let g:airline_theme='dark'  " :AirlineTheme <color>
let is_using_dark_theme = 1 " keep track of current theme

" Toggle light and dark theme
function! ToggleLightDark ()
    if g:is_using_dark_theme == 1
        :colorscheme soda
        :AirlineTheme papercolor
        let g:is_using_dark_theme = 0
    else
        :colorscheme monokai
        :AirlineTheme dark
        let g:is_using_dark_theme = 1
    endif
endfunction

nnoremap <leader>t :call ToggleLightDark()<CR>


" vim-pandoc
hi! link Conceal Special


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

" When the completion menu is shown, <CR> will select the 
"   current item without inserting a newline
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
:set completeopt=longest,menuone

" Searching
" Ignore case by default, if upper is used, it won't match lower
set ignorecase
set smartcase


" PLUGIN SETTINGS
"""""""""""""""""
set laststatus=2                        " vim-airline view
let ctrlp_show_hidden = 1               " ctrlp: show hidden files
let ctrlp_switch_buffer = 1             " switch to existing buffer if one is open
set wildignore+=*build/*,*.swp

let g:minimap_highlight='Visual'

let Tlist_Use_Right_Window   = 1

let g:delimitMate_expand_cr=2

" NERDTree
autocmd StdinReadPre * let s:std_in=1   " NERDTree autostart on directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" NERDTree exit vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1                " show hidden files

" Comfortable Motion
nnoremap <silent> <PageDown> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>
nnoremap <silent> <S-Up> :call comfortable_motion#flick(-100)<CR>
nnoremap <silent> <S-Down> :call comfortable_motion#flick(100)<CR>
" Syntastic
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

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

function! RemoveWS ()
    :%s/\s\+$//flake 8 too many blank lines
endfunction

" XHTML Autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.launch'
let g:closetag_shortcut = '>'

" CtrlP

set wildignore+=*.o,*.swp,*.zip,build/*



" KEY MAPPINGS
""""""""""""""""

" run in browser
""nnoremap <leader>ff :w<CR> :exe ':silent !firefox %'<CR><C-l>
nnoremap <leader>ff :silent update<Bar>silent !open %:p &<CR><CR><C-l>
" preveew markdown in browser
nnoremap <leader>fm :w<CR> :! pandoc % -o %:r.html<CR> :exe ':silent !open %:r.html'<CR><C-l>

" Quick Settings
nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap <leader>m :MinimapToggle<CR>
nnoremap ; :
inoremap <leader><leader> <Esc>
nnoremap <leader>n :set number!<CR>
nnoremap <leader>p :set paste<CR>p :set nopaste<CR>
" Window Navigation
nnoremap <leader>a <C-w><Left>
nnoremap <leader>d <C-w><Right>
nnoremap <leader>w <C-w><Up>
nnoremap <leader>s <C-w><Down>
" Toggle syntastic checking
nnoremap <leader><leader>s :SyntasticToggleMode<CR>
" move selected lines up one line
xnoremap <C-Up>  :m-2<CR>gv=gv
" move selected lines down one line
xnoremap <C-Down> :m'>+<CR>gv=gv
" Tab / untab lines
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
" Select all
nnoremap <C-a> ggvG$
inoremap <C-a> <esc>ggvG$
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
nnoremap <leader>/ :TlistOpen<CR>

" Running / Building Files
""""""""""""""""""""""""""""


" :make to compile .c and cpp files
au FileType cpp,c,rs setl mp=make\ %:t:r
let $CXXFLAGS='-std=c++11'

nnoremap <silent> <leader>bp :w<CR>:!clear;python2 %<CR>
nnoremap <silent> <leader>bP :w<CR>:!clear;python3 %<CR>
nnoremap <silent> <leader>br :w<CR>:!clear<CR>:make<CR>:!./%:r<CR>
nnoremap <leader>bc :w<CR>:make %:t:r<CR>
nnoremap <silent> <leader>ml :w<CR>:!latexmk -c %<CR>:!gnome-open %:r.pdf<CR><CR>
nnoremap <silent> <leader>pd :w<CR>:!pandoc --variable urlcolor=cyan % -o %:r.pdf<CR>:!open %:r.pdf<CR>


" AUTOCORRECT
"""""""""""""""
iabbrev feild field




" OTHER SETTINGS
""""""""""""""""""

" Gvim
" Hide Toolbar
set guioptions-=T

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
    endif
endif


" Notes
" gg=G  Reindent the entire document
" :%s/\s\+$//e  Remove all trailing whitespace 

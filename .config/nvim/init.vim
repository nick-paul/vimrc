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

" Tags
set tags=./tags;/
set tags+=~/.vim/tags/cpp


" VimPlug
"""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'nick-paul/aya-vim'
" Tree view
Plug 'scrooloose/nerdtree'
" Alignment
Plug 'godlygeek/tabular'
" Markdown
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
" Git line modification ui
Plug 'airblade/vim-gitgutter'
" NERDTree git ui
Plug 'Xuyuanp/nerdtree-git-plugin'
" Enhanced C++ highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" airline themes
Plug 'vim-airline/vim-airline-themes'
" Distraction free writing
Plug 'junegunn/goyo.vim'
" Pyhsics based scrolling
Plug 'yuttie/comfortable-motion.vim'
" Colorscheme Management
Plug 'flazz/vim-colorschemes'
" Fuzzy file search
Plug 'ctrlpvim/ctrlp.vim'
" Quickly comment selections
Plug 'scrooloose/nerdcommenter'
" Vim LaTeX
Plug 'lervag/vimtex'
" Autoclose (X)HTML tage
Plug 'alvan/vim-closetag'
" Rainbow parens
Plug 'kien/rainbow_parentheses.vim'
" Inactive buffer fading
Plug 'TaDaa/vimade'

" Other languages:
Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'

Plug 'majutsushi/tagbar'
Plug 'tacahiroy/ctrlp-funky'
Plug 'davidhalter/jedi-vim'

" Async project searching
Plug 'dyng/ctrlsf.vim'
" Edit fish files
Plug 'dag/vim-fish'


if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    call mkdir(glob('~/') . '.var/neovim/cquery', 'p')

    let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery',
    \ '--log-file=/tmp/cq.log',
    \ '--init={"cacheDirectory":"' . glob('~/.var/neovim/cquery/') . '"}'],
    \ 'cpp': ['cquery',
    \ '--log-file=/tmp/cq.log',
    \ '--init={"cacheDirectory":"' . glob('~/.var/neovim/cquery/') . '"}']
    \ }

    Plug 'zchee/deoplete-jedi'

else
    Plug 'vim-syntastic/syntastic'
    "Plug 'Shougo/deoplete.nvim'
    "Plug 'roxma/nvim-yarp'
    "Plug 'roxma/vim-hug-neovim-rpc'
endif

" Icon support
" Must be last
Plug 'ryanoasis/vim-devicons'

call plug#end()


let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang.so.1'

if has('nvim')
    if has('unix')
        let g:deoplete#enable_at_startup = 1
        let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
        let g:deoplete#sources#clang#clang_header = '/usr/include/clang/3.8.0/include/'
    endif
endif



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
call mkdir(glob('~/') . '.var/neovim/undofiles', 'p')
set undodir=$HOME/.var/neovim/undofiles " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


" PLUGIN SETTINGS
"""""""""""""""""

" CtrlP
set laststatus=2                        " vim-airline view
let ctrlp_show_hidden = 1               " ctrlp: show hidden files
let ctrlp_switch_buffer = 1             " switch to existing buffer if one is open
set wildignore+=*build/*,*.swp*.o,*.zip

" CtrlP Funky
nnoremap <C-r> :CtrlPFunky<CR>

" Minimap
let g:minimap_highlight='Visual'
nnoremap <leader>m :MinimapToggle<CR>

" Markdown
" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:pandoc#modules#disabled = ["folding"]

" Syntastic
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'

" vim-pandoc
hi! link Conceal Special

" Rainbow Parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" NERDTree
autocmd StdinReadPre * let s:std_in=1   " NERDTree autostart on directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" NERDTree exit vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1                " show hidden files

" Comfortable Motion
if has('nvim')
    nnoremap <silent> <PageDown> :call comfortable_motion#flick(100)<CR>
    nnoremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>
    nnoremap <silent> <S-Up> :call comfortable_motion#flick(-100)<CR>
    nnoremap <silent> <S-Down> :call comfortable_motion#flick(100)<CR>
endif

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" XHTML Autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.launch'
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



" KEY MAPPINGS
""""""""""""""""

" run in browser
""nnoremap <leader>ff :w<CR> :exe ':silent !firefox %'<CR><C-l>
nnoremap <leader>ff :silent update<Bar>silent !open %:p &<CR><CR><C-l>
" preveew markdown in browser
nnoremap <leader>fm :w<CR> :! pandoc % -o %:r.html<CR> :exe ':silent !open %:r.html'<CR><C-l>

" Quick Settings
nnoremap <C-\> :NERDTreeToggle<CR>
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
autocmd BufRead,BufNewFile *.cpp,*.hpp setlocal signcolumn=yes

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

nnoremap <leader>t :call ToggleTagbar()<CR>

" Notes
" gg=G  Reindent the entire document
" :%s/\s\+$//e  Remove all trailing whitespace

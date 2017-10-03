set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","
set backspace=2

" Keep vim turds in one place
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//


" Quickly open/reload vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>



" VUNDLE
"""""""""""""


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Tree view
Plugin 'scrooloose/nerdtree'
" Alignment
Plugin 'godlygeek/tabular'
" Markdown enable
Plugin 'plasticboy/vim-markdown'
" Tab completions
Plugin 'ervandew/supertab'
" Minimap
Plugin 'severin-lemaignan/vim-minimap'
" sublime text style multiple cursors
Plugin 'terryma/vim-multiple-cursors'
" View indent guides (:IndentGuides*)
Plugin 'nathanaelkane/vim-indent-guides'
" Better status bar
Plugin 'bling/vim-airline'
" Git wrapper
Plugin 'tpope/vim-fugitive'
" Python autocomplete
" Plugin 'davidhalter/jedi-vim'
" Git line modification ui
Plugin 'airblade/vim-gitgutter'
" Syntax checking
" Plugin 'vim-syntastic/syntastic'
" NERDTree git ui
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Enhanced C++ highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'
" airline themes
Plugin 'vim-airline/vim-airline-themes'
" Distraction free writing
Plugin 'junegunn/goyo.vim'
" Pyhsics based scrolling
Plugin 'yuttie/comfortable-motion.vim'
" Colorscheme Management
Plugin 'flazz/vim-colorschemes'
" Fuzzy file search
Plugin 'ctrlpvim/ctrlp.vim'
" Quickly comment selections
Plugin 'scrooloose/nerdcommenter'
" Vim LaTeX
Plugin 'lervag/vimtex'
" Autocomplete braces
Plugin 'jiangmiao/auto-pairs'
" Autoclose (X)HTML tage
Plugin 'alvan/vim-closetag'

" Other languages:
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'rust-lang/rust.vim'

" Disable folding in vim-markdown
let g:vim_markdown_folding_disabled = 1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



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

set list listchars=tab:»·,trail:·





" PLUGIN SETTINGS
"""""""""""""""""
set laststatus=2                        " vim-airline view
let ctrlp_show_hidden = 1               " ctrlp: show hidden files
let g:minimap_highlight='Visual'

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

" XHTML Autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.launch'
let g:closetag_shortcut = '>'




" KEY MAPPINGS
""""""""""""""""

" run in browser
""nnoremap <leader>ff :w<CR> :exe ':silent !firefox %'<CR><C-l>
nnoremap <leader>ff :silent update<Bar>silent !firefox %:p &<CR><CR><C-l>
" preview markdown in browser
nnoremap <leader>fm :w<CR> :! pandoc % -o %:r.html<CR> :exe ':silent !firefox %:r.html'<CR><C-l>

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
vmap <C-_> <leader>c<space>
nmap <C-_> <leader>c<space>
" Cursor Navigation
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>


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
nnoremap <silent> <leader>pd :w<CR>:!pandoc % -o %:r.pdf<CR>:!open %:r.pdf<CR><CR>


" AUTOCORRECT
"""""""""""""""
iabbrev feild field




" OTHER SETTINGS
""""""""""""""""""

" ROS
autocmd BufNewFile,BufRead *.launch set syntax=xml
autocmd BufNewFile,BufRead *.cfg set syntax=python



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
    endif
endif

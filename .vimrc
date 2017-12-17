" very useful vim optimized for python
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
"
set nocompatible              " required
"set backspace to be able to delete anywhere
set backspace=indent,eol,start
" set line number
set nu
" utf-8 support
set encoding=utf-8
set splitbelow
set splitright
"no swap or backup
set nowritebackup
set nobackup
set noswapfile

filetype off                  " required
filetype plugin indent on    " required

" add indentation for PEP8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" flag extra whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"accelerated scrolling
Plugin 'rhysd/accelerated-jk'

" auto-indentation for multiple lines
Plugin 'vim-scripts/indentpython.vim'

" clear indentation indicators
" Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'

" auto-complete for python
Bundle 'Valloric/YouCompleteMe'

" syntax checking and highlighting
Plugin 'scrooloose/syntastic'

" enable PEP8 checking
Plugin 'nvie/vim-flake8'

" Python docstring
Plugin 'heavenshell/vim-pydocstring'

" NERDTree as file explorer
Plugin 'scrooloose/nerdtree'

"Use Tabs for NERDTree
Plugin 'jistr/vim-nerdtree-tabs'

"Mark files in NERDTree if they have been edited
Plugin 'Xuyuanp/nerdtree-git-plugin'

" current virtual env, git branch, files being edited
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" FileSuper Searching (Ctrl-P)
Plugin 'kien/ctrlp.vim'

" Git Integration
Plugin 'tpope/vim-fugitive'

" Show edited lines managed by Git
Plugin 'airblade/vim-gitgutter'

" coloring
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'

" color scheme extension to tmux following vim's style
Bundle 'edkolev/tmuxline.vim'

" cheat sheet
Plugin 'lifepillar/vim-cheat40'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" enable 256 colors
set t_Co=256

" Choose color scheme
if has('gui_running')
    set background=dark
    "colorscheme solarized
    colorscheme zenburn
else
    colorscheme molokai 
endif

"
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" pretty code
let python_highlight_all=1
syntax on

"NERD Tree
" ignore pyc files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Open Nerd Tree by default
au VimEnter *  NERDTree

" Close Nerd Tree if last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" let NERD Tree hidden files by default
let NERDTreeShowHidden = 1

" switch between NERD and other files
nmap <Leader><Tab> <C-w>w

let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"	:"*",
	\ "Staged"	:"a",
	\ "Untracked"	:"u",
	\ "Renamed"	:">",
	\ "Unmerged"	:"u",
	\ "Deleted"	:"x",
	\ "Dirty"	:"@",
	\ "Clean"	:"c",
	\ "Ignored"	:"i",
	\ "Unknown"	:"?"
	\}

" complete me add customization to make it better
let g:ycm_autoclose_preview_window_after_completion=1
let g:yvm_python_binary_path = 'python'

" YCM sub command mappings
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap jd :YcmCompleter GoToDefinition<CR>

" pydoc string
nmap <silent> <C-D> <Plug>(pydocstring)

"highlight search by default
set hlsearch
highlight Search ctermbg=DarkCyan
highlight Search ctermfg=LightRed

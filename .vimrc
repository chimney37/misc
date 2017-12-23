" very useful vim optimized for python
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

" enable 256 colors
set t_Co=256
set ttyfast
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
" ignore case in search
set ignorecase
set showcmd

filetype off                  " required
filetype plugin indent on    " required

" add indentation for PEP8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=100|
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

"vertical move
Plugin 'bruno-/vim-vertical-move'

"go development plugin
Plugin 'fatih/vim-go'

" auto-indentation for multiple lines
Plugin 'vim-scripts/indentpython.vim'

" clear indentation indicators
Plugin 'Yggdroot/indentLine'

" Folding code
Plugin 'tmhedberg/SimpylFold'
Plugin 'Konfekt/FastFold'

" commenter
Plugin 'scrooloose/nerdcommenter'

" auto-complete for python
Plugin 'Valloric/YouCompleteMe'

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

" UI to show current virtual env, git branch, files being edited
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plugin 'lokaltog/powerline-fontpatcher'

" FileSuper Searching (Ctrl-P)
Plugin 'kien/ctrlp.vim'

" Fuzzy and incremental Search
Plugin 'haya14busa/incsearch.vim'
" easy motion
Plugin 'easymotion/vim-easymotion'

" Git Integration (:Git)
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'

" Show edited lines managed by Git
Plugin 'airblade/vim-gitgutter'

" coloring
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'

" color scheme extension to tmux following vim's style
Plugin 'edkolev/tmuxline.vim'

" change python to more unicode symbol like
" Plugin 'ehamberg/vim-cute-python'

" For creating pretty tables in Markdown
Plugin 'dhruvasagar/vim-table-mode'

" cheat sheet (<leader>?)
Plugin 'lifepillar/vim-cheat40'

" easy note taking (:Note, :SearchNotes)
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

" hacker news (:HackerNews)
Plugin 'ryanss/vim-hackernews'

" quantify coding time
Plugin 'wakatime/vim-wakatime'

"language checker
Plugin 'chimney37/vim-LanguageTool'


" All of your Plugins must be added before the following line
call vundle#end()            " required

" Choose color scheme
if has('gui_running')
    set background=dark
    "colorscheme solarized
    colorscheme zenburn
else
    colorscheme molokai 
endif

" disable arrow keys (rites of passage of VIM)
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" pretty code
set hlsearch
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
"nmap <Leader><Tab> <C-w>w

" open NERDTree
map <C-n> :NERDTreeToggle<CR>

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

" allow multiple highlighting based on file in NERDTree
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('txt', 'yellow', 'none', 'green', '#151515')
call NERDTreeHighlightFile('csv', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('tsv', 'yellow', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('xls', 'yellow', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('py', 'cyan', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('pickle', 'blue', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('log', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('sh', 'DarkCyan', 'none', '#ffa500', '#151515')


" pydoc string
nmap <silent> <C-D> <Plug>(pydocstring)

"highlight search by default
"set hlsearch
highlight Search ctermbg=DarkCyan
highlight Search ctermfg=LightRed

"fuzzy search (Plugin)
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
"doesn't move the cursor
map g/ <Plug>(incsearch-stay) 

" notes (Plugin)
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix='.txt'

" languagetool jar location
let g:languagetool_jar='/usr/local/Cellar/languagetool/3.9/libexec/languagetool-commandline.jar'

" Folding configuration
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  []
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" Tabbing
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap td  :tabclose<CR>


" acceleration of cursor (Plugin)
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" complete me add customization to make it better
let g:ycm_autoclose_preview_window_after_completion=1
let g:yvm_python_binary_path = 'python'

" YCM sub command mappings
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"syntastic setting
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_python_checkers= ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" call flake to check pep8 everykime writing to python file
" autocmd BufWritePost *.py call Flake8()

" Macros
let @a = '^f=ha la j'
let @b = 'f,a '
let @c = '^a j'
let @d = 'f:a l'
let @e = '$a  # flake8: noqa'

" VIM CONFIGURATION FILE 

" Vim general Settings-----------------------{{{
" always show statusline
set laststatus=2
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
" }}}

" Indentation and related setting sections for python, C, etc. ------------------- {{{
highlight BadWhitespace ctermbg=red guibg=darkred
augroup Custom_Coding_group
    autocmd!
    autocmd BufNewFile,BufRead *.py,*.go
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=100|
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix
    " flag extra whitespace
    autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.go match BadWhitespace /\s\+$/
    autocmd FileType vim,go,python setlocal foldmethod=marker
    autocmd FileType vim,potion
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix
augroup END
" }}}

" Plugin Settings----------------{{{
filetype off                  " required
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
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-dispatch'

" Show edited lines managed by Git
Plugin 'airblade/vim-gitgutter'

" coloring
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
Plugin 'dansomething/vim-hackernews'

" quantify coding time
Plugin 'wakatime/vim-wakatime'

"language checker
Plugin 'chimney37/vim-LanguageTool'

" Potion sandbox plugin
Plugin 'chimney37/potion'
" Convert Markdown to BB plugin
Plugin 'chimney37/vim-md2bb'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
syntax on
" }}}

" Color scheme Settings (highlights, etc.)----------------{{{
if has('gui_running')
    set background=dark
    "colorscheme solarized
    colorscheme zenburn
else
    colorscheme molokai 
endif

"highlight search by default
set hlsearch
highlight Search ctermbg=DarkCyan
highlight Search ctermfg=LightRed

" pretty code
let python_highlight_all=1
" }}}

" NERD Tree Plugin Settings ------------{{{
" ignore pyc files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" let NERD Tree hidden files by default
let NERDTreeShowHidden = 1
" uses custom symbols for various Git status 
let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"	:"*",
	\ "Staged"	:"a",
	\ "Untracked"	:"u̱",
	\ "Renamed"	:">",
	\ "Unmerged"	:"ū",
	\ "Deleted"	:"x",
	\ "Dirty"	:"@",
	\ "Clean"	:"c",
	\ "Ignored"	:"i",
	\ "Unknown"	:"?"
	\}

" open NERDTree
noremap <C-n> :NERDTreeToggle<CR>

" NERDTree File highlighting --------------------{{{
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
" Custom NERDTree Group for au commands
augroup Custom_NERDTreeGroup
    autocmd!
    " Open Nerd Tree by default
    autocmd VimEnter *  NERDTree

    " Close Nerd Tree if last buffer
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    call NERDTreeHighlightFile('txt', 'yellow', 'none', 'green', '#151515')
    call NERDTreeHighlightFile('csv', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('tsv', 'yellow', 'none', '#3366FF', '#151515')
    call NERDTreeHighlightFile('xls', 'yellow', 'none', '#3366FF', '#151515')
    call NERDTreeHighlightFile('py', 'cyan', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('pickle', 'blue', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('log', 'Magenta', 'none', '#ff00ff', '#151515')
    call NERDTreeHighlightFile('sh', 'DarkCyan', 'none', '#ffa500', '#151515')
augroup END
"}}}
"}}}

" pydocstring Plugin Settings ----------------------{{{
nmap <silent> <C-D> <Plug>(pydocstring)
"}}}

"Fuzzy search Plugin Settings-------------------{{{
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
"doesn't move the cursor
map g/ <Plug>(incsearch-stay) 
"}}}

" Notes Plugin Settings----------------------------{{{
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix='.txt'
"}}}

" Languagetool settings--------------{{{ 
let g:languagetool_jar='/usr/local/Cellar/languagetool/3.9/libexec/languagetool-commandline.jar'
"}}}

" Fast Folding Plugin Settings ------------------{{{
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  []
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
"}}}

" Acceleration of cursor Plugin Settings-------------------{{{
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
"}}}

" You Complete me Plugin Settings---------------------{{{
" complete me add customization to make it better
let g:ycm_autoclose_preview_window_after_completion=1
let g:yvm_python_binary_path = 'python'

" YCM sub command mappings
noremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"}}}

" Syntastic Plugin Settings --------------------------------{{{
let g:syntastic_python_checkers= ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"}}}

" General mappings-------------------------{{{
" extra useful mappings
noremap - <nop>
let maplocalleader="-"

" move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tabbing
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap td  :tabclose<CR>

" swap 2 lines
nnoremap <localleader>- ddp
nnoremap <localleader>_ ddkP
" make a word in mode uppercase
inoremap <c-u> <esc>viwU$a
nnoremap <c-u> viwU$
" make it easier to edit vimrc and source it
nnoremap <localleader>ev :split $MYVIMRC<cr>
nnoremap <localleader>sv :source $MYVIMRC<cr>
" splitting the current buffer into a new split
nnoremap <localleader>ec :execute "vsplit " . bufname("%")<cr>
"complicated mappings
" encase word under visual selection in double quotes
nnoremap <localleader>" viw<esc>a"<esc>bi"<esc>lel
" encase word under visiaul selection in single quotes
nnoremap <localleader>' viw<esc>a'<esc>bi'<esc>lel
" encase entire visual selection in single quotes
vnoremap <localleader>' <esc>`<<esc>i'<esc>`>li'<esc>
" map to highlight trailing whitespaces (outside of autocmd FileType)
nnoremap <localleader>w :execute ':match Error /\v\s+$/'<cr>
" map to clear the match above
nnoremap <localleader>W :execute ':match none'<cr>

" nnoremap / /\v
" run external grep on word under cursor
" nnoremap <localleader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen 5<cr>
" cnext and cprevious mappings
nnoremap <localleader>n :cnext<cr>
nnoremap <localleader>p :cprevious<cr>

" stop highligting from last search
nnoremap <silent> <localleader>? :nohlsearch<cr>

" delete 2 lines but can undo one at a time
" Note: dddd that deletes 2 lines in succession in a command, is treated as
" one undo-block in normal mode. This means without making adjustments, it is not
" possible to undo each deletion separately. In order to do this, we must
" break the undo sequence. Use :helpgrep undo to look up for hints:
" <C-G>u is a way to break the undo sequence, but this only works in insert
" mode, hence the i in the commands.
nnoremap <localleader>d ddi<C-G>u<esc>dd
nnoremap H ^
nnoremap L $
" rites of passage of vim
noremap <left> <NOP>
noremap <Down> <NOP>
noremap <Up> <NOP>
noremap <Right> <NOP>
inoremap jk  <esc>
onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>

" Custom_Mapping_Group AutoGroup ---------------{{{
augroup Custom_Mapping_Group
    autocmd!
    "commenting out certain code lines in different file types 
    autocmd FileType javascript,go nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
    " snippet for javascript
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
    " snippet to add semicolon
    autocmd FileType javascript nnoremap <buffer> <localleader>ic :execute "normal! mqA;\e`q"<cr>
    " tag outline close for html
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
    " Delete header of markdown in current paragraph 
    " Note: normal! doesn' recognize <cr>, hence we use execute. ! is to make
    " sure that the non-remappable mapping remains non-remappable. Without it,
    " it becomes mappable. help: normal 
    " Note: on the regular expression in execute string below
    " ?\v^(\-\-|\=\=)+$ searches backwards for lines beginning and ending with 2 or more equal signs. - and + is escaped in searches because they have a special meaning in vim-regex.
    " since the whole expression is a string, \ is escaped with \ to make it a literal. \v is "very magic". help: pattern-overview
    " | is also escaped with \ for a different reason, because | in execute strings is a command separater. help: execute
    " :nohlsearch clears search highlighting so not distracting
    " kvg_  g_ move to the last  non-blank char of current line
    autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?\\v^(\\-\\-\|\\=\\=)+$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap ah :<c-u>execute "normal! ?\\v^(\\-\\-\|\\=\\=)+$\r:nohlsearch\rg_vk0"<cr>
    autocmd FileType markdown onoremap in@ :<c-u>execute "normal!  /\\w\\v[a-z]+\\@\r:nohlsearch\rvt@"<cr>
augroup END
"}}}
" }}}

" Toggling Option Settings ---------------{{{
" Show or not show the foldcolumn
nnoremap <silent> <localleader>f :call <SID>FoldColumnToggle()<cr>
" FoldColumn Toggling Function ---------------{{{
function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=2
    endif
endfunction
"}}}

" open or close the quickfix window, with the additional feature of going back
" to the previous window when closing the quickfix
nnoremap <silent> <localleader>q :call <SID>QuickFixToggle()<cr>
" Quick Fix Toggling Function -----------{{{
let g:quickfix_is_open = 0
function! s:QuickFixToggle()
    " solve the case where copen is called elsewhere outside of this function
    " getqflist gets the quickfix list, dictionary item gets the value of the
    " item when set to 0
    let g:quickfix_opened_elsewhere = getqflist({'winid' : 0}).winid != 0
    if g:quickfix_is_open || g:quickfix_opened_elsewhere 
        cclose
        let g:quickfix_is_open = 0
        " wincmd tells Vim to go to the window specified with a window number
        " prepended as a count
        if g:quickfix_opened_elsewhere != 0
            " when opened elsewhere, quickfix_return_to_window is undefined,
            " so open the top window (value of 1)
            execute '1' . "wincmd w"
        else
            execute g:quickfix_return_to_window . "wincmd w"
        endif
        " case where qf is closed
    else
        " save current window number
        let g:quickfix_return_to_window = winnr() 
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
"}}}
" }}}

"Abbreviation Settings -----------------{{{
" bunch of abbreviations
iabbrev adn and
iabbrev teh the
iabbrev tehn then
iabbrev waht what
iabbrev mail@@ mail@hotmail.com
iabbrev ccopy Copyright 2017 chimney37, all rights reserved.
iabbrev ssig -- <cr>chimney37<cr>chimney37@hotmail.com
"}}}

" Macros----------------{{{ 
" useful macros for fixing python PEP8
let @a = '^f=ha la j'
let @b = 'f,a '
let @c = '^a j'
let @d = 'f:a l'
let @e = '$a  # flake8: noqa'

" Macro (for converting markdown to bbcode
let @m = ':2,$y+ |$ |read !echo "`pbpaste`" | perl ~/Documents/misc/md2bb.pl/md2bb.pl'
let @n = ':2,$y+ |$ |read !echo "`pbpaste`" | node ~/Documents/nodejs/index.js'
"}}}

" Debugging-----------------{{{
" for debugging statusline as powerline interferes
"let g:powerline_loaded=1
"}}}

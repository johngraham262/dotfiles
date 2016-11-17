" Pathogen setup
execute pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp.vim
"""

"syntax on

" Colors
""" I use iterm2. Make sure you add your color scheme to iterm2.
syntax enable
set background=dark
colorscheme solarized

let mapleader=","

set nocompatible
set ignorecase
set smartcase
set nostartofline
set autoindent
set number
set scrolloff=5
set hlsearch
set incsearch
set title
set showcmd
set ruler
set ai " Automatically set the indent of a new line (local to buffer)
set mouse=a
set expandtab

" Feels like cursor moves to the new pane after split
set splitbelow
set splitright

" Turn off the swapfiles
set nobackup
set nowritebackup
set noswapfile

" Fix backspace in vim 7
set backspace=indent,eol,start

" Always show status line
set laststatus=2
set statusline+=%F

" crtl-direction navigate between vim panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Convenience
nmap ,a :wa<CR>
nmap ,q :q<CR>

""" Clipboard
" copy highlighted to clipboard
vmap ,c "*y
" copy word to clipboard
nmap ,d "*yiw
" paste
nmap ,v :set paste<CR>"*p:set nopaste<CR>

" Python debugging
" drop a debugger with: ----- from nose.tools import set_trace; set_trace()

" Fix frequent typo of mine
command WQ wq
command Wq wq
command W w
command Q q

" Try to fix slow esc key lag
set timeoutlen=1000 ttimeoutlen=10

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Open useful sidebars (nerdtree)
nmap ,nt :NERDTreeToggle<CR>

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Formatting by filetype
filetype plugin indent on
filetype plugin on
filetype on

autocmd Filetype python set tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype ruby set expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype html set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype yaml set expandtab tabstop=2 softtabstop=2 shiftwidth=2

# Easy add a breakpoint with ",d" in normal vim mode
autocmd FileType javascript map <Leader>d kodebugger;<ESC>
autocmd FileType python map <Leader>d koimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType ruby map <Leader>d kobinding.pry<ESC>

" Custom ignores for ctrlp and NERDTree
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|compiled_site)$',
  \ 'file': '\v\.(exe|so|dll|pyc|yaml)$',
  \ }
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.db$' ]

""" Syntastic check

" Mark syntax errors with signs
let g:syntastic_enable_signs=2

" Specify height of error list
let g:syntastic_loc_list_height = 3

" Don't jump when it finds an error
let g:syntastic_auto_jump=0

" Autoshow error list if it finds an error
let g:syntastic_auto_loc_list=1

let g:syntastic_ruby_checkers=['rubocop', 'mri']
let g:syntastic_python_checkers=['pep8', 'pylint', 'python']
let g:syntastic_javascript_checkers=['eslint']

" vimux
let g:vimux_ruby_file_relative_paths = 1
let g:vimux_ruby_cmd_unit_test = "rspec"
autocmd FileType ruby  map <Leader>ra :call VimuxRunCommand("rspec")<CR>
autocmd FileType ruby  map <Leader>rF :RunAllRubyTests<CR>
autocmd FileType ruby  map <Leader>rf :RunRubyFocusedTest<CR>

autocmd FileType python map <Leader>ra :call RunNoseTest()<CR>
autocmd FileType python map <Leader>rF :call RunNoseTestBuffer()<CR>
autocmd FileType python map <Leader>rf :call RunNoseTestFocused()<CR>

map <Leader>rr :call VimuxRunLastCommand()<CR>
map <Leader>rs :call VimuxRunNoseSetup()<CR>
map <Leader>ri :call VimuxInspectRunner()<CR>
map <Leader>rc :call VimuxCloseRunner()<CR>
map <Leader>rt :call VimuxTogglePane()<CR>

map Y y$

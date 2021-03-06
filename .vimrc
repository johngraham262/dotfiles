call plug#begin('~/.vim/plugged')

" File navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Easy commenting
Plug 'scrooloose/nerdcommenter'

" Linter
Plug 'w0rp/ale'

" Back to basics
Plug 'tpope/vim-sensible'

" Color scheme
Plug 'altercation/vim-colors-solarized'

" Improved text editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'

" Vim helpers
Plug 'tpope/vim-fugitive'

" Navigate between tmux and vim panes
Plug 'christoomey/vim-tmux-navigator'

" Running tests
Plug 'benmills/vimux'
Plug 'pitluga/vimux-nose-test'
Plug 'pgr0ss/vimux-ruby-test'

" Text completion
" After installation, run this: `cd ~/.vim/plugins/YouCompleteMe && ./install.py --all`
" Plug 'Valloric/YouCompleteMe'

" Switch between buffers
Plug 'jlanzarotta/bufexplorer'

Plug 'flowtype/vim-flow'

" Descriptive bottom line
" Plug 'powerline/powerline'
" Plug 'vim-airline/vim-airline'

Plug 'nvie/vim-flake8'
Plug 'shime/vim-livedown'

Plug 'ruanyl/vim-gh-line'

call plug#end()

" Colors
""" I use iterm2. Make sure you add your color scheme to iterm2.
syntax on
syntax enable
set background=dark
colorscheme solarized
" iterm2 color scheme: https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized

let mapleader=","

set nocompatible
set ignorecase
set smartcase
set nostartofline
set cindent
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

" auto-update if the file changes outside of vim
set autoread
au CursorHold * checktime

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

" Map :FZF to ctrl+p
nnoremap <C-p> :FZF<CR>

" crtl-direction navigate between vim panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Swap 'I' to go to beginning of line without insert mode
nmap I ^

" Convenience save / quit
nmap ,a :redraw!<CR>:wa<CR>
nmap ,q :q<CR>

" Don't auto-jump to the next search result
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Fix frequent typo of mine
" command WQ wq
" command Wq wq
" command W w
" command Q q

""" Clipboard
set clipboard=unnamed
" copy highlighted to clipboard
vmap ,c "*y
" copy word to clipboard
nmap ,d "*yiw
" paste
nmap ,v :set paste<CR>"*p:set nopaste<CR>

" Try to fix slow esc key lag
set timeoutlen=1000 ttimeoutlen=10

" show the 100 char line guide
set cc=100

" Powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" Open useful sidebars (nerdtree)
nmap ,nt :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.db$' ]

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Autoremove trailing spaces when saving the buffer
autocmd FileType c,cpp,elixir,eruby,html,java,javascript,php,ruby,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Formatting by filetype
filetype plugin indent on
filetype plugin on
filetype on

autocmd Filetype python set tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype ruby set expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype html set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype java set tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype yaml set expandtab tabstop=2 softtabstop=2 shiftwidth=2

" Add a breakpoint
autocmd FileType javascript map <Leader>db kodebugger;<ESC>
autocmd FileType python map <Leader>db koimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType ruby map <Leader>db kobinding.pry<ESC>

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Custom ignores for ctrlp and NERDTree
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|compiled_site)$',
  \ 'file': '\v\.(exe|so|dll|pyc|yaml)$',
  \ }

" View markdown
nmap <leader>ld :LivedownToggle<CR>

""" Javascript
"function FormatPrettierJs()
    "let ln = line('.')
    "let cn = col('.')
    "%! prettier --single-quote --jsx-bracket-same-line --parser babylon --trailing-comma es5 --print-width 100
    "cal cursor(ln, cn)
"endfunction
" Run prettier on save (with Fin flags)
"autocmd BufWritePre *.js,*.jsx call FormatPrettierJs()

""" Ale syntax checks
"set statusline+=%#warningmsg#
"set statusline+=%{ALEGetStatusLine()}
"set statusline+=%*

let g:airline#extensions#ale#enable = 1
let g:ale_enabled = 1
" visual options
let g:ale_sign_column_always = 1
let g:ale_sign_warning = '*'
let g:ale_sign_error = 'E'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:airline_section_error = '%{ALEGetStatusLine()}'

" Linting options
let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'jsx': ['eslint', 'flow-language-server'],
\   'python': ['flake8'],
\   'ruby': ['ruby', 'rubocop'],
\   'hcl': [],
\}

let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['rubocop'],
\}
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 1

" language-specific options
let g:ale_javascript_prettier_options = ' --parser babylon --single-quote --jsx-bracket-same-line --trailing-comma es5 --print-width 100'
let g:ale_javascript_flow_executable = './dev-scripts/flow-proxy.sh'

" Flow
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
let g:flow#enable = 1
let g:flow#omnifunc = 1
let g:flow#showquickfix = 0
let g:flow#ale_set_loclist = 1

" vim-javascript and vim-jsx settings
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

map <Leader>G :FlowType<CR>
map <Leader>g :FlowJumpToDef<CR>
nnoremap <leader>s :ALENextWrap<CR>

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" |
        \ endif

" YouCompleteMe YCM disable syntax checking
let g:ycm_show_diagnostics_ui = 0

""" vimux test running
let g:vimux_ruby_file_relative_paths = 1
let g:vimux_ruby_cmd_unit_test = "rspec"
autocmd FileType ruby  map <Leader>ra :call VimuxRunCommand("rspec")<CR>
autocmd FileType ruby  map <Leader>rF :RunAllRubyTests<CR>
autocmd FileType ruby  map <Leader>rf :RunRubyFocusedTest<CR>

autocmd FileType python map <Leader>ra :call RunNoseTest()<CR>
autocmd FileType python map <Leader>rF :call RunNoseTestBuffer()<CR>
autocmd FileType python map <Leader>rf :call RunNoseTestFocused()<CR>

autocmd FileType javascript map <Leader>rf :call VimuxRunCommand("clear; ./dev-scripts/karma-run-line-number.sh " . expand("%.") . ":" . line("."))<CR>
autocmd FileType javascript map <Leader>ra :call VimuxRunCommand("clear; $NODE_PATH/karma/bin/karma run -- —grep=”)<CR>

map <Leader>rr :call VimuxRunLastCommand()<CR>
map <Leader>rs :call VimuxRunNoseSetup()<CR>
map <Leader>ri :call VimuxInspectRunner()<CR>
map <Leader>rc :call VimuxCloseRunner()<CR>
map <Leader>rt :call VimuxTogglePane()<CR>

""" YouCompleteMe settings

map Y y$


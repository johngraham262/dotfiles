" call plug#begin('~/.vim/plugged')
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" File navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
" Plug 'nvim-tree/nvim-tree.lua'

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Easy commenting
Plug 'scrooloose/nerdcommenter'

" Linter
Plug 'dense-analysis/ale'
Plug 'prettier/vim-prettier'

" Set up ctags
Plug 'ludovicchabant/vim-gutentags'

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

" Switch between buffers
Plug 'jlanzarotta/bufexplorer'

Plug 'flowtype/vim-flow'

" Descriptive bottom line
" Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'

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

" Map :FZF to ctrl+p, and FZF will only search files in a git repo
silent! nmap <C-p> :GFiles<CR>
" nnoremap <C-p> :FZF<CR>
let g:fzf_layout = {'down':'20'}

" Silver searcher, ag, settings
" let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <C-f> :Ag<CR>

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

" delete without yanking
nnoremap <Leader>d "_d
" replace currently selected text with default register without yanking it
vnoremap <Leader>p "_dP

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

" Open useful sidebars (nerdtree)
nmap ,nt :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.db$' ]
let NERDTreeShowHidden=1

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Autoremove trailing spaces when saving the buffer
autocmd FileType c,cpp,elixir,eruby,html,java,javascript,typescript,php,ruby,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Formatting by filetype
filetype plugin indent on
filetype plugin on
filetype on

set tabstop=2
set shiftwidth=2
autocmd Filetype python set tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype ruby set expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype html set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype typescript set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype java set tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype yaml set expandtab tabstop=2 softtabstop=2 shiftwidth=2

" Add a breakpoint
autocmd FileType javascript map <Leader>db Odebugger;<ESC>
autocmd FileType typescript map <Leader>db Odebugger;<ESC>
autocmd FileType python map <Leader>db Oimport ipdb; ipdb.set_trace()<ESC>
autocmd FileType ruby map <Leader>db Obinding.pry<ESC>

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

""" Ale syntax checks
set statusline+=%#warningmsg#
" set statusline+=%{ALEGetStatusLine()}
set statusline+=%*

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
" let g:airline_section_error = '%{ALEGetStatusLine()}'

" Linting options
let g:ale_lint_on_save = 1
let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'jsx': ['eslint', 'flow-language-server'],
\   'python': ['flake8'],
\   'ruby': ['ruby', 'rubocop'],
\   'hcl': [],
\}

let g:ale_fixers = {
\   'typescript': ['eslint', 'prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['rubocop'],
\}
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 1
let g:ale_completion_enabled = 1

" language-specific options
" let g:ale_javascript_prettier_options = ' --config ~/.prettierrc '

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

map Y y$

" Tags and jump to defs
" ideas here: https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

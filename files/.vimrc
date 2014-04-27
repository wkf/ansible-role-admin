set runtimepath+=~/.vim/bundle/neobundle.vim/

set nocompatible                                            " be iMproved
set shell=/bin/bash
set backspace=indent,eol,start
set t_Co=256
set list
set listchars=tab:>-,trail:.,nbsp:.
set hidden
set history=100                                             " default history is only 20
set undolevels=100                                          " use more levels of undo
set undofile                                                " save undo's after file closes
set undodir=~/.vim/undos                                    " where to save undo histories
set undoreload=10000
set expandtab
set tabstop=2                                               " a tab is 2 spaces
set softtabstop=2                                           " tab size when insterting/pasting
set shiftwidth=2                                            " number of spaces to use for autoindenting
set shiftround                                              " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab                                                " insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent                                              " always set autoindenting on
set copyindent                                              " copy the previous indentation on autoindenting
set splitbelow
set nofoldenable                                            " dont fold by default
set foldmethod=indent                                       " fold based on indentation
set foldnestmax=10                                          " deepest fold is 10 levels
set foldlevel=1
set foldlevelstart=99
set timeoutlen=1000 ttimeoutlen=0
set fillchars+=fold:\ ,diff:\ ,vert:│
set clipboard=unnamed
set cursorline
set ruler                                                   " ruler on
set nu                                                      " line numbers on
set nobackup                                                " don't use backupfile
set noswapfile
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp         " store swap files here
set incsearch                                               " show search matches as you type
set ignorecase                                              " case insensitive search
set smartcase                                               " if a capital letter is included in search, make it case-sensitive
set background=dark
set visualbell                                              " don't beep
set noerrorbells                                            " don't beep
set laststatus=2
set autoread                                                " auto read when a file is changed on disk
set nowrap
set whichwrap+=<,>,h,l
set formatoptions-=cro
set completeopt-=preview

syntax on
filetype off

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'wkf/base16-vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'puppetlabs/puppet-syntax-vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'elzr/vim-json'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-surround'
NeoBundle 'godlygeek/tabular'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'vim-scripts/scratch.vim'
NeoBundle 'stephpy/vim-yaml'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'chase/vim-ansible-yaml'

NeoBundleCheck

filetype plugin indent on

" change leader from \ to ,
noremap \ ,
let mapleader=','

" normalize Y behavior
nnoremap Y y$

" reset search
nnoremap g/ :let @/ = ""<CR>

" undo from insert mode
inoremap <C-U> <C-G>u<C-U>

" save with ctrl-s
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" map S-Space to F2 in iTerm
map! <silent> <F2> <Space>
map <silent> <F2> 1000<C-u>
map <silent> <Space> 1000<C-d>

" save with sudo
cmap w!! w !sudo tee "%" >/dev/null

au FileType gitcommit setlocal textwidth=80
au FileType gitcommit setlocal spell spelllang=en_us
au BufRead,BufNewFile *.md setlocal spell spelllang=en_us

" stop vim from inserting comments on newlines
au FileType * setlocal formatoptions-=r formatoptions-=o

" strip trailing whitespace on save
au BufWritePre * :%s/\s\+$//e

" strip trailing newlines on save
au BufWritePre * :%s#\($\n\s*\)\+\%$##e

" configure theme
let base16colorspace=256
set background=dark
colorscheme base16-eighties

" configure vim-airline
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'base16'
    let l:dark_grey       = 238
    let l:light_grey      = 251
    let l:airline_warning = ['', '', 'black', 'red', 'bold']

    for p in ['normal', 'insert', 'replace', 'visual']
      let a:palette[p].airline_b       = ['', '', l:light_grey, l:dark_grey]
      let a:palette[p].airline_y       = ['', '', l:light_grey, l:dark_grey]
      let a:palette[p].airline_a[2]    = 'black'
      let a:palette[p].airline_z[2]    = 'black'
      let a:palette[p].airline_warning = l:airline_warning
    endfor

    let a:palette['normal_modified'].airline_c       = ['', '', 'red', '']
    let a:palette['normal_modified'].airline_warning = l:airline_warning
  endif
endfunction

" configure syntastic
let g:syntastic_check_on_open=1

" configure tcomment
let g:tcommentMapLeaderOp1 = ',c'
let g:tcommentMapLeaderOp2 = ',C'

" configure easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_prompt = '{n}> '
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  ? <Plug>(easymotion-sn)
omap ? <Plug>(easymotion-sn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

map  <leader>m <Plug>(easymotion-prefix)
map  <leader>m. <Plug>(easymotion-repeat)
map  <leader>mj <Plug>(easymotion-j)
map  <leader>mk <Plug>(easymotion-k)

" configure neomru
let g:neomru#file_mru_ignore_pattern .= '\|\.\%(git\)'
let g:neomru#file_mru_ignore_pattern .= '\|\%([Vv]im\).*\%(doc\)'
let g:neomru#file_mru_ignore_pattern .= '\|\.\%(fugitiveblame\)$'

" configure unite
let g:unite_source_history_yank_enable = 1
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_rec_max_cache_files=5000
let g:unite_enable_start_insert = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_source_file_rec_max_cache_files = 0

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
endif

call unite#filters#sorter_default#use(['sorter_rank'])
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_mru,file_rec,file_rec/async,grep,buffer,file_mru', 'max_candidates', 0)

nnoremap <leader>t/ :Unite -buffer-name=grep    -no-split grep:.<CR>
nnoremap <leader>ty :Unite -buffer-name=yank    -no-split history/yank<CR>
nnoremap <leader>tt :Unite -buffer-name=file    -no-split file_rec/async:!<CR>
nnoremap <leader>tb :Unite -buffer-name=buffer  -no-split -immediately buffer<CR>
nnoremap <leader>tm :Unite -buffer-name=mru     -no-split file_mru<CR>
nnoremap <leader>tf :Unite -buffer-name=folder  -no-split file file/new directory/new<CR>
nnoremap <leader>tu :Unite -buffer-name=undo    -no-split undo<CR>
nnoremap <leader>ts :Unite -buffer-name=source  -no-split source<CR>
nnoremap <leader>tk :Unite -buffer-name=mapping -no-split mapping<CR>

au FileType unite call s:unite_settings()

function! s:unite_settings()
  imap <buffer> <C-n>   <Plug>(unite_select_next_line)
  imap <buffer> <C-p>   <Plug>(unite_select_previous_line)
  imap <buffer> <C-r>   <Plug>(unite_redraw)

  inoremap <silent><buffer><expr> <C-l> unite#do_action('right')
  inoremap <silent><buffer><expr> <C-h> unite#do_action('left')
  inoremap <silent><buffer><expr> <C-j> unite#do_action('below')
  inoremap <silent><buffer><expr> <C-k> unite#do_action('above')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('preview')

  nmap <buffer> <Esc> <Plug>(unite_exit)
endfunction

" replace netrw with unite directory viewer
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

au BufEnter * call s:explore_directory(expand("<amatch>"))

function! s:explore_directory(dir)
  if a:dir != '' && isdirectory(a:dir)
    bw
    exe 'Unite -buffer-name=folder -no-split -input=' . (a:dir != getcwd() ? a:dir : '') . ' file file/new directory/new'
  endif
endfunction

" this gets set when reading man pages
au StdinReadPre * let s:std_in=1

" when opened without arguments, show most recently used files
au VimEnter * call s:on_vim_enter(expand("<amatch>"))

function! s:on_vim_enter(dir)
  if !exists("s:std_in") && a:dir == ''
    bw
    Unite -buffer-name=mru -no-split file_mru file/new
  elseif isdirectory(a:dir)
    cd %:p:h
  endif
endfunction

" switch to last used buffer
let g:last_buffer = 0
map <leader>b :exe 'b ' . g:last_buffer<CR>

au BufLeave * call s:last_buffer()

function! s:last_buffer()
  if &filetype != 'unite'
    let g:last_buffer = bufnr('%')
  endif
endfunction

" normalize pane switching when inside tmux
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  noremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
  noremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
  noremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
  noremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
  noremap! <silent> <C-h> <ESC>:call TmuxOrSplitSwitch('h', 'L')<CR>
  noremap! <silent> <C-j> <ESC>:call TmuxOrSplitSwitch('j', 'D')<CR>
  noremap! <silent> <C-k> <ESC>:call TmuxOrSplitSwitch('k', 'U')<CR>
  noremap! <silent> <C-l> <ESC>:call TmuxOrSplitSwitch('l', 'R')<CR>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
  map! <C-h> <ESC><C-w>h
  map! <C-j> <ESC><C-w>j
  map! <C-k> <ESC><C-w>k
  map! <C-l> <ESC><C-w>l
endif

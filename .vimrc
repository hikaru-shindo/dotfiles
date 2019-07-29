set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Common
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomtom/tcomment_vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'google/vim-searchindex'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'romainl/vim-cool'
Plug 'wellle/targets.vim'
if has('nvim')
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
else
  Plug 'maralla/completor.vim'
endif
Plug 'sheerun/vim-polyglot'
Plug 'justinmk/vim-dirvish'
Plug 'udalov/kotlin-vim'
call plug#end()

"
" SETTINGS
"

set autoread         " Automatically reload files when changed outside vim
set clipboard^=unnamed               " Copy selected text to the system clipboard
set clipboard^=unnamedplus           " Copy selected text to the system clipboard
set noerrorbells     " Disable the bell (beep or screen flash)
set pastetoggle=<leader>p " Disable all kinds of smartness for pasting
set ttyfast          " Indicate fast terminal for smooth redrawing
set scrolloff=999                    " Keep the cursor centered
set sidescrolloff=8  " Chars to keep while scrolling
set sidescroll=1     " Enable side scrolling
set cmdheight=1      " Force the command height to 1
set spelllang=en_us  " Set default spell check language to English US
set noshowmode       " We show the current mode with airline
set mouse-=a         " We want to copy text normally
set hidden
set signcolumn=yes   " Always show the sign column
set fillchars=""
set updatetime=100   " reduce from default of 4000 for vim-gitgutter
set number
set relativenumber   " Show relative line numbers
set shortmess+=c     " don't give ins-completion-menu messages.
set laststatus=2     " Always show the statusline
set encoding=utf-8   " Necessary to show Unicode glyphs
set termguicolors
set ttimeout
set ttimeoutlen=10
set title titlestring=%{getcwd()}

" Indentation
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Search
set incsearch
set ignorecase
set smartcase
set infercase
set hlsearch
if has('nvim')
  set inccommand=nosplit " Live substitution
endif

" Backups
set nobackup      " Don't make backups before overwriting files
set noswapfile    " Don't use swapfiles
set nowb          " Dont' make backups before writing files

" Persistent Undo
set undodir=~/.vim/backups
set undofile
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo

" Wildmenu completion settings
set wildmenu
set wildmode=list:full                           " Wildcard matches the longest and shows a list
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set switchbuf=useopen,usetab

"
" MAPPINGS
"

let mapleader="\<Space>"
" Make dot work over visual line selections
xnoremap . :norm.<CR>
" Execute a macro over visual line selections
xnoremap Q :'<,'>:normal @q<CR>
if has('nvim')
  nmap <C-Space> <C-^>
else
  nmap <C-@> <C-^>
endif
nmap <silent> <leader>s :vsp <bar> :wincmd l<CR>
nmap <silent> <leader><leader> :FZFMru --no-sort --exact<CR>
nmap <silent> <leader>e :Files<CR>
nmap <silent> <leader>t :Tags<CR>
nmap <silent> <leader>q :nohl <bar> :ccl<CR>
nmap <silent> <leader>Q :cwindow<CR>
nmap <leader>w :w<CR>
nmap <leader>W :wa<CR>
nmap <leader>x :q<CR>
nmap <leader>X :qa<CR>
nmap <leader>ov :e $HOME/.vimrc<CR>
nmap <leader>og :e $HOME/.gitconfig<CR>
nmap <leader>of :e <C-r>=expand("%")<CR>
if has('nvim')
  nmap <leader>ot :term<CR>
else
  nmap <leader>ot :term ++curwin<CR>
endif
nmap <silent> <leader>n :Dirvish %:p:h<CR>
nmap <silent> <leader>N :Dirvish<CR>
nmap <silent> <leader>c :let @+ = expand("%")<CR>
nmap <silent> <leader>C :let @+ = expand("%:p")<CR>
nmap <leader>f :Ack!<Space>
nmap <leader>F :Ack! <C-r>=fnameescape(@+)<CR>
xnoremap <leader>f "0y:Ack! <C-r>=fnameescape(@0)<CR><CR>
if has('nvim')
  nmap <leader>r <Plug>(coc-rename)
  nmap <silent> <leader>gd <Plug>(coc-definition)
  nmap <silent> <leader>gy <Plug>(coc-type-definition)
  nmap <silent> <leader>gi <Plug>(coc-implementation)
  nmap <silent> <leader>gr <Plug>(coc-references)
  nmap [c <Plug>(coc-git-prevchunk)
  nmap ]c <Plug>(coc-git-nextchunk)
  nmap <leader>vs <Plug>(coc-git-chunkinfo)
  nmap <leader>vc <Plug>(coc-git-commit)
  inoremap <silent><expr> <c-space> coc#refresh()
  nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
  nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
  nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
  nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
  nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
  nnoremap <silent> <leader>lr  :<C-u>CocListResume<CR>
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
endif
cmap w!! w !sudo tee % >/dev/null
" Quick insert mode exit
inoremap jk <esc>
" Stop that damn ex mode
nnoremap Q <nop>
" completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" FZF
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0
  \| autocmd BufLeave <buffer> set laststatus=2
let g:fzf_mru_relative = 1
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Dirvish
let g:dirvish_mode = 'sort i | sort ri /^.*[^\/]$/'
let g:dirvish_relative_paths = 1
augroup dirvish_config
  autocmd!
  " Default for key 'o' is split, I like 'o' to open in current window
  autocmd FileType dirvish silent! nnoremap <nowait><buffer><silent> o :<C-U>.call dirvish#open("edit", 0)<CR>
augroup END

" Color scheme
syntax enable
highlight DiffAdd    guifg=#009900 guibg=#2D2E27 ctermfg=2 ctermbg=235
highlight DiffChange guifg=#bbbb00 guibg=#2D2E27 ctermfg=3 ctermbg=235
highlight DiffDelete guifg=#ff2222 guibg=#2D2E27 ctermfg=1 ctermbg=235
highlight VertSplit  ctermbg=NONE guibg=NONE
highlight Special    guifg=#E8E8E3 guibg=#272822 ctermfg=252 ctermbg=234
" for Neovim
let g:terminal_color_0 = '#272822'
let g:terminal_color_1 = '#f92672'
let g:terminal_color_2 = '#a6e22e'
let g:terminal_color_3 = '#f4bf75'
let g:terminal_color_4 = '#66d9ef'
let g:terminal_color_5 = '#ae81ff'
let g:terminal_color_6 = '#a1efe4'
let g:terminal_color_7 = '#f8f8f2'
let g:terminal_color_8 = '#75715e'
let g:terminal_color_9 = '#f92672'
let g:terminal_color_10 = '#a6e22e'
let g:terminal_color_11 = '#f4bf75'
let g:terminal_color_12 = '#66d9ef'
let g:terminal_color_13 = '#ae81ff'
let g:terminal_color_14 = '#a1efe4'
let g:terminal_color_15 = '#f9f8f5'
" for Vim
let g:terminal_ansi_colors = [
\ '#272822',
\ '#f92672',
\ '#a6e22e',
\ '#f4bf75',
\ '#66d9ef',
\ '#ae81ff',
\ '#a1efe4',
\ '#f8f8f2',
\ '#75715e',
\ '#f92672',
\ '#a6e22e',
\ '#f4bf75',
\ '#66d9ef',
\ '#ae81ff',
\ '#a1efe4',
\ '#f9f8f5',
\ ]

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'term'
let g:airline_detect_modified = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#branch#enabled = 0
function! AirlineInit()
  call airline#parts#define_raw('modified', '%{&modified ? " (modified)" : ""}')
  call airline#parts#define_accent('modified', 'red')
  let g:airline_section_c = airline#section#create(['%f', 'modified'])
endfunction
autocmd VimEnter * call AirlineInit()
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" Ack
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading --smart-case'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
let g:ackhighlight = 1

" Open help vertically
command! -nargs=* -complete=help H :enew | :set buftype=help | :keepalt h <args>
autocmd FileType help wincmd L

" ALE
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ }
let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_info = '●'
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_echo_cursor = 0
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '  '
hi ALEErrorSign   ctermfg=Red      ctermbg=235 guibg=#2D2E27 guifg=#FF0000
hi ALEWarningSign ctermfg=DarkCyan ctermbg=235 guibg=#2D2E27 guifg=#00FFFF
hi ALEInfoSign    ctermfg=59       ctermbg=235 guibg=#2D2E27 guifg=#75715E
hi ALEVirtualTextError   ctermfg=Red      ctermbg=235 guibg=#2D2E27 guifg=#FF0000
hi ALEVirtualTextWarning ctermfg=DarkCyan ctermbg=235 guibg=#2D2E27 guifg=#00FFFF
hi ALEVirtualTextInfo    ctermfg=59       ctermbg=235 guibg=#2D2E27 guifg=#75715E
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'go': ['goimports'],
  \ }

" COC
if has('nvim')
  let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-eslint',
    \ 'coc-tsserver',
    \ 'coc-git',
  \ ]
  " https://github.com/neoclide/coc.nvim/blob/master/data/schema.json
  let g:coc_user_config = {
    \ 'javascript.suggestionActions.enabled': v:false,
    \ 'javascript.validate.enable': v:false,
    \ 'eslint.options': {
      \ 'rules': {
        \ 'prettier/prettier': 'off',
      \ },
    \ },
    \ 'diagnostic': {
      \ 'errorSign': '●',
      \ 'warningSign': '●',
      \ 'infoSign': 'i',
      \ 'hintSign': 'h',
      \ 'virtualText': v:true,
      \ 'virtualTextPrefix': '  ',
      \ 'enableMessage': 'never',
    \ }
  \ }
  hi CocErrorSign   ctermfg=Red      ctermbg=235 guibg=#2D2E27 guifg=#FF0000
  hi CocWarningSign ctermfg=DarkCyan ctermbg=235 guibg=#2D2E27 guifg=#00FFFF
  hi CocInfoSign    ctermfg=59       ctermbg=235 guibg=#2D2E27 guifg=#75715E
  hi CocHintSign    ctermfg=59       ctermbg=235 guibg=#2D2E27 guifg=#75715E
  hi CocFloating    ctermfg=252      ctermbg=235 guibg=#383830 guifg=#E8E8E3
  let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
  let g:airline_section_b = "%{trim(get(b:,'coc_git_status',''))}"
endif

" jump to last known cursor pos when reopening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

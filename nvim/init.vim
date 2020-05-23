" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" auto install plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Configure backup, swap, undodir directory
" <
if !exists("g:vimdirs_vimhome")
  let g:vimdirs_vimhome = $HOME.'/.config/nvim/'
endif

if !exists("g:vimdirs_temp")
  let g:vimdirs_temp = g:vimdirs_vimhome."temp"
endif

if !exists("g:vimdirs_backup")
  let g:vimdirs_backup = g:vimdirs_vimhome."backup"
endif

if !exists("g:vimdirs_undo")
  let g:vimdirs_undo = g:vimdirs_vimhome."undo"
endif

if has("unix") || has("mac")
    if !isdirectory(g:vimdirs_vimhome)
        call mkdir(g:vimdirs_vimhome)
    endif
    if !isdirectory(g:vimdirs_vimhome."backup")
        call mkdir(g:vimdirs_vimhome."backup","p")
    endif
    if !isdirectory(g:vimdirs_vimhome."temp")
        call mkdir(g:vimdirs_vimhome."temp","p")
    endif
    if !isdirectory(g:vimdirs_vimhome."undo")
        call mkdir(g:vimdirs_vimhome."undo","p")
    endif
    execute "set directory=".escape(g:vimdirs_temp, ' ').'//'
    execute "set backupdir=".escape(g:vimdirs_backup, ' ').'//'
    execute "set undodir=".escape(g:vimdirs_undo, ' ').'//'
    set undofile
    set backup
endif
" >

" plugins
if has('nvim')
  call plug#begin(g:vimdirs_vimhome.'plugged')
endif

" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'                                            " Undo Tree
Plug 'junegunn/rainbow_parentheses.vim'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'dracula/vim', { 'as': 'dracula' }

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'

Plug 'godlygeek/tabular'                                          " Alignment
Plug 'henrik/vim-indexed-search'                                  " Show N of M matches during search
Plug 'Townk/vim-autoclose'                                        " Auto close parens
Plug 'kshenoy/vim-signature'                                      " Mark gutter
" Plug 'Yggdroot/indentLine'
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-surround'
" Plug 'junegunn/goyo.vim'
" Plug 'tpope/vim-repeat'
" Plug 'mhinz/vim-startify'
" Plug 'dylanaraps/wal.vim'
call plug#end()

" Plugin settings
let g:secure_modelines_allowed_items = [
      \ "textwidth",   "tw",
      \ "softtabstop", "sts",
      \ "tabstop",     "ts",
      \ "shiftwidth",  "sw",
      \ "expandtab",   "et",   "noexpandtab", "noet",
      \ "filetype",    "ft",
      \ "foldmethod",  "fdm",
      \ "readonly",    "ro",   "noreadonly", "noro",
      \ "rightleft",   "rl",   "norightleft", "norl",
      \ "colorcolumn"
      \ ]

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Color
color dracula

" =============================================================================
" # Editor settings
" =============================================================================
syntax on
filetype plugin indent on
set autoindent                           " Always set autoindenting on
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf8                        " Set standard file encoding
set nomodeline                           " No special per file vim override configs
set nowrap                               " Stop word wrapping

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set ignorecase                           " Ignore case when searching
set smartcase                            " Ignore case if search pattern is all lowercase
set incsearch                            " Show search matches as you type

autocmd FileType markdown setlocal wrap  " Except... on Markdown. That's good stuff.

set tabstop=2                            " A tab is four spaces
set smarttab                             " Insert tabs on the start of a line according to shiftwidth, not tabstop
set copyindent                           " Copy the previous indentation on autoindenting
set shiftwidth=2                         " Number of spaces to use forautoindenting
set shiftround                           " Use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                            " Set show matching parenthesis
set expandtab
set conceallevel=1                       " Don't let Vim hide characters or make loud dings
set noerrorbells
set number                               " Number gutter
set hlsearch                             " Use search highlighting
set scrolloff=2                          " Space above/beside cursor from screen edges
set sidescrolloff=5
set nofoldenable                         " Disable folding
set nolazyredraw                         " Disable lazyredraw

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" disable mouse support
set mouse=r
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Ctrl+c and Ctrl+j as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
inoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
snoremap <C-c> <Esc>
xnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
onoremap <C-c> <Esc>
lnoremap <C-c> <Esc>
tnoremap <C-c> <Esc>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" racer + rust
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Quick-save
nmap <leader>w :w<CR>

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Return to last file opened
nmap <Leader><Leader> <c-^>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC configuration
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <C-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>

" Indent
let g:indentLine_enabled = 1
let g:indentLine_char = "⟩"

" CtrlP settings
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>t :CtrlP<CR>

" Fuzzy searcher
nnoremap <Leader>fp :Grepper<Space>-query<Space>
nnoremap <Leader>fb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

set relativenumber
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {}
" Enable completion where available.
let g:ale_completion_enabled = 1


" =============================================================================
" # Editor settings
" =============================================================================

" fzf maps
let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores --ignore .git -l -g ""'
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap \ :Buffers<CR>
" nmap <Leader>t :Files<CR>
" nmap <Leader>r :Tags<CR>
" nmap <Leader>c :Commits<CR>

"                           Search open buffers
nnoremap <leader>fb         :Buffers<CR>
"                           Search buffer commits
nnoremap <leader>fc         :BCommits<CR>
"                           Search commits
nnoremap <leader>fC         :Commits<CR>
"                           Search changed files
nnoremap <leader>fd         :GFiles?<CR>
"                           Search v:oldfiles and open buffers
nnoremap <leader>fe         :History<CR>
"                           Search all tags
nnoremap <leader>fe         :History<CR>
"                           Search lines in current buffer
nnoremap <leader>fl         :BLines<CR>
"                           Search lines in loaded buffers
nnoremap <leader>fL         :Lines<CR>
"                           Search marks
nnoremap <leader>fm         :Marks<CR>
"                           Search marks
nnoremap <leader>fM         :Maps<CR>
"                           Search git files
nnoremap <leader>fo         :GFiles<CR>
"                           Search all files
nnoremap <leader>fO         :Files<CR>
"                           Search buffer tags
nnoremap <leader>ft         :BTags<CR>
"                           Search all tags
nnoremap <leader>fT         :Tags<CR>
"                           Search windows
nnoremap <leader>fw         :Windows<CR>

let g:fzf_layout = { 'window': 'enew' }
let g:fzf_buffers_jump = 1
let g:fzf_height = 10

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Remap Space p to Find using fzf
nmap <Leader>p :Find<Space>

" Add counts of find
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" Used for expand region
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" Remap sneak to f
map f <Plug>Sneak_s
map F <Plug>Sneak_S

augroup interoMaps
  au!

  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  au FileType haskell map <leader>t <Plug>InteroGenericType
  au FileType haskell map <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>
  au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

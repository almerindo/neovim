" Specify a directory for plugins.
call plug#begin(stdpath('data') . '/plugged')

  " Appearance
  Plug 'vim-airline/vim-airline'
  Plug 'ryanoasis/vim-devicons'
  Plug 'martinsione/darkplus.nvim'

  " Utilities
  Plug 'sheerun/vim-polyglot'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ap/vim-css-color'
  Plug 'preservim/nerdtree'
  Plug 'kien/ctrlp.vim'

  " Completion / linters / formatters
  Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}
  Plug 'plasticboy/vim-markdown'

  " Git
  Plug 'airblade/vim-gitgutter'

  " Terminal toggle buffer
  Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

  " Initialize plugin system.
call plug#end()

" Initial Options

" Options
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu
colorscheme darkplus
set background=dark


" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

" Sintax
filetype plugin indent on
syntax on

" Terminal Colors
set t_Co=256

" True color if available
let term_program=$TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
	set termguicolors
else
	if $TERM !=? 'xterm-256color'
		set termguicolors
	endif
endi

" Italic support
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"


augroup auto_commands
	autocmd filetype netrw call Netrw_mappings()
augroup END

let g:airline_theme='darkplus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" NERTTRee
let NERDTreeShowHidden=1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


lua require("toggleterm").setup()


augroup auto_commands
	autocmd BufWrite *.py call CocAction('format')
augroup END

"" Shortcuts
let mapleader = "\<Space>"

" Close
nnoremap <Leader>q :q!<CR>

" File Bar
nnoremap <Leader>n :NERDTreeMirror<CR>:NERDTreeToggle<CR>

" Tab Navigator Handler
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>

" Terminal Buffer Handler
nnoremap <Leader>t :ToggleTerm direction=horizontal<CR>
nnoremap <Leader>tv :ToggleTerm direction=vertical size=40<CR>
nnoremap <Leader>ts :TermSelect <CR>
nnoremap <Leader>ta :ToggleTermToggleAll<CR>


" Enable line numbers
set number

" Enable syntax highlighting
syntax enable

" Tab
set ts=4 sts=4 sw=4 expandtab
set mouse=a

" Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' 

Plug 'akinsho/bufferline.nvim'

call plug#end()

" COC

" Make <Tab> used for trigger completion, completion confirm, snippet expand and jump

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

map <a-cr> :CocAction<CR>

" Close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" NERDTree 
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Paste mode
set pastetoggle=<F3>

" Check syntax highlighting group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Clipboard
set clipboard+=unnamedplus

" Wildmode
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

" Automatically change working directory when opening NeoVim
set autochdir

" Prevent NeoVim from wrapping lines in the middle of a word
set linebreak

" Auto source when writing to init.vm alternatively you can run :source $MYVIMRCi
au! BufWritePost $MYVIMRC source %      

nnoremap <F5> :QuickRun<CR>

" bufferline.nvim
lua << EOF
require("bufferline").setup{}
EOF

" Move cursor by display lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
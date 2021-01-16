unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set nocompatible
set hidden
set encoding=utf-8
set autowrite
set autowriteall

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/neovimhaskell/haskell-vim'
Plug 'vim-syntastic/syntastic'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-dadbod'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim', {'dir': '~/.fzf', 'do':'./install --all'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'liuchengxu/space-vim-dark'
call plug#end()
"nerd tree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" airline
let g:airline_powerline_fonts = 1
set t_Co=256
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" prettier
"autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

let g:Tex_FoldedSections = ""
let g:Tex_FoldedEnvironments = ""
let g:Tex_FoldedMisc = ""
let mapleader = " "
set clipboard=unnamedplus
filetype plugin on
filetype plugin indent on
let g:hident_on_save = 1
set number
syntax on
"hi Normal ctermbg=0 guibg=#000000
"set background=dark
"colorscheme spacemacs-theme
colorscheme SpaceMacs
"
"colorscheme space-vim-dark
"hi Comment cterm=italic



set tags=/home/chai/code/Kairos/tags

set tabstop =4
set expandtab
"set softtabstop=2
set softtabstop=2
"set shiftwidth=2
set shiftwidth=2
set shiftround


" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e


"search
nnoremap <C-g> :GFiles?<CR>
nnoremap <C-h> :History<CR>
nnoremap <C-l> :Rg<CR>
nnoremap <C-b> :BLines<CR>
nnoremap <C-p> :All<CR>
nnoremap <leader>b :Buffers<CR>
"set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
let g:fzf_preview_window = ['up:50%:hidden', 'ctrl-/']
command! -bang -nargs=*  All
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*}"', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse' }))

"count occurences of last search
nnoremap <leader>n :%s///gn <CR>

"buffers
map <leader>0 :bn<cr>
map <leader>9 :bp<cr>
map <leader>3 :b#<cr>
map <leader>4 ":b "
nnoremap <C-x> :bd<cr>

" syntastic settings
map <Leader>s :SyntasticToggleMode<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jsl']

" CoC extensions
let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json']

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

nmap <silent><leader>g <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>d  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>f  <Plug>(coc-fix-current)


" Spellcheck for features and markdown
au BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.md.erb setlocal spell
au BufRead,BufNewFile *.feature setlocal spell

" tabular stuff:
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
nnoremap <Leader>t= :Tabularize /=<CR>
vnoremap <Leader>t= :Tabularize /=<CR>
nnoremap <Leader>t: :Tabularize /:\zs<CR>
vnoremap <Leader>t: :Tabularize /:\zs<CR>

"  folds:
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2
nmap z za


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" multicursor

let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-m>'
let g:multi_cursor_select_all_word_key = '<C-a>'
let g:multi_cursor_start_key           = 'g<C-m>'
let g:multi_cursor_select_all_key      = 'g<C-a>'
let g:multi_cursor_next_key            = '<C-m>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
let g:multi_cursor_exit_from_visual_mode   = 0
let g:multi_cursor_exit_from_insert_mode   = 0


"wrapping selections
vnoremap \ l<ESC>xgvoh<ESC>x
command! -nargs=1 -range Wrap :normal! `<<ESC>i<args><ESC>`>l<ESC>a<args><ESC>
vnoremap ? :Wrap

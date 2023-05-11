with import <nixpkgs> {};
#{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs {} }:
# let coc = callPackage ./coc-new.nix { pkgs-unstable = pkgs; };
let coc = callPackage ./coc-plugin.nix {};
    pkgs-unstable = import <pkgs-unstable> {};
in
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  withNodeJs = true;
  plugins = with pkgs.vimPlugins; [
    argtextobj-vim
    auto-pairs
    camelcasemotion
    coc
    direnv-vim
    fzfWrapper
    emmet-vim
    fzf-vim
    haskell-vim
    i3config-vim
    Jenkinsfile-vim-syntax
    # nvim-surround
    # neoformat
    papercolor-theme
    PreserveNoEOL
    # supertab
    syntastic
    tabular
    typescript-vim
    vim-addon-nix
    vim-airline
    vim-airline-themes
    vim-commentary
    vim-css-color
    vim-floaterm
    vim-javascript
    vim-jsx-pretty
    vim-markdown
    vim-nix
    # vim-plug
    vim-terraform
  ];
  extraConfig = ''
" Put plugins and dictionaries in this directory
" let vimDir = expand('$XDG_CONFIG_HOME/nvim')
" let vimPlugFile = vimDir . '/autoload/plug.vim'

" Install vim-plug if not present
"if empty(glob(vimPlugFile))
    " There is no vim-plug file → Download and install it"
"    let vimPlugUrl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"    exec '!curl -fLo ' . vimPlugFile . ' --create-dirs ' . vimPlugUrl
"    autocmd VimEnter * PlugInstall
" endif

" call plug#begin()
  "      Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
" call plug#end()

    unlet! skip_defaults_vim
    "source $VIMRUNTIME/defaults.vim

    set noendofline
    set nofixendofline
    set nocompatible
    set hidden
    set encoding=utf-8
    set mouse=nv
    set nofoldenable

    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.github

    let g:PreserveNoEOL = 1

    " Camelcase
    let g:camelcasemotion_key = '<leader>'



    " airline
    let g:airline_powerline_fonts = 1
    set t_Co=256
    let g:airline_theme='luna'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_alt_sep = '|'

    " prettier
    "autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

    let g:Tex_FoldedSections = ""
    let g:Tex_FoldedEnvironments = ""
    let g:Tex_FoldedMisc = ""
    let mapleader = " "
    set clipboard+=unnamedplus
    filetype plugin on
    filetype plugin indent on
    let g:hident_on_save = 1
    set number
    syntax on

    set background=dark
    colorscheme PaperColor
    " colorscheme SpaceMacs

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
    nnoremap <leader>v :Buffers<CR>
    "set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
    let g:fzf_preview_window = ['up:50%:hidden', 'ctrl-/']
    command! -bang -nargs=*  All
      \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*}"', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse' }))

    "======================== copied from source: https://github.com/junegunn/fzf.vim/blob/master/plugin/fzf.vim ============
    "======================== can possibly be removed  after update =========================================================
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>),
      \ 1, s:p(), <bang>0)

    command! -bang -nargs=* History
      \ call s:history(<q-args>, s:p(), <bang>0)'])

    command! -bar -bang -nargs=? -complete=buffer Buffers
      \ call fzf#vim#buffers(<q-args>, s:p({ "placeholder": "{1}" }), <bang>0)

    function! s:p(...)
      let preview_args = get(g:, 'fzf_preview_window', ['right', 'ctrl-/'])
      if empty(preview_args)
        return { 'options': ['--preview-window', 'hidden'] }
      endif

      " For backward-compatiblity
      if type(preview_args) == type("")
        let preview_args = [preview_args]
      endif
      return call('fzf#vim#with_preview', extend(copy(a:000), preview_args))
    endfunction

    function! s:history(arg, extra, bang)
      let bang = a:bang || a:arg[len(a:arg)-1] == '!'
      if a:arg[0] == ':'
        call fzf#vim#command_history(bang)
      elseif a:arg[0] == '/'
        call fzf#vim#search_history(bang)
      else
        call fzf#vim#history(a:extra, bang)
      endif
    endfunction

    "=====================================================================================================================
    "=====================================================================================================================

    "Floaterm
    let g:floaterm_opener = 'edit'
    vnoremap <leader>m :FloatermNew --autoclose=2 vifm<CR>
    nnoremap <leader>m :FloatermNew --autoclose=2 vifm<CR>

    "buffers
    map <leader>0 :bn<cr>
    map <leader>9 :bp<cr>
    map <leader>3 :b#<cr>
    map <leader>4 ":b "
    nnoremap <C-x> :bd<cr>

    "============================= C O C ===================================================="


    " CoC extensions
    let g:coc_global_extensions = ['coc-solargraph', 'coc-json', 'coc-html', 'coc-tsserver', 'coc-xml', 'coc-prettier', 'coc-eslint', 'coc-angular']

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
    " delays and poor user experience
    set updatetime=300

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved
    set signcolumn=yes

    " Add CoC Prettier if prettier is installed
    if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
      let g:coc_global_extensions += ['coc-prettier']
    endif

    " Add CoC ESLint if ESLint is installed
    if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
      let g:coc_global_extensions += ['coc-eslint']
    endif

    nmap <silent><leader>g <Plug>(coc-definition)
    nmap <leader>t <Plug>(coc-type-definition)
    nmap <leader>i <Plug>(coc-implementation)
    nmap <leader>w <Plug>(coc-references)
    nmap <leader>r <Plug>(coc-rename)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>d  <Plug>(coc-codeaction)
    nmap <leader>k  <Plug>(coc-codeaction-selected)w
    nmap <leader>j  <Plug>(coc-codeaction-line)
    nmap <leader>h  <Plug>(coc-codeaction-cursor)
    " Apply AutoFix to problem on the current line.
    nmap <leader>f  <Plug>(coc-fix-current)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    "============================= C O C ===================================================="

    " Spellcheck for features and markdown
    au BufRead,BufNewFile *.md setlocal spell
    au BufRead,BufNewFile *.md.erb setlocal spell
    au BufRead,BufNewFile *.feature setlocal spell

    " tabular stuff:
    inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

    function! s:align()
      let p = "^\s*|\s.*\s|\s*$"
      if exists(":Tabularize") && getline(".") =~# "^\s*|" && (getline(line(".")-1) =~# p || getline(line(".")+1) =~# p)
        let column = strlen(substitute(getline(".")[0:col(".")],"[^|]","","g"))
        let position = strlen(matchstr(getline(".")[0:col(".")],".*|\s*\zs.*"))
        Tabularize/|/l1
        normal! 0
        call search(repeat("[^|]*|",column)."\s\{-\}".repeat(".",position),"ce",line("."))
      endif
    endfunction
    nnoremap <Leader>t= :Tabularize /=<CR>
    vnoremap <Leader>t= :Tabularize /=<CR>
    nnoremap <Leader>t: :Tabularize /:\zs<CR>
    vnoremap <Leader>t: :Tabularize /:\zs<CR>

    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    "wrapping selections
    vnoremap \ l<ESC>xgvoh<ESC>x
    command! -nargs=1 -range Wrap :normal! `<<ESC>i<args><ESC>`>l<ESC>a<args><ESC>
    vnoremap ? :Wrap

    "wipe all registers
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
    nmap <leader>c :WipeReg<CR>

    "count occurences of last search
    nnoremap <leader>n :%s///gn <CR>

    "syntastic
    let g:syntastic_check_on_open = 0

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
    nnoremap <leader>w :SyntasticCheck<CR>

    "commenting
    nnoremap ff :Commentary<CR>
    vnoremap ff :Commentary<CR>
    vnoremap fg $%:Commentary<CR>

    "emmet
    let g:user_emmet_install_global = 0
    autocmd FileType html,css EmmetInstall
    let g:user_emmet_leader_key=','

    "nnoremap w <ESC>

    "Enter and Space in normal / visual mode
    nnoremap <CR> <Esc>
    vnoremap a <ESC>a
    vnoremap i <ESC>i

    "moving selections up down
    xnoremap <C-S-Up> xkP`[V`]
    xnoremap <C-S-Down> xp`[V`]
    xnoremap <C-S-Left> <gv
    xnoremap <C-S-Right> >gv

    function! MoveLineAndInsert(n)       " -x=up x lines; +x=down x lines
      let n_move = (a:n < 0 ? a:n-1 : '+'.a:n)
      let pos = getcurpos()
      try         " maybe out of range
          exe ':move'.n_move
          call setpos('.', [0,pos[1]+a:n,pos[2],0])
      finally
          startinsert
      endtry
    endfunction
    inoremap <C-S-Up> <Esc>`^:silent! call MoveLineAndInsert(-1)<CR>
    inoremap <C-S-Down> <Esc>`^:silent! call MoveLineAndInsert(+1)<CR>

    "run @q in visual block
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction


  '';
}

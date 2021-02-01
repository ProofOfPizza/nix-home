with import <nixpkgs> {};
#{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs {} }:
let coc = callPackage ./coc-plugin.nix {};
in
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  withNodeJs = true;
  plugins = with pkgs.vimPlugins; [
    auto-pairs
    coc
    direnv-vim
    fzfWrapper
    fzf-vim
    haskell-vim
    Jenkinsfile-vim-syntax
    nerdtree
    supertab
    syntastic
    tabular
    typescript-vim
    vim-addon-nix
    vim-airline
    vim-airline-themes
    vim-commentary
    vim-javascript
    vim-jsx-pretty
    vim-surround
  ];
  extraConfig = ''
    unlet! skip_defaults_vim
    "source $VIMRUNTIME/defaults.vim

    set nocompatible
    set hidden
    set encoding=utf-8
    set mouse=nv

-   "nerd tree
    map <C-n> :NERDTreeToggle<CR>
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

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
    set clipboard=unnamedplus
    filetype plugin on
    filetype plugin indent on
    let g:hident_on_save = 1
    set number
    syntax on
    colorscheme SpaceMacs

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
    nmap <leader>t <Plug>(coc-type-definition)
    nmap <leader>i <Plug>(coc-implementation)
    nmap <silent>w <Plug>(coc-references)
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

    "wrapping selections
    vnoremap \ l<ESC>xgvoh<ESC>x
    command! -nargs=1 -range Wrap :normal! `<<ESC>i<args><ESC>`>l<ESC>a<args><ESC>
    vnoremap ? :Wrap

    "wipe all registers
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
    nmap <leader>c :WipeReg<CR>

    "count occurences of last search
    nnoremap <leader>n :%s///gn <CR>

    " commenting
    vnoremap <C-/> gc
    nnoremap <C-/> gc

    " Enter and Space in normal / visual mode
    nnoremap <CR> <Esc>
    vnoremap a <ESC>a
    vnoremap i <ESC>i

  '';
}

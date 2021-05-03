{
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "viins";
    #dotDir = "./.config/nixpkgs/program/shell/zsh";
    history = {
      size = 10000;
      save = 10000;
      path = "./zsh_history";
     };
    shellAliases = {
      backend = "gf; x=$(docker ps -a -q); docker stop $x; if [ ! -z '$x' ]; then docker rm $x; fi; npm run start:be";
      backend-all = "gf; x=$(docker ps -a -q); docker stop $x; if [ ! -z '$x' ]; then docker rm $x; fi; docker system prune --all --force; docker system prune --volumes --force; npm run build:be; npm run start:be";
      backend-build = "gf; npm run build:be && npm run start:be";
      backup_config = "~/.scripts/backup_config.sh";
      cases = "gk; cd src/seeds; npm run seed:testdata";
      cc="rm -rf ~/.config/Cypress";
      cfb = "vim ~/.bashrc";
      cfi = "vim ~/.config/nixpkgs/program/window-manager/i3/config";
      cfv = "vim ~/.config/nixpkgs/program/editor/neovim/default.nix";
      cfx = "vim ~/.Xresources";
      cfz = "vim ~/.config/nixpkgs/program/shell/zsh/default.nix";
      conflicts = "git diff --name-only --diff-filter=U";
      die = "pkill -i $1 -f";
      dstop = "docker stop $(docker ps -q); docker rm --force $(docker ps -a -q); docker rmi --force $(docker images -q)";
      frontend = "gf; npm start;";
      fzfi = "rg --files --hidden --follow --no-ignore-vcs -g '!{node_modules,.git}' | fzf";
      ga = "cd ~/Nextcloud/Documents/music/AntiforZ && r";
      gc = "~/code/Kairos/src/e2e-cypress";
      gd = "cd ~/Downloads && r";
      gdev = "cd ~/Nextcloud/Documents/nerdspul/werkspul/dev-division && r";
      gf = "cd ~/code/Kairos/src/front-ends/kairos-portal && ls -a";
      gfo = "cd ~/code/Kairos/src/front-ends/kairos-portal && o";
      gfr = "cd ~/code/Kairos/src/front-ends/kairos-portal && r";
      gh = "cd ~ && r";
      gk = "cd ~/code/Kairos && r";
      gko = "cd ~/code/Kairos && o";
      gn = "cd ~/Nextcloud/Documents && r";
      gt = "cd ~/code/Kairos/src/e2e && ls -a";
      gto = "cd ~/code/Kairos/src/e2e && o";
      gtr = "cd ~/code/Kairos/src/e2e && r";
      kk = "kill -9 $(pgrep KeeWeb)";
      kswp = "cd ~/.cache/vim/swap && rm *.* && ls -a";
      nx = "~/.config/nixpkgs";
      nxo = "nx && o";
      nxr = "nx && r";
      o = "x=$(fzfi);vim $x";
      r = "vicd ./";
      seed = "x=$(pwd); cd ~/code/Kairos/src/seeds; npm run seed:userdata; cd $x";
      seed-all = "x=$(pwd); cd ~/code/Kairos/src/seeds; npm run seed:userdata; npm run seed:testdata; cd $x";
      seed-db = "x=$(pwd); cd ~/code/Kairos/src/seeds; npm run seed:createDb; cd $x";
      swp = "cd ~/.cache/vim/swap && ls -a";
      vimii = "x='/home/chai/.vim/pack/coc/start'; if [ ! -d '$x' ]; then mkdir -p $x && cd $x && git clone 'git@github.com:neoclide/coc.nvim.git'; fi; echo 'check je vim alias voor coc bs' && nvim";
      x = "exit";
      xc = "xclip_in";
      z = "alacritty --working-directory $(pwd)";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "git"
      ];
    theme = "agnoster";
    extraConfig = ''
      export FZF_DEFAULT_OPTS="-m"
      FZF_DEFAULT_OPTS+=" --color='light'"
      FZF_DEFAULT_OPTS+=" --bind 'ctrl-/:toggle-preview'"
      FZF_DEFAULT_OPTS+=" --preview 'head -500 {}' --height 80%"
      FZF_DEFAULT_OPTS+=" --preview-window=up:40%:hidden"
      FZF_DEFAULT_OPTS+=" --height=80%"
      FZF_DEFAULT_OPTS+=" --layout=reverse"
      FZF_DEFAULT_OPTS+=" --border"
      export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export jenkinshost='ec2-18-222-22-215.us-east-2.compute.amazonaws.com'

      export KEYTIMEOUT=1

      # Change cursor shape for different vi modes.
      function zle-keymap-select {
        if [[ ''\${KEYMAP} == vicmd ]] ||
          [[ $1 = 'block' ]]; then
          echo -ne '\e[1 q'
        elif [[ ''\${KEYMAP} == main ]] ||
            [[ ''\${KEYMAP} == viins ]] ||
            [[ ''\${KEYMAP} = "" ]] ||
            [[ $1 = 'beam' ]]; then
          echo -ne '\e[3 q'
        fi
      }
      zle -N zle-keymap-select
      zle-line-init() {
          echo -ne "\e[5 q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

      function awsl()
      {
        server=$1
        ssh_file=''\${2:-~/.ssh/devops.pem}
        login=ec2-user@$server
        echo $login
        ssh -i $ssh_file $login -y
      }

      function xclip_in()
      {
        cat $1 | xclip -i -selection clipboard
      }

      vicd()
      {
        local dst="$(command vifm --choose-dir - "$@")"
        if [ -z "$dst" ]; then
          echo 'Directory picking cancelled/failed'
          return 1
        fi
        cd "$dst"
      }
      eval "$(direnv hook zsh)"
    '';
   };
}

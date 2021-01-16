{
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "viins";
    #dotDir = "./.config/nixpkgs/program/shell/zsh";
    history = {
      size = 1000;
      save = 1000;
      path = "./zsh_history";
     };
    shellAliases = {
      vim = "nvim";
      fzfi = "rg --files --hidden --follow --no-ignore-vcs -g '!{node_modules,.git}' | fzf";
      o = "vim $(fzfi)";
      r = "vicd ./";
      x = "exit";
      ghr= "cd ~ && r";
      gh = "cd ~ && ls -a";
      gfo = "cd ~/code/Kairos/src/front-ends/kairos-portal && o";
      gfr = "cd ~/code/Kairos/src/front-ends/kairos-portal && r";
      gf = "cd ~/code/Kairos/src/front-ends/kairos-portal && ls -a";
      gto = "cd ~/code/Kairos/src/e2e && o";
      gtr = "cd ~/code/Kairos/src/e2e && r";
      gt = "cd ~/code/Kairos/src/e2e && ls -a";
      gko = "cd ~/code/Kairos && o";
      gkr = "cd ~/code/Kairos && r";
      gk = "cd ~/code/Kairos && ls -a";
      gnr = "cd ~/Nextcloud/Documents && r";
      gn = "cd ~/Nextcloud/Documents && ls -a";
      gdev = "cd ~/Nextcloud/Documents/nerdspul/werkspul/dev-division && r";
      ga = "cd ~/Nextcloud/Documents/music/AntiforZ && r";
      gd = "cd ~/Downloads && r";
      swp = "cd ~/.cache/vim/swap && ls -a";
      kswp = "cd ~/.cache/vim/swap && rm *.* && ls -a";
      cfv = "vim ~/.vim/vimrc";
      cfb = "vim ~/.bashrc";
      cfz = "vim ~/.zshrc";
      cfi = "vim ~/.i3/config";
      cfx = "vim ~/.Xresources";
      backup_config = "~/.scripts/backup_config.sh";
      kk = "kill -9 $(pgrep KeeWeb)";
      die = "pkill -i $1 -f";
      backend = "gf; x=$(docker ps -a -q); docker stop $x; if [ ! -z '$x' ]; then docker rm $x; fi; npm run start:be";
      conflicts = "git diff --name-only --diff-filter=U";
      frontend = "gf; pkill -i selenium -f; cd ../../e2e && npm run webdriver && cd ../front-ends/kairos-portal && npm start;";
      backend-all = "gf; x=$(docker ps -a -q); docker stop $x; if [ ! -z '$x' ]; then docker rm $x; fi; docker system prune --all --force; docker system prune --volumes --force; npm run build:be; npm run start:be";
      backend-build = "gf; npm run build:be && npm run start:be";
      seed = "x=$(pwd); gk; cd src/seeds; npm run seed:all; cd $x";
      cases = "gk; cd src/seeds; npm run seed:testdata";
      dstop = "docker stop $(docker ps -q); docker rm --force $(docker ps -a -q); docker rmi --force $(docker images -q)";
      z = "terminal -cd $(pwd)";
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

      function awsl()
      {
        server=$1
        ssh_file=''\${2:-~/.ssh/devops.pem}
        login=ec2-user@$server
        echo $login
        ssh -i $ssh_file $login -y
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
    '';
   };
} 

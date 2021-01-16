# The following lines were added by compinstall
#source ${pkgs.zsh}/share/antigen.zsh
#powerline-daemon -q
#. /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

#antigen use oh-my-zsh

export ALIEN_SECTIONS_LEFT=(
  exit
  path
  vcs_branch:async
  vcs_status:async
  vcs_dirty:async
  newline
  ssh
  venv
  prompt
)

export ALIEN_SECTIONS_RIGHT=(
#  time
)
export ALIEN_SECTIONS_LEFT_SEP_SYM=" "
export ALIEN_SECTIONS_RIGHT_SEP_SYM=" "
export ALIEN_PROMPT_SYM=∮
export ALIEN_USE_NERD_FONT=1

export ALIEN_GIT_STASH_SYM=@
export ALIEN_GIT_SYM=≠
export ALIEN_HG_SYM=H
export ALIEN_SVN_SYM=S
export ALIEN_BRANCH_SYM=≡
export ALIEN_GIT_ADD_SYM=♯
export ALIEN_GIT_DEL_SYM=♭
export ALIEN_GIT_MOD_SYM=♫
export ALIEN_GIT_NEW_SYM=ن
export ALIEN_GIT_PUSH_SYM=↑
export ALIEN_GIT_PULL_SYM=↓
export ALIEN_JAVA_SYM='JAVA:'
export ALIEN_PY_SYM='PY:'
export ALIEN_RB_SYM='RB:'
export ALIEN_GO_SYM='GO:'
export ALIEN_ELIXIR_SYM='EX:'
export ALIEN_CRYSTAL_SYM='CR:'
export ALIEN_NODE_SYM='⬡ '
export ALIEN_PHP_SYM='PHP:'

## Load a custom Theme
# antigen theme eendroroy/alien alien
#cloud

# 3. Commit Antigen Configuration
#antigen apply


#zstyle ':completion:*' completer _complete _ignored _approximate
#zstyle :compinstall filename '/home/chai/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
#bindkey -v
# End of lines configured by zsh-newuser-install


export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
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

alias vim='nvim'
alias fzfi='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}" | fzf'
alias o='vim $(fzfi)'
alias r='vicd ./'

alias x='exit'
alias ghr='cd ~ && r'
alias gh='cd ~ && ls -a'
alias gfo='cd ~/code/Kairos/src/front-ends/kairos-portal && o'
alias gfr='cd ~/code/Kairos/src/front-ends/kairos-portal && r'
alias gf='cd ~/code/Kairos/src/front-ends/kairos-portal && ls -a'
alias gto='cd ~/code/Kairos/src/e2e && o'
alias gtr='cd ~/code/Kairos/src/e2e && r'
alias gt='cd ~/code/Kairos/src/e2e && ls -a'
alias gko='cd ~/code/Kairos && o'
alias gkr='cd ~/code/Kairos && r'
alias gk='cd ~/code/Kairos && ls -a'
alias gnr='cd ~/Nextcloud/Documents && r'
alias gn='cd ~/Nextcloud/Documents && ls -a'
alias gdev='cd ~/Nextcloud/Documents/nerdspul/werkspul/dev-division && r'
alias ga='cd ~/Nextcloud/Documents/music/AntiforZ && r'
alias gd='cd ~/Downloads && r'
alias swp='cd ~/.cache/vim/swap && ls -a'
alias kswp='cd ~/.cache/vim/swap && rm *.* && ls -a'
alias cfv='vim ~/.vim/vimrc'
alias cfb='vim ~/.bashrc'
alias cfz='vim ~/.zshrc'
alias cfi='vim ~/.i3/config'
alias cfx='vim ~/.Xresources'
alias backup_config='~/.scripts/backup_config.sh'
alias kk='kill -9 $(pgrep KeeWeb)'
#alias die='function _die(){ p=$(pgrep -i $1 -f); echo $p; kill -9 $p; };_die'
alias die='pkill -i $1 -f'
alias backend='gf; x=$(docker ps -a -q); docker stop $x; if [ ! -z "$x" ]; then docker rm $x; fi; npm run start:be'
alias conflicts='git diff --name-only --diff-filter=U'
alias frontend='gf; pkill -i selenium -f; cd ../../e2e && npm run webdriver && cd ../front-ends/kairos-portal && npm start;'
alias backend-all='gf; x=$(docker ps -a -q); docker stop $x; if [ ! -z "$x" ]; then docker rm $x; fi; docker system prune --all --force; docker system prune --volumes --force; npm run build:be; npm run start:be'
alias backend-build='gf; npm run build:be && npm run start:be'
alias seed='x=$(pwd); gk; cd src/seeds; npm run seed:all; cd $x'
alias cases='gk; cd src/seeds; npm run seed:testdata'
alias dstop='docker stop $(docker ps -q); docker rm --force $(docker ps -a -q); docker rmi --force $(docker images -q)'
alias z='terminal -cd $(pwd)'
function awsl()
{
  server=$1
  ssh_file=${2:-~/.ssh/devops.pem}
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


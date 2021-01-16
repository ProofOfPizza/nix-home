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


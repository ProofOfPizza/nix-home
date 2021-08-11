#!/bin/bash



cwd=$(pwd)
rm kairos-backend-output*
arg=$1

if [[ $arg == "" ]]
then
  echo "Please run as: bash ./startup.sh build or bash ./startup.sh run"
  echo "If you run the BE you can check on the logs with f.e.: tail -f kairos-backend-output-ApplicationService.log"
  echo "Everytime you run the script those log files are purged"
  exit 1
fi

function writeQuery {
  cat backend-workspace.code-workspace | grep -v "^\s*//"  | jq -c "$@" >> tmp.json
}

function query {
  res=`cat backend-workspace.code-workspace | grep -v "^\s*//"  | jq -c "$@"`
  echo $res | tr -d '"'
}
function build {
  dotnet build $@
}

_q=".folders | .[0].path"
workspaceFolder=$(query "$_q")
workspaceFolder="$cwd/$workspaceFolder"
_q=".tasks.tasks | .[0].args | .[1]"
solution=$workspaceFolder/Kairos.Services.sln
_q=".launch.configurations | .[] | {name:.name, dll:.program, env:.env.ASPNETCORE_ENVIRONMENT, url:.env.ASPNETCORE_URLS}"

writeQuery "$_q"

commands=$(cat tmp.json)
if [[ $arg == "build" ]]
then
  echo 'building ... '$solution
  build $solution
fi

for command in $commands
do
  echo $command
  if [[ $arg == "build" ]]
  then
    name=$(echo $command | jq .name | tr -d '"' | cut -d. -f3 )
    servicePath=$workspaceFolder/Services/Kairos.Services.$name/
    cd $servicePath
    echo "building " $name " ======================"
    build
    echo "========================================> NEXT!"
  elif [[ $arg == "run" ]]
  then
    name=$(echo $command | jq .name | tr -d '"' | cut -d. -f3 )
    dllQuery=$(echo $command | jq .dll | tr -d '"'| cut -d/ --complement -f1-3)
    url=$(echo $command | jq .url | tr -d '"')
    env=$(echo $command | jq .env | tr -d '"')
    export ASPNETCORE_ENVIRONMENT=$env
    export ASPNETCORE_URLS=$url
    servicePathDll=$workspaceFolder/Services/Kairos.Services.$name/$dllQuery
    servicePath=$workspaceFolder/Services/Kairos.Services.$name
    outfile=$cwd/kairos-backend-output-$name.log
    echo "starting up" $name '=========================='
    cd $servicePath
    nohup dotnet run > $outfile &
  fi
done
cd $cwd
rm tmp.json



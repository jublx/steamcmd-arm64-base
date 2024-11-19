#!/bin/bash


WORKSPACE="/root/Steam"
SERVER_SCRIPT="server.sh"

# usage function
function usage()
{
    cat << HEREDOC

    Usage: entrypoint.sh [--install <GAME_ID>] [--script <PATH>]

    required arguments:
        -n, --name <NAME>           server name
    optional arguments:
        -i, --install <GAME_ID>                     install server from the steamdb id
        -r, --run-script <PATH>                     use steamcmd runscript, must mount the file beforehand in the container
        -s, --server-script <SCRIPT_EXECUTABLE>     name of the server script executable
HEREDOC
}


while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--name)
      SERVER_NAME="$2"
      shift # past argument
      shift # past value
      ;;
    -i|--install)
      GAME_ID="$2"
      shift # past argument
      shift # past first value
      ;;
    -r|--run-script)
      RUNSCRIPT_PATH="$2"
      shift # past argument
      shift # past value
      ;;
    -s|--server-script)
      SERVER_SCRIPT="$2"
      shift # past argument
      shift # past value
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done 


if [ -z "$SERVER_NAME" ] ; then
    usage
    exit 1
fi

SERVER_WORKSPACE="${WORKSPACE}/${SERVER_NAME}"

if [ -n "$RUNSCRIPT_PATH" ] ; then
    echo "Using runscript $RUNSCRIPT_PATH"
    exec /bin/FEXBash -c "${WORKSPACE}/steamcmd.sh +runscript $RUNSCRIPT_PATH +exit"
elif [ -n "$GAME_ID" ] ; then
    exec /bin/FEXBash -c "${WORKSPACE}/steamcmd.sh +force_install_dir $SERVER_WORKSPACE +login anonymous +app_update $GAME_ID +exit" 
fi

chmod u+x "${SERVER_WORKSPACE}/${SERVER_SCRIPT}"
exec /bin/FEXBash -c "${SERVER_WORKSPACE}/${SERVER_SCRIPT}"

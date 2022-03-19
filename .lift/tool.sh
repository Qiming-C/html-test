#!/usr/bin/env bash
# Define versions
INSTALL_NODE_VER=10
INSTALL_NVM_VER=0.33.11

RESULT_DIR=/tmp/htmlhint_result.json
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#Install curl and jg git
apt update  &> /dev/null
apt install -y curl  &> /dev/null
apt install -y jq  &> /dev/null
apt install -y git  &> /dev/null

# Install nvm 
curl -o- https://raw.githubusercontent.com/creationix/nvm/v$INSTALL_NVM_VER/install.sh | bash > /dev/null

# Make nvm command available to terminal
source ~/.nvm/nvm.sh

nvm install $INSTALL_NODE_VER &> /dev/null

nvm alias default $INSTALL_NODE_VER &> /dev/null
nvm use default &> /dev/null

pushd $SCRIPT_DIR/HTMLHint
npm run-script build &> /dev/null
popd


function run(){
	node $SCRIPT_DIR/HTMLHint/dist/cli/htmlhint.js -f json "$1" | jq '.'
	exit 0
}

case "$3" in 
	run)
		run "$1" "$2" "$3"
		;;
	applicable)
		echo "true"
		;;
	version)
		echo 1
		;;
esac			





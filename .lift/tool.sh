#!/usr/bin/env bash


RESULT_DIR=/tmp/htmlhint_result.json
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
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





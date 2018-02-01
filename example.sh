#!/bin/sh

# load functions
source sh-json.sh

# call a function and turn its return as json
funcA() {
	json=$(funcB -first "some value" -second "something else")
	result=$(_get result "$json")

	echo $result # result: congratulations! it works!
}

# turn arguments into json and extract its variables
funcB() {
	json=$(_set "$@")
	key1=$(_get first "$json")
	key2=$(_get second "$json")

	[[ $key1 == "some value" ]] && [[ $key2 == "something else" ]] || return 1
	_set -result "congratulations! it works!"
}

main() {
	funcA
}

main

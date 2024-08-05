#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

function usage() {
	echo "Usage: textsearch folder text"
	echo -e "error: ${1}"
}

function search() {
	if ! [[ -d "$1" ]] ; then
		if [[ -f "$1" ]] ; then
			print_result "$2" "$1" "$3"
		else
			usage "${RED}${1}${NC} is not existing or not a dir"
		fi
	else
		mapfile -d $'\0' files < <(find "$1" -type f -print0)
		for f in "${files[@]}" ; do
			if ! print_result "$2" "$f" "$3" ; then
				exit 1
			fi
		done
	fi
}

function print_result() {
	if [[ -n "$3" ]] && [ "$3" -eq "$3" ] 2>/dev/null ; then
		res=$(grep -n -m "$3" "$1" "$2")
	elif [[ -z "$3" ]] ; then
		res=$(grep -n "$1" "$2")
	else
		usage "${RED}${3}${NC} is not a number"
		exit 1
	fi
	if ! [[ -z "$res" ]] ; then
		echo -e "${GREEN}\"${1}\"${NC} found in ${BROWN}${2}${NC}:"
		echo -e "$res" | grep -n --color "$1"
	fi
}

function main() {
	args=("$@")
	n=${#args[@]}
	case "$n" in
		0)
			usage "text input argument is required"
			;;
		1)
			search . "$1"
			;;
		2)
			search "$1" "$2"
			;;
		3)
			search "$1" "$2" "$3"
			;;
		*)
			usage "maximum three input arguments"
			;;
	esac
}

main "$@"

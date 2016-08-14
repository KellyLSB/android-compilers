#!/bin/bash -e

export COMPILERS_PATH=""
export COMPILERS_REPO="https://github.com/KellyLSB/android-compilers.git"
export COMPILERS_BRANCH=""
export COMPILERS_GROUPS=()
export COMPILERS_INSTALL2BIN=0
export COMPILERS_LINK2CCACHE=0

if [ $(id -u) -gt 0 ]; then
	COMPILERS_PATH="${HOME}/.android-compilers"
else
	COMPILERS_PATH="/opt/android-compilers"
fi

eval set -- "$(getopt -o p:g:r:bc --long path:,group:groups:,repo:,git:,bin,ccache -- "$@")"

while true; do
	case "$1" in
	--path|-p) 		COMPILERS_PATH="$2"; 		shift 2;;
	--repo|--git|-r) 	COMPILERS_REPO="$2"; 		shift 2;;
	--branch|-b) 		COMPILERS_BRANCH="$2"; 		shift 2;;
	--groups|--group|-g) 	COMPILERS_GROUPS+=("$2"); 	shift 2;;
	--bin|-b)               COMPILERS_INSTALL2BIN=1;        shift 1;;
	--ccache|-c)            COMPILERS_LINK2CCACHE=1;        shift 1;;
	--) 			shift 1; 			break;;
	esac
done

mkdir -p "${COMPILERS_PATH}"
cd "${COMPILERS_PATH}"

args=("-u" "${COMPILERS_REPO}")

if [ "${COMPILERS_BRANCH}" ]; then
	args+=("-b" "${COMPILERS_BRANCH}")
fi

if [ "${COMPILERS_GROUPS[@]}" ]; then
	args+=("-g" "$(tr ' ' ',' <<<"${COMPILERS_GROUPS[@]}")")
fi

repo init ${args[@]}
repo sync
cd -

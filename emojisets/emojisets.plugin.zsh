# ------------------------------------------------------------------------------
#          FILE: emotty.plugin.zsh
#   DESCRIPTION: Return an emoji for the current $TTY number.
#        AUTHOR: Alexis Hildebrandt (afh[at]surryhill.net)
#       VERSION: 1.0.0
#       DEPENDS: emoji plugin
#       
# There are different sets of emoji characters available, to choose a different
# set export emotty_set to the name of the set you would like to use, e.g.:
# % export emotty_set=nature
# ------------------------------------------------------------------------------

# Handle $0 according to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

typeset -gAH _emoji_sets
local _emojisets_plugin_dir="${0:h}"
source "$_emojisets_plugin_dir/_emoji_sets.zsh"
unset _emojisets_plugin_dir

function select_set() {
    local dt=$(date +%m%d)
    if [[ $dt > 1024 && $dt < 1102 ]] ; then
        echo "halloween"
    elif [[ $dt > 1200 && $dt < 1210 ]] ; then
        echo "santa_claus"
    elif [[ $dt > 1209 && $dt < 1228 ]] ; then
        echo "christmas"
    elif [[ $dt > 1227 && $dt < 1232 ]] ; then
        echo "newyear"
    elif [[ $dt > 0100 && $dt < 0103 ]] ; then
        echo "newyear"
    elif [[ $dt > 0315 && $dt < 0415 ]] ; then
        echo "easter"
    elif [[ $dt > 0102 && $dt < 0306 ]] ; then 
        echo "winter"
    elif [[ $dt > 0305 && $dt < 0532 ]] ; then
        echo "spring"
    elif [[ $dt > 0600 && $dt < 0910 ]] ; then
        echo "summer"
    elif [[ $dt > 0909 && $dt < 1131 ]] ; then
        echo "autumn"
    fi
}

emoji_default_set=$(select_set)

function get_random_emoji() {
    local size=${#${=_emoji_sets[$emoji_default_set]}[@]}
    local random_index=$(( ( RANDOM % $size ) + 1 ))
    echo "${${=_emoji_sets[$emoji_default_set]}[$random_index]}"
}


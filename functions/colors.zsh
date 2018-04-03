#!/usr/bin/env zsh
# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################################
# @title powerlevel9k Color Functions
# @source https://github.com/bhilburn/powerlevel9k
##
# @authors
#   Ben Hilburn (bhilburn)
#   Dominik Ritter (dritter)
##
# @info
#   This file contains some color-functions for powerlevel9k.
##

################################################################
# @description
#   This function checks if the terminal supports 256 colors.
#   If it doesn't, an error message is displayed.
##
# @noargs
##
# @note
#   You can bypass this check by setting `P9K_IGNORE_TERM_COLORS=true`.
##
function termColors() {
  [[ $P9K_IGNORE_TERM_COLORS == true ]] && return

  local term_colors

  if which tput &>/dev/null; then
	term_colors=$(tput colors)
  else
	term_colors=$(echotc Co)
  fi
  if (( ! $? && ${term_colors:-0} < 256 )); then
    print -P "%F{red}WARNING!%f Your terminal appears to support fewer than 256 colors!"
    print -P "If your terminal supports 256 colors, please export the appropriate environment variable"
    print -P "_before_ loading this theme in your \~\/.zshrc. In most terminal emulators, putting"
    print -P "%F{blue}export TERM=\"xterm-256color\"%f at the top of your \~\/.zshrc is sufficient."
  fi
}

################################################################
# @description
#   This function gets the proper color code if it does not exist as a name.
##
# @args
#   $1 misc Color to check (as a number or string)
##
function getColor() {
  # no need to check numerical values
  if [[ "$1" = <-> ]]; then
    if [[ "$1" = <8-15> ]]; then
      1=$(($1 - 8))
    fi
  else
    # named color added to parameter expansion print -P to test if the name exists in terminal
    local named="%K{$1}"
    # https://misc.flogisoft.com/bash/tip_colors_and_formatting
    local default="$'\033'\[49m"
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    local quoted=$(printf "%q" $(print -P "$named"))
    if [[ $quoted = "$'\033'\[49m" && $1 != "black" ]]; then
        # color not found, so try to get the code
        1=$(getColorCode $1)
    fi
  fi
  echo -n "$1"
}

################################################################
# @description
#   Function to set the background color.
##
# @args
#   $1 misc The background color.
##
# @returns
#   An escape code string for (re)setting the background color.
##
# @note
#   An empty paramenter resets (stops) background color.
##
function backgroundColor() {
  if [[ -z $1 ]]; then
    echo -n "%k"
  else
    echo -n "%K{$(getColor $1)}"
  fi
}

################################################################
# @description
#   Function to set the foreground color.
##
# @args
#   $1 misc The foreground color.
##
# @returns
#   An escape code string for (re)setting the foreground color.
##
# @note
#   An empty paramenter resets (stops) foreground color.
##
function foregroundColor() {
  if [[ -z $1 ]]; then
    echo -n "%f"
  else
    echo -n "%F{$(getColor $1)}"
  fi
}

typeset -A _p9k_colors
# https://jonasjacek.github.io/colors/
# use color names by default to allow dark/light themes to adjust colors based on names
_p9k_colors[black]=000
_p9k_colors[maroon]=001
_p9k_colors[green]=002
_p9k_colors[olive]=003
_p9k_colors[navy]=004
_p9k_colors[purple]=005
_p9k_colors[teal]=006
_p9k_colors[silver]=007
_p9k_colors[grey]=008
_p9k_colors[red]=009
_p9k_colors[lime]=010
_p9k_colors[yellow]=011
_p9k_colors[blue]=012
_p9k_colors[fuchsia]=013
_p9k_colors[aqua]=014
_p9k_colors[white]=015
_p9k_colors[grey0]=016
_p9k_colors[navyblue]=017
_p9k_colors[darkblue]=018
_p9k_colors[blue3]=019
_p9k_colors[blue3]=020
_p9k_colors[blue1]=021
_p9k_colors[darkgreen]=022
_p9k_colors[deepskyblue4]=023
_p9k_colors[deepskyblue4]=024
_p9k_colors[deepskyblue4]=025
_p9k_colors[dodgerblue3]=026
_p9k_colors[dodgerblue2]=027
_p9k_colors[green4]=028
_p9k_colors[springgreen4]=029
_p9k_colors[turquoise4]=030
_p9k_colors[deepskyblue3]=031
_p9k_colors[deepskyblue3]=032
_p9k_colors[dodgerblue1]=033
_p9k_colors[green3]=034
_p9k_colors[springgreen3]=035
_p9k_colors[darkcyan]=036
_p9k_colors[lightseagreen]=037
_p9k_colors[deepskyblue2]=038
_p9k_colors[deepskyblue1]=039
_p9k_colors[green3]=040
_p9k_colors[springgreen3]=041
_p9k_colors[springgreen2]=042
_p9k_colors[cyan3]=043
_p9k_colors[darkturquoise]=044
_p9k_colors[turquoise2]=045
_p9k_colors[green1]=046
_p9k_colors[springgreen2]=047
_p9k_colors[springgreen1]=048
_p9k_colors[mediumspringgreen]=049
_p9k_colors[cyan2]=050
_p9k_colors[cyan1]=051
_p9k_colors[darkred]=052
_p9k_colors[deeppink4]=053
_p9k_colors[purple4]=054
_p9k_colors[purple4]=055
_p9k_colors[purple3]=056
_p9k_colors[blueviolet]=057
_p9k_colors[orange4]=058
_p9k_colors[grey37]=059
_p9k_colors[mediumpurple4]=060
_p9k_colors[slateblue3]=061
_p9k_colors[slateblue3]=062
_p9k_colors[royalblue1]=063
_p9k_colors[chartreuse4]=064
_p9k_colors[darkseagreen4]=065
_p9k_colors[paleturquoise4]=066
_p9k_colors[steelblue]=067
_p9k_colors[steelblue3]=068
_p9k_colors[cornflowerblue]=069
_p9k_colors[chartreuse3]=070
_p9k_colors[darkseagreen4]=071
_p9k_colors[cadetblue]=072
_p9k_colors[cadetblue]=073
_p9k_colors[skyblue3]=074
_p9k_colors[steelblue1]=075
_p9k_colors[chartreuse3]=076
_p9k_colors[palegreen3]=077
_p9k_colors[seagreen3]=078
_p9k_colors[aquamarine3]=079
_p9k_colors[mediumturquoise]=080
_p9k_colors[steelblue1]=081
_p9k_colors[chartreuse2]=082
_p9k_colors[seagreen2]=083
_p9k_colors[seagreen1]=084
_p9k_colors[seagreen1]=085
_p9k_colors[aquamarine1]=086
_p9k_colors[darkslategray2]=087
_p9k_colors[darkred]=088
_p9k_colors[deeppink4]=089
_p9k_colors[darkmagenta]=090
_p9k_colors[darkmagenta]=091
_p9k_colors[darkviolet]=092
_p9k_colors[purple]=093
_p9k_colors[orange4]=094
_p9k_colors[lightpink4]=095
_p9k_colors[plum4]=096
_p9k_colors[mediumpurple3]=097
_p9k_colors[mediumpurple3]=098
_p9k_colors[slateblue1]=099
_p9k_colors[yellow4]=100
_p9k_colors[wheat4]=101
_p9k_colors[grey53]=102
_p9k_colors[lightslategrey]=103
_p9k_colors[mediumpurple]=104
_p9k_colors[lightslateblue]=105
_p9k_colors[yellow4]=106
_p9k_colors[darkolivegreen3]=107
_p9k_colors[darkseagreen]=108
_p9k_colors[lightskyblue3]=109
_p9k_colors[lightskyblue3]=110
_p9k_colors[skyblue2]=111
_p9k_colors[chartreuse2]=112
_p9k_colors[darkolivegreen3]=113
_p9k_colors[palegreen3]=114
_p9k_colors[darkseagreen3]=115
_p9k_colors[darkslategray3]=116
_p9k_colors[skyblue1]=117
_p9k_colors[chartreuse1]=118
_p9k_colors[lightgreen]=119
_p9k_colors[lightgreen]=120
_p9k_colors[palegreen1]=121
_p9k_colors[aquamarine1]=122
_p9k_colors[darkslategray1]=123
_p9k_colors[red3]=124
_p9k_colors[deeppink4]=125
_p9k_colors[mediumvioletred]=126
_p9k_colors[magenta3]=127
_p9k_colors[darkviolet]=128
_p9k_colors[purple]=129
_p9k_colors[darkorange3]=130
_p9k_colors[indianred]=131
_p9k_colors[hotpink3]=132
_p9k_colors[mediumorchid3]=133
_p9k_colors[mediumorchid]=134
_p9k_colors[mediumpurple2]=135
_p9k_colors[darkgoldenrod]=136
_p9k_colors[lightsalmon3]=137
_p9k_colors[rosybrown]=138
_p9k_colors[grey63]=139
_p9k_colors[mediumpurple2]=140
_p9k_colors[mediumpurple1]=141
_p9k_colors[gold3]=142
_p9k_colors[darkkhaki]=143
_p9k_colors[navajowhite3]=144
_p9k_colors[grey69]=145
_p9k_colors[lightsteelblue3]=146
_p9k_colors[lightsteelblue]=147
_p9k_colors[yellow3]=148
_p9k_colors[darkolivegreen3]=149
_p9k_colors[darkseagreen3]=150
_p9k_colors[darkseagreen2]=151
_p9k_colors[lightcyan3]=152
_p9k_colors[lightskyblue1]=153
_p9k_colors[greenyellow]=154
_p9k_colors[darkolivegreen2]=155
_p9k_colors[palegreen1]=156
_p9k_colors[darkseagreen2]=157
_p9k_colors[darkseagreen1]=158
_p9k_colors[paleturquoise1]=159
_p9k_colors[red3]=160
_p9k_colors[deeppink3]=161
_p9k_colors[deeppink3]=162
_p9k_colors[magenta3]=163
_p9k_colors[magenta3]=164
_p9k_colors[magenta2]=165
_p9k_colors[darkorange3]=166
_p9k_colors[indianred]=167
_p9k_colors[hotpink3]=168
_p9k_colors[hotpink2]=169
_p9k_colors[orchid]=170
_p9k_colors[mediumorchid1]=171
_p9k_colors[orange3]=172
_p9k_colors[lightsalmon3]=173
_p9k_colors[lightpink3]=174
_p9k_colors[pink3]=175
_p9k_colors[plum3]=176
_p9k_colors[violet]=177
_p9k_colors[gold3]=178
_p9k_colors[lightgoldenrod3]=179
_p9k_colors[tan]=180
_p9k_colors[mistyrose3]=181
_p9k_colors[thistle3]=182
_p9k_colors[plum2]=183
_p9k_colors[yellow3]=184
_p9k_colors[khaki3]=185
_p9k_colors[lightgoldenrod2]=186
_p9k_colors[lightyellow3]=187
_p9k_colors[grey84]=188
_p9k_colors[lightsteelblue1]=189
_p9k_colors[yellow2]=190
_p9k_colors[darkolivegreen1]=191
_p9k_colors[darkolivegreen1]=192
_p9k_colors[darkseagreen1]=193
_p9k_colors[honeydew2]=194
_p9k_colors[lightcyan1]=195
_p9k_colors[red1]=196
_p9k_colors[deeppink2]=197
_p9k_colors[deeppink1]=198
_p9k_colors[deeppink1]=199
_p9k_colors[magenta2]=200
_p9k_colors[magenta1]=201
_p9k_colors[orangered1]=202
_p9k_colors[indianred1]=203
_p9k_colors[indianred1]=204
_p9k_colors[hotpink]=205
_p9k_colors[hotpink]=206
_p9k_colors[mediumorchid1]=207
_p9k_colors[darkorange]=208
_p9k_colors[salmon1]=209
_p9k_colors[lightcoral]=210
_p9k_colors[palevioletred1]=211
_p9k_colors[orchid2]=212
_p9k_colors[orchid1]=213
_p9k_colors[orange1]=214
_p9k_colors[sandybrown]=215
_p9k_colors[lightsalmon1]=216
_p9k_colors[lightpink1]=217
_p9k_colors[pink1]=218
_p9k_colors[plum1]=219
_p9k_colors[gold1]=220
_p9k_colors[lightgoldenrod2]=221
_p9k_colors[lightgoldenrod2]=222
_p9k_colors[navajowhite1]=223
_p9k_colors[mistyrose1]=224
_p9k_colors[thistle1]=225
_p9k_colors[yellow1]=226
_p9k_colors[lightgoldenrod1]=227
_p9k_colors[khaki1]=228
_p9k_colors[wheat1]=229
_p9k_colors[cornsilk1]=230
_p9k_colors[grey100]=231
_p9k_colors[grey3]=232
_p9k_colors[grey7]=233
_p9k_colors[grey11]=234
_p9k_colors[grey15]=235
_p9k_colors[grey19]=236
_p9k_colors[grey23]=237
_p9k_colors[grey27]=238
_p9k_colors[grey30]=239
_p9k_colors[grey35]=240
_p9k_colors[grey39]=241
_p9k_colors[grey42]=242
_p9k_colors[grey46]=243
_p9k_colors[grey50]=244
_p9k_colors[grey54]=245
_p9k_colors[grey58]=246
_p9k_colors[grey62]=247
_p9k_colors[grey66]=248
_p9k_colors[grey70]=249
_p9k_colors[grey74]=250
_p9k_colors[grey78]=251
_p9k_colors[grey82]=252
_p9k_colors[grey85]=253
_p9k_colors[grey89]=254
_p9k_colors[grey93]=255

################################################################
# @description
#   Function to get numerical color codes. That way we translate
#   ANSI codes into ZSH-Style color codes.
##
# @args
#   $1 misc Number or string of color.
##
function getColorCode() {
  # Check if given value is already numerical
  if [[ "$1" = <-> ]]; then
    # ANSI color codes distinguish between "foreground"
    # and "background" colors. We don't need to do that,
    # as ZSH uses a 256 color space anyway.
    if [[ "$1" = <8-15> ]]; then
      echo -n $(($1 - 8))
    else
      echo -n "$1"
    fi
  else
    # for testing purposes in terminal
    if [[ "$1" == "foreground"  ]]; then
        # call via `getColorCode foreground`
        for i in "${(k@)_p9k_colors}"; do
            print -P "$(foregroundColor $i)$(getColor $i) - $i$(foregroundColor)"
        done
    elif [[ "$1" == "background"  ]]; then
        # call via `getColorCode background`
        for i in "${(k@)_p9k_colors}"; do
            print -P "$(backgroundColor $i)$(getColor $i) - $i$(backgroundColor)"
        done
    else
        #[[ -n "$1" ]] bg="%K{$1}" || bg="%k"
        # Strip eventual "bg-" prefixes
        1=${1#bg-}
        # Strip eventual "fg-" prefixes
        1=${1#fg-}
        # Strip eventual "br" prefixes ("bright" colors)
        1=${1#br}
        echo -n $_p9k_colors[$1]
    fi
  fi
}

################################################################
# @description
#   Check if two colors are equal, even if one is specified as ANSI code.
##
# @args
#   $1 misc First color (number or string)
#   $2 misc Second color (number or string)
##
function isSameColor() {
  if [[ "$1" == "NONE" || "$2" == "NONE" ]]; then
    return 1
  fi

  local color1=$(getColorCode "$1")
  local color2=$(getColorCode "$2")

  return $(( color1 != color2 ))
}

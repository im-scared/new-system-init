#!/usr/bin/env bash

if [[ "$1" != "remote" ]]; then
	echo "starting a kitten with remote control enabled, for trying out themes in..."
	kitty -o allow_remote_control=yes ./try-themes.sh remote
	exit
fi

color_test() {
	# https://raw.githubusercontent.com/stark/Color-Scripts/master/color-scripts/colortest
	# Daniel Crisman's ANSI color chart script from
	# The Bash Prompt HOWTO: 6.1. Colours
	# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
	#
	# This function echoes a bunch of color codes to the 
	# terminal to demonstrate what's available.  Each 
	# line is the color code of one forground color,
	# out of 17 (default + 16 escapes), followed by a 
	# test use of that color on all nine background 
	# colors (default + 8 escapes).

	T='•••'   # The text for the color test

	echo -e "\n         def     40m     41m     42m     43m     44m     45m     46m     47m";

	for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
						 '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
						 '  36m' '1;36m' '  37m' '1;37m'; do
		FG=${FGs// /}
		echo -en " $FGs \033[$FG  $T  "

		for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
			do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
		done
		echo;
	done
	echo
}

read_char() {
	read -s -n 1 char
	printf "%s" "$char" | xxd -p
}

clamp() {
	min="$1"
	max="$2"
	val="$3"
	if [[ $val -lt $min ]]; then
		echo $min
	elif [[ $max -lt $val ]]; then
		echo $max
	else
		echo $val
	fi
}

print_status() {
	tput hpa 0
	tput el
	tput hpa 0
	echo -n "$1"
	tput hpa 0
}

set_status_current_theme() {
	print_status "current theme: $(basename "$1" .conf)"
}

cat <<COMMANDS
COMMANDS:
	left/right arrows -- change theme
	up arrow          -- include theme (themes are included by default)
	down arrow        -- exclude theme
	p                 -- print the current theme to stdout
	u                 -- update the current theme file link
COMMANDS

ls -lAhFG

color_test

declare -a theme_files
declare -A good_themes
if [[ -f good_themes.txt && $(wc -c good_themes.txt | cut -wf 2) -ne 0 ]]; then
	readarray -t theme_files < good_themes.txt
	for f in "${theme_files[@]}"; do good_themes["$f"]=1; done
else
	for file in kitty-themes/themes/*.conf
	do
		theme_files+=("$file")
	done
fi

theme_i=-1
current_theme_file=$(readlink theme.conf)
i=0
for theme_file in "${theme_files[@]}"; do
	if [[ "$current_theme_file" == "$theme_file" ]]; then
		theme_i=i
		break
	fi
	i=$((i + 1))
done

current_theme=$(basename "$current_theme_file" .conf)
if [[ $theme_i -lt 0 ]]; then
	echo "current theme [$current_theme] not found in good themes file. switching to first good theme."
	theme_i=0
fi
print_status "current theme: $current_theme"

tput init

exit_selection=0
while [[ theme_i -lt ${#theme_files[@]} && exit_selection -eq 0 ]]; do
	theme_file="${theme_files[$theme_i]}"
	kitty @ set-colors -a "$theme_file"
	set_status_current_theme "$theme_file"

	while true; do
		first_char="$(read_char)"
		if [[ "$first_char" == "70" ]]; then # char: p
			set_status_current_theme "$theme_file"
			continue
		elif [[ "$first_char" == "71" ]]; then # char: q
			exit_selection=1
			break
		elif [[ "$first_char" == "75" ]]; then # char: u
			print_status "updating theme to: $(basename "$theme_file" .conf) [was: $current_theme]"
			echo "[$(date -I)] $current_theme" >> prev-themes.txt
			continue
			ln -sf "$theme_file" theme.conf
		elif [[ "$first_char" != "1b" ]]; then # char: <Esc>
			echo "unrecognized char: $first_char"
			continue
		fi

		second_char="$(read_char)"
		if [[ "$second_char" == "1b" ]]; then # char: <Esc>
			exit_selection=1
			break
		fi
		[[ "$second_char" == "5b" ]] || continue # char: <escape sequence start>

		next_char="$(read_char)" 
		case "$next_char" in
			41) # char: up arrow
				good_themes["$theme_file"]=1
				;;
			42) # char: down arrow
				good_themes["$theme_file"]=0
				;;
			43) # char: right arrow
				theme_i="$(clamp 0 ${#theme_files[@]} $((theme_i+1)))"
				break
				;;
			44) # char: left arrow
				theme_i="$(clamp 0 ${#theme_files[@]} $((theme_i-1)))"
				break
				;;
			*)
				echo "unrecognized char: $next_char"
				;;
		esac
	done
done

tput reset

for key in ${!good_themes[@]}; do
	if [[ ${good_themes["$key"]} -ne 1 ]]; then
		unset good_themes["$key"]
	fi
done

if [[ ${#good_themes[@]} -eq 0 ]]; then
	echo "no themes selected :P"
	echo done
	exit
else
	cp good_themes.txt good_themes.txt.prev &> /dev/null
	: > good_themes.txt
	echo "${#good_themes[@]} themes selected ^w^:"
	for f in ${!good_themes[@]}; do
		echo "  - $f"
		echo "$f" >> good_themes.txt
	done
fi

echo done

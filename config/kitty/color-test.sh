#!/usr/bin/env bash

# If the '-e' flag is passed, cells will be three rows high.
if [ "$1" == "-e" ]; then
	expanded=true;
else
	expanded=false
fi

# If the option --sixteen is given, only show the first 16 colors
if [ "$1" == "-16" ]; then
	showall=true;
	sixteen=true;
	expanded=true;
else
	sixteen=false
fi

# Creates a color row.
# Arguments:
#   - width (number)
#   - starting color (number)
#   - ending color (number)
row () {
	# Give the arguments names for scope reasons.
	local width=$((5 - 1))
	local start=$1
	local end=$2
	local text=$3

	# Creates a "slice" (one terminal row) of a row.
	# Can be have number labels or be blank.
	# Arguments:
	#   - label (boolean)
	slice () {
		local i
		for ((i=$start; i<$end; i++))
		do
			# Determine if there will be a label on this cell (this is actually
			# a per slice setting but the title needs to be set on each cell
			# because of the numbering).
			if [ $1 ]; then
				string="$i"
			else
				string=' '
			fi

			# Change background to the correct color.
			tput setab $i

			# Print the cell.
			printf "%${width}s " $string
		done

		# Clear the coloring to avoid nasty wrapping colors.
		tput sgr0
		echo
	}

	if [ $expanded == true ]; then
		# Print a blank slice, a labeled one, and then a blank one.
		slice; slice true; slice
	else
		# Just print the labeled slice.
		slice $text
	fi
}

block () {
	local left=$1
	local top=$2
	local width=$3
	local height=$4
	local start=$5

	local j
	for ((j=0; j<$height; j++))
	do
		local s=$((start + j*width))
		tput cup $((top + j*2)) $left
		row $s $((s + width)) true
		tput cup $((top + j*2 + 1)) $left
		row $s $((s + width))
	done
}

display () {
	tput clear

	# Get the widths based on columns.
	cols=$(tput cols)

	# Give it some room to breathe.
	echo

	# The first sixteen colors.
	row 0 8 true
	row 0 8
	row 8 16 true
	row 8 16

	if [ $sixteen == true ]; then
		exit
	fi

	local i
	local j
	local width=6
	local height=6
	for ((i=0; i<3; i++)); do
		for ((j=0; j<2; j++)); do
			local left=$((i*5*width))
			local top=$((6 + j*2*height))
			local start_color=$((16 + i*width*height + j*3*width*height))
			block $left $top $width $height $start_color
		done
	done

	# Greyscale.
	echo
	row 232 243 true
	row 232 243
	tput setaf 0
	row 244 255 true
	row 244 255

	# Clear before exiting.
	tput sgr0
	echo
}

# Show that table thang!
display

#!/bin/bash
#-r is just to declare a constant in bash
	declare -r NUM1=5 # Declare a constant
	num2=4
	
	# Use arithmetic expansion for adding
	num3=$((NUM1+num2))
	num4=$((NUM1-num2))
	num5=$((NUM1*num2))
	num6=$((NUM1/num2))
	
	# Place variables in strings with $
	echo "5 + 4 = $num3"
	echo "5 - 4 = $num4"
	echo "5 * 4 = $num5"
	echo "5 / 4 = $num6"
	echo $(( 5**2 ))
	echo $(( 5%4 ))


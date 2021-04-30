#!/bin/bash
# Declare a constant in bash
# declare -r varName=value
declare -r x=5
declare -r y=4

# Use arithmetic expansion for adding
addition=$((x+y))
sustraction=$((x-y))
multiplication=$((x*y))
division=$((x/y))
power=$((x**2))
percentage=$((x%y))

	# Place variables in strings with $
	echo "$addition"
	echo "$sustraction"
	echo "$multiplication"
	echo "$division"
	echo "$power"
  	echo "$percentage"


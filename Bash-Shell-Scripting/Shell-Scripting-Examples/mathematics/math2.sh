#!/bin/bash

# Declare a constant in bash
# declare -r varName=value

declare -r num1=8
declare -r num2=4

# Use arithmetic expansion for adding
num3=$((num1+num2))
num4=$((num1-num2))
num5=$((num1*num2))
num6=$((num1/num2))
num7=$((num1**2))
num8=$((num1%num2))

	# Place variables in strings with $
		echo "$num3"
		echo "$num4"
		echo "$num5"
		echo "$num6"
		echo "$num7"
  		echo "$num8"


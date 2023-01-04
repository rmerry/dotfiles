#!/bin/bash

if [ "$1" = "1" ]; then
	echo ¹
elif [ "$1" = "2" ]; then
	echo ²
elif [ "$1" = "3" ]; then
	echo ³
elif [ "$1" = "4" ]; then
	echo ⁴
elif [ "$1" = "5" ]; then
	echo ⁵
elif [ "$1" = "6" ]; then
	echo ⁶
elif [ "$1" = "7" ]; then
	echo ⁷
elif [ "$1" = "8" ]; then
	echo ⁸
elif [ "$1" = "9" ]; then
	echo ⁹
elif [ $1 -gt 9 ]; then
	echo "-$1"
fi


#!/bin/env sh

set -u

script_root=$(realpath $(dirname "$0"))
root=$(realpath "$script_root/..")

cd "$root" || exit 1

no_color='\033[0m'
color_red='\033[1;31m'
color_green='\033[0;32m'

color_grey='\033[2;37m'

all_test_units=$(find "./tests" -name '*.lua')

LUA_PATH=$(lua -e 'print(package.path)')";$root/lua/?.lua;$root/lua/?/init.lua"

failure_count=0
success_count=0
for unit in $all_test_units; do
	echo -e "${color_grey}$unit${no_color}"
	LUA_PATH="$LUA_PATH" lua -- "$unit"

	if [ "$?" == "0" ]; then
		echo -e "\t${color_green}PASSED!${no_color}"
		((success_count++))
	else
		echo -e "\t${color_red}FAILED!${no_color}"
		((failure_count++))
	fi
done

echo
echo "$success_count tests passed successfuly"
echo "$failure_count tests failed"

if [ "$failure_count" -gt "0" ]; then
	exit 1
fi


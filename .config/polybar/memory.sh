#!/bin/sh
mem=$(free -h | grep Mem: | sed 's/[\t ]\+/\t/g' | cut -f3)
echo " $mem"

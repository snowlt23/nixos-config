#!/bin/sh
acpi -b | grep "Battery 0" | cut -d "," -f2 | sed 's/%//g' | cut -c 2-

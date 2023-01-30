#!/bin/bash

if [ $# -ne 1 ] ; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

export LANG=C
RE1=$(date +'%b')
RE2=$(date +'%d')
if [ $RE2 -le 9 ] ; then
	RE2=$(echo $RE2 | cut -c2-)
	RE2=" $RE2"
fi
cat $1 | egrep "$RE1 $RE2" | egrep -i --color 'warn|errror|fail|crit|alert|emerg' 

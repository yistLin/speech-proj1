#!/bin/bash
# usage: ./reg_format_gviz.sh graph.dot
# source: %s/label=\([a-zA-Z]*\)_\([a-zA-Z@#]*\)/label="\1_\2"/g

if [ -z "$1" ]; then
    echo "usage: ./escape-char.sh [inputfile]"
    echo ""
    echo "eg. label=CH_@ --> label=\"CH_@\""
    echo "eg. label=CH_#z --> label=\"CH_#z\""
else
    cat $1 | sed -e 's/label=\([a-zA-Z]*\)_\([a-zA-Z@#]*\)/label="\1_\2"/g'
fi

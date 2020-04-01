#!/bin/bash

cd "$(dirname "$0")"

mkdir -p _build

[ -e _build/fool-output.log ] && rm _build/fool-output.log
[ -e _build/fool-code.bin ] && rm _build/fool-code.bin
[ -e _build/fool-loader.tap ] && rm _build/fool-loader.tap
[ -e _build/1b-basic.tap ] && rm _build/1b-basic.tap

sjasmplus fool.asm > _build/fool-output.log
RES="$?"
[ -e _build/fool-output.log ] && echo "----" && cat _build/fool-output.log && echo "----"
[ $RES != "0" ] && exit

bas2tap -a10 -s1b-basic fool.bas _build/fool-loader.tap
RES="$?"
[ $RES != "0" ] && exit

ruby tapmaker.rb

if [ "$1" == "--run" ] ; then
    zemu _build/1b-basic.tap
fi

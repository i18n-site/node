#!/usr/bin/env bash

DIR=$(realpath ${0%/*})
cd $DIR

echo $@
PORT=3223 exec dev $@

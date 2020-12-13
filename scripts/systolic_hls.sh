#!/bin/bash

if [ ! -z "$1" ]; then
    parallelism="$1"
else
    parallelism="-j1"
fi

# make results directory and run hls-estimate on all systolic sources
mkdir -p results/systolic/hls
ls benchmarks/systolic-sources/*.fuse | parallel --bar $parallelism "fud e -q {} --to hls-estimate > results/systolic/hls/{/.}.json"

#!/bin/bash

# make results directory and run hls-estimate on all systolic sources
mkdir -p results/systolic/hls
ls benchmarks/systolic-sources/*.fuse | parallel --bar -j4 "fud e -q {} --to hls-estimate > results/systolic/hls/{/.}.json"

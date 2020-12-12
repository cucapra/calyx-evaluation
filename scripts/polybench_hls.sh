#!/bin/bash

# make results directory and run hls-estimate for all polybench benchmarks
mkdir -p results/standard/hls
ls benchmarks/polybench/*.fuse | parallel --bar -j4 "fud e -q {} --to hls-estimate > results/standard/hls/{/.}.json"

# make results directory and run hls-estimate on unrolled polybench benchmarks
mkdir -p results/unrolled/hls
ls benchmarks/unrolled/*.fuse | parallel --bar -j4 "fud e -q {} --to hls-estimate > results/unrolled/hls/{/.}.json"

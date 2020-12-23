#!/bin/bash

if [ ! -z "$1" ]; then
    parallelism="$1"
else
    parallelism="-j1"
fi

function synth() {
    mkdir -p results/opts/"$1"
    ls benchmarks/"$2"/*.fuse | \
        parallel --bar $parallelism "fud e -q {} -s futil.flags '$3' --to synth-files -o results/opts/$1/{/.}-files"
    ls results/"$1"/*.files | parallel "fud e -q {} --from synth-files --to resource-estimate -o results/opts/$1/{/.}.json"
}

synth "none" "polybench" "-d resource-sharing -d minimize-regs"
synth "none-unrolled" "unrolled" "-d resource-sharing -d minimize-regs"

synth "both" "polybench" ""
synth "both-unrolled" "unrolled" ""

synth "resource-sharing" "polybench" "-d minimize-regs"
synth "resource-sharing-unrolled" "unrolled" "-d minimize-regs"

synth "minimize-regs" "polybench" "-d resource-sharing"
synth "minimize-regs-unrolled" "unrolled" "-d resource-sharing"

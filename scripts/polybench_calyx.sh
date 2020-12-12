#!/bin/bash

# standard (25 minutes)
mkdir -p results/standard/futil
ls benchmarks/small_polybench/*.fuse | parallel --bar -j4 "fud e -q {} --to resource-estimate > results/standard/futil/{/.}.json"

# standard latency (7 minutes)
mkdir -p results/standard/futil-latency
ls benchmarks/small_polybench/*.fuse | parallel --bar -j4 "fud e -q {} --to vcd_json -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/standard/futil-latency/{/.}.json"

# unrolled (25 minutes)
mkdir -p results/unrolled/futil
ls benchmarks/unrolled/*.fuse | parallel --bar -j4 "fud e -q {} --to resource-estimate > results/unrolled/futil/{/.}.json"

# unrolled latency (7 minutes)
mkdir -p results/unrolled/futil-latency
ls benchmarks/unrolled/*.fuse | parallel --bar -j4 "fud e -q {} --to vcd_json -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/unrolled/futil-latency/{/.}.json"

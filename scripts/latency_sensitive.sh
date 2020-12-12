#!/bin/bash

# static timing enabled (7 minutes)
mkdir -p results/latency-sensitive/with-static-timing
ls benchmarks/small_polybench/*.fuse | \
    parallel --bar -j4 \
             "fud e -q {} --to vcd_json -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/latency-sensitive/with-static-timing/{/.}.json"

# static timing disabled (9 minutes)
mkdir -p results/latency-sensitive/no-static-timing
ls benchmarks/small_polybench/*.fuse | \
    parallel --bar -j4 \
             "fud e -q {} --to vcd_json -s futil.flags '-d static-timing' -s verilog.data '{}.data' | jq '{\"latency\":.TOP.main.clk | add}' > results/latency-sensitive/no-static-timing/{/.}.json"

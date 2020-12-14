#!/bin/bash

echo "Systolic Vivado HLS"
time ./scripts/systolic_hls.sh -j8

echo "Systolic Calyx"
time ./scripts/systolic_calyx.sh -j3

echo "Polybench HLS"
time ./scripts/polybench_hls.sh -j8

echo "Polybench Calyx"
time ./scripts/polybench_calyx.sh -j4

echo "Latency Sensitive"
time ./scripts/latency_sensitive.sh -j8

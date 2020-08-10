#!/bin/sh

# -e: fail on first error.
# -u: fail on unset variable.
set -eu

workdir=$1
result_dir=$2

mkdir -p "$result_dir"
cp "$workdir"/solution1/syn/report/kernel_csynth.rpt "$result_dir/"
cp "$workdir"/solution1/solution1_data.json "$result_dir/"

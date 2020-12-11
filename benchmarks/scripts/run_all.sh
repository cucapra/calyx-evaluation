#!/bin/sh

set -eu

script_dir=$(dirname "$0")
benchmarks="$1"

for f in $(cat $benchmarks); do
	bench_name=$(basename -s .fuse $f | cut -d'-' -f3)
	$script_dir/futil.sh $f $bench_name
	$script_dir/dahlia.sh $f $bench_name
done

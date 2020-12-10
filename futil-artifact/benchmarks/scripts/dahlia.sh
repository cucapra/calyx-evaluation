#!/bin/sh

# -e: fail on first error.
# -u: fail on unset variable.
set -eu

script_dir=$(dirname "$0")
fuse_file="$1"
benchmark_name="$2"

synth_dir="$script_dir"/../synthesis_scripts/

workdir=$(mktemp -d)
echo "Working in $workdir" >&2

cleanup() {
    echo "Cleaning up $workdir" >&2
    rm -rf "$workdir"
}
trap cleanup EXIT

saved_loc=$(pwd)

dahlia $fuse_file --memory-interface ap_memory > $workdir/"$benchmark_name.cpp"
cp "$synth_dir"/hls.tcl "$synth_dir"/fxp_sqrt.h "$workdir"
cd "$workdir"
vivado_hls -f hls.tcl 1>&2	
cd "$saved_loc"
$script_dir/extract_hls.py "$workdir" "$benchmark_name"

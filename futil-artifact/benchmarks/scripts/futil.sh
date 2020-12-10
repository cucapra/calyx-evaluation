#!/bin/sh

# -e: fail on first error.
# -u: fail on unset variable.
set -eu

script_dir=$(dirname "$0")
fuse_file="$1"
benchmark_name="$2"

synth_dir="$script_dir"/../synthesis_scripts

workdir=$(mktemp -d)
echo "Working in $workdir" >&2

cleanup() {
    echo "Cleaning up $workdir" >&2
    rm -rf "$workdir"
}
trap cleanup EXIT

saved_loc=$(pwd)

# XXX(sam) add optimization flags
fud exec $fuse_file --to verilog -s futil.flags "-p external --synthesis" > $workdir/"$benchmark_name.sv"
cp "$synth_dir"/synth.tcl "$synth_dir"/device.xdc "$workdir"
cd "$workdir"
vivado -mode batch -source synth.tcl >&2

cd "$saved_loc"
$script_dir/extract_futil.py "$workdir" "$benchmark_name"

cycle_count=$(fud e $fuse_file --to vcd_json -s verilog.data "$fuse_file.data" | jq '.TOP.main.clk | add')
echo $benchmark_name,'futil','LATENCY',$cycle_count

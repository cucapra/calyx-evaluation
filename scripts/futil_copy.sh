#!/bin/sh

# -e: fail on first error.
# -u: fail on unset variable.
set -eu

workdir=$1
result_dir=$2

mkdir -p "$result_dir"
cp "$workdir"/FutilBuild.runs/impl_1/runme.log "$result_dir/impl_runme.log"
cp "$workdir"/FutilBuild.runs/synth_1/runme.log "$result_dir/synth_runme.log"
cp "$workdir"/FutilBuild.runs/synth_1/*.rpt "$result_dir/"
cp "$workdir"/FutilBuild.runs/impl_1/*.rpt "$result_dir/"
cp "$workdir"/FutilBuild.runs/impl_1/*.rpt "$result_dir/"

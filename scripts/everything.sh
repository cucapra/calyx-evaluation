#!/usr/bin/env bash


# -e: fail on first error.
# -u: fail on unset vars.
set -eu

script_dir=$(dirname "$0")

small_polybench=$script_dir/small_polybench
unrolled_polybench=$script_dir/unrolled_polybench

parent_result_dir="pldi_results"
mkdir -p $parent_result_dir

# create directory to store the results
pre=$(date +%b%d)
count=$(find $parent_result_dir -name "$pre*" | wc -l)
results="$parent_result_dir/$pre-$count"
mkdir $results

# small polybench matrix
# ./scripts/run_suite.sh $small_polybench $results all '' -j8 --lb
# ./scripts/run_suite.sh $small_polybench $results no-mr '-d minimize-regs' -j8 --lb
# ./scripts/run_suite.sh $small_polybench $results no-rs '-d resource-sharing' -j8 --lb
# ./scripts/run_suite.sh $small_polybench $results no-mr-rs '-d minimize-regs -d resource-sharing' -j8 --lb
# ./scripts/run_suite.sh $small_polybench $results no-static '-d static-timing' -j8 --lb

# unrolled polybench matrix
# ./scripts/run_suite.sh $unrolled_polybench $results unrolled-all '' -j8 --lb
# ./scripts/run_suite.sh $unrolled_polybench $results unrolled-no-mr '-d minimize-regs' -j8 --lb
# ./scripts/run_suite.sh $unrolled_polybench $results unrolled-no-rs '-d resource-sharing' -j8 --lb
# ./scripts/run_suite.sh $unrolled_polybench $results unrolled-no-mr-rs '-d minimize-regs -d resource-sharing' -j8 --lb
./scripts/run_suite.sh $unrolled_polybench $results unrolled-no-static '-d static-timing' -j8 --lb

./scripts/to_csv.py $results/* > $results/results.csv

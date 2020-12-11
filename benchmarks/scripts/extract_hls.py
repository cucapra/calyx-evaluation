#!/usr/bin/env python3

import rpt
import sys
import re
import json
from pathlib import Path

def find_row(table, colname, key):
    for row in table:
        if row[colname] == key:
            return row
    raise Exception(f"{key} was not found in column: {colname}")


def to_int(s):
    if s == '-':
        return 0
    else:
        return int(s)


def observation(bench_name, typ, val_name, value):
    print(f"{bench_name},{typ},{val_name},{value}")


def hls_extract(directory, bench_name):
    directory = directory / "benchmark.prj" / "solution1"
    try:
        parser = rpt.RPTParser(directory / "syn" / "report" / "kernel_csynth.rpt")
        summary_table = parser.get_table(re.compile(r'== Utilization Estimates'), 2)
        instance_table = parser.get_table(re.compile(r'\* Instance:'), 0)

        solution_data = json.load((directory / "solution1_data.json").open())
        latency = solution_data['ModuleInfo']['Metrics']['kernel']['Latency']

        total_row = find_row(summary_table, 'Name', 'Total')
        s_axi_row = find_row(instance_table, 'Instance', 'kernel_control_s_axi_U')

        observation(bench_name, "hls", 'TOTAL_LUT', to_int(total_row['LUT'])),
        observation(bench_name, "hls", 'INSTANCE_LUT', to_int(s_axi_row['LUT'])),
        observation(bench_name, "hls", 'LUT', to_int(total_row['LUT']) - to_int(s_axi_row['LUT'])),
        observation(bench_name, "hls", 'DSP', to_int(total_row['DSP48E']) - to_int(s_axi_row['DSP48E'])),
        observation(bench_name, "hls", 'AVG_LATENCY', latency['LatencyAvg']),
        observation(bench_name, "hls", 'BEST_LATENCY', latency['LatencyBest']),
        observation(bench_name, "hls", 'WORST_LATENCY', latency['LatencyWorst']),
    except:
        print("HLS files weren't found, skipping.", file=sys.stderr)


if __name__ == "__main__":
    directory = sys.argv[1]
    bench_name = sys.argv[2]
    hls_extract(Path(directory), bench_name)

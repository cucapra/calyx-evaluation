#!/usr/bin/env python3

import rpt
import sys
import re
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


def file_contains(regex, filename):
    strings = re.findall(regex, filename.open().read())
    return len(strings) == 0


def rtl_component_extract(directory, name):
    try:
        with (directory / "synth_1" / "runme.log").open() as f:
            log = f.read()
            comp_usage = re.search(r'Start RTL Component Statistics(.*?)Finished RTL', log, re.DOTALL).group(1)
            a = re.findall('{} := ([0-9]*).*$'.format(name), comp_usage, re.MULTILINE)
            return sum(map(int, a))
    except Exception as e:
        print(e)
        print("RTL component log not found")
        return 0


def observation(bench_name, typ, val_name, value):
    print(f"{bench_name},{typ},{val_name},{value}")


def futil_extract(directory, bench_name):
    directory = directory / "out" / "FutilBuild.runs"
    try:
        parser = rpt.RPTParser(directory / "impl_1" / "main_utilization_placed.rpt")
        slice_logic = parser.get_table(re.compile(r'1\. CLB Logic'), 2)
        dsp_table = parser.get_table(re.compile(r'4\. ARITHMETIC'), 2)
        meet_timing = file_contains(r'Timing constraints are not met.', directory / "impl_1" / "main_timing_summary_routed.rpt")

        observation(bench_name, 'futil', 'LUT', find_row(slice_logic, 'Site Type', 'CLB LUTs')['Used'])
        observation(bench_name, 'futil', 'DSP', find_row(dsp_table, 'Site Type', 'DSPs')['Used'])
        observation(bench_name, 'futil', 'MEET_TIMING', int(meet_timing))
        observation(bench_name, 'futil', 'REGISTERS', rtl_component_extract(directory, 'Registers'))
        observation(bench_name, 'futil', 'MUXES', rtl_component_extract(directory, 'Muxes'))
    except Exception as e:
        print(e)
        print("Synthesis files weren't found, skipping.", file=sys.stderr)


if __name__ == "__main__":
    directory = sys.argv[1]
    bench_name = sys.argv[2]
    futil_extract(Path(directory), bench_name)

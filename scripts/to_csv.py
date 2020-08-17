#!/usr/bin/env python3

import sys
from pathlib import Path
import json
import pandas as pd

def get(dic, key):
  if dic != None and key in dic:
    return dic[key]
  else:
    return None

def main():
  result = []
  for directory in sys.argv[1:]:
    for f in Path(directory).glob('*'):
        if f.is_dir():
          data = json.load((f / "data.json").open())
          hls = data['hls']
          futil = data['futil']
          result.append({
            'benchmark': f.stem,
            'type': 'hls',
            'lut': get(hls, 'LUT'),
            'dsp': get(hls, 'DSP'),
            'latency': get(hls, 'AVG_LATENCY'),
            'meet_timing': 1,
            'source': directory
          })
          result.append({
            'benchmark': f.stem,
            'type': 'hls_total',
            'lut': get(hls, 'TOTAL_LUT'),
            'dsp': get(hls, 'DSP'),
            'latency': get(hls, 'AVG_LATENCY'),
            'meet_timing': 1,
            'source': directory
          })
          result.append({
            'benchmark': f.stem,
            'type': 'futil',
            'lut': get(futil, 'LUT'),
            'dsp': get(futil, 'DSP'),
            'latency': 0,
            'meet_timing': get(futil, 'MEET_TIMING'),
            'source': directory
          })
  df = pd.DataFrame(result)
  print(df.to_csv(index=False))

if __name__ == "__main__":
    main()

# Futil Evaluation

## Scripts

*vivado.sh*: Does the bulk of the work running `vivado` or `vivado_hls`. It has two modes,
`./vivado.sh futil` and `./vivado.sh hls`. `futil` mode expects a `.sv` file to be provided,
copies over necessary files to a server, runs `vivado`, and then copies the results back.

`hls` mode expects a `.cpp` file to be provided, copies over files to a server, runs `vivado_hls` and then
copies the results back.

Examples:
To synthesis some Futil generated SystemVerilog:
```
mkdir my_results
./scripts/vivado.sh futil my_file.sv my_results
./scripts/futil_copy.sh my_results my_results
./scripts/extract.py my_results
```

For HLS:
```
mkdir my_results
./scripts/vivado.sh hls my_file.cpp my_results
./scripts/hls_copy.sh my_results my_results
./scripts/extract.py my_results
```


For comparing the Vivado HLS results against the equivalent Futil results, use
*compare.sh*. I usually don't call this directly and instead call `run_all.sh`
which is a simple wrapper on top that uses GNU parallel to parallelize running
multiple benchmarks. This expects a file with a list of benchmark names. This is
my workflow:

```
ls ~futil/benchmarks/*.fuse > benchmarks
./scripts/run_all.sh benchmarks -j8 --lb # passes on extra flags to `parallel`
```

The `--lb` flag tells `parallel` to print something out every line it receives from a job
rather then printing the whole thing out at the end of the job.

`-j8` tells parallel to run `8` jobs in parallel.

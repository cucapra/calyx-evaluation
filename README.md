# Calyx Evaluation

This repository contains the evaluation materials for our ASPLOS 2021 paper,
"A Compiler Infrastructure for Hardware Accelerators".

The evaluation consist of three code artifacts and several graphs generated in
the paper:
- [The Calyx Infrastructure][calyx]: Calyx IL & the surrounding compiler infrastructure.
- Calyx backend for the [Dahlia compiler][dahlia]: Backend and passes for compiling Dahlia to Calyx.
- Systolic array generator: A python script to generate systolic arrays in Calyx.

**Goals**: There are two goals for this artifact evaluation:
1. To reproduce the graphs presented in our technical paper.
2. To demonstrate robustness of our software artifacts.

### Prerequisites

The artifact is available in two formats: A virtual machine image and through
code repositories hosted on Github.
If you're using the VM image, skip to the next step.

- Install the [Dahlia compiler][dahlia].
  - (*Optional*) Run the Dahlia tests to ensure that the compiler is correctly installed.
- Install the [Calyx compiler][calyx-install] and all of its [testing dependencies][calyx-install-testing] (`runt`, `vcdump`, `verilator`, `jq`).
  - (*Optional*) Run the tests to ensure that the Calyx compiler is installed correctly.
- Install our Calyx driver utility [Fud][fud].
- Clone the [artifact evaluation repository][calyx-eval].

### Installing external tools (Estimated time: 2-4 hours)
Our evaluation uses Xilinx's Vivado and Vivado HLS tools to generate
area and resource estimates.
Our evaluation requires **Vivado WEBPack v.2019.2**.
Due to the [instability of synthesis tools][verismith], we cannot guarantee our
evaluation works with a newer or older version of the Vivado tools.

If you're installing the tools on your own machine instead the VM, you can
[download the installer][vivado-webpack].
The following instructions assume you're using the VM:

1. The desktop should have a file named: `Xilinx_Unified_2019.2_1106_2127_Lin64.bin`.
2. Right-click on the Desktop and select `Open Terminal Here`.
   In the terminal type following command to start the GUI installer:
   `./Xilinx_Unified_2019.2_1106_2127_Lin64.bin`
3. Ignore the warning and press `Ok`.
4. When the box pops up asking you for a new version, click `Continue`.
5. Enter your Xilinx credentials. If you don't have them, click `please create one` and create a Xilinx account.
6. Agree to the contract and press `Next`.
7. Choose `Vivado` and click `Next`.
7. Choose `Vivado HLS WebPACK` and click `Next`.
8. Leave the defaults for selecting devices and click `Next`.
9. Change the install path from `/tools/Xilinx` to `/home/vagrant/Xilinx`.
10. Install.  Depending on the speed of your connection, the whole process
    should take about 2 - 4 hrs.

### Step-by-Step Guide

- **Experimental data and graph generation**: Generate the graphs found in the paper using pre-supplied data.
  - Play around with the data and generate graph using supplied jupyter notebeooks.
  - **Cycle counts normalized to Vivado HLS**: TODO
  - **LUT usage normalized to Vivado HLS**: TODO
  - **Cycle counts normalized to latency-insensitive design**: TODO
- **Regenerating Data**
  - **Polybench experiments**: Compare the Calyx compiler to the Vivado HLS toolchain on the linear algebra polybench benchmarks.
  - **Systolic Array**: Compare the Calyx compiler to the Vivado HLS toolchain on systolic arrays of different sizes.
- *(Optional)* Using the Calyx compiler
  - Implement a counter by writing Calyx IL.
  - Implement a simple pass for the Calyx compiler.

----

### Experimental Data and Graph Generation (Estimated time: 10 minutes)

In this section, we will regenerate graphs presented in the paper using
from **data already committed to the repository**.
Since collecting the data relies on proprietary compilers and takes several
hours, we provide this step as a quick sanity check.
The next section will covers how to collect the data.

**TODO**

----

### HLS vs. Systolic Array (Estimated time: 1-2 hours)

In this section, we will collect data to reproduce Figure 5a and 5b which
compare the estimated cycle count and resource usage of HLS designs and
Calyx-based systolic arrays.

**TODO**

----

### HLS vs. Calyx (Estimated time: 4-5 hours)

This section reproduces Figure 6a and 6b which compare the estimated cycle
count and resource usage of HLS and Calyx-based designs.

#### Vivado HLS (Estimated time: 8 minutes)
**TODO**: write words and scriptify
Standard (Estimated time: 5 minutes):
```
mkdir -p results/standard/hls
ls benchmarks/small_polybench/*.fuse | parallel --bar -j4 "fud e -q {} --to hls-estimate > results/standard/hls/{/.}.json"
```

Unrolled (Estimated time: 3 minutes):
```
mkdir -p results/unrolled/hls
ls benchmarks/unrolled/*.fuse | parallel --bar -j4 "fud e -q {} --to hls-estimate > results/unrolled/hls/{/.}.json"
```

#### Calyx (Estimated time: 50 minutes)
XXX: write words and scriptify
Standard (Estimated time: 25 minutes):
```
mkdir -p results/standard/futil
ls benchmarks/small_polybench/*.fuse | parallel --bar -j4 "fud e -q {} --to resource-estimate > results/standard/futil/{/.}.json"
```

Unrolled (Estimated time: 25 minutes):
```
mkdir -p results/unrolled/futil
ls benchmarks/unrolled/*.fuse | parallel --bar -j4 "fud e -q {} --to resource-estimate > results/unrolled/futil/{/.}.json"
```

**TODO**: get Calyx latency numbers


----

### Latency-Sensitive compilation (Estimated time: 30 minutes)

In this section, we will collect data to reproduce Figure 6c which captures
the change in cycle count when enabling latency sensitive compilation (Section
4.4) with the Calyx compiler.

**TODO**.

### (Optional) Writing a Calyx Program (Estimated time: 15 minutes)

----

### (Optional) Implementing a Compiler Pass (Estimated time: 15 minutes)

---

Systolic:
```
mkdir -p results/systolic/hls
ls benchmarks/unrolled/*.fuse | parallel --bar -j4 "fud e -q {} --to hls-estimate > results/unrolled/hls/{/.}.json"
```

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

[calyx]: https://github.com/cucapra/futil
[calyx-eval]: https://github.com/cucapra/futil-evaluation
[calyx-install]: https://capra.cs.cornell.edu/calyx/
[fud]: https://capra.cs.cornell.edu/calyx/tools/fud.html
[dahlia]: https://github.com/cucapra/dahlia
[calyx-install-testing]: https://capra.cs.cornell.edu/calyx/#testing-dependencies
[vivado-webpack]: https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_Unified_2019.2_1106_2127_Lin64.bin
[verismith]: https://johnwickerson.github.io/papers/verismith_fpga20.pdf

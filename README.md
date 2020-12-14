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

## Prerequisites

### Artifact Sources

The artifact is available in two formats: A virtual machine image and through
code repositories hosted on Github.

**Using the VM**.
The VM is packaged as an OVA file and can be downloaded [here][vm-link].
Our instructions assume you're using [VirtualBox][].

- Minimum disk space required to install external tools: 30 GB
  - **TODO**: How is this configured in virtual box
- Increase number of cores and RAM
  - Select the VM and click "Settings".
  - Select "System" > "Motherboard" and increase the "Base Memory" to at between 4-8 GB.
  - Select "System" > "Processor" and select at least 2 cores.

**Using a local machine**.
The following instructions can be used to setup and build all the tools required
to evaluate Calyx on a local machine:

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

1. Log in to the VM with the username `vagrant` and the password `vagrant`.
2. The desktop should have a file named: `Xilinx_Unified_2019.2_1106_2127_Lin64.bin`.
3. Right-click on the Desktop and select `Open Terminal Here`.
   In the terminal type following command to start the GUI installer:
   `./Xilinx_Unified_2019.2_1106_2127_Lin64.bin`
4. Ignore the warning and press `Ok`.
5. When the box pops up asking you for a new version, click `Continue`.
6. Enter your Xilinx credentials. If you don't have them, click `please create one` and create a Xilinx account.
7. Agree to the contract and press `Next`.
8. Choose `Vivado` and click `Next`.
9. Choose `Vivado HLS WebPACK` and click `Next`.
10. Leave the defaults for selecting devices and click `Next`.
11. **Important!** Change the install path from `/tools/Xilinx` to `/home/vagrant/Xilinx`.
12. Install.  Depending on the speed of your connection, the whole process
    should take about 2 - 4 hrs.

## Step-by-Step Guide

- **Experimental data and graph generation**: Generate the graphs found in the paper using pre-supplied data.
  - Play around with the data and generate graph using supplied jupyter notebeooks.
  - **Systolic array comparison**
    - 5a. Vivado HLS vs. Systolic Array Cycle count
    - 5b. Vivado HLS vs. Systolic Array LUT usage
  - **Polybench graphs**
    - 6a. Cycle counts normalized to Vivado HLS
    - 6b. LUT usage normalized to Vivado HLS
    - 6c. Cycle counts normalized to latency-insensitive design
- **Regenerating Data**
  - **Systolic Array**: Compare the Calyx compiler to the Vivado HLS toolchain on systolic arrays of different sizes.
  - **Polybench experiments**: Compare the Calyx compiler to the Vivado HLS toolchain on the linear algebra polybench benchmarks.
- *(Optional)* Using the Calyx compiler
  - Implement a counter by writing Calyx IL.
  - Implement a simple pass for the Calyx compiler.

## Experimental Data and Graph Generation (Estimated time: 5 minutes)
Since the process to collecting data takes several hours, we will first
regenerate the graphs presented in the paper from **data already committed to
the repository**.
The [next section](#data-collection) will demonstrate how to collect this data.

In the root of the `futil-evaluation` directory, run:
```
jupyter lab
```

This will open up a Jupyter notebook that generates graphs using the data in
the `results/` directory.

- Navigate to the `analysis/artfact.ipynb` notebook.
- Click "Restart the kernel and re-run the whole notebook" button (⏩)️.
- All the graphs will be generated within the notebook under headers that correspond with the figures
  in the paper.

<details>
<summary>
Details about the structure of the <code>results</code> directory [click to expand]
</summary>

**Data organization**.
All the data lives in the `results` directory. There are three directories:
 - `standard`: standard Polybench benchmarks
 - `unrolled`: unrolled versions of select Polybench benchmarks
 - `systolic`: Systolic array data.

Each of these directories have a `calyx` and an `hls` directory which contain
a json file for each benchmark.

**Data processing**.
For easier processing, we transform the `json` files into `csv` files. This is done with
the `analysis/data_format.ipynb` notebook file.

 - Navigate to the `analysis/data_format.ipynb` notebook.
 - Click "Restart the kernel, then re-run the whole notebook" button (⏩).
 - Check that a `data.csv` file has appeared in each of the data directories (`results/standard/hls/data.csv`, `results/standard/futil/data.csv`, ...).

Run the notebook, and check to make sure that `data.csv` files have appeared in each of
the data directories.

**Graph generation**.
The graph generating is done in `analysis/artfact.ipynb`.
 - Navigate to the `analysis/artfact.ipynb` notebook.
 - Click "Restart the kernel and re-run the whole notebook" button (⏩)️.
 - All the graphs will be generated within the notebook under headers that correspond with the figures
 in the paper.
</details>

## Data Collection
In this section, we will collect the data required to reproduce the figures in
the paper.
Start by moving the results directory somewhere else:
```
mv results result_provided
```

The following explanations will regenerate all the data files in the `results/`
directory.
At the end of this section, you can reopen the Jupyter notebook from the previous
section and regenerate the graphs with the data you collected.

Each subsection uses a single script to collect data for a study.
The scripts use [fud][], a tool we built to generate and compile Calyx programs
and invoke various toolchains (simulation, synthesis).

By default, the scripts run one benchmark at a time. If you configured your VM to use more CPU cores
and memory, you can increase the parallelism with the `-j` flag. For example:
```
./scripts/systolic_hls.sh -j4
```
This allows 4 jobs to run in parallel and will help things run faster. However, you may run into
`Out of Memory` failures. If this happens, simply re-run the script with less parallelism.

<details>
<summary>Explanation of various flags used by `fud` to automate the evaluation [click to expand]</summary>
    <ul>
        <li><code>--to hls-estimate</code>: Uses Vivado HLS to compile and estimate resource usage of an input Dahlia/C++ program.</li>
        <li><code>--to resource-estimate</code>: Uses Vivado to synthesis Verilog and estimate resource usage.</li>
        <li><code>--to vcd_json</code>: Uses Verilator to simulate a Verilog program.</li>
        <li><code>-s systolic.flags {args}</code>: Passes in parameters to the systolic array frontend.</li>
        <li><code>-s verilog.data {data file}</code>: Passes in a json data file to be given to Verilator for simulation.</li>
    </ul>
</details>

### HLS vs. Systolic Array (Estimated time: ~30 minutes)
In this section, we will collect data to reproduce Figure 5a and 5b which
compare the estimated cycle count and resource usage of HLS designs and
Calyx-based systolic arrays.

**Vivado HLS (Estimate time: 1-2 minutes):**
To gather the Vivado HLS data, run:
```
./scripts/systolic_hls.sh
```
<details>
<summary>The script is a simple wrapper over the following <code>fud</code> calls: [click to expand]</summary>
    <ul>
        <li><code>fud e {dahlia file} --to hls-estimate</code></li>
    </ul>
</details>

<details>
<summary>Relevant files: [click to expand]</summary>
    This script uses the sources here:
    <ul>
        <li><code>benchmarks/systolic_sources/*.fuse</code></li>
    </ul>
    to generate the data:
    <ul>
        <li><code>results/systolic/hls/*.json</code></li>
    </ul>
</details>

**Calyx (Estimated time: 30 minutes):**
To gather the Calyx systolic array data, run:
```
./scripts/systolic_calyx.sh
```
<details>
<summary>The script is a simple wrapper over the following <code>fud</code> calls: [click to expand]</summary>
    <ul>
        <li><code>fud e --from systolic --to resource-estimate -s systolic.flags {parameters}</code></li>
        <li><code>fud e --from systolic --to vcd_json -s systolic.flags {parameters} -s verilog.data {data}</code></li>
    </ul>
</details>

<details>
<summary>Relevant files: [click to expand]</summary>
    This script uses the sources here:
    <ul>
        <li><code>benchmarks/systolic_sources/*.systolic</code></li>
        <li><code>benchmarks/systolic_sources/*.systolic.data</code></li>
    </ul>
    to generate the data:
    <ul>
        <li><code>results/systolic/futil/*.json</code></li>
        <li><code>results/systolic/futil-latency/*.json</code></li>
    </ul>
</details>

----

### HLS vs. Calyx (Estimated time: 4-5 hours)
This section reproduces Figure 6a and 6b which compare the estimated cycle
count and resource usage of HLS and Calyx-based designs.

**Vivado HLS** (Estimated time: 8 minutes):
To gather the Polybench HLS data, run:
```
./scripts/polybench_hls.sh
```
<details>
<summary>The script is a simple wrapper over the following <code>fud</code> calls: [click to expand]</summary>
    <ul>
        <li><code>fud e {dahlia file} --to hls-estimate</code></li>
    </ul>
</details>

<details>
<summary>Relevant files: [click to expand]</summary>
    This script uses the sources here:
    <ul>
        <li><code>benchmarks/polybench/*.fuse</code></li>
        <li><code>benchmarks/unrolled/*.fuse</code></li>
    </ul>
    to generate the data:
    <ul>
        <li><code>results/standard/hls/*.json</code></li>
        <li><code>results/unrolled/hls/*.json</code></li>
    </ul>
</details>

**Calyx** (Estimated time: 75 minutes):
To gather the Polybench Calyx data, run:
```
./scripts/polybench_calyx.sh
```
<details>
<summary>The script is a simple wrapper over the following <code>fud</code> calls: [click to expand]</summary>
    <ul>
        <li><code>fud e {dahlia file} --to resouce-estimate</code></li>
        <li><code>fud e {dahlia file} --to vcd_json</code></li>
    </ul>
</details>

<details>
<summary>Relevant files: [click to expand]</summary>
    This script uses the sources here:
    <ul>
        <li><code>benchmarks/polybench/*.fuse</code></li>
        <li><code>benchmarks/polybench/*.fuse.data</code></li>
        <li><code>benchmarks/unrolled/*.fuse</code></li>
        <li><code>benchmarks/unrolled/*.fuse.data</code></li>
    </ul>
    to generate the data:
    <ul>
        <li><code>results/standard/hls/*.json</code></li>
        <li><code>results/unrolled/hls/*.json</code></li>
    </ul>
</details>

----

### Latency-Sensitive compilation (Estimated time: 15 minutes)
In this section, we will collect data to reproduce Figure 6c which captures
the change in cycle count when enabling latency sensitive compilation (Section
4.4) with the Calyx compiler.

**Data** (Estimated time: 15 minutes):
To gather the latency sensitive vs. latency insensitive data, run:
```
./scripts/latency_sensitive.sh
```
<details>
<summary>The script is a simple wrapper over the following <code>fud</code> calls: [click to expand]</summary>
    <ul>
        <li><code>fud e {dahlia file} --to vcd_json -s verilog.data {data}</code></li>
        <li><code>fud e {dahlia file} --to vcd_json -s verilog.data {data} -s futil-flags '-d static-timing'</code></li>
    </ul>
</details>

<details>
<summary>Relevant files: [click to expand]</summary>
    This script uses the sources here:
    <ul>
        <li><code>benchmarks/polybench/*.fuse</code></li>
        <li><code>benchmarks/polybench/*.fuse.data</code></li>
    </ul>
    to generate the data:
    <ul>
        <li><code>results/latency-sensitive/with-static-timing/*.json</code></li>
        <li><code>results/latency-sensitive/no-static-timing/*.json</code></li>
    </ul>
</details>

## (Optional) Writing a Calyx Program (Estimated time: 15 minutes)

[Our tutorial][hello-world] guides you through the process of writing a
Calyx program *by hand* and demonstrates how we use `fud` to simplify working
with Calyx programs.

[calyx]: https://github.com/cucapra/futil
[calyx-eval]: https://github.com/cucapra/futil-evaluation
[calyx-install]: https://capra.cs.cornell.edu/calyx/
[fud]: https://capra.cs.cornell.edu/calyx/tools/fud.html
[dahlia]: https://github.com/cucapra/dahlia
[calyx-install-testing]: https://capra.cs.cornell.edu/calyx/#testing-dependencies
[vivado-webpack]: https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_Unified_2019.2_1106_2127_Lin64.bin
[verismith]: https://johnwickerson.github.io/papers/verismith_fpga20.pdf
[hello-world]: https://capra.cs.cornell.edu/calyx/tutorial/langtut.html
[vm-link]: https://cornell.box.com/s/xkvdmtl4l3rhj0gy8qbxo7tzra5bb266
[virtualbox]: https://www.virtualbox.org/

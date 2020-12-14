# Instructions
This document details how to use `vagrant` to build the Virtual Machine for the artifact.

## Dependencies
Make sure that you have [vagrant][] and [virtualbox][] installed to your system locally.

## Download the Vivado/Vivado HLS installer.
For licensing reasons, we can't distributed Vivado or Vivado HLS directly with the Virtual
Machine. However, we can ship the installer. Download it [here][vivado-webpack].
To build the VM make sure that the installer
is called `Xilinx_Unified_2019.2_1106_2127_Lin64.bin` and located in the same directory
as the `Vagrantfile`.

## Disk resizing plugin
Install the vagrant disksize plugin: `vagrant plugin install vagrant-disksize`.

## Creating the Virtual machine image
 - Run `vagrant up` and wait for this to finish.
 - Run `vagrant halt`.
 - Run `GUI=1 vagrant up`.
 - Login to the `vagrant` user with `vagrant` as the password.
 You'll need to select the right user from the drop-down.
 - Run `vagrant halt`.
 - Open the VirtualBox gui and find the created VM.
 - Click Settings. Then navigate to 'Serial Ports'.
 - Disable all the serial ports.
 - Right click on entry for the VM and select, `Export to OCI`.
 - Click through and `Export`.

## Install Vivado tools with WebPACK
In this step, we install the necessary Vivado tools so that we can synthesis Verilog designs and run Vivado HLS.

### Start the Virtual Machine
Open the virtual machine in the manager of your choosing (we used VirtualBox). Start the machine and login to the `vagrant`
user (select this from the drop down menu) with the password `vagrant`.

[vagrant]: https://www.vagrantup.com/
[virtualbox]: https://www.virtualbox.org/
[vivado-webpack]: https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_Unified_2019.2_1106_2127_Lin64.bin

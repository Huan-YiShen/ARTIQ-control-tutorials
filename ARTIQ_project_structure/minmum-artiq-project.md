# The minimum setup for an ARTIQ project include the following

In this repository, we define an **ARTIQ project** as a code repository that utilizes the ARTIQ python library to control a specific set of Sinara hardware. 
It includes two components: (1) custom ARTIQ-python experiment scripts that can be run on the hardware, and (2) configuration files that specifies the project environment and hardware configuration, namely `flake.nix` and `device_db.py`. This page focuses on understanding (2), additional documentation will used to focus specifically on the structure of ARTIQ-python experiment scripts.


## What is in an ARTIQ project
1. Configured Sinara hardware accessible via the network (or use `DAX.sim`)
2. `device_db.py` specifies the hardware configuration for this ARTIQ project
3. `flake.nix` specifies the software environment of this ARTIQ project
4. Any `ARTIQ-python experiment scripts` that one would execute on the Sinara hardware

Bare minimum file structure for an ARTIQ project
```
/my_artiq_project
    |- flake.nix
    |- device_db.py
    |- /repository
          |- my_artiq_python_expr_1.py
          |- my_artiq_python_expr_2.py
          |-...
```

Setting up the physical Sinara hardware requires building the gateware to generate a bitstream and
flashing the bitstream onto the Kasli FPGA boards. Within ARTIQ, one can define the connectivity
and configuration of your Sinara hardware in a JSON file and feed it through the ARTIQ gateware
scripts to generate the bitstream. Then one can flash the bit-stream on to the FPGA (for a step-by-step tutorial, see [Flash Kasli](../Flash_Kasli/configure_sinara_system.md))

The `device_db.py` file acts similarly to the device tree files in embedded systems. It should match
exactly to the physical Sinara hardware connectivity and settings. User are able to generate a
device_db.py from the same Kasli config JSON used to generate the bitstream. This can be done
using the script provided within the ARTIQ source code [artiq ddb template](https://github.com/m-labs/artiq/blob/master/artiq/frontend/artiq_ddb_template.py). Any additional
device, such as the [NDSP](https://m-labs.hk/artiq/manual/developing_a_ndsp.html), can be manually added into the device_db.py file.

The `flake.nix` file specifies all the software dependencies within your ARTIQ project, such as
pandas, matplotlib, or other custom libraries. A [template file](https://m-labs.hk/artiq/manual/installing.html#flake-custom-environments) can be found in the manual
and user can modify it to fit the needs of their project. 

The experimental scripts is how we ultimately tells the system what to do. Such as turn ON/OFF an specific RF signal that drives an AOM, or a complex sequence of quantum gate experiments.

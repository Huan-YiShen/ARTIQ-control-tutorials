# Flashing Kasli and Kasli SoC card

This page is a step-by-step tutorial for flashing the Sinara hardware system. Core reference is from the [manual](https://m-labs.hk/artiq/manual/flashing.html#writing-the-flash).

This page is a continuation of [configure Sinara System](Flash_Kasli\configure_sinara_system.md). We assume you  have obtained the desried configuration binaries. There are three ways of flashing discussed on this page

1. [Use OpenOCD and `artiq_flash`](#flashing-kasli), work with Kasli, not KasliSoC
2. [Use SD card](#flashing-kaslisoc), work fo KasliSoC, not Kasli
3. [Over the nextwork with `artiq_coremgmt`](#flashing-over-the-network), work for both Kasli and KasliSoC, but if failed, need to revert back to one of the first two options

## Kasli vs. Kasli SoC

Now that we have generated the binary files, we can proceed to flash these file onto the Kasli FPGA chips. At the time of writing, Sinara offers two types of Kasli cards ([see store page](https://sinara.technosystem.pl/module-category/controllers/)), and the process for flashing these two cards are noticeably different.

1. [Kasli card](https://sinara.technosystem.pl/modules/kasli/)
    - FPGA chip: **AMD Artix-7 FPGA**
    - Flashing method: **SPI Flash for FPGA configuration**
2. [Kasli SoC card](https://sinara.technosystem.pl/modules/kasli-soc/)
    - FPGA chip: **AMD Zynq-7000 SoC (XC7Z030)**
    - Flashing method: **SD Card slot for firmware storage**

Both cards function similarily, but the hardware on Kasli SoC is an upgrade from the original Kasli card in almost every way (you can compare the specs on their website or just ask AI to summarize them). The main difference we care about here are their FPGA chip and how we can flash gateware onto these chips.

## Flashing Kasli

```bash
!!! this does NOT work with KasliSoC !!!
```

Since the Kasli card uses an **AMD Artix-7 FPGA** chip which is volatile and does not have any hardcore processors, we need to flash our binary files onto an external SPI Flash memory chip. Whenever Kasli powers on, the FPGA chip could boot form the flash memory to setup a softcore processor. To achieve this we can employ a tool called OpenOCD. If OpenOCD is not already installed with your artiq nix environment, you can follow the guide in the manual to [install OpenOCD in nix](https://m-labs.hk/artiq/manual/flashing.html#installing-and-configuring-openocd).

Then you can use the `artiq_flash` command to flash the binary files, [see ref](https://m-labs.hk/artiq/manual/utilities.html#module-artiq.frontend.artiq_flash). The command requires a directory path which should contain the following files, they should be generated directly from the configuration JSON.

```bash
top.bit
runtime.elf
runtime.fbi
bootloader.bin
```

Procedure Summary:

1. Find the generated binary file from config JSON. For Kasli, it should contain the 4 files describes above
2. Ensure OpenOCD is installed in your ARTIQ nix environment
    1. Go into your nix environment (e.g. `nix develop`) and type `which openocd`
    2. If not avaliable, install it following this guide [install OpenOCD in nix](https://m-labs.hk/artiq/manual/flashing.html#installing-and-configuring-openocd)
3. Connect your computer with (OpenOCD + the binary files) to the Kasli card's microUSB port
4. In your ARTIQ nix environment, run `artiq_flash -d <binary_directory>` to flash the gateware and firmware ([command ref](https://m-labs.hk/artiq/manual/utilities.html#module-artiq.frontend.artiq_flash))

## Flashing KasliSoC

Since the KasliSoC uses an **AMD Zynq-7000 SoC (XC7Z030)**, its flashing procedure is noticeably different. First, instead of 4 binary files, the KasliSoC gateware generation process should only produce one `boot.bin` file. Second, instead of a using SPI Flash memory chip to store the binries, KasliSoC includes an micro SD card slot so we can directly put our `boot.bin` file into an SD card and slot it in. This also skips the OpenOCD part, so we do NOT need the `artiq_flash` command.

Now `boot.bin` contains only the static firmware, so we need a way to specify all the unique, device-specific network and runtime settings. ARTIQ uses a plaint `config.txt` file for this purpose, [see ref](https://m-labs.hk/artiq/manual-beta/core_device.html#configuration-storage).

Procedure Summary:

1. Find the generated binary file `boot.bin` from config JSON
2. Create the `config.txt` file and set `ip=` field to what is written in your `device_db.py` (`device_db.py` should also be generated when you generate your binary from the config JSON)
3. Shut down you Sinara system and take out the micro SD card from the KasliSoC
4. Move the `boot.bin` and `config.txt` into the SD card (remove any other files on the SD card, back them up just in case)
5. Put the SD card back and power on to reboot the KasliSoC

## Flashing over the network

If your system is already setup and running, and you can use `artiq_coremgmt` command to quickly reflash over the network. But if the reflash was unsuccessful, Kasli may fail to establish network connection, at this point we need to use either the SD card method for KasliSoC or the OpenOCD method of the Kasli card. See [ref](https://m-labs.hk/artiq/manual-beta/flashing.html#writing-the-flash)

## Debugging

If there's any issue during the flashing process, you can setup an UART connection to monitor activity log, [see ref](https://m-labs.hk/artiq/manual/flashing.html#connecting-to-the-uart-log)
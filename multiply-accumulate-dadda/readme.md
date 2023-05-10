# Optimised Multiply Accumulate Circuit using Dadda Multiplier Architecture

## Done as part of the coursework in EE 671 - VLSI Design

- This contains the VHDL description of a multiply-accumulate circuit which multiplies two 8 bit operands and adds a 16 bit number to the product $\ A \cdot B + C$. Implemented using Brent Kung Adder and Dadda Multiplier Architecture.
- The VHDL hardware descriptions given for `andgate`, `abcgate`,
`xorgate`, `Cin_map_G` in [Assignment 4](https://github.com/rohankalbag/ee671-iitb/blob/main/brent-kung-adder/report.pdf) were directly imported into
`gates.vhdl` **and was kept unchanged**. 
- The 16-bit Brent Kung adder
`brentkung` description was moved into a file called `adders.vhdl`.
- Descriptions for **Full Adder** with entity name `fa`, and **Half
Adder** with entity name `ha` were created using the gates provided as
follows and stored in `adders.vhdl`.

## Simulation of DUT using GHDL

- The latest version of `ghdl` was installed and the bash script `test.sh`
was created to minimize the commands to be entered on terminal while
testing the circuit and preparing the testcases.
- This script provides reports on whether the testcases have passed or
not. Additionally makes `wave.ghw` file which can be used to study all
the signals


## Submission Details

- Detailed report with results can be found in this [documentation](https://github.com/rohankalbag/ee671-iitb/blob/main/multiply-accumulate-dadda/report.pdf)
- The submission contains `mac.vhdl`, `adders.vhdl`, `gates.vhdl`,
`testbench.vhdl`, `testcase_generator.py`, the bash script `test.sh`,
the outputs and testcases for the test simulated above and waveform
generated `wave.ghw`. The RTL was synthesised using Intel Quartus, its
project files have been included in `rtl_files.zip`

## System Requirements

- Linux Operating System or Git Bash/WSL on Windows
- [GHDL - Open Source VHDL Simulator](http://ghdl.free.fr/)
- [GTKwave - Open Source Waveform
  Analyser](https://gtkwave.sourceforge.net/)
- [Python 3.x](https://www.python.org/downloads/)

## Instructions to Test

- Make sure all system requirements are satisfied
- Open a terminal in the project directory
- Type the following `bash test.sh`
- The waveform can be accessed by opening `wave.ghw` using GTKWave

## Intel Quartus Generated RTL

Just for the sake of completeness, the **RTL** was generated for the
`mac` entity using **Intel Quartus**. The project RTL files can be found in `rtl_files.zip`

This is the CPC FPGA project - a modern reimplementation of the Amstrad CPC
on an FPGA.

Whilst it's designed for use with the Amstrad CPC, the board could be
used for almost any 8-bit system. Alternatively, it could be used as a
cheap FPGA development board that includes a SCART socket, RAM, flash ROM,
PS/2 keyboard, twin joystick ports, tape input, etc...

This repo is a partial snapshot of my private repo, and currently only
contains the schematic and board layout for revision 1 of the board along
with the code required for the Atmega controller.

I am currently working on a newer revision of the board, which will be
made public once I'm satisfed that it works well and has no major bugs.

LICENCES

The Atmega source code uses the LUFA library, licensed under the MIT library.
Please see licence/LUFA-License.txt for copyright information.

The schematic and board layout are currently licensed under the Creative
Commons Attribution-Share Alike 3.0.
Please see http://creativecommons.org/licenses/by-sa/3.0/ for more information.

If you make derivative works, you must license under a compatible licence
and include the following text:
Portions of this project are derived from CPC FPGA, (c) 2011-2013 Ranulf Doswell

Any VHDL code is currently not open sourced unless explicitly mentioned.
The scope of the project is solely the hardware design and software for the
support chip.

If you need a commercial licence for the hardware portion of this project,
please contact licensing@ranulf.net for more information.

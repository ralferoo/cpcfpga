
PLEASE NOTE THAT THIS IS ONLY A PARTIAL REPOSITORY DUMP WHILE I TRY TO
SEPARATE PUBLIC AND PRIVATE PARTS...

-------------------------------------------------------------------------------

Contents
--------

This is the CPC FPGA project - a modern reimplementation of the Amstrad CPC
on an FPGA.

Whilst it's designed for use with the Amstrad CPC, the board could be
used for almost any 8-bit system. Alternatively, it could be used as a
cheap FPGA development board that includes a SCART socket, RAM, flash ROM,
PS/2 keyboard, twin joystick ports, tape input, etc...

The project is structured in these subdirectories:

bitstreams	Contains FPGA images that can be loaded from SD card
client		Contains Linux utilities to communicate with the board
datasheets	Miscellaneous datasheets (obtained publically, but are NOT
		part of this project)
docs		Various snippets of documentation I've written at various times
hardware/case	The case for revision 2 of CPC FPGA, for laser cutter use
hardware/eagle	The eagle schematic and circuit design for:
			homeboard30  (revision 1)
			homeboard99r (revision 2)
hardware/spice	Various spice analysis snippets
library/hdl	VHDL files that can be used in projects hosted on CPC FPGA
projects	Contains FPGA projects to be run on the CPC FPGA.
sidecar2	The firmware for the CPC FPGA suport chip
stuff		Old bits and bobs, to be deleted
Makefile	Used to build the system
README.txt	This file

-------------------------------------------------------------------------------

Building the CPC FPGA project
-----------------------------

The user part of CPC FPGA program can be built simply by running "make".

Other build targets:

all		Rebuild client and bitstreams
clean		Clean all build files, excluding final targets
bitstreams	Rebuild all the FPGA bitstream files

scan		Check to see if the CPC FPGA board is present
log		Keep an eye on the diagnostic log from the CPC FPGA board
dump		Dump the CPC FPGA image stored in the PROM
reload		Reload the CPC FPGA image stored in the PROM
xxx.load	Reload the CPC FPGA image for project xxx
xxx.program	Programs the CPC FPGA's PROM with the image for project xxx

sidecar2	Rebuild just the firmware
dfu		Install the firmware
reset		Resets the firmware

-------------------------------------------------------------------------------

LICENCES

The Atmega source code uses the LUFA library, licensed under the MIT library.
Please see licence/LUFA-License.txt for copyright information.

The schematic and board layout are currently licensed under the Creative
Commons Attribution-Share Alike 3.0.
Please see http://creativecommons.org/licenses/by-sa/3.0/ for more information.

If you make derivative works, you must license under a compatible licence
and include the following text:
Portions of this project are derived from CPC FPGA, (c) 2011-2013 Ranulf Doswell

Other than including the above attribution, you should rename the derivative
work so that it cannot be confused with the original CPC FPGA project, nor
can you refer to CPC FPGA in a manner that suggests the derivative work is
endorsed by CPC FGPA or used by CPC FPGA.

Any VHDL code is currently not open sourced unless explicitly mentioned.
The scope of the project is solely the hardware design and software for the
support chip.

If you need a commercial licence for the hardware portion of this project,
please contact licensing@ranulf.net for more information.

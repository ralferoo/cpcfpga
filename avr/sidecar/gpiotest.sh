#!/bin/sh

#TDO_PROM	WHITE		GPIO 22 (IN)
#TMS		GREY		GPIO 21
#TCK		PURPLE		GPIO 17
#TDI_FPGA	BLUE		GPIO 4

GPIO_TMS=21
GPIO_TCK=17
GPIO_TDI=4
GPIO_TDO=22

fnInitPin()
{
	echo $1 >/sys/class/gpio/export
	echo $2 >/sys/class/gpio/gpio$1/direction
}

fnOutPin()
{
	echo $2 >/sys/class/gpio/gpio$1/value
}

fnInPin()
{
	cat /sys/class/gpio/gpio$1/value
}

fnPulseClock()
{
	fnOutPin $GPIO_TCK 1
	fnOutPin $GPIO_TCK 0
}

fnOutput()
{
# data TMS
	echo -n "TDI: $1 TMS: $2 - TDO: "

	fnOutPin $GPIO_TDI $1
	fnOutPin $GPIO_TMS $2
	fnInPin  $GPIO_TDO
	fnPulseClock
}

fnReset()
{
	fnOutPin $GPIO_TMS 1
	fnPulseClock
	fnPulseClock
	fnPulseClock
	fnPulseClock
	fnPulseClock
	fnPulseClock
}

fnInitPin $GPIO_TMS out
fnInitPin $GPIO_TCK out
fnInitPin $GPIO_TDI out
fnInitPin $GPIO_TDO in

fnScanIR()
{
	fnReset
	fnOutput 0 0	# move to idle
	fnOutput 0 1	# move to select DR
	fnOutput 0 1	# move to select IR
	fnOutput 0 0	# move to capture IR
	fnOutput 0 0	# move to shift IR

	echo BYPASS scan

	i=0
	while test $i != 20
	do
		fnOutput 1 0
		fnOutput 0 0
		fnOutput 1 0
		fnOutput 0 0
		fnOutput 1 0
		fnOutput 0 0
		fnOutput 1 0
		fnOutput 0 0
		echo
		i=`expr $i + 1`
	done

	echo BYPASS scan done

	fnReset
}

fnScanDR()
{
	fnReset
	fnOutput 0 0	# move to idle
	fnOutput 0 1	# move to select DR
	fnOutput 0 0	# move to capture DR
	fnOutput 0 0	# move to shift DR

	echo BYPASS scan

	i=0
	while test $i != 20
	do
		fnOutput 1 0
		fnOutput 0 0
		fnOutput 1 0
		fnOutput 0 0
		fnOutput 1 0
		fnOutput 0 0
		fnOutput 1 0
		fnOutput 0 0
		echo
		i=`expr $i + 1`
	done

	echo BYPASS scan done

	fnReset
}

fnScanDR

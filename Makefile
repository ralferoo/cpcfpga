
all:
	@echo Hello

clean:
	c:\cygwin\bin\rm -f synthesis/top.edn

syn: synthesis/top.edn

synthesis/top.edn: hdl/top.vhd
	C:\Actel\Libero_v9.1\Synopsys\synplify_E201009A-1\bin\mbin\synplify.exe -product synplify_pro manual_syn.prj


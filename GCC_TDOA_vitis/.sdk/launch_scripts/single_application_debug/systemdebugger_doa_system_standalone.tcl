connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-HS1 210512180081" && level==0} -index 1
fpga -file E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/DOA/_ide/bitstream/pl_top.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/pl_top/export/pl_top/hw/pl_top.xsa -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/DOA/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/DOA/Debug/DOA.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con

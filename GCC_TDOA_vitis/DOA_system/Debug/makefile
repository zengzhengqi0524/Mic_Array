#
# This file was created by Xilinx Vitis tool.
#


#
# tools
#

RM = rm -f
RMDIR = rm -rf

#
# variables
#

SDCARD_GEN = sdcard_gen
GENERATE_BIF = ::scw::generate_bif

XPFM_PATH = E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/pl_top/export/pl_top/pl_top.xpfm
SYS_CONFIG = pl_top
DOMAINS = standalone_domain
BIF_PATH = E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/DOA_system/Debug/system.bif

BITSTREAM_PATH = E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/DOA/_ide/bitstream/pl_top.bit
SD_FILES = --elf E:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/DOA/Debug/DOA.elf,ps7_cortexa9_0

#
# primary build targets
#

all: sd_card

sd_card:
	-@echo Generating bif file for the system project
	generate_system_bif.bat 7121 ${XPFM_PATH} ${DOMAINS} ${BIF_PATH}
	${SDCARD_GEN} --xpfm ${XPFM_PATH} --sys_config ${SYS_CONFIG} --bif ${BIF_PATH} --bitstream ${BITSTREAM_PATH} ${SD_FILES}

clean:
	$(RMDIR) ./_sds
	${RMDIR} sd_card
	${RM} system.bif

.PHONY: all sd_card clean



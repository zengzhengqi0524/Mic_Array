################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/easyMatrix.c \
../src/helloworld.c \
../src/init.c \
../src/led.c \
../src/platform.c \
../src/tdoa_angle.c 

OBJS += \
./src/easyMatrix.o \
./src/helloworld.o \
./src/init.o \
./src/led.o \
./src/platform.o \
./src/tdoa_angle.o 

C_DEPS += \
./src/easyMatrix.d \
./src/helloworld.d \
./src/init.d \
./src/led.d \
./src/platform.d \
./src/tdoa_angle.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -IE:/WorkSpace/FPGA_Workspace/Mic_Array/GCC_TDOA_vitis/pl_top/export/pl_top/sw/pl_top/standalone_domain/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '



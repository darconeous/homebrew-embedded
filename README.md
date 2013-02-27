Various Toolchains and Tools for Embedded Development
=====================================================

## Getting Started ##

	brew tap darconeous/embedded

### Code Sourcery ARM Toolchain 2008q3 (arm-none-eabi) ###

	brew install arm-2008q3-gcc

### AVR ###

	brew install avr-gcc
	brew install avr-gdb
	brew install avrdude
	brew install dfu-programmer

### 8052 (CC253x, CC243x, CC110x, etc.) ###

	brew install darconeous/sdcc # SDCC with special fixes
	brew install cc-tool         # For using the CC-Debugger
	brew install srecord

### smcpctl (if you are doing CoAP development) ###

	brew install smcp



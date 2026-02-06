AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OCOPY = arm-none-eabi-objcopy
BUILD_DIR = build

ASFLAGS = -mcpu=cortex-m4 -mthumb 
LDFLAGS = -Tf407.ld 
OCOPYFLAGS = -O binary

SRC = challenge.s
MAIN_ELF = main.elf
MAIN_OBJ = main.o
MAIN_BIN = firmware.bin

F407_SRC = challenge_f407.s
F407_ELF = f407.elf
F407_OBJ = f407.o
F407_BIN = f407.bin

all: 
	$(AS) $(ASFLAGS) $(SRC) -o $(MAIN_OBJ)
	$(LD) $(LDFLAGS) $(MAIN_OBJ) -o $(MAIN_ELF)
	$(OCOPY) $(OCOPYFLAGS) $(MAIN_ELF) $(MAIN_BIN)

.PHONY: clean
clean:
	rm $(MAIN_BIN) $(MAIN_OBJ) $(MAIN_ELF) $(F407_BIN) $(F407_OBJ) $(F407_ELF)

.PHONY: flash
flash:

	@echo "Flashing $(MAIN_BIN)..."
	openocd -f /usr/share/openocd/scripts/interface/stlink.cfg \
	-f /usr/share/openocd/scripts/target/stm32f4x.cfg \
		-c "program $(MAIN_BIN) 0x08000000 reset exit"


.PHONY: debug
debug:

	@echo "Flashing $(MAIN_BIN)..."
	openocd -f /usr/share/openocd/scripts/interface/stlink.cfg \
	-f /usr/share/openocd/scripts/target/stm32f4x.cfg \
		-c "program $(MAIN_BIN) 0x08000000 reset exit"

	@echo "Starting OpenOCD server..."
	openocd -f /usr/share/openocd/scripts/interface/stlink.cfg \
	-f /usr/share/openocd/scripts/target/stm32f4x.cfg & \
	gf2 $(MAIN_BIN) \
		-ex "target remote localhost:3333" \
		-ex "monitor reset halt" 
	
	pkill openocd

.PHONY: f407
f407:
	$(AS) $(ASFLAGS) $(F407_SRC) -o $(F407_OBJ)
	$(LD) $(LDFLAGS) $(F407_OBJ) -o $(F407_ELF)
	$(OCOPY) $(OCOPYFLAGS) $(F407_ELF) $(F407_BIN)

.PHONY: flash_f407
flash_f407:

	@echo "Flashing $(F407_BIN)..."
	openocd -f /usr/share/openocd/scripts/interface/stlink.cfg \
	-f /usr/share/openocd/scripts/target/stm32f4x.cfg \
		-c "program $(F407_BIN) 0x08000000 reset exit"

.PHONY: debug
debug_f407:

	@echo "Flashing $(F407_BIN)..."
	openocd -f /usr/share/openocd/scripts/interface/stlink.cfg \
	-f /usr/share/openocd/scripts/target/stm32f4x.cfg \
		-c "program $(F407_BIN) 0x08000000 reset exit"

	@echo "Starting OpenOCD server..."
	openocd -f /usr/share/openocd/scripts/interface/stlink.cfg \
	-f /usr/share/openocd/scripts/target/stm32f4x.cfg & \
	gf2 $(F407_BIN) \
		-ex "target remote localhost:3333" \
		-ex "monitor reset halt" 
	
	pkill openocd

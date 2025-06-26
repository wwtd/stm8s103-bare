TARGET = uid-and-eeprom

SRC := $(wildcard src/*.c)
OBJ := $(patsubst src/%.c, debug/%.rel, $(SRC))

CC = sdcc
CFLAGS = --std-c99 -mstm8 --opt-code-speed --out-fmt-ihx -Iinclude

all: $(TARGET).ihx

debug/%.rel: src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET).ihx: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

stm8flash:
	stm8flash -c stlinkv2 -p stm8s103f3 -w $(TARGET).ihx

clean:
	rm -f *.asm *.lst *.rel *.rst *.sym *.ihx *.lk *.map *.cdb
	rm -rf ./debug/*

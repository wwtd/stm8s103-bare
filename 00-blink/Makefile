TARGET = blink
SRC = main.c
OBJ = $(SRC:.c=.rel)

CC = sdcc
CFLAGS = --std-c99 -mstm8 --opt-code-speed --out-fmt-ihx

all: $(TARGET).ihx

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

$(TARGET).ihx: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

stm8flash:
	stm8flash -c stlinkv2 -p stm8s103f3 -w $(TARGET).ihx

clean:
	rm -f *.asm *.lst *.rel *.rst *.sym *.ihx *.lk *.map *.cdb

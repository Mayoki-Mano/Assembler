
AS = /usr/bin/nasm
LD = /usr/bin/ld

ASFLAGS = -g -f elf64

LDFLAGS = -static -lc 


SRCS = lab3.s



OBJS = $(SRCS:.s=.o)

EXE = lab3
all: $(SRCS) $(EXE)

clean:
	rm -rf $(EXE) $(OBJS)

$(EXE): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@

.s.o:
	$(AS) $(ASFLAGS) $< -o $@


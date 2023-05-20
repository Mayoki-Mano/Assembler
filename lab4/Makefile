AS = nasm
LD = gcc

ASFLAGS = -g -f elf64

LDFLAGS = -no-pie -lc -lm


SRCS = lab4.s



OBJS = $(SRCS:.s=.o)

EXE = lab4
all: $(SRCS) $(EXE)

$(EXE): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@

.s.o:
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf $(EXE) $(OBJS)

AS = nasm
CC = gcc
LD = gcc

ASFLAGS = -g -f elf64
CCFLAGS = -lm -no-pie -Wall
СFLAG = -c

SRCC = lab5.c
SRCSS = asm_func.s
SRCSC = lab5_with_asm.c

OBJSS = $(SRCSS:.s=.o)
OBJSC = $(SRCSC:.c=.o)
OBJC = $(SRCC:.c=.o)

EXE = lab5
EXE2 = lab5withAsm
all: $(SRCC) $(SRCSC) $(SRCSS) $(EXE) $(EXE2)

$(EXE): $(OBJSS) $(OBJC) $(OBJSC)
	$(LD) $(OBJC) -o $@ $(CCFLAGS)

$(EXE2): $(OBJSS) $(OBJC) $(OBJSC)
	$(LD) $(OBJSS) $(OBJSC) -o $@ $(CCFLAGS)
.s.o:
	$(AS) $(ASFLAGS) $< -o $@
.c.o:
	$(CC) $(OBJSS) $< -o $@ $(CCFLAGS)
clean:
	rm -rf $(EXE) $(OBJSS) $(OBJC) $(OBJSC) $(EXE2)






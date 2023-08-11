
AS = /usr/bin/nasm
LD = /usr/bin/ld

ASFLAGS = -g -f elf64 -D SORT_TYPE=$(SORT_TYPE)

LDFLAGS = -static 


SRCS = lab2.s



OBJS = $(SRCS:.s=.o)

EXE = lab2
ifeq ($(SORT_TYPE),right_sort)
ASFLAGS += -D RIGHT_SORT
endif
all: $(SRCS) $(EXE)

clean:
	rm -rf $(EXE) $(OBJS)

$(EXE): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@

.s.o:
	$(AS) $(ASFLAGS) $< -o $@


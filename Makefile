SRCS = $(wildcard *.c)
PROGS = $(patsubst %.c,%,$(SRCS))
CC = kcc

all: $(PROGS)
%: %.c
	$(CC) $(CFLAGS) -o $@ $<
clean: 
	rm -f $(PROGS)
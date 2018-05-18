SRCS = $(wildcard *.c)
PROGS = $(patsubst %.c,%,$(SRCS))
CC = kcc
LD=kcc
CFLAGS=-fissue-report=./my_errors.json

all: $(PROGS)
%: %.c
	$(CC) $(CFLAGS) -o $@ $<
clean: 
	rm -f $(PROGS)

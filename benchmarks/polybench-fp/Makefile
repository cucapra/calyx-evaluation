SRCS := $(wildcard *.fuse.m4)
TARGETS := $(SRCS:.fuse.m4=.futil)

%.fuse: %.fuse.m4
	m4 $< > $@

%.futil: %.fuse
	fud e $< -o $@

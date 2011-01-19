SRCDIR=src
OBJDIR=build
BINDIR=bin

CFLAGS=-g -Wall -Werror -O0
INCLUDE=-I./src/

OBJECTS=$(addprefix $(OBJDIR)/, hello.o)

all: $(BINDIR)/main postbuild

$(BINDIR)/main: $(SRCDIR)/hello.h $(OBJECTS) | $(BINDIR)
	cc $(CFLAGS) $(INCLUDE) $^ main.c -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	cc -c $^ -o $@

$(OBJDIR) $(BINDIR):
	mkdir $@

postbuild: $(BINDIR)/main
	$<

.PHONY: clean
clean:
	rm -rf $(OBJDIR) $(BINDIR)

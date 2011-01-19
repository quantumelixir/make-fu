SRCDIR=src
OBJDIR=build

CFLAGS=-g -Wall -Werror -O0
INCLUDE=-I./src/

OBJECTS=$(addprefix $(OBJDIR)/, hello.o)

all: $(OBJDIR)/main | postbuild

$(OBJDIR)/main: $(SRCDIR)/hello.h $(OBJECTS)
	cc $(CFLAGS) $(INCLUDE) $^ main.c -o $(OBJDIR)/main

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	cc -c $^ -o $@

$(OBJDIR):
	mkdir $(OBJDIR)

postbuild: $(OBJDIR)/main
	$<

.PHONY: clean
clean:
	rm -rf $(OBJDIR)

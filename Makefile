CC=cc
CFLAGS=-g -Wall -Werror -O0
INCLUDE=-I./src/

SRCDIR=src
OBJDIR=build
BINDIR=bin

OBJECTS=$(addprefix $(OBJDIR)/, hello.o)
TARGETS=$(addprefix $(BINDIR)/, main extra)

all: $(TARGETS) postbuild

.SECONDEXPANSION:
$(TARGETS): $$(@F).c $(SRCDIR)/hello.h $(OBJECTS) | $(BINDIR)
	$(CC) $(CFLAGS) $(INCLUDE) $^ -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) -c $^ -o $@

$(OBJDIR) $(BINDIR):
	mkdir $@

postbuild: $(TARGETS)
	for i in $^; do ./$$i; done

.PHONY: clean backup
clean:
	rm -rf $(OBJDIR) $(BINDIR)

backup:
	tar cvzf ../backup.tar.gz --exclude="*$(OBJDIR)" \
		--exclude="*$(BINDIR)" .

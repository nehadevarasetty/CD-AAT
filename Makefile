# ── Makefile for Lex + Yacc Lexical Analyzer ─────────────────────
#
# Tools used:
#   lex   – generates lex.yy.c  from lexer.l
#   yacc  – generates y.tab.c and y.tab.h from parser.y
#   gcc   – compiles both C files into the final binary
#
# Build:  make
# Run:    make run
# Clean:  make clean

CC      = gcc
LEX     = lex
YACC    = yacc
CFLAGS  = -Wall -Wextra
TARGET  = lexer
INPUT   = test_input.c

.PHONY: all run clean

all: $(TARGET)

# Step 1: Yacc generates y.tab.c (parser) and y.tab.h (token codes)
y.tab.c y.tab.h: parser.y
	$(YACC) -d parser.y

# Step 2: Lex generates lex.yy.c (scanner) using token codes from y.tab.h
lex.yy.c: lexer.l y.tab.h
	$(LEX) lexer.l

# Step 3: Compile both generated C files into one binary
$(TARGET): y.tab.c lex.yy.c
	$(CC) $(CFLAGS) -o $(TARGET) y.tab.c lex.yy.c -ll -ly

# Run the lexer on the test input
run: $(TARGET)
	./$(TARGET) $(INPUT)

# Remove all generated files
clean:
	rm -f lex.yy.c y.tab.c y.tab.h $(TARGET)

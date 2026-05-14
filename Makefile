# ── Makefile for Lex-based Lexical Analyzer ─────────────────────

CC      = gcc
FLEX    = flex
CFLAGS  = -Wall -Wextra
TARGET  = lexer
LEX_SRC = lexer.l
LEX_C   = lex.yy.c
INPUT   = test_input.c

.PHONY: all run clean

all: $(TARGET)

# Step 1: Flex generates lex.yy.c from lexer.l
$(LEX_C): $(LEX_SRC) tokens.h
	$(FLEX) $(LEX_SRC)

# Step 2: gcc compiles lex.yy.c into the lexer binary
$(TARGET): $(LEX_C)
	$(CC) $(CFLAGS) -o $(TARGET) $(LEX_C) -lfl 2>/dev/null || \
	$(CC) $(CFLAGS) -o $(TARGET) $(LEX_C)   # fallback if -lfl absent

# Step 3: Run the lexer on the test file
run: $(TARGET)
	./$(TARGET) $(INPUT)

clean:
	rm -f $(LEX_C) $(TARGET)

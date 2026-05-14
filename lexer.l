%{
#include <stdio.h>
#include <string.h>
#include "tokens.h"

/* Token table entry */
typedef struct {
    int  token_id;
    char lexeme[256];
    char type[32];
} TokenEntry;

TokenEntry token_table[1024];
int token_count = 0;

void add_token(int id, const char *lexeme, const char *type) {
    token_table[token_count].token_id = id;
    strncpy(token_table[token_count].lexeme, lexeme, 255);
    strncpy(token_table[token_count].type,   type,   31);
    token_count++;
}
%}

/* ── Flex options ─────────────────────────────────────────────── */
%option noyywrap
%option yylineno

/* ── Definitions ──────────────────────────────────────────────── */
DIGIT        [0-9]
LETTER       [a-zA-Z_]
ID           {LETTER}({LETTER}|{DIGIT})*
INTEGER      {DIGIT}+
FLOAT        {DIGIT}+\.{DIGIT}+
STRING       \"([^\"\\]|\\.)*\"

%%

 /* ── Single-line comments (C++/Java style) ─────────────────── */
"//"[^\n]*                      { /* ignore */ }

 /* ── Multi-line comments (C style) ─────────────────────────── */
"/*"([^*]|\*+[^*/])*\*+"/"     { /* ignore */ }

 /* ── Whitespace ─────────────────────────────────────────────── */
[ \t\r\n]+                      { /* ignore */ }

 /* ── Keywords ───────────────────────────────────────────────── */
"int"       { add_token(TOK_INT,      yytext, "KEYWORD"); return TOK_INT;      }
"float"     { add_token(TOK_FLOAT_KW, yytext, "KEYWORD"); return TOK_FLOAT_KW; }
"char"      { add_token(TOK_CHAR,     yytext, "KEYWORD"); return TOK_CHAR;     }
"double"    { add_token(TOK_DOUBLE,   yytext, "KEYWORD"); return TOK_DOUBLE;   }
"void"      { add_token(TOK_VOID,     yytext, "KEYWORD"); return TOK_VOID;     }
"if"        { add_token(TOK_IF,       yytext, "KEYWORD"); return TOK_IF;       }
"else"      { add_token(TOK_ELSE,     yytext, "KEYWORD"); return TOK_ELSE;     }
"while"     { add_token(TOK_WHILE,    yytext, "KEYWORD"); return TOK_WHILE;    }
"for"       { add_token(TOK_FOR,      yytext, "KEYWORD"); return TOK_FOR;      }
"do"        { add_token(TOK_DO,       yytext, "KEYWORD"); return TOK_DO;       }
"return"    { add_token(TOK_RETURN,   yytext, "KEYWORD"); return TOK_RETURN;   }
"break"     { add_token(TOK_BREAK,    yytext, "KEYWORD"); return TOK_BREAK;    }
"continue"  { add_token(TOK_CONTINUE, yytext, "KEYWORD"); return TOK_CONTINUE; }
"switch"    { add_token(TOK_SWITCH,   yytext, "KEYWORD"); return TOK_SWITCH;   }
"case"      { add_token(TOK_CASE,     yytext, "KEYWORD"); return TOK_CASE;     }
"default"   { add_token(TOK_DEFAULT,  yytext, "KEYWORD"); return TOK_DEFAULT;  }
"struct"    { add_token(TOK_STRUCT,   yytext, "KEYWORD"); return TOK_STRUCT;   }

 /* ── Identifiers ─────────────────────────────────────────────── */
{ID}        { add_token(TOK_ID,       yytext, "IDENTIFIER"); return TOK_ID;    }

 /* ── Constants ───────────────────────────────────────────────── */
{FLOAT}     { add_token(TOK_FLOAT_CONST, yytext, "FLOAT_CONST");   return TOK_FLOAT_CONST;   }
{INTEGER}   { add_token(TOK_INT_CONST,   yytext, "INT_CONST");     return TOK_INT_CONST;     }
{STRING}    { add_token(TOK_STR_CONST,   yytext, "STRING_CONST");  return TOK_STR_CONST;     }

 /* ── Relational Operators ─────────────────────────────────────── */
"=="        { add_token(TOK_EQ,  yytext, "REL_OP"); return TOK_EQ;  }
"!="        { add_token(TOK_NEQ, yytext, "REL_OP"); return TOK_NEQ; }
"<="        { add_token(TOK_LE,  yytext, "REL_OP"); return TOK_LE;  }
">="        { add_token(TOK_GE,  yytext, "REL_OP"); return TOK_GE;  }
"<"         { add_token(TOK_LT,  yytext, "REL_OP"); return TOK_LT;  }
">"         { add_token(TOK_GT,  yytext, "REL_OP"); return TOK_GT;  }

 /* ── Logical Operators ───────────────────────────────────────── */
"&&"        { add_token(TOK_AND, yytext, "LOG_OP"); return TOK_AND; }
"||"        { add_token(TOK_OR,  yytext, "LOG_OP"); return TOK_OR;  }
"!"         { add_token(TOK_NOT, yytext, "LOG_OP"); return TOK_NOT; }

 /* ── Arithmetic Operators ─────────────────────────────────────── */
"+"         { add_token(TOK_PLUS,  yytext, "ARITH_OP"); return TOK_PLUS;  }
"-"         { add_token(TOK_MINUS, yytext, "ARITH_OP"); return TOK_MINUS; }
"*"         { add_token(TOK_MUL,   yytext, "ARITH_OP"); return TOK_MUL;   }
"/"         { add_token(TOK_DIV,   yytext, "ARITH_OP"); return TOK_DIV;   }
"%"         { add_token(TOK_MOD,   yytext, "ARITH_OP"); return TOK_MOD;   }

 /* ── Assignment Operators ─────────────────────────────────────── */
"+="        { add_token(TOK_PLUS_EQ,  yytext, "ASSIGN_OP"); return TOK_PLUS_EQ;  }
"-="        { add_token(TOK_MINUS_EQ, yytext, "ASSIGN_OP"); return TOK_MINUS_EQ; }
"*="        { add_token(TOK_MUL_EQ,   yytext, "ASSIGN_OP"); return TOK_MUL_EQ;   }
"/="        { add_token(TOK_DIV_EQ,   yytext, "ASSIGN_OP"); return TOK_DIV_EQ;   }
"="         { add_token(TOK_ASSIGN,   yytext, "ASSIGN_OP"); return TOK_ASSIGN;   }

 /* ── Increment / Decrement ───────────────────────────────────── */
"++"        { add_token(TOK_INC, yytext, "UNARY_OP"); return TOK_INC; }
"--"        { add_token(TOK_DEC, yytext, "UNARY_OP"); return TOK_DEC; }

 /* ── Bitwise Operators ───────────────────────────────────────── */
"&"         { add_token(TOK_BAND, yytext, "BIT_OP"); return TOK_BAND; }
"|"         { add_token(TOK_BOR,  yytext, "BIT_OP"); return TOK_BOR;  }
"^"         { add_token(TOK_BXOR, yytext, "BIT_OP"); return TOK_BXOR; }
"~"         { add_token(TOK_BNOT, yytext, "BIT_OP"); return TOK_BNOT; }

 /* ── Punctuation / Delimiters ─────────────────────────────────── */
"("         { add_token(TOK_LPAREN,    yytext, "DELIMITER"); return TOK_LPAREN;    }
")"         { add_token(TOK_RPAREN,    yytext, "DELIMITER"); return TOK_RPAREN;    }
"{"         { add_token(TOK_LBRACE,    yytext, "DELIMITER"); return TOK_LBRACE;    }
"}"         { add_token(TOK_RBRACE,    yytext, "DELIMITER"); return TOK_RBRACE;    }
"["         { add_token(TOK_LBRACKET,  yytext, "DELIMITER"); return TOK_LBRACKET;  }
"]"         { add_token(TOK_RBRACKET,  yytext, "DELIMITER"); return TOK_RBRACKET;  }
";"         { add_token(TOK_SEMICOLON, yytext, "DELIMITER"); return TOK_SEMICOLON; }
","         { add_token(TOK_COMMA,     yytext, "DELIMITER"); return TOK_COMMA;     }
"."         { add_token(TOK_DOT,       yytext, "DELIMITER"); return TOK_DOT;       }
":"         { add_token(TOK_COLON,     yytext, "DELIMITER"); return TOK_COLON;     }

 /* ── Unknown character ───────────────────────────────────────── */
.           { fprintf(stderr, "Line %d: Unknown character '%s'\n", yylineno, yytext); }

%%

/* ── Print the token table ─────────────────────────────────────── */
void print_token_table(void) {
    printf("\n");
    printf("╔══════╦══════════════════════════╦══════════════════╗\n");
    printf("║  No. ║ Lexeme                   ║ Token Type       ║\n");
    printf("╠══════╬══════════════════════════╬══════════════════╣\n");
    for (int i = 0; i < token_count; i++) {
        printf("║ %4d ║ %-24s ║ %-16s ║\n",
               i + 1,
               token_table[i].lexeme,
               token_table[i].type);
    }
    printf("╚══════╩══════════════════════════╩══════════════════╝\n");
    printf("\nTotal tokens: %d\n", token_count);
}

/* ── Main ─────────────────────────────────────────────────────── */
int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <source_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Cannot open file");
        return 1;
    }

    printf("Lexical Analysis of: %s\n", argv[1]);
    printf("===========================================\n");

    while (yylex() != 0);   /* drive the lexer */

    fclose(yyin);
    print_token_table();
    return 0;
}

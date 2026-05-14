%{
/*
 * parser.y  –  Yacc specification for a C lexical analyzer
 * Build:  yacc -d parser.y  →  y.tab.c  +  y.tab.h
 * The grammar accepts any sequence of tokens (the token stream
 * produced by the Lex scanner) and triggers token table printing
 * at end of input.  No parse tree is built; Yacc is used here to
 * define the token namespace and drive the scanner.
 */

#include <stdio.h>
#include <stdlib.h>

/* Declared in lexer.l / lex.yy.c */
extern int   yylex(void);
extern FILE *yyin;
extern void  print_token_table(void);
extern int   token_count;

void yyerror(const char *msg) {
    fprintf(stderr, "Parse error: %s\n", msg);
}
%}

/* ── Token declarations ────────────────────────────────────────
   yacc -d writes these as #define lines into y.tab.h,
   which lexer.l includes instead of tokens.h              */

/* Keywords */
%token TOK_INT       300
%token TOK_FLOAT_KW  301
%token TOK_CHAR      302
%token TOK_DOUBLE    303
%token TOK_VOID      304
%token TOK_IF        305
%token TOK_ELSE      306
%token TOK_WHILE     307
%token TOK_FOR       308
%token TOK_DO        309
%token TOK_RETURN    310
%token TOK_BREAK     311
%token TOK_CONTINUE  312
%token TOK_SWITCH    313
%token TOK_CASE      314
%token TOK_DEFAULT   315
%token TOK_STRUCT    316

/* Identifiers and constants */
%token TOK_ID          320
%token TOK_INT_CONST   321
%token TOK_FLOAT_CONST 322
%token TOK_STR_CONST   323

/* Relational operators */
%token TOK_EQ   330
%token TOK_NEQ  331
%token TOK_LE   332
%token TOK_GE   333
%token TOK_LT   334
%token TOK_GT   335

/* Logical operators */
%token TOK_AND  340
%token TOK_OR   341
%token TOK_NOT  342

/* Arithmetic operators */
%token TOK_PLUS  350
%token TOK_MINUS 351
%token TOK_MUL   352
%token TOK_DIV   353
%token TOK_MOD   354

/* Assignment operators */
%token TOK_ASSIGN    360
%token TOK_PLUS_EQ   361
%token TOK_MINUS_EQ  362
%token TOK_MUL_EQ    363
%token TOK_DIV_EQ    364

/* Unary operators */
%token TOK_INC  370
%token TOK_DEC  371

/* Bitwise operators */
%token TOK_BAND  380
%token TOK_BOR   381
%token TOK_BXOR  382
%token TOK_BNOT  383

/* Delimiters */
%token TOK_LPAREN    390
%token TOK_RPAREN    391
%token TOK_LBRACE    392
%token TOK_RBRACE    393
%token TOK_LBRACKET  394
%token TOK_RBRACKET  395
%token TOK_SEMICOLON 396
%token TOK_COMMA     397
%token TOK_DOT       398
%token TOK_COLON     399

%%

/*
 * Grammar: a program is a sequence of zero or more tokens.
 * Each alternative in token_list matches one token type.
 * The grammar is intentionally flat — we only need to consume
 * every token the lexer produces; no tree structure is built.
 */

program
    : token_list
    ;

token_list
    : /* empty */
    | token_list token
    ;

token
    : TOK_INT       | TOK_FLOAT_KW  | TOK_CHAR      | TOK_DOUBLE
    | TOK_VOID      | TOK_IF        | TOK_ELSE       | TOK_WHILE
    | TOK_FOR       | TOK_DO        | TOK_RETURN     | TOK_BREAK
    | TOK_CONTINUE  | TOK_SWITCH    | TOK_CASE       | TOK_DEFAULT
    | TOK_STRUCT
    | TOK_ID
    | TOK_INT_CONST | TOK_FLOAT_CONST | TOK_STR_CONST
    | TOK_EQ        | TOK_NEQ       | TOK_LE         | TOK_GE
    | TOK_LT        | TOK_GT
    | TOK_AND       | TOK_OR        | TOK_NOT
    | TOK_PLUS      | TOK_MINUS     | TOK_MUL        | TOK_DIV
    | TOK_MOD
    | TOK_ASSIGN    | TOK_PLUS_EQ   | TOK_MINUS_EQ   | TOK_MUL_EQ
    | TOK_DIV_EQ
    | TOK_INC       | TOK_DEC
    | TOK_BAND      | TOK_BOR       | TOK_BXOR       | TOK_BNOT
    | TOK_LPAREN    | TOK_RPAREN    | TOK_LBRACE     | TOK_RBRACE
    | TOK_LBRACKET  | TOK_RBRACKET  | TOK_SEMICOLON  | TOK_COMMA
    | TOK_DOT       | TOK_COLON
    ;

%%

/* ── Main ──────────────────────────────────────────────────────── */
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

    yyparse();          /* Yacc calls yylex() internally */

    fclose(yyin);
    print_token_table();
    return 0;
}

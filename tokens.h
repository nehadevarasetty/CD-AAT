#ifndef TOKENS_H
#define TOKENS_H

/* ── Keywords ─────────────────────────────────── */
#define TOK_INT       300
#define TOK_FLOAT_KW  301
#define TOK_CHAR      302
#define TOK_DOUBLE    303
#define TOK_VOID      304
#define TOK_IF        305
#define TOK_ELSE      306
#define TOK_WHILE     307
#define TOK_FOR       308
#define TOK_DO        309
#define TOK_RETURN    310
#define TOK_BREAK     311
#define TOK_CONTINUE  312
#define TOK_SWITCH    313
#define TOK_CASE      314
#define TOK_DEFAULT   315
#define TOK_STRUCT    316

/* ── Identifiers & Constants ──────────────────── */
#define TOK_ID          320
#define TOK_INT_CONST   321
#define TOK_FLOAT_CONST 322
#define TOK_STR_CONST   323

/* ── Relational Operators ─────────────────────── */
#define TOK_EQ   330
#define TOK_NEQ  331
#define TOK_LE   332
#define TOK_GE   333
#define TOK_LT   334
#define TOK_GT   335

/* ── Logical Operators ────────────────────────── */
#define TOK_AND  340
#define TOK_OR   341
#define TOK_NOT  342

/* ── Arithmetic Operators ─────────────────────── */
#define TOK_PLUS  350
#define TOK_MINUS 351
#define TOK_MUL   352
#define TOK_DIV   353
#define TOK_MOD   354

/* ── Assignment Operators ─────────────────────── */
#define TOK_ASSIGN    360
#define TOK_PLUS_EQ   361
#define TOK_MINUS_EQ  362
#define TOK_MUL_EQ    363
#define TOK_DIV_EQ    364

/* ── Unary Operators ──────────────────────────── */
#define TOK_INC  370
#define TOK_DEC  371

/* ── Bitwise Operators ────────────────────────── */
#define TOK_BAND  380
#define TOK_BOR   381
#define TOK_BXOR  382
#define TOK_BNOT  383

/* ── Delimiters ───────────────────────────────── */
#define TOK_LPAREN    390
#define TOK_RPAREN    391
#define TOK_LBRACE    392
#define TOK_RBRACE    393
#define TOK_LBRACKET  394
#define TOK_RBRACKET  395
#define TOK_SEMICOLON 396
#define TOK_COMMA     397
#define TOK_DOT       398
#define TOK_COLON     399

#endif /* TOKENS_H */

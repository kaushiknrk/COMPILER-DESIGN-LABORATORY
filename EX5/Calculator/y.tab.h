#define INT 257
#define DOUBLE 258
#define PLUS 259
#define MINUS 260
#define MUL 261
#define DIV 262
#define POW 263
#define LPAREN 264
#define RPAREN 265
#define NEWLINE 266
#define QUIT 267
#define UMINUS 268
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union {
    int    ival;
    double dval;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;

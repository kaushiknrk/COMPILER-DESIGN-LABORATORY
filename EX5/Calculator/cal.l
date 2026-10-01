%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option noyywrap

%%

[ \t]+              ;

[0-9]+              { yylval.ival = atoi(yytext); return INT; }
[0-9]+\.[0-9]*      { yylval.dval = atof(yytext); return DOUBLE; }
\.[0-9]+            { yylval.dval = atof(yytext); return DOUBLE; }

"quit"|"exit"       { return QUIT; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return MUL; }
"/"                 { return DIV; }
"^"                 { return POW; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"\n"                { return NEWLINE; }

.                   { return yytext[0]; }

%%

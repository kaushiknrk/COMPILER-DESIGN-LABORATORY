%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex(void);
void yyerror(const char *s);

%}

%union {
    int    ival;
    double dval;
}

%token <ival> INT
%token <dval> DOUBLE
%token PLUS MINUS MUL DIV POW
%token LPAREN RPAREN
%token NEWLINE QUIT

%type <dval> EXP

%left  PLUS MINUS
%left  MUL DIV
%right POW
%right UMINUS

%%

S:
      /* empty */
    | S line
    ;

line:
      NEWLINE
        { printf("> "); }
    | EXP NEWLINE
        {
            printf("Result: %.6f\n", $1);
            printf("> ");
        }
    | QUIT NEWLINE
        { printf("Exiting...\n"); exit(0); }
    | error NEWLINE
        { yyerrok; printf("> "); }
    ;

EXP:
      INT
        { $$ = (double)$1; }

    | DOUBLE
        { $$ = $1; }

    | EXP PLUS EXP
        { $$ = $1 + $3; }

    | EXP MINUS EXP
        { $$ = $1 - $3; }

    | EXP MUL EXP
        { $$ = $1 * $3; }

    | EXP DIV EXP
        {
            if ($3 == 0.0) {
                yyerror("Division by zero");
                $$ = 0.0;
            } else {
                $$ = $1 / $3;
            }
        }

    | EXP POW EXP
        { $$ = pow($1, $3); }

    | MINUS EXP %prec UMINUS
        { $$ = -$2; }

    | LPAREN EXP RPAREN
        { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {

    printf("Type 'quit' to exit\nEnter any Expression:");
    yyparse();
    return 0;
}


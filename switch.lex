%{
#include <stdio.h>
#include <string.h>

int case_count = 0;
int default_count = 0;
%}

%%

"switch" {
    printf("\n[SWITCH] switch statement found\n");
}

"case" {
    case_count++;
    printf("\n[CASE %d] case label found\n", case_count);
}

"default" {
    default_count++;
    printf("\n[DEFAULT] default label found\n");
}

/* Arithmetic operators */
"+"  { printf("Arithmetic operator: +\n"); }
"-"  { printf("Arithmetic operator: -\n"); }
"*"  { printf("Arithmetic operator: *\n"); }
"/"  { printf("Arithmetic operator: /\n"); }
"%"  { printf("Arithmetic operator: %%\n"); }

/* Relational operators */
"==" { printf("Relational operator: ==\n"); }
"!=" { printf("Relational operator: !=\n"); }
"<=" { printf("Relational operator: <=\n"); }
">=" { printf("Relational operator: >=\n"); }
"<"  { printf("Relational operator: <\n"); }
">"  { printf("Relational operator: >\n"); }

/* Logical operators */
"&&" { printf("Logical operator: &&\n"); }
"||" { printf("Logical operator: ||\n"); }
"!"  { printf("Logical operator: !\n"); }

/* Assignment operators */
"+=" { printf("Assignment operator: +=\n"); }
"-=" { printf("Assignment operator: -=\n"); }
"*=" { printf("Assignment operator: *=\n"); }
"/=" { printf("Assignment operator: /=\n"); }
"%=" { printf("Assignment operator: %%=\n"); }
"="  { printf("Assignment operator: =\n"); }

/* Increment and decrement */
"++" { printf("Increment operator: ++\n"); }
"--" { printf("Decrement operator: --\n"); }

/* Bitwise operators */
"&"  { printf("Bitwise operator: &\n"); }
"|"  { printf("Bitwise operator: |\n"); }
"^"  { printf("Bitwise operator: ^\n"); }
"<<" { printf("Bitwise shift operator: <<\n"); }
">>" { printf("Bitwise shift operator: >>\n"); }
"~"  { printf("Bitwise complement operator: ~\n"); }

/* Brackets and punctuation */
"("  { printf("Left parenthesis: (\n"); }
")"  { printf("Right parenthesis: )\n"); }
"{"  { printf("Left brace: {\n"); }
"}"  { printf("Right brace: }\n"); }
"["  { printf("Left bracket: [\n"); }
"]"  { printf("Right bracket: ]\n"); }
":"  { printf("Colon: :\n"); }
";"  { printf("Semicolon: ;\n"); }
","  { printf("Comma: ,\n"); }

/* Control statements */
"break" {
    printf("Control statement: break\n");
}

"continue" {
    printf("Control statement: continue\n");
}

"return" {
    printf("Control statement: return\n");
}

/* Conditional statements inside a case */
"if" {
    printf("Conditional statement: if\n");
}

"else" {
    printf("Conditional statement: else\n");
}

/* Loops inside a case */
"for" {
    printf("Loop statement: for\n");
}

"while" {
    printf("Loop statement: while\n");
}

"do" {
    printf("Loop statement: do\n");
}

/* Input/output */
"printf" {
    printf("Library function: printf()\n");
}

"scanf" {
    printf("Library function: scanf()\n");
}

/* Data types / declarations */
"int" {
    printf("Data type: int\n");
}

"float" {
    printf("Data type: float\n");
}

"char" {
    printf("Data type: char\n");
}

"double" {
    printf("Data type: double\n");
}

/* Integer constants */
[0-9]+ {
    printf("Integer constant: %s\n", yytext);
}

/* Floating-point constants */
[0-9]+\.[0-9]+ {
    printf("Floating constant: %s\n", yytext);
}

/* Character constants */
\'[a-zA-Z0-9]\' {
    printf("Character constant: %s\n", yytext);
}

/* String constants */
\"([^\"\\]|\\.)*\" {
    printf("String constant: %s\n", yytext);
}

/* Identifiers */
[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
}

/* Ignore spaces and newlines */
[ \t\n]+ ;

/* Anything else */
. {
    printf("Unknown symbol: %s\n", yytext);
}

%%

int main()
{
    printf("Enter the switch statement:\n\n");

    yylex();

    printf("\n-----------------------------\n");
    printf("Switch Analysis Completed\n");
    printf("-----------------------------\n");

    printf("Number of case labels    : %d\n", case_count);
    printf("Number of default labels : %d\n", default_count);

    return 0;
}

int yywrap()
{
    return 1;
}

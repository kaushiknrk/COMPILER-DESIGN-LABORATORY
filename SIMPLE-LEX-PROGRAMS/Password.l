%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
%}

%%

[a-zA-Z][a-zA-Z0-9&@$_\-]* {
    int i;
    int len = strlen(yytext);
    int upper = 0, lower = 0, digit = 0, special = 0;
    int valid = 1;

    if (len < 8) {
        printf("Invalid password: Length should be at least 8.\n");
        valid = 0;
    }
    if (len > 64) {
        printf("Invalid Password: Length should not exceed 64.\n");
        valid = 0;
    }

    for (i = 0; i < len; i++) {
        if (isupper(yytext[i])) {
            upper = 1;
        }
        if (islower(yytext[i])) {
            lower = 1;
        }
        if (isdigit(yytext[i])) {
            digit = 1;
        }
        if (yytext[i] == '&' || yytext[i] == '@' || yytext[i] == '$' || yytext[i] == '-' || yytext[i] == '_') {
            special = 1;
        }
    }

    if (!upper) {
        printf("Invalid: No uppercase letter\n");
        valid = 0;
    }
    if (!lower) {
        printf("Invalid: No lowercase letter\n");
        valid = 0;
    }
    if (!digit) {
        printf("Invalid: No digit\n");
        valid = 0;
    }
    if (!special) {
        printf("Invalid: No special character available\n");
        valid = 0;
    }

    if (valid) {
        printf("Valid Password\n");
        return 0;
    }
}

[^ \t\n]+ {
    printf("Invalid Password: Should start with an alphabet and contain only valid characters.\n");
}

[ \t\n]+ ;

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter Password: ");
    yylex();
    return 0;
}

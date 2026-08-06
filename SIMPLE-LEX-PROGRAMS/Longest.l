%{
#include <stdio.h>
#include <string.h>

int max = 0;
char longest[100][100];
int count = 0;
%}

%%

[a-zA-Z][a-zA-Z0-9]*   {
    int len = strlen(yytext);

    if (len > max)
    {
        max = len;
        count = 0;

        if (count < 100) {
            strcpy(longest[count], yytext);
            count++;
        }
    }
    else if (len == max)
    {
        if (count < 100) {
            strcpy(longest[count], yytext);
            count++;
        }
    }
}

[ \t\n]+    ;

.           ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    int i;

    yyin = fopen("long.txt", "r");
    if (yyin == NULL)
    {
        printf("Cannot open input file\n");
        return 1;
    }

    yylex();

    printf("Longest string length = %d\n", max);
    printf("The longest string is ");
    for (i = 0; i < count; i++)
    {
        printf("%s\n", longest[i]);
    }

    fclose(yyin);
    return 0;
}

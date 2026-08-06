%{
#include <stdio.h>
#include <stdlib.h>

char *month[] = {
    "jan", "feb", "mar", "apr", "may", "jun",
    "jul", "aug", "sep", "oct", "nov", "dec"
};
%}

%%
[0-3][0-9]-[0-1][0-9]-[0-9][0-9][0-9][0-9]   {
    int d, m, y;


    sscanf(yytext, "%2d-%2d-%4d", &d, &m, &y);

    if (m >= 1 && m <= 12)
    {

        printf("%02d,%s,%04d\n", d, month[m - 1], y);
    }
    else
    {
        printf("Invalid date: %s\n", yytext);
    }
}

.|\n     ECHO;
%%

int yywrap()
{
    return 1;
}

int main()
{
    yyin = fopen("date.txt", "r");
    if (yyin == NULL)
    {
        printf("File not found\n");
        return 1;
    }

    yylex();
    fclose(yyin);
    return 0;
}

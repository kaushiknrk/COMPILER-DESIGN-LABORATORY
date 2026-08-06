%{
#include <stdio.h>
#include <string.h>

FILE *out;
int count = 0;

void checkAndLogPalindrome(char *str)
{
    int i, j;
    int len = strlen(str);
    int isPal = 1;

    for (i = 0, j = len - 1; i < j; i++, j--)
    {
        if (str[i] != str[j])
        {
            isPal = 0;
            break;
        }
    }

    if (isPal == 1)
    {
        fprintf(out, "%s\n", str);
        count++;
    }
}
%}

%%
[0-9]+   {
    checkAndLogPalindrome(yytext);
}

[ \t\n]+      ;

.             ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    FILE *in;

    in = fopen("palin.txt", "r");
    if (in == NULL)
    {
        printf("Cannot open input file\n");
        return 1;
    }

    out = fopen("palindrome.txt", "w");
    if (out == NULL)
    {
        printf("Cannot open output file\n");
        fclose(in);
        return 1;
    }

    yyin = in;
    yyout = out;

    yylex();

    printf("Number of palindrome strings = %d\n", count);

    fclose(in);
    fclose(out);

    return 0;
}

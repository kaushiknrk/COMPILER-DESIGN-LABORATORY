#include <stdio.h>
#include <string.h>

#define MAX_STATES 20
#define MAX_SYMBOLS 20
#define MAX_INPUT 100

int transitionTable[MAX_STATES][MAX_SYMBOLS];
char symbols[MAX_SYMBOLS];

int noStates;
int noSymbols;

int startState;
int finalStates[MAX_STATES];
int noFinalStates;


/* Find the index of a symbol in the alphabet */
int getSymbolIndex(char ch)
{
    int i;

    for (i = 0; i < noSymbols; i++)
    {
        if (symbols[i] == ch)
            return i;
    }

    return -1;
}


/* Check whether a state is an accepting state */
int isAccepting(int state)
{
    int i;

    for (i = 0; i < noFinalStates; i++)
    {
        if (finalStates[i] == state)
            return 1;
    }

    return 0;
}


/*
    DFA Lexer

    Processes the complete input string.

    If a character is not in the alphabet,
    that character is printed as an
    unrecognized token and the lexer
    continues from the next character.
*/
void DfaLexer(char w[])
{
    int fp = 0;
    int cs;
    int lastAcceptedPosition;

    while (w[fp] != '\0')
    {
        /* Start DFA from initial state */
        cs = startState;

        /* Stores the last accepting position */
        lastAcceptedPosition = -1;

        /*
            Process characters until:
            1. End of string
            2. No transition is possible
            3. Character is not in alphabet
        */
        while (w[fp] != '\0')
        {
            int symbolIndex;
            int ns;

            symbolIndex = getSymbolIndex(w[fp]);

            /*
                Character is not present
                in DFA alphabet.
            */
            if (symbolIndex == -1)
            {
                break;
            }

            ns = transitionTable[cs][symbolIndex];

            /*
                No transition exists.
            */
            if (ns == -1)
            {
                break;
            }

            /* Move to next state */
            cs = ns;

            /* Move forward */
            fp++;

            /*
                If current state is accepting,
                remember this position.
            */
            if (isAccepting(cs))
            {
                lastAcceptedPosition = fp;
            }
        }


        /*
            If an accepting state was reached,
            print the longest recognized lexeme.
        */
        if (lastAcceptedPosition != -1)
        {
            printf("Recognized Lexeme: ");

            for (int i = 0; i < lastAcceptedPosition; i++)
            {
                printf("%c", w[i]);
            }

            printf("\n");

            /*
                Move fp to the position after
                the recognized lexeme.
            */
            fp = lastAcceptedPosition;
        }
        else
        {
            /*
                No valid lexeme was recognized.

                If the current character is not
                in the alphabet, print it as an
                unrecognized token.
            */
            if (w[fp] != '\0')
            {
                printf("Unrecognized Token: %c\n", w[fp]);

                /* Skip the invalid character */
                fp++;
            }
        }
    }
}


int main()
{
    int i, j;
    char inputString[MAX_INPUT];
    char choice;

    /* ---------------- DFA INPUT ---------------- */

    printf("Enter number of states: ");
    scanf("%d", &noStates);

    printf("Enter number of symbols: ");
    scanf("%d", &noSymbols);

    printf("Enter the symbols:\n");

    for (i = 0; i < noSymbols; i++)
    {
        scanf(" %c", &symbols[i]);
    }


    /* Input transition table */
    printf("\nEnter transition table:\n");

    for (i = 0; i < noStates; i++)
    {
        for (j = 0; j < noSymbols; j++)
        {
            printf("State %d on symbol '%c' -> ",
                   i, symbols[j]);

            scanf("%d", &transitionTable[i][j]);
        }
    }


    /* Input initial state */
    printf("\nEnter initial state: ");
    scanf("%d", &startState);


    /* Input accepting states */
    printf("Enter number of accepting states: ");
    scanf("%d", &noFinalStates);

    printf("Enter accepting states:\n");

    for (i = 0; i < noFinalStates; i++)
    {
        scanf("%d", &finalStates[i]);
    }


    /* ---------------- LEXER LOOP ---------------- */

    do
    {
        printf("\nEnter input string: ");
        scanf("%s", inputString);

        printf("\n----- DFA LEXER OUTPUT -----\n");

        DfaLexer(inputString);

        printf("----------------------------\n");

        printf("\nDo you want to continue? (y/n): ");
        scanf(" %c", &choice);

    } while (choice == 'y' || choice == 'Y');


    printf("\nProgram terminated.\n");

    return 0;
}


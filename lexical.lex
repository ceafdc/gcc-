%{

#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>

#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif

FILE *fp;

char *KEYWORD;
char *ID;

char *
keyword_or_id(const char *text) {
    char *keywords[] = {
        "else",
        "if",
        "int",
        "return",
        "void",
        "while",
        0
    };
    for (int i = 0; keywords[i]; i++) {
        if (strcmp(keywords[i], text) == 0) {
            return KEYWORD;
        }
    }
    return ID;
}

%}

%%

"/*" {

    char c;
    int ok = FALSE;
    //ECHO;
    do{
        while ((c=input()) != '*') {
            //putchar(c);
        }
        //putchar(c);
        while ((c=input()) == '*') {
            //putchar(c);
        }
        //putchar(c);
        if (c == '/')
            ok = TRUE;
    }while(!ok);

}

[a-zA-Z]+ { fprintf(fp, "%s %s\n", yytext, keyword_or_id(yytext)); }
[0-9]+    { fprintf(fp, "%s NUM\n", yytext); }

\+ {fprintf(fp, "%s SOMA\n", yytext);}
\- {fprintf(fp, "%s SUB\n", yytext);}
\* {fprintf(fp, "%s MUL\n", yytext);}
\/ {fprintf(fp, "%s DIV\n", yytext);}
\< {fprintf(fp, "%s MENOR\n", yytext);}
\<= {fprintf(fp, "%s MEIGUAL\n", yytext);}
> {fprintf(fp, "%s MAIOR\n", yytext);}
>= {fprintf(fp, "%s MAIGUAL\n", yytext);}
== {fprintf(fp, "%s IGUAL\n", yytext);}
!= {fprintf(fp, "%s DIF\n", yytext);}
= {fprintf(fp, "%s ATRIB\n", yytext);}
\; {fprintf(fp, "%s PV\n", yytext);}
\, {fprintf(fp, "%s V\n", yytext);}
\( {fprintf(fp, "%s AP\n", yytext);}
\) {fprintf(fp, "%s FP\n", yytext);}
"\[" {fprintf(fp, "%s ACO\n", yytext);}
"\]" {fprintf(fp, "%s FCO\n", yytext);}
"\{" {fprintf(fp, "%s ACH\n", yytext);}
"\}" {fprintf(fp, "%s FCH\n", yytext);}

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s input_file\n", argv[0]);
        return EXIT_FAILURE;
    }

    ID = malloc(sizeof(char) * 100);
    strcpy(ID, "ID");
    KEYWORD = malloc(sizeof(char) * 100);
    strcpy(KEYWORD, "Palavra-chave");

    yyset_in(fopen(argv[1], "r"));
    fp = fopen("relatório.txt", "w");
    fprintf(fp, "0 erro(s) encontrado(s)\n");
    yylex();
    fflush(fp);
    fclose(fp);
    fclose(yyin);

    free(ID);
    free(KEYWORD);
    return EXIT_SUCCESS;
}

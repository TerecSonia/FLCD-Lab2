
%{
#include <stdlib.h>
#include <string.h>
#include <math.h>


typedef struct{
    int id1;
    int id2;
    }PIF;

typedef struct{
    char name[30];
}ST;

int pifLength=0;

PIF pif_table[200];

int stLength = 0;

ST st_table[20];


void addPif(int id1 , int id2){
    pif_table[pifLength].id1 = id1;
    pif_table[pifLength].id2 = id2;
    pifLength++;
}

void addSt(char* c,int code){
    
    int found = 0 ;
    int i= 0;

    while(i<stLength){
        if(strcmp(st_table[i].name,c)==0){
            found =1;
            addPif(code,i);
        }
        i++;
    }

    if (found == 0){
        strcpy(st_table[stLength].name,c);
        addPif(code,stLength);
        stLength++;
    }
}

void showPif(){
    printf("PIF\n");
    int i;
    for(i=0;i<pifLength;i++){
        if(pif_table[i].id1 != 0 && pif_table[i].id1 != 1){
          printf(" %d|-1 \n",pif_table[i].id1);
        }
        else{
          printf(" %d|%d \n",pif_table[i].id1,pif_table[i].id2);
        }
    }
}

void showSt(){
    printf("ST\n");
    int i;
    for(i = 0 ;i<stLength;i++)
        printf(" %s|%d \n", st_table[i].name , i);
    printf("\n");
}

%}

%option noyywrap
DIGIT 		[0-9]
ID      [a-zA-Z][a-zA-Z0-9]*


%%
{DIGIT}+                                addSt(yytext,1);
{DIGIT}+"."{DIGIT}*                     addSt(yytext,1);
"`"+{ID}+"`"                             addSt(yytext,1);

\identificator                          addPif(0,0);
\constanta                              addPif(1,0);
NAME                                   addPif(2,0);
BEGIN                                  addPif(3,0);
END                                    addPif(4,0);
WHETHER                                addPif(5,0);
NEXT                                   addPif(6,0);
WHILE                                  addPif(7,0);
MAKE                                   addPif(8,0);
ELSE                                   addPif(9,0);
OF                                     addPif(10,0);
PROGRAM                                addPif(11,0);
IN                                     addPif(12,0);
OUT                                    addPif(13,0);
ARR                                    addPif(14,0);
CHR                                    addPif(15,0);
INTEGER                                addPif(16,0);
REAL                                   addPif(17,0);
BOOLEAN                                addPif(18,0);
\(                                     addPif(19,0);
\)                                     addPif(20,0);
\[                                     addPif(21,0);
\]                                      addPif(22,0);
\{                                      addPif(23,0);
\}                                      addPif(24,0);
\:                                      addPif(25,0);
\;                                      addPif(26,0);
\+                                    addPif(27,0);
\-                                     addPif(28,0);
\/                                addPif(29,0);
\*                                     addPif(30,0);
\=                                      addPif(31,0);
\:=                                     addPif(32,0);
\<=                                     addPif(33,0);
\>=                                     addPif(34,0);
\<>                                    addPif(35,0);
\.                                    addPif(36,0);
\>                                      addPif(37,0);
\<                                      addPif(38,0);
\,                                      addPif(39,0);
{ID}                                    addSt( yytext,0);

[ \t\n]+             ;/* eat up whitespace */
. {
  if(yytext[0] != 13) {
    printf("error at %s or %d ! \n",yytext,yytext[0]);
  }
}
%%
int main( argc, argv )
int argc;
char **argv;
{
    ++argv, --argc; /* skip over program name */
    if ( argc > 0 )
    	yyin = fopen( argv[0], "r" );
    else
     	yyin = stdin;
    yylex();

    showSt();
    printf("\n");
    showPif();
    
}
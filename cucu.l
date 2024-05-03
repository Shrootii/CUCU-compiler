%{
    #include<stdlib.h>
    #include<stdio.h>
    #define YYSTYPE char*
    #include"cucu.tab.h"
%}

 
%%

[ \t\n]+ {};  /*space, tab, new line - removes whitespace */

\/\*(.|\n)*\*\/ ;
\/\/.* ; /* ignores comments*/


(^int|int) { fprintf(yyout, "DATATYPE: %s\n", yytext );  /*reading datatypes*/
             return(DATATYPE);}
(^char|char) { fprintf(yyout, "DATATYPE: %s\n", yytext );  
             return(DATATYPE);}
(^c|c)har" *" { fprintf(yyout, "DATATYPE: %s\n", yytext ); 
             return(DATATYPE);}

(^float|float) { fprintf(yyout, "DATATYPE: %s\n", yytext ); 
             return(DATATYPE);}

(^struct|struct) { fprintf(yyout, "STRUCT: %s\n", yytext ); 
             return(STRUCT);}


(^while|while) { fprintf(yyout, "WHILE_LOOP: %s\n", yytext );  /*reading loop*/
             return(WHILE_LOOP);}


(^if|if) { fprintf(yyout, "IF: %s\n", yytext ); /*reading conditionals*/
             return(IF);}             
(^else|else) { fprintf(yyout, "ELSE: %s\n", yytext ); 
             return(ELSE);}    


(^return|return) { fprintf(yyout, "RETURN: %s\n", yytext ); /*reading return*/
             return(RETURN);}  


[0-9]+   { fprintf(yyout, "DIGITS: %s\n", yytext );  yylval = yytext;
             return(DIGITS);}  
[a-zA-Z][a-zA-Z0-9_]* { fprintf(yyout, "WORD: %s\n", yytext ); yylval = strdup(yytext);
             return(WORD);} 

";"   { fprintf(yyout, "SEMICOLON: %s\n", yytext ); 
             return(SEMICOLON);}
","   { fprintf(yyout, "COMMA: %s\n", yytext ); 
             return(COMMA);}


"+"   { fprintf(yyout, "ADD: %s\n", yytext ); /*reading arithmetic operators*/
             return(ADD);}
"-"   { fprintf(yyout, "SUB: %s\n", yytext ); 
             return(SUB);}
"*"   { fprintf(yyout, "MUL: %s\n", yytext ); 
             return(MUL);}
"/"   { fprintf(yyout, "DIV: %s\n", yytext ); 
             return(DIV);}


"]"   { fprintf(yyout, "SQ_R: %s\n", yytext ); /*reading brackets*/
             return(SQ_R);}
"["   { fprintf(yyout, "SQ_L: %s\n", yytext ); 
             return(SQ_L);}
"("   { fprintf(yyout, "CURVE_L: %s\n", yytext ); 
             return(CURVE_L);}
")"   { fprintf(yyout, "CURVE_R: %s\n", yytext ); 
             return(CURVE_R);}
"{"   { fprintf(yyout, "CURLY_L: %s\n", yytext ); 
             return(CURLY_L);}
"}"   { fprintf(yyout, "CURLY_R: %s\n", yytext ); 
             return(CURLY_R);}


"="     { fprintf(yyout, "EQUAL: %s\n", yytext ); /*reading mathetmatical equations*/
             return(EQUAL);}  
"=="     { fprintf(yyout, "EQUAL_D: %s\n", yytext ); 
             return(EQUAL_D);} 
"!="     { fprintf(yyout, "NOT_EQUAL: %s\n", yytext ); 
             return(NOT_EQUAL);}   
">"     { fprintf(yyout, "GRT_THAN: %s\n", yytext ); 
             return(GRT_THAN);}  
">="     { fprintf(yyout, "GRT_THAN_EQUAL: %s\n", yytext ); 
             return(GRT_THAN_EQUAL);}
"<="     { fprintf(yyout, "LESS_THAN_EQUAL: %s\n", yytext ); 
             return(LESS_THAN_EQUAL);} 
"<"     { fprintf(yyout, "LESS_THAN: %s\n", yytext ); 
             return(LESS_THAN);}


(\S)+     { fprintf(yyout, "ERROR: %s\n", yytext ); } 
%%

int yywrap()
{ 
   return 1;
} 
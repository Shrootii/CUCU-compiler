%{
    #include<stdio.h>
    #include<stdlib.h>
    #define YYSTYPE char*
    int yyparse();
    extern int yylex(void);
    void yyerror (const char* message);
    FILE *yyin, *yyout, *yyout2;
%}

%token DATATYPE DIGITS WORD
%token WHILE_LOOP IF ELSE STRUCT
%token ADD SUB MUL DIV
%token SQ_R SQ_L CURVE_R CURVE_L CURLY_R CURLY_L
%token EQUAL EQUAL_D NOT_EQUAL GRT_THAN GRT_THAN_EQUAL LESS_THAN LESS_THAN_EQUAL
%token SEMICOLON COMMA RETURN


%%

program: var_decl program | var_def program | func_decl program | func_def program | ;

var_decl: DATATYPE WORD SEMICOLON ;

var_def: DATATYPE WORD {fprintf(yyout2, "variable: %s\n", yylval);} EQUAL expr SEMICOLON ;

func_decl: DATATYPE WORD CURVE_L func_parameter CURVE_R SEMICOLON
         | STRUCT WORD {fprintf(yyout2, "struct name: %s\n", yylval);} CURLY_L struct_body CURLY_R SEMICOLON
         ;

struct_body: DATATYPE WORD {fprintf(yyout2, "variable: %s\n", yylval);} SEMICOLON struct_body
           | DATATYPE WORD {fprintf(yyout2, "array: %s\n", yylval);} SQ_L DIGITS SQ_R SEMICOLON struct_body
           |
           ;

func_def: DATATYPE WORD CURVE_L func_parameter CURVE_R CURLY_L func_body CURLY_R ;

func_parameter: DATATYPE WORD {fprintf(yyout2, "Func parameter: %s\n", yylval);} COMMA func_parameter
              | DATATYPE WORD {fprintf(yyout2, "Func parameter: %s\n", yylval);}
              |
              ;

func_body: statement func_body
         | statement
         |
         ;

statement: DATATYPE WORD EQUAL expr SEMICOLON
         | WORD EQUAL expr SEMICOLON
         | RETURN expr SEMICOLON 
         | IF {fprintf(yyout2, "control_stmt : IF\n");} CURVE_L expr CURVE_R CURLY_L func_body CURLY_R
         | IF CURVE_L expr CURVE_R CURLY_L func_body CURLY_R ELSE CURLY_L func_body CURLY_R
         | WHILE_LOOP {fprintf(yyout2, "control_stmt : WHILE\n");} CURVE_L expr CURVE_R CURLY_L func_body CURLY_R
         | func_call
         | WORD EQUAL func_call
         ;


func_call: WORD CURVE_L func_argument CURVE_R SEMICOLON {fprintf(yyout2, "Func call\n");} ;

func_argument: expr {fprintf(yyout2, "Func argument\n");} COMMA func_argument
             | expr {fprintf(yyout2, "Func argument\n");} 
             |
             ;

expr: math_operation
    | boolean
    ;

math_operation: math_operation ADD {fprintf(yyout2, "+ ");} term1
              | math_operation SUB {fprintf(yyout2, "- ");} term1
              | term1
              ;

term1: term1 MUL {fprintf(yyout2, "* ");} term2
     | term1 DIV {fprintf(yyout2, "/ ");} term2
     | term2
     ;

term2: CURVE_L term2 CURVE_R
     | WORD {fprintf(yyout2, "var -%s" , yylval);}
     | DIGITS {fprintf(yyout2, "const -%s" , yylval);}
     ;

boolean:expr EQUAL_D {fprintf(yyout2, "== ");} expr
       | expr NOT_EQUAL {fprintf(yyout2, "!= ");} expr
       | expr GRT_THAN {fprintf(yyout2, "> ");} expr
       | expr LESS_THAN {fprintf(yyout2, "< ");} expr
       | expr GRT_THAN_EQUAL {fprintf(yyout2, ">= ");} expr
       | expr LESS_THAN_EQUAL {fprintf(yyout2, "<= ");} expr
       ;


%%

int main(int argc, char *argv[])
{
    if(argc!=2)
    {
        printf("INVALID! \n");
        exit(0);
    }

    yyin = fopen(argv[1], "r");
    yyout = fopen ("Lexer.text", "w");
    yyout2 = fopen("Parser.txt", "w");
    yyparse();
    yylex();
    return 0;
}

void yyerror (const char* message)
{ 
    printf("SYNTAX ERROR : %s\n", message);
    exit(0);
}

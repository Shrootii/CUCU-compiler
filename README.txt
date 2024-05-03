how to run program

1. bison -d cucu.y
2. flex cucu.l
3. gcc cucu.tab.c lex.yy.c -lfl -o cucu
4. ./cucu filename.cucu

cucu.l 
All the required elements are identified as tokens and used in cucu.y grammar

cucu.y

First we define program as the recursive relation between
variable declarations, variable definitions, function declarations and function definitions.

Variable declaration- initializing a variable (int a;)
Variable definition- initializing and assigning a variable some value (int a = 3;)

Function declaration- initializing a function and its parameters (int function(int a);)
Function definition- defining the function and its rules (int function(int a){body};)

the function body consists of more recursive statements that allow while loop, 
if-else conditionals and mathematical/boolean operations to take place inside the function.

expr- consists of mathematicals expressions using boolean or arithmetic operators with
product/division having higher priority than addition/subtraction.
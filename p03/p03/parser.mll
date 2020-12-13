%{
	open Printf 
%}

%token WHITESPACE NEWLINE
%token <string> ID
%token <int> NUM
%token <float> FLOAT
%token PROGRAM BEGIN END SEMI
%token <string> TYPE
%token ASSIGNMENT_OP LPAREN RPAREN WRITE
%token ADD_OP ADD_F_OP SUB_OP SUB_F_OP MULT_OP MULT_F_OP DIV_OP DIV_F_OP EXP_OP

%left ADD_OP ADD_F_OP SUB_OP SUB_F_OP
%left MULT_OP MULT_F_OP DIV_OP DIV_F_OP
%right EXP_OP

%start input
%type <unit> input

%% /* Grammar definitions */ 


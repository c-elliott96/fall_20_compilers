/* file: parser.mly */
/* MYCPP parser */

%{
	open Printf

	let tbl = Hashtbl.create 100

	let var_in_tbl v = Hashtbl.mem tbl v 
	let add_to_tbl v = Hashtbl.add tbl v

	let store_int i = "INT" ^ (string_of_int i)
	let store_string str = "STR" ^ str
	let store_real r = "REA" ^ (string_of_float r)

	let get_type v = String.sub v 0 3

	let get_val v = 
		let len = (String.length v) - 3 in
		match get_type v with
		| "INT" -> String.sub v 3 len
		| "STR" -> String.sub v 3 len
		| "REA" -> String.sub v 3 len
		| _ -> "Error"

	let declar_var t v = if var_in_tbl v then raise Parser.Parse_error (printf "Redeclaration of '%s'" v)
		else match t with
		| "INTEGER" -> add_to_tbl "INT"
		| "STRING" -> add_to_tbl "STR"
		| "REAL" -> add_to_tbl "REA"
		| _ -> raise Parser.Parse_error "**Error** {line-num}: Syntax error"
%}

/* declaration helper function: 
	- check if var is in table. If so, throw error.
	- If not in table, insert it. */

/* get_val has some redunancies - should fix later */ 
/* Error handling is also not right yet */ 

/* TODO:
	- Add table insertion function for declarations
	- Add wrapper function to store a value in table; will use store_{type} 
	- Finish rules below
*/

/* Token declarations - to match lexer.mll tokens */

%token NEWLINE
%token PROGRAM BEGIN END
%token LPAREN RPAREN
%token <string> ID
%token <int> INTEGER
%token <float> REAL
%token <string> STRING
%token SEMI
%token ASSIGN
%token PLUS MINUS MULTIPLY DIVIDE EXPONENT
%left PLUS MINUS
%left MULTIPLY DIVIDE
%right EXPONENT
%start input 
%type <unit> input

input: /* empty */ { }
| PROGRAM declarations BEGIN expr END SEMI { }
;

declarations: declaration 
| declaration declarations
;

declaration: 
type ID SEMI NEWLINE { declar_var type ID }
;

type: 
INTEGER 
| REAL 
| STRING
;

expr: 
ID ASSIGN expr SEMI { 
	if var_in_tbl ID then (
		if )
 }
| LPAREN expr RPAREN
| WRITE expr SEMI
| expr SEMI NEWLINE expr
| expr PLUS expr SEMI
| expr MINUS expr SEMI
| expr MULTIPLY expr SEMI
| expr DIVIDE expr SEMI
| expr EXPONENT expr SEMI
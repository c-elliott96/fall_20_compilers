%{
	open Printf

	let parse_error s = printf "%s\n" s 

	let dec_tbl = Hashtbl.create 100
	let val_tbl = Hashtbl.create 100

	let line_num = ref 1

	let inc_line line_num = line_num := !line_num + 1

	
	
	let add_id_tbl typ id = 
		if (Hashtbl.mem dec_tbl id) then 
			(raise Parsing.Parse_error (printf "**Error** %d: Redefinition of %s\n" !line_num id)) else
		(match typ with 
		| "INTEGER" -> Hashtbl.add dec_tbl id "INT"
		| "STRING" -> Hashtbl.add dec_tbl id "STR"
		| "REAL" -> Hashtbl.add dec_tbl id "REA")

	let assign_val id v = 
		if Hashtbl.mem dec_tbl id then (Hashtbl.add val_tbl id v) else 
		( raise Parsing.Parse_error (printf "**Error** %d: Use of undeclared identifier %s\n" !line_num id) )

	let lookup_id id = if Hashtbl.mem dec_tbl id then (
			let typ = Hashtbl.find dec_tbl id in
			match typ with 
			| "INT" -> int_of_string (Hashtbl.find val_tbl id)
			| "STR" -> Hashtbl.find val_tbl id
			| "REA" -> float_of_string (Hashtbl.find val_tbl id)
		) else raise Parsing.Parse_error (printf "**Error** %d: Use of undeclared identifier %s\n" !line_num id)

%}

%token WHITESPACE NEWLINE
%token <string> ID
%token <int> INT
%token <float> FLOAT
%token PROGRAM BEGIN END SEMI
%token <string> TYPE
%token <string> STRING_LIT
%token ASSIGNMENT_OP LPAREN RPAREN WRITE
%token ADD_OP ADD_F_OP SUB_OP SUB_F_OP MULT_OP MULT_F_OP DIV_OP DIV_F_OP EXP_OP

%left ADD_OP ADD_F_OP SUB_OP SUB_F_OP
%left MULT_OP MULT_F_OP DIV_OP DIV_F_OP
%right EXP_OP

%start input
%type <unit> input

%% /* Grammar definitions */ 

input: /* empty */ { }
| input program { }
;

whitespace: WHITESPACE { }
| WHITESPACE whitespace { }
;

declarations: TYPE ID SEMI { add_id_tbl $1 $2 }
| TYPE ID SEMI NEWLINE declarations { add_id_tbl $1 $2 }
;

assignment: ID ASSIGNMENT_OP expr SEMI { assign_val $1 $3 }
;

write: WRITE expr { printf "%s" $2 }
;

expr: ID { lookup_id $1 }
| LPAREN expr RPAREN { $2 }
| iexpr ADD_OP iexpr { $1 + $3 }
| fexpr ADD_F_OP fexpr { $1 +. $3 }
| iexpr SUB_OP iexpr { $1 - $3 }
| fexpr SUB_F_OP fexpr { $1 -. $3 }
| iexpr MULT_OP iexpr { $1 * $3 }
| fexpr MULT_F_OP fexpr { $1 *. $3 }
| iexpr DIV_OP iexpr { $1 / $3 }
| fexpr DIV_F_OP fexpr { $1 /. $3 }
| fexpr EXP_OP fexpr { $1 ** $3 }
| STRING_LIT { $1 }
| INT { $1 }
| FLOAT { $1 }
;

iexpr: INT { $1 }
;

fexpr: FLOAT { $1 }
;

body: assignment { }
| write { }
| expr { }
| body { }
;

program: PROGRAM whitespace declarations whitespace BEGIN body END SEMI { }
;
{
	open Printf
	open Parser
	let file_name = "test.txt"

	let line_num = ref 1

	let inc_line line_num = line_num := !line_num + 1
}

(* Tokens to capture: 
	- Identifier
	- keywords: PROGRAM, BEGIN, END
	- Semicolon
	- declaration:
		- type variable; where
			- type = ["INTEGER", "REAL", "STRING"]
			- variable = Identifier
	- assignment: ":="
	- in body section: 
		- variable := expression;
		- WRITE expression;
		- expression;
		where expression can be:
			- operand binary_op operand 
			- operand where operand can be a variable or a number
*)

let digit = ['0' - '9']
let digits = digit + 
let id = ['a'-'z'] ['a'-'z''_''0'-'9']*
let printable = [' ' - '~']
let number = digit digits*
let float = digits '.' digits *

let program = "PROGRAM"
let begin = "BEGIN"
let end = "END"
let write = "WRITE" 
let semi = ';'
let newline = '\n'
let whitespace = ['\t' ' ']
let int = "INTEGER"
let real = "REAL"
let string = "STRING"
let type = int | real | string

let string_literal = '"' printable * '"'
let assignment_op = ":="
let add_op = '+'
let add_f_op = ".+"
let sub_op = '-'
let sub_f_op = "-."
let mult_op = '*'
let mult_f_op = "*."
let div_op = '/'
let div_f_op = "/."
let exp_op = "**"
let lparen = '('
let rparen = ')'

(*
rule token = parse 
| whitespace { token lexbuf }
| newline { printf "\tNEWLINE\t # %d\n" !line_num ; inc_line line_num; token lexbuf }
| id as var { printf "ID: %s " var; token lexbuf }
| number as num { printf "NUM: %s " num; token lexbuf }
| float as flo { printf "FLOAT: %s " flo; token lexbuf }
| program { printf "PROGRAM "; token lexbuf }
| begin { printf "BEGIN "; token lexbuf }
| end { printf "END "; token lexbuf }
| semi { printf "SEMI "; token lexbuf }
| type as typ { printf "TYPE: %s " typ; token lexbuf }
| assignment_op { printf "ASSIGNMENT_OP "; token lexbuf }
| lparen { printf "LPAREN "; token lexbuf }
| rparen { printf "RPAREN "; token lexbuf }
| write { printf "WRITE "; token lexbuf }
| add_op { printf "ADD_OP "; token lexbuf }
| add_f_op { printf "ADD_F_OP "; token lexbuf }
| sub_op { printf "SUB_OP "; token lexbuf }
| sub_f_op { printf "SUB_F_OP "; token lexbuf }
| mult_op { printf "MULT_OP "; token lexbuf }
| mult_f_op { printf "MULT_F_OP "; token lexbuf }
| div_op { printf "DIV_OP "; token lexbuf }
| div_f_op { printf "DIV_F_OP "; token lexbuf }
| exp_op { printf "EXP_OP "; token lexbuf }
| _ as unid { printf "Unidentified character: %c on line %d" unid !line_num; token lexbuf }
| eof { (* raise End_of_file *) printf "\n --- END OF FILE --- \n" }
*)

rule token = parse 
| whitespace { WHITESPACE }
| newline { NEWLINE }
| id as var { ID var }
| number as num { INT (int_of_string num) }
| float as flo { FLOAT (float_of_string flo) }
| string_literal as str { STRING_LIT str }
| program { PROGRAM }
| begin { BEGIN }
| end { END }
| semi { SEMI }
| type as typ { TYPE typ }
| assignment_op { ASSIGNMENT_OP }
| lparen { LPAREN }
| rparen { RPAREN }
| write { WRITE }
| add_op { ADD_OP }
| add_f_op { ADD_F_OP }
| sub_op { SUB_OP }
| sub_f_op { SUB_F_OP }
| mult_op { MULT_OP }
| mult_f_op { MULT_F_OP }
| div_op { DIV_OP }
| div_f_op { DIV_F_OP }
| exp_op { EXP_OP }
| _ as unid { token lexbuf }
| eof { raise End_of_file }

{
	(* let file = open_in "test.txt" in
	let lexbuf = Lexing.from_channel file in 
		token lexbuf *)
}
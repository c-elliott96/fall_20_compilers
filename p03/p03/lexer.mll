{
	open Printf
	open My_parser
	open Lexing
	let inc_lineno lexbuf = 
		let pos = lexbuf.lex_curr_p in
		lexbuf.lex_curr_p <- { pos with 
			pos_lnum = pos.pos_lnum + 1;
		}
}


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
let sub_op = '-'
let mult_op = '*'
let div_op = '/'
let exp_op = "**"
let lparen = '('
let rparen = ')'


rule token = parse 
| whitespace { token lexbuf }
| newline { inc_lineno lexbuf; NEWLINE }
| id as var { ID var }
| number as num { NUMBER (int_of_string num) }
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
| sub_op { SUB_OP }
| mult_op { MULT_OP }
| div_op { DIV_OP }
| exp_op { EXP_OP }
| _ as unid { token lexbuf }
| eof { raise End_of_file }

{
	(* let file = open_in "test.txt" in
	let lexbuf = Lexing.from_channel file in 
		token lexbuf *)
}
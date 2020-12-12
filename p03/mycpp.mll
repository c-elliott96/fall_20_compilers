{
	(* Header; all setup actions go here *)
}

let digit = ['0' - '9']
let id = ['a'-'z'] ['a'-'z''_''0'-'9']*

let program = "PROGRAM"
let begin = "BEGIN"
let end = "END;"

let type = "INTEGER" | "REAL" | "STRING"

let declaration = type id ';'
let declarations = declaration * 

let assignment = id ":=" expression
let write = "WRITE" expression
let expression = operand binary_op operand | operand
let binary_op = "+" | "-" | "*" | "/" | "**"
let expression = '(' expression ')' | assignment | write | 
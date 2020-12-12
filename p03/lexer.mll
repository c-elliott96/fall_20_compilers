{
	open parser
}

let digit = ['0' - '9']
let printable = [' ' - '~']
let id = ['a'-'z'] ['a'-'z''_''0'-'9']*

rule token = parse
| ['\t' ' '] { token lexbuf }
| '\n' { NEWLINE }
| ';' { SEMI }
| ":=" { ASSIGN }
| '+' { PLUS }
| '-' { MINUS }
| '*' { MULTIPLY }
| '/' { DIVIDE }
| "**" { EXPONENT }
| '(' { LPAREN }
| ')' { RPAREN }
| id as id { ID id }
| digit+ as num { INTEGER (int_of_string num) }
| digit+ '.' digit+ as num { REAL (float_of_string num) }
| '"' printable* '"' as str { STRING str }
| "PROGRAM" { PROGRAM }
| "BEGIN" { BEGIN }
| "END" { END }
| _ { token lexbuf }
| eof { raise End_of_file }

(*
{
	let lexbuf = Lexing.from_channel stdin in 
		token lexbuf
}
*)
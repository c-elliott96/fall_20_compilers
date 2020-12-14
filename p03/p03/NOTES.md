NOTES

Tables:

1st table: Variable name and type
---------------------------------
"a" -> "STR"
"b" -> "INT"
"c" -> "REA"

2nd table: Variable name and value
----------------------------------
"a" -> "Hello"
"b" -> "42"
"c" -> "5.5"

Table uses:

1. Adding declarations to 1st table
example: 
	`STRING a;`
	--> `if !Hashtbl.mem tbl1 "a" then (Hashtbl.add tbl1 "a" "STR") else (raise Parser.Parser_error "Redeclaration ... ")`

	`INTEGER b;`
	--> `if !Hashtbl.mem tbl1 "b" then (Hashtbl.add tbl1 "b" "INT") else ( ... )`

	`REAL c;`
	--> `if !Hashtbl.mem tbl1 "c" then (Hashtbl.add tbl1 "c" "REAL") else ( ... )`

2. Retrieving values when given var name
example:
	`a;`
	--> 

TODO:
* Get helper functions for retrieval, type checking, and adding to table working
* Work out whatever kinks in parser logic still exist. 








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
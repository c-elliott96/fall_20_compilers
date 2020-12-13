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
%{
	open Printf

	let var_tbl = Hashtbl.create 100
	let val_tbl = Hashtbl.create 100

	let is_even n = 
  		n mod 2 = 0

  	let pow base exponent =
    	if exponent < 0 then invalid_arg "exponent can not be negative" else
    	let rec aux accumulator base = function
	      | 0 -> accumulator
	      | 1 -> base * accumulator
	      | e when is_even e -> aux accumulator (base * base) (e / 2)
	      | e -> aux (base * accumulator) (base * base) ((e - 1) / 2) in
	    aux 1 base exponent

	let last_three value = 
		(String.sub value ((String.length value) - 3) 3 )

	let add_op op1 op2 = 
		if (String.sub op1 ((String.length op1) - 3) 3) = "\n~i" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~i" then
			( 
			string_of_int 
				(
					(int_of_string (String.sub op1 0 ((String.length op1) - 3))
					) + 
					(int_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~i"
			)
		else if (String.sub op1 ((String.length op1) - 3) 3) = "\n~f" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~f" then
			(
			string_of_float
				(
					(float_of_string (String.sub op1 0 ((String.length op1) - 3))
					) +. 
					(float_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~f"
			)
		else (
			let start_pos = Parsing.rhs_start_pos 3 in
			printf "**Error** %d: Addition of different data types\n" start_pos.pos_lnum; raise Parsing.Parse_error
			)

	let sub_op op1 op2 = 
		if (String.sub op1 ((String.length op1) - 3) 3) = "\n~i" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~i" then
			( 
			string_of_int 
				(
					(int_of_string (String.sub op1 0 ((String.length op1) - 3))
					) - 
					(int_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~i"
			)
		else if (String.sub op1 ((String.length op1) - 3) 3) = "\n~f" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~f" then
			(
			string_of_float
				(
					(float_of_string (String.sub op1 0 ((String.length op1) - 3))
					) -. 
					(float_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~f"
			)
		else (
			let start_pos = Parsing.rhs_start_pos 3 in
			printf "**Error** %d: Subtraction of different data types\n" start_pos.pos_lnum; raise Parsing.Parse_error
			)

	let div_op op1 op2 = 
		if (String.sub op1 ((String.length op1) - 3) 3) = "\n~i" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~i" then
			if (int_of_string (String.sub op2 0 ((String.length op2) - 3)) = 0) then 
				let start_pos = Parsing.rhs_start_pos 3 in
				printf "**Error** %d: Division by 0 is Undefined\n" start_pos.pos_lnum; raise Parsing.Parse_error
			else ( 
			string_of_int 
				(
					(int_of_string (String.sub op1 0 ((String.length op1) - 3))
					) / 
					(int_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~i"
			)
		else if (String.sub op1 ((String.length op1) - 3) 3) = "\n~f" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~f" then
			if (float_of_string (String.sub op2 0 ((String.length op2) - 3)) = 0.0) then 
				let start_pos = Parsing.rhs_start_pos 3 in
				printf "**Error** %d: Division by 0 is Undefined\n" start_pos.pos_lnum; raise Parsing.Parse_error
			else (
			string_of_float
				(
					(float_of_string (String.sub op1 0 ((String.length op1) - 3))
					) /. 
					(float_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~f"
			)
		else (
			let start_pos = Parsing.rhs_start_pos 3 in
			printf "**Error** %d: Division of different data types\n" start_pos.pos_lnum; raise Parsing.Parse_error
			)

	let mult_op op1 op2 = 
		if (String.sub op1 ((String.length op1) - 3) 3) = "\n~i" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~i" then
			( 
			string_of_int 
				(
					(int_of_string (String.sub op1 0 ((String.length op1) - 3))
					) * 
					(int_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~i"
			)
		else if (String.sub op1 ((String.length op1) - 3) 3) = "\n~f" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~f" then
			(
			string_of_float
				(
					(float_of_string (String.sub op1 0 ((String.length op1) - 3))
					) *. 
					(float_of_string (String.sub op2 0 ((String.length op2) - 3))
					)
				) ^ "\n~f"
			)
		else (
			let start_pos = Parsing.rhs_start_pos 3 in
			printf "**Error** %d: Multiplication of different data types\n" start_pos.pos_lnum; raise Parsing.Parse_error
			)

	let exp_op op1 op2 = 
		if (String.sub op1 ((String.length op1) - 3) 3) = "\n~i" &&
		(String.sub op2 ((String.length op2) - 3) 3) = "\n~i" then
			string_of_float (float_of_string (String.sub op1 0 ((String.length op1) - 3)) ** 
			float_of_string (String.sub op2 0 ((String.length op2) - 3)))
		else (
			let start_pos = Parsing.rhs_start_pos 3 in
			printf "**Error** %d: Exponentiation of different data types\n" start_pos.pos_lnum; raise Parsing.Parse_error
			)

	let store_var typ name = 
		(* Look to see if redeclaration or not *)
		if (Hashtbl.mem var_tbl name) then (
			let start_pos = Parsing.rhs_start_pos 2 in
			printf "**Error** %d: Redeclaration of variable %s\n" start_pos.pos_lnum name; 
			raise Parsing.Parse_error
			)
		else (Hashtbl.add var_tbl name typ)

	let assign_var name value = 
		(* 1. Make sure variable exists in var_tbl *)
		(* 2. Make sure types are compatible *)
		if (Hashtbl.mem var_tbl name = false) then 
			let start_pos = Parsing.rhs_start_pos 1 in
			printf "**Error** %d: Assignment of undeclared variable\n" start_pos.pos_lnum;
			raise Parsing.Parse_error
		else
			(* Adding in int to table *)
			let typ = (Hashtbl.find var_tbl name) in
			if (String.sub value ((String.length value) - 3) 3 = "\n~i" && typ = "INTEGER") then (
				Hashtbl.add val_tbl name value
			)
			else if (String.sub value ((String.length value) - 3) 3 = "\n~f" && typ = "REAL") then (
				Hashtbl.add val_tbl name value
			)
			else if String.contains value '\n' then 
				let start_pos = Parsing.rhs_start_pos 1 in 
				printf "**Error** %d: Assignment of operand with incompatible type\n" start_pos.pos_lnum;
				raise Parsing.Parse_error
			else Hashtbl.add val_tbl name value

	let lookup_id id = 
		if (Hashtbl.mem val_tbl id = false) then
			let start_pos = Parsing.rhs_start_pos 1 in
			printf "**Error** %d: Use of undeclared identifier %s\n" start_pos.pos_lnum id;
			raise Parsing.Parse_error
		else Hashtbl.find val_tbl id 

	let write_stmt value = 
		let last_three = (String.sub value ((String.length value) - 3) 3) in
		if (last_three <> "\n~i") && (last_three <> "\n~f") then value else
		(String.sub value 0 ((String.length value) - 3) )

%}

%token WHITESPACE NEWLINE
%token <string> ID
%token <int> NUMBER
%token <float> FLOAT
%token PROGRAM BEGIN END SEMI
%token <string> TYPE
%token <string> STRING_LIT
%token ASSIGNMENT_OP LPAREN RPAREN WRITE
%token ADD_OP SUB_OP MULT_OP DIV_OP EXP_OP

%left ADD_OP SUB_OP 
%left MULT_OP DIV_OP
%right EXP_OP

%start input
%type <unit> input

%% /* Grammar definitions */ 

input: /* empty */ { }
| input program { }
| error NEWLINE { }
;


newlines: NEWLINE { }
| NEWLINE newlines { }
;

declarations: 	{ } 
| TYPE ID SEMI declarations { store_var $1 $2 }
| newlines declarations { }
;


write: WRITE expr SEMI { printf "%s\n" (write_stmt $2) }
;

expr: ID { lookup_id $1 } 
| NUMBER { (string_of_int $1) ^ "\n~i" }
| FLOAT { (string_of_float $1) ^ "\n~f" }
| STRING_LIT { $1 }
| LPAREN expr RPAREN { $2 }
| expr ADD_OP expr { add_op $1 $3 }
| expr SUB_OP expr { sub_op $1 $3 }
| expr MULT_OP expr { mult_op $1 $3 }
| expr DIV_OP expr { div_op $1 $3 }
| expr EXP_OP expr { exp_op $1 $3 }
| ID ASSIGNMENT_OP expr { assign_var $1 $3; "" }
;

body: /* nothing */ { }
| newlines body { }
| write body { }
| expr SEMI body { }
;

program: PROGRAM declarations BEGIN body END SEMI { printf "\t--- No syntax errors ---\n"}
;
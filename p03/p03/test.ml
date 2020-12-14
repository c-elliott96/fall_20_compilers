let var_tbl = Hashtbl.create 100
let val_tbl = Hashtbl.create 100

open Printf

let declaration var_type var =
	match var_type with
	| "INTEGER" -> Hashtbl.add var_tbl var "INT"
	| "STRING" -> Hashtbl.add var_tbl var "STR"
	| "REAL" -> Hashtbl.add var_tbl var "REA"
	| _ -> printf "Invalid var type\n"
;;

let assignment var value = 
	(* Check to make sure value is same type as var -> value in var_tbl *)
	(* Check that var is in var_tbl *)
	(* skipping the above checks for brevity *)
	let var_type = Hashtbl.find var_tbl var in
	match var_type with 
	| "INT" -> Hashtbl.add val_tbl var (string_of_int value)
	| "STR" -> Hashtbl.add val_tbl var value
	| "REA" -> Hashtbl.add val_tbl var (string_of_float value)
;;

declaration "INTEGER" "a"
(* Here, we have added "a" -> "INT" to var_tbl *)

printf "Value in var_tbl: %s\n" (Hashtbl.find var_tbl "a")

printf "Adding value for %s\n"

assignment "a" 42;;

printf "Value in val_tbl: %s\n" (Hashtbl.find val_tbl "a")
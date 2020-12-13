(* File: main.mly *)

let main () = 
	try
		let lexbuf = Lexing.from_channel stdin in
		while true do
			parser.input lexer.token lexbuf
		done
	with End_of_file -> exit 0

let _ = Printexc.print main ()
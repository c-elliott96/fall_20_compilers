type token =
  | WHITESPACE
  | NEWLINE
  | ID of (string)
  | INT of (int)
  | FLOAT of (float)
  | PROGRAM
  | BEGIN
  | END
  | SEMI
  | TYPE of (string)
  | STRING_LIT of (string)
  | ASSIGNMENT_OP
  | LPAREN
  | RPAREN
  | WRITE
  | ADD_OP
  | ADD_F_OP
  | SUB_OP
  | SUB_F_OP
  | MULT_OP
  | MULT_F_OP
  | DIV_OP
  | DIV_F_OP
  | EXP_OP

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
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

	let assign_int id v = 
		if ((Hashtbl.find dec_tbl id) <> "INT") then (* wrong type in table *) 
			(let start_pos = Parsing.rhs_start_pos 3 in 
				raise Parser.Parse_error "**Error** %d: Cannot store non-int value in %s" start_pos.pos_lnum id)
		else (Hashtbl.add val_tbl id v)

	let lookup_id id = if Hashtbl.mem dec_tbl id then (
			let typ = Hashtbl.find dec_tbl id in
			match typ with 
			| "INT" -> int_of_string (Hashtbl.find val_tbl id)
			| "STR" -> Hashtbl.find val_tbl id
			| "REA" -> float_of_string (Hashtbl.find val_tbl id)
		) else raise Parsing.Parse_error (printf "**Error** %d: Use of undeclared identifier %s\n" !line_num id)

# 64 "parser.ml"
let yytransl_const = [|
  257 (* WHITESPACE *);
  258 (* NEWLINE *);
  262 (* PROGRAM *);
  263 (* BEGIN *);
  264 (* END *);
  265 (* SEMI *);
  268 (* ASSIGNMENT_OP *);
  269 (* LPAREN *);
  270 (* RPAREN *);
  271 (* WRITE *);
  272 (* ADD_OP *);
  273 (* ADD_F_OP *);
  274 (* SUB_OP *);
  275 (* SUB_F_OP *);
  276 (* MULT_OP *);
  277 (* MULT_F_OP *);
  278 (* DIV_OP *);
  279 (* DIV_F_OP *);
  280 (* EXP_OP *);
    0|]

let yytransl_block = [|
  259 (* ID *);
  260 (* INT *);
  261 (* FLOAT *);
  266 (* TYPE *);
  267 (* STRING_LIT *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\003\000\003\000\004\000\004\000\005\000\005\000\
\005\000\006\000\007\000\007\000\007\000\007\000\007\000\007\000\
\007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
\008\000\009\000\010\000\010\000\010\000\010\000\002\000\000\000"

let yylen = "\002\000\
\000\000\002\000\001\000\002\000\003\000\005\000\004\000\004\000\
\004\000\003\000\001\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\008\000\002\000"

let yydefred = "\000\000\
\001\000\000\000\000\000\000\000\002\000\000\000\000\000\004\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\022\000\000\000\000\000\027\000\028\000\029\000\
\000\000\000\000\000\000\006\000\000\000\011\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\012\000\010\000\025\000\
\013\000\015\000\017\000\019\000\026\000\014\000\016\000\018\000\
\020\000\021\000\031\000\007\000\009\000\008\000"

let yydgoto = "\002\000\
\003\000\005\000\007\000\010\000\022\000\023\000\024\000\025\000\
\026\000\027\000"

let yysindex = "\006\000\
\000\000\000\000\013\255\023\255\000\000\023\255\016\255\000\000\
\032\255\023\255\034\255\038\255\058\255\255\254\016\255\049\255\
\000\000\000\000\000\000\017\255\017\255\000\000\000\000\000\000\
\026\255\015\255\054\255\000\000\036\255\000\000\050\255\056\255\
\059\255\059\255\059\255\059\255\061\255\061\255\061\255\061\255\
\061\255\060\255\062\255\063\255\064\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\067\000\000\000\000\000\254\254\000\000\000\000\
\000\000\000\000\000\000\000\000\067\255\000\000\000\000\066\255\
\009\255\248\254\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\027\000\055\000\000\000\000\000\038\000\021\000\
\012\000\000\000"

let yytablesize = 74
let yytable = "\024\000\
\024\000\016\000\017\000\018\000\003\000\024\000\001\000\003\000\
\026\000\019\000\026\000\020\000\026\000\021\000\026\000\026\000\
\023\000\023\000\004\000\030\000\017\000\018\000\023\000\006\000\
\025\000\009\000\025\000\019\000\025\000\020\000\025\000\037\000\
\008\000\038\000\011\000\039\000\012\000\040\000\041\000\043\000\
\044\000\033\000\013\000\034\000\014\000\035\000\045\000\036\000\
\054\000\055\000\056\000\057\000\058\000\049\000\050\000\051\000\
\052\000\031\000\032\000\015\000\029\000\042\000\048\000\046\000\
\047\000\053\000\032\000\005\000\059\000\028\000\060\000\061\000\
\062\000\011\000"

let yycheck = "\008\001\
\009\001\003\001\004\001\005\001\007\001\014\001\001\000\010\001\
\017\001\011\001\019\001\013\001\021\001\015\001\023\001\024\001\
\008\001\009\001\006\001\003\001\004\001\005\001\014\001\001\001\
\016\001\010\001\018\001\011\001\020\001\013\001\022\001\017\001\
\006\000\019\001\003\001\021\001\010\000\023\001\024\001\004\001\
\005\001\016\001\009\001\018\001\007\001\020\001\011\001\022\001\
\037\000\038\000\039\000\040\000\041\000\033\000\034\000\035\000\
\036\000\020\000\021\000\002\001\012\001\008\001\004\001\014\001\
\009\001\005\001\000\000\001\001\009\001\015\000\009\001\009\001\
\009\001\008\001"

let yynames_const = "\
  WHITESPACE\000\
  NEWLINE\000\
  PROGRAM\000\
  BEGIN\000\
  END\000\
  SEMI\000\
  ASSIGNMENT_OP\000\
  LPAREN\000\
  RPAREN\000\
  WRITE\000\
  ADD_OP\000\
  ADD_F_OP\000\
  SUB_OP\000\
  SUB_F_OP\000\
  MULT_OP\000\
  MULT_F_OP\000\
  DIV_OP\000\
  DIV_F_OP\000\
  EXP_OP\000\
  "

let yynames_block = "\
  ID\000\
  INT\000\
  FLOAT\000\
  TYPE\000\
  STRING_LIT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 56 "parser.mly"
                   ( )
# 206 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : unit) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'program) in
    Obj.repr(
# 57 "parser.mly"
                ( )
# 214 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    Obj.repr(
# 60 "parser.mly"
                       ( )
# 220 "parser.ml"
               : 'whitespace))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'whitespace) in
    Obj.repr(
# 61 "parser.mly"
                        ( )
# 227 "parser.ml"
               : 'whitespace))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 64 "parser.mly"
                          ( add_id_tbl _1 _2 )
# 235 "parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'declaration) in
    Obj.repr(
# 65 "parser.mly"
                                   ( add_id_tbl _1 _2 )
# 244 "parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 68 "parser.mly"
                                      ( assign_int _1  )
# 252 "parser.ml"
               : 'assignment))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 69 "parser.mly"
                                   ( )
# 260 "parser.ml"
               : 'assignment))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : float) in
    Obj.repr(
# 70 "parser.mly"
                              ( )
# 268 "parser.ml"
               : 'assignment))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 74 "parser.mly"
                       ( printf "%s\n" _2 )
# 275 "parser.ml"
               : 'write))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 77 "parser.mly"
         ( lookup_id _1 )
# 282 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 78 "parser.mly"
                     ( _2 )
# 289 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'iexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'iexpr) in
    Obj.repr(
# 79 "parser.mly"
                     ( _1 + _3 )
# 297 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'fexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'fexpr) in
    Obj.repr(
# 80 "parser.mly"
                       ( _1 +. _3 )
# 305 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'iexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'iexpr) in
    Obj.repr(
# 81 "parser.mly"
                     ( _1 - _3 )
# 313 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'fexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'fexpr) in
    Obj.repr(
# 82 "parser.mly"
                       ( _1 -. _3 )
# 321 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'iexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'iexpr) in
    Obj.repr(
# 83 "parser.mly"
                      ( _1 * _3 )
# 329 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'fexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'fexpr) in
    Obj.repr(
# 84 "parser.mly"
                        ( _1 *. _3 )
# 337 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'iexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'iexpr) in
    Obj.repr(
# 85 "parser.mly"
                     ( _1 / _3 )
# 345 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'fexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'fexpr) in
    Obj.repr(
# 86 "parser.mly"
                       ( _1 /. _3 )
# 353 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'fexpr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'fexpr) in
    Obj.repr(
# 87 "parser.mly"
                     ( _1 ** _3 )
# 361 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 88 "parser.mly"
             ( _1 )
# 368 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 89 "parser.mly"
      ( _1 )
# 375 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 90 "parser.mly"
        ( _1 )
# 382 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 93 "parser.mly"
           ( _1 )
# 389 "parser.ml"
               : 'iexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 96 "parser.mly"
             ( _1 )
# 396 "parser.ml"
               : 'fexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assignment) in
    Obj.repr(
# 99 "parser.mly"
                 ( )
# 403 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'write) in
    Obj.repr(
# 100 "parser.mly"
        ( )
# 410 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 101 "parser.mly"
       ( )
# 417 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 102 "parser.mly"
       ( )
# 424 "parser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'whitespace) in
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'declaration) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'whitespace) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'body) in
    Obj.repr(
# 105 "parser.mly"
                                                                       ( )
# 434 "parser.ml"
               : 'program))
(* Entry input *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let input (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)

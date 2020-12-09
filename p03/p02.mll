{ 
  open Printf
  let line_num = ref 1

  let count_newlines str =
    let i = ref 0 in
    let len = String.length str in
    while (!i < len) do
      if (str.[!i] == '\n') then line_num := !line_num + 1;
      i := !i + 1;
    done

  let check_len_id id = 
    if String.length id > 25 then
      ( printf "Error: Identifier too long on line %d \n" !line_num;
        false )
    else true
}

let digit = ['0'-'9']
let id = ['a'-'z'] ['a'-'z''_''0'-'9']*
let keyword = "begin" | "end" | "if" | "then" | "else" | "goto" | "while" |
   "label" | "do" | "integer" | "real" | "string"
let newline = '\n'
let delim = ';' | ':' | '(' | ')' | '[' | ']'
let op = "+" | "-" | "*" | "/" | ":=" | "==" | "<>" | "<" | "<=" | ">=" | ">"
let string = '\"' _ * '\"'
let multi_comment = "/*" _ * "*/"
let sing_comment = "//" [^'\n']* '\n'
let whitespace = '\t' | ' '
let invalid_digit = digit + '.'

rule my_lexer = parse
| keyword as kwrd { printf "KEYWORD: %s \n" kwrd; my_lexer lexbuf }
| delim as delim { printf "DELIMTOK: %c \n" delim; my_lexer lexbuf }
| id as id { if (check_len_id id) then (printf "IDENTTOK: %s \n" id; my_lexer lexbuf) }
| string as str { printf "STRINGTOK: %s" str; my_lexer lexbuf }
| sing_comment { line_num := !line_num + 1; my_lexer lexbuf }
| multi_comment as mc { count_newlines mc; my_lexer lexbuf }
| digit + | digit + '.' digit + as numtok { printf "NUMTOK: %s \n" numtok; my_lexer lexbuf }
| op as op { printf "OPTOK: %s \n" op; my_lexer lexbuf }
| newline { line_num := !line_num + 1; my_lexer lexbuf }
| whitespace { my_lexer lexbuf }
| invalid_digit as invd { printf "*Error* Unrecognized characters (line %d): \"%s\" \n" !line_num invd }
| _ as c { printf "*Error* Unrecognized character (line %d): \"%c\" \n" !line_num c }
| eof { () }

{
  let lexbuf = Lexing.from_channel stdin in 
    my_lexer lexbuf
}

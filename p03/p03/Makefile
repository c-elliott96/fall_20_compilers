# Makefile for my_parser

my_parser: lexer.cmo my_parser.cmo main.cmo
	ocamlc -o my_parser lexer.cmo my_parser.cmo main.cmo
lexer.cmo: lexer.ml
	ocamlc -c lexer.ml
my_parser.cmo: my_parser.ml
	ocamlc -c my_parser.ml
main.cmo: main.ml
	ocamlc -c main.ml
lexer.ml: my_parser.cmi lexer.mll
	ocamllex lexer.mll
my_parser.cmi: my_parser.mli
	ocamlc -c my_parser.mli
my_parser.mli: my_parser.mly
	ocamlyacc my_parser.mly
my_parser.ml: my_parser.mly
	ocamlyacc my_parser.mly
clean:
	@echo $(DELIM) Cleaning up... $(DELIM)
	@rm -f *.cmo *.cmi *.mli my_parser my_parser.ml lexer.ml
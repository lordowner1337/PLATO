type token =
  | PRINT
  | SEMICOLON
  | EOF
  | INTEGER of (int)

open Parsing;;
let _ = parse_error;;
# 1 "Parser.mly"
 open Ast 
# 2 "Parser.mly"
 open Logger 
# 14 "Parser.ml"
let yytransl_const = [|
  257 (* PRINT *);
  258 (* SEMICOLON *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  259 (* INTEGER *);
    0|]

let yylhs = "\255\255\
\002\000\001\000\000\000"

let yylen = "\002\000\
\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\003\000\001\000\000\000\002\000"

let yydgoto = "\002\000\
\004\000\006\000"

let yysindex = "\255\255\
\000\255\000\000\255\254\000\000\000\000\001\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000"

let yytablesize = 3
let yytable = "\001\000\
\003\000\005\000\007\000"

let yycheck = "\001\000\
\001\001\003\001\002\001"

let yynames_const = "\
  PRINT\000\
  SEMICOLON\000\
  EOF\000\
  "

let yynames_block = "\
  INTEGER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 13 "Parser.mly"
          ( logParserInteger _1; Integer(_1) )
# 70 "Parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 16 "Parser.mly"
                             ( logParserPrint; Print(_2) )
# 77 "Parser.ml"
               : Ast.statement))
(* Entry statement *)
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
let statement (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.statement)

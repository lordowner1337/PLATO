type token =
  | PRINT
  | SEMICOLON
  | EOF
  | INTEGER of (int)

val statement :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.statement

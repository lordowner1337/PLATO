{ open Parser open Logger}

rule token = parse
    [' ' '\t' '\r' '\n'] { token lexbuf }
  | ['0'-'9']+ as integer { INTEGER(int_of_string integer) }
  | "PRINT" { PRINT }
  | ';' { SEMICOLON }
	| '{' { OPEN_BRACE }
	| '}' { CLOSE_BRACE }
	| "main()" { MAIN_HEADER }
  | eof { EOF } 

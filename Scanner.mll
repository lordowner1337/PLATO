{ open Parser open Logger}

rule token = parse
    [' ' '\t' '\r' '\n'] { token lexbuf }
  | "TRUE" { BOOLEAN(true) }
	| "FALSE" { BOOLEAN(false) }
	| "OR" { OR }
	| "AND" { AND }
	| '0' { NUMBER(0) }
  | ['-']?['1'-'9']['0'-'9']* as number { NUMBER(int_of_string number) }
	| '+' { PLUS }
	| '-' { MINUS }
	| '*' { TIMES }
	| '/' { DIVIDE }
	| '%' { PERCENT }
	| '^' { CARET }
  | "PRINT" { PRINT }
  | ';' { SEMICOLON }
	| '{' { OPEN_BRACE }
	| '}' { CLOSE_BRACE }
	| "main()" { MAIN_HEADER }
  | eof { EOF } 

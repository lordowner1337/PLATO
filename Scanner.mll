{ open Parser }

rule token = parse
    [' ' '\t' '\r' '\n'] { token lexbuf }
  | ['0'-'9']+ as integer { logScannerInteger integer; INTEGER(int_of_string integer) }
  | "PRINT" { logScannerPrint; PRINT }
  | ';' { logScannerSemicolon; SEMICOLON }
  | eof { EOF } 
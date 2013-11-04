open Ast

let _ =
	let lexbuf = Lexing.from_channel stdin 
	in statement = Parser.statement Scanner.token lexbuf
	
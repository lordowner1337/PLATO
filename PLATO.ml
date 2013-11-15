open Ast;; 
open Logger;;

(* TODO: Need to check for correct file extension and existance and permissions for file *)
let fileName = Sys.argv.(1)
in let lexbuf = Lexing.from_channel (open_in fileName) 
	 in let ast = Parser.program Scanner.token lexbuf
	 in logProgram ast
	 

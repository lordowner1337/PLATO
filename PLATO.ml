open Ast;;
open Logger;;

(* TODO: Need to check for correct file extension and existance and permissions for file *)
let compile fileName =
  let lexbuf = Lexing.from_channel (open_in fileName) 
	in let ast = Parser.program Scanner.token lexbuf
	   in logProgram ast
in compile Sys.argv.(1)
	 

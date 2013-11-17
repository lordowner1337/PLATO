open Ast;;
open Logger;;
open Sast;;

let rec checkExpression environment = function
	  Ast.Number(numberValue) -> Sast.Number(numberValue), Ast.IntegerType

let rec checkStatement environment = function
	  Ast.Print(expression) -> Sast.Print(checkExpression environment expression)

let checkStatementBlock environment = function
	  Ast.StatementBlock(statementList) -> Sast.StatementBlock(List.map (checkStatement environment) statementList) 

let checkMainBlock environment = function
	  Ast.MainBlock(mainBlock) -> Sast.MainBlock(checkStatementBlock environment mainBlock)

let checkProgram environment = function
	  Ast.Program(mainBlock) -> Sast.Program(checkMainBlock environment mainBlock)	 

let createJavaAst sast = 0
	(* TODO *)
	
let generateJavaCode javaAst = 0
	(* TODO *)

(* TODO: Need to check for correct file extension and existance and permissions for file *)
let compile fileName =
  let lexbuf = Lexing.from_channel (open_in fileName) 
	in let programAst = Parser.program Scanner.token lexbuf
	   in logProgram programAst; 
		    let sast = checkProgram programAst
		    in let javaAst = createJavaAst sast
		       in generateJavaCode javaAst

let _ = compile Sys.argv.(1)
	 

open Printf;;
open Ast;;

let logToFile fileName logString = 
	let fileHandle = open_out_gen [Open_creat; Open_append] 0o777 fileName
	in fprintf fileHandle "%s\n" logString; close_out fileHandle

let logListToAst logStringList = 
	logToFile "Ast.log" (String.concat " " logStringList)
	
let logStringToAst logString = 
	logListToAst [logString]

let logOperator = function
	  Plus -> logStringToAst "Plus"
	| Minus -> logStringToAst "Minus"
	| Times -> logStringToAst "Times"
	| Divide -> logStringToAst "Divide"
	| Mod -> logStringToAst "Mod"
	| Raise -> logStringToAst "Raise"
	| And -> logStringToAst "And"
	| Or -> logStringToAst "Or"

let rec logExpression = function
	  Boolean(booleanValue) -> logListToAst ["Boolean"; string_of_bool booleanValue]
	| Number(integerValue) -> logListToAst ["Number"; string_of_int integerValue]
	| Binop(expression1, operator, expression2) -> logExpression expression1; logOperator operator; logExpression expression2

let logStatement = function
	  Print(printValue) -> logStringToAst "Print"; logExpression(printValue)
		
let logStatementBlock = function
	  StatementBlock(statementList) -> logListToAst ["StatementBlock of size"; string_of_int (List.length statementList)]; List.map logStatement statementList
		
let logMainBlock = function
	  MainBlock(statementBlock) -> logStringToAst "MainBlock"; logStatementBlock statementBlock

let logProgram = function
	  Program(mainBlock) -> logListToAst ["Program of size"; "1"]; logMainBlock mainBlock
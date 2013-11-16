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
	  Not ->  logStringToAst "Not"
	| And -> logStringToAst "And"
	| Or -> logStringToAst "Or"
	| Plus -> logStringToAst "Plus"
	| Minus -> logStringToAst "Minus"
	| Times -> logStringToAst "Times"
	| Divide -> logStringToAst "Divide"
	| Mod -> logStringToAst "Mod"
	| Raise -> logStringToAst "Raise"
	| LessThan -> logStringToAst "LessThan"
	| LessThanOrEqual -> logStringToAst "LessThanOrEqual"
	| GreaterThan -> logStringToAst "GreaterThan"
	| GreaterThanOrEqual -> logStringToAst "GreaterThanOrEqual"
	| Equal ->  logStringToAst "Equal"

let rec logPlatoType = function
	  BooleanType -> logStringToAst "BooleanType"
	| IntegerType -> logStringToAst "IntegerType"
	| NumberType(identifier) -> logListToAst ["NumberType"; "Over"; identifier]

let rec logExpression = function
	  Boolean(booleanValue) -> logListToAst ["Boolean"; string_of_bool booleanValue]
	| Number(integerValue) -> logListToAst ["Number"; string_of_int integerValue]
	| Identifier(identifierName) -> logListToAst ["Identifier"; identifierName]
	| Unop(operator, expression) -> logOperator operator; logExpression expression
	| Binop(operator, expression1, expression2) -> logOperator operator; logExpression expression1; logExpression expression2

let logStatement = function
	  Print(printValue) -> logStringToAst "Print"; logExpression(printValue)
	| Assignment(identifier, rhs) -> logStringToAst "Assignment"; logListToAst ["Identifier"; identifier]; logExpression(rhs)
	| Declaration(platoType, identifier, rhs) -> logStringToAst "Declaration"; logPlatoType platoType; logListToAst ["Identifier"; identifier]; logExpression(rhs)
		
let logStatementBlock = function
	  StatementBlock(statementList) -> logListToAst ["StatementBlock of size"; string_of_int (List.length statementList)]; List.map logStatement statementList
		
let logMainBlock = function
	  MainBlock(statementBlock) -> logStringToAst "MainBlock"; logStatementBlock statementBlock

let logProgram = function
	  Program(mainBlock) -> logListToAst ["Program of size"; "1"]; logMainBlock mainBlock
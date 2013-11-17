open Ast;;

type expressionDetail = 
	  Number of int
		
type expression =
	  expressionDetail * Ast.platoType

type statement = 
	  Print of expression
	
type statementBlock = 
	  StatementBlock of statement list
				
type mainBlock = 
	  MainBlock of statementBlock
		
type program = 
	  Program of mainBlock

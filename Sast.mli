open Ast;;

type expressionDetail = 
	  TypedNumber of int
		
type typedExpression =
	  expressionDetail * Ast.platoType

type typedStatement = 
	  TypedPrint of typedExpression
	
type typedStatementBlock = 
	  TypedStatementBlock of typedStatement list
				
type typedMainBlock = 
	  TypedMainBlock of typedStatementBlock
		
type typedProgram = 
	  TypedProgram of typedMainBlock

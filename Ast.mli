type expression = 
	  Integer of int

type  statement =
	  Print of expression
		
type statementList = 
	  StatementList of statement list
				
type statementBlock = 
	  StatementBlock of statement list
		
type mainBlock = 
	  MainBlock of statementBlock
		
type program  =
	  Program of mainBlock
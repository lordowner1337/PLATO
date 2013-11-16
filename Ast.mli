type operator = 
    Plus 
	| Minus
	| Times
	| Divide
	| Mod
	| Raise
	| And
	| Or

type expression = 
	  Boolean of bool
	| Number of int
	| Binop of expression * operator * expression

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
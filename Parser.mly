%{ open Ast %}
%{ open Logger %}

%token PLUS MINUS TIMES DIVIDE PERCENT CARET AND OR PRINT, SEMICOLON, OPEN_BRACE, CLOSE_BRACE, MAIN_HEADER, EOF
%token <bool> BOOLEAN
%token <int> NUMBER

%left AND OR
%left PLUS MINUS
%left TIMES DIVIDE PERCENT
%left CARET

%start program
%type <Ast.program> program

%%
  
expression:
    BOOLEAN { Boolean($1) }
	|	NUMBER { Number($1) }
	| expression PLUS expression{ Binop($1, Plus, $3) }
	| expression MINUS expression{ Binop($1, Minus, $3) }
	| expression TIMES expression{ Binop($1, Times, $3) }
	| expression DIVIDE expression{ Binop($1, Divide, $3) }
	| expression PERCENT expression{ Binop($1, Mod, $3) }
	| expression CARET expression{ Binop($1, Raise, $3) }
	| expression AND expression{ Binop($1, And, $3) }
	| expression OR expression{ Binop($1, Or, $3) }
	
statement:
    PRINT expression SEMICOLON { Print($2) }
	
statementList:
    /* empty */ { [] }
  | statementList statement { $2::$1 }
	
statementBlock: 
    OPEN_BRACE statementList CLOSE_BRACE { StatementBlock(List.rev $2) }
	
mainBlock:
    MAIN_HEADER statementBlock { MainBlock($2) }

program:
    mainBlock  { Program($1) }
  
  
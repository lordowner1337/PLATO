%{ open Ast %}
%{ open Logger %}

%token PRINT, SEMICOLON, OPEN_BRACE, CLOSE_BRACE, MAIN_HEADER, EOF
%token <int> INTEGER

%start program
%type <Ast.program> program

%%

expression:
    INTEGER { Integer($1) }
	
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
  
  
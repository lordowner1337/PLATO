%{ open Ast %}

%token PRINT, SEMICOLON, EOF
%token <int> INTEGER

%start statement
%type <Ast.statement>

%%

expression:
  INTEGER { logParserInteger $1; Integer($1) }
	
statement:
  PRINT expression SEMICOLON { logParserPrint; Print($2) }
  
  
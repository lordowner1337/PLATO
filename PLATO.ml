open Ast;;
open Logger;;
open Sast;;
open JavaAst;;
open Filename;;

(* Convert Ast to Sast *)
let rec checkExpression environment = function
	  Number(numberValue) -> TypedNumber(numberValue), IntegerType

let rec checkStatement environment = function
	  Print(expression) -> TypedPrint(checkExpression environment expression)

let checkStatementBlock environment = function
	  StatementBlock(statementList) -> TypedStatementBlock(List.map (checkStatement environment) statementList) 

let checkMainBlock environment = function
	  MainBlock(mainBlock) -> TypedMainBlock(checkStatementBlock environment mainBlock)

let checkProgram environment = function
	  Program(mainBlock) -> TypedProgram(checkMainBlock environment mainBlock)	 

(* Convert Sast to Java Ast *)
let createJavaExpression = function
	  TypedNumber(numberValue), IntegerType -> JavaInt(numberValue)

let createJavaStatement = function
	  TypedPrint(expression) -> JavaStatement(JavaExpression(JavaCall("System.out.println", [createJavaExpression expression])))

let createJavaMain = function
	  TypedStatementBlock(statementList) -> JavaMain(JavaBlock(List.map createJavaStatement statementList))

let createJavaClass = function 
	  TypedMainBlock(typedStatementList) -> [JavaClass("main", [createJavaMain typedStatementList])]

let createJavaAst = function
	  TypedProgram(typedMainBlock) -> JavaClassList(createJavaClass typedMainBlock)
		
(* Generate code from Java Ast *)		
let rec generateJavaCall logToJavaFile = function
	  JavaCall(methodName, javaExpressionList) ->
			logToJavaFile (String.concat "" [methodName; "("]);
			ignore (List.map (generateJavaExpression logToJavaFile) javaExpressionList);
			logToJavaFile ")"
and generateJavaExpression logToJavaFile = function
	  JavaInt(intValue) -> logToJavaFile (string_of_int intValue)
  | JavaExpression(javaCall) -> generateJavaCall logToJavaFile javaCall

let generateJavaStatement logToJavaFile = function
	  JavaStatement(javaExpression) ->
			generateJavaExpression logToJavaFile javaExpression;
			logToJavaFile ";\n"
		
let generateJavaBlock logToJavaFile = function
	  JavaBlock(javaStatementList) ->
			logToJavaFile "{\n"; 
			ignore (List.map (generateJavaStatement logToJavaFile) javaStatementList);
			logToJavaFile "}\n"

let generateJavaMethod logToJavaFile = function
	  JavaMain(javaBlock) -> 
			logToJavaFile "public static void main(String[] args) "; 
			generateJavaBlock logToJavaFile javaBlock

let generateJavaClass fileName = function
	  JavaClass(javaClassName, javaMethodList) -> 
			let fullClassName = String.concat "_" [javaClassName; fileName]
			in let logToJavaFile = logToFileNoNewline (String.concat "" [fullClassName; ".java"])
				 in logToJavaFile (String.concat " " ["public class"; fullClassName; "{\n"]);  
				    ignore (List.map (generateJavaMethod logToJavaFile) javaMethodList);
			      logToJavaFile "}\n"
			
let generateJavaCode fileName = function
	  JavaClassList(javaClassList) -> ignore (List.map (generateJavaClass fileName) javaClassList)

(* TODO: Need to check for correct file extension and existance and permissions for file *)
let compile fileName =
  let lexbuf = Lexing.from_channel (open_in fileName) 
	in let programAst = Parser.program Scanner.token lexbuf
	   in logProgramAst programAst; 
		    let programSast = checkProgram [] programAst
		    in logProgramSast programSast; 
				   let javaClassListAst = createJavaAst programSast
		       in logJavaClassListAst javaClassListAst; 
					    generateJavaCode (Filename.chop_extension (Filename.basename fileName)) javaClassListAst

let _ = compile Sys.argv.(1)
	 

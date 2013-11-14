open Printf

let logToFile fileName logString = 
	let fileHandle = open_out_gen [Open_creat; Open_append] 0o777 fileName
	in fprintf fileHandle "%s\n" logString; close_out fileHandle
	
let logScanner logString = 
	logToFile "Scanner.log" logString

let logScannerInteger integer =
	logScanner (String.concat " " ["INTEGER"; integer])		
		
let logScannerPrint =
	logScanner "PRINT"
	
let logScannerSemicolon =
	logScanner "SEMICOLON"
			
let logParser logString = 
	logToFile "Parser.log" logString

let logParserInteger integer =
	logParser (String.concat " " ["INTEGER"; (string_of_int integer)])
	
let logParserPrint =
	logParser "PRINT"
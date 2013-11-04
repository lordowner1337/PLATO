let logToFile fileName logString = 
	let fileHandle = open_out fileHandle
	in fprintf fileHandle "%s\n" logString; close_out fileHandle
	
let logScanner logString = 
	logToFile "Scanner.log" logString

let logScannerInteger integer =
	logScanner (String.concat " " ["INTEGER"; (int_of_string integer)])		
		
let logScannerPrint =
	logScanner "PRINT"
	
let logScannerSemicolon =
	logScanner "SEMICOLON"
			
let logParser logString = 
	logToFile "Parser.log" logString

let logScannerParser integer =
	logParser (String.concat " " ["INTEGER"; (int_of_string integer)])
	
let logParserPrint =
	logParser "PRINT"
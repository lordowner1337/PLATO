open OUnit;;

let testPrintStatement _ = 
	assert_equal 1 2


let testSuite = "TEMP" >:::
[
	"testPrintStatement" >:: testPrintStatement
]

(* Run tests *)
let _ = run_test_tt_main testSuite
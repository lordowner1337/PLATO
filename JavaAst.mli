open Sast;;

type javaCall = 
	  JavaCall of string * javaExpression list
and 
javaExpression = 
	  JavaInt of int
	| JavaExpression of javaCall

type javaStatement =
	  JavaStatement of javaExpression

type javaBlock =
	  JavaBlock of javaStatement list

type javaMethod	=
	  JavaMain of javaBlock
				
type javaClass = 
	  JavaClass of string * javaMethod list
		
type javaClassList = 
	  JavaClassList of javaClass list

# see: http://www.ocaml.info/home/ocaml_sources.html#toc16

# put here the names of your source files (in the right order)
SOURCES = Ast.mli Logger.ml Parser.mly Scanner.mll PLATO.ml

# the name of the resulting executable
RESULT  = platoc

# generate type information (.annot files)
ANNOTATE = yes

# make target (see manual) : byte-code, debug-code, native-code, ...
all: debug-code

# trash files for make clean
TRASH = *.log

include OCamlMakefile

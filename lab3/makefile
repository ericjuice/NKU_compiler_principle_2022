flex:
	flex -+ -o "src/lexer.cc" "src/lexer.l"
	g++ src/lexer.cc -o lexer.o
	./lexer.o
# 下面这个测试用的，暂时没啥用
exe:
	./lexer.o
flex1:
	flex -+ -o "src/lexer.cc" --header-file="src/lexer.h" "src/lexer.l"
	byacc -d -o "src/parser.c" "src/parser.y"
	g++ src/lexer.cc -lfl  -o lexer.o


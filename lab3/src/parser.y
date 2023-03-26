%{
#include "lexer.h"
#include <fstream>
#include <iostream>
using namespace std;
#ifndef YYSTYPE
#define YYSTYPE int
#endif
%}

// declarations section
/* %name parser */
// attribute type
%token NUMBER	//十进制数
%token ID
%token ADD SUB // 加减
%token MUL DIV	//乘除
%token LE RE	//括号
%token MOD INC DEC

%token MAIN	INT CHAR IF ELSE WHILE FOR

%token LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET SEMICOLON

%%

/////////////////////////////////////////////////////////////////////////////
// rules section


Grammar
	: /* empty */
	;

%%


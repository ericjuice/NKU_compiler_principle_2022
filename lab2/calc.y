%{

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#ifndef YYSTPYE
#define YYSTYPE double
#endif



int yylex();

extern int yyparse();
FILE* yyin;



void yyerror(const char* s);
%}


%token T_INT UMINUS
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT T_MOD
%token T_NEWLINE 
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE T_MOD
%right UMINUS

%type expression
//%type mixed_expression

%start line

%%


line: T_NEWLINE
    | expression T_NEWLINE { printf("Result: %f\n", $1); }
    |	
;


expression: T_INT				{ $$ = $1; }
	  | expression T_PLUS expression	{ $$ = $1 + $3; }
	  | expression T_MINUS expression	{ $$ = $1 - $3; }
	  | expression T_MULTIPLY expression	{ $$ = $1 * $3; }
	  | expression T_DIVIDE expression	{ $$ = $1 / $3; }
	  | T_LEFT expression T_RIGHT		{ $$ = $2; }
	  | expression T_MOD expression		{ $$ = (int)$1 % (int)$3;}
	  | T_MINUS expression %prec UMINUS	{ $$ = -$2;}
;

%%

int yylex()
{
    // place your token retrieving code here
    int t;
    while (1)
    {
        t = getchar();
        if (t == ' ' || t == '\t' || t == '\n') //是空白
            ;
        
        else if ((t >= '0' && t <= '9'))    // 是数字
        {
            yylval = 0;
         
            while ((t >= '0' && t <= '9'))
            {
                
                yylval = yylval*10+t-'0';
                
                t = getchar();
                
            }
            // yylval是自动定义的全局变量
            ungetc(t, stdin);   // 剩余的字符送回输入流
            return T_INT;
        }
        
        else {  // 是符号
            switch(t){
                case '+':
                    return T_PLUS;
                    break;
                case '-':
                    return T_MINUS;
                    break;
                case '*':
                    return T_MULTIPLY ;
                    break;
                case '/':
                    return T_DIVIDE;
                    break;
                case '(':
               	    return T_LEFT;
               	    break;
               	case ')':
               	    return T_RIGHT;
               	    break;
               	case ';':
               	    return T_NEWLINE;
               	    break;
               	case '%':
               	    return T_MOD;
               	    break;
             	
                default:
                    printf("无法解析符号%c\n",t);
                    return t;
            }
        }
        
    }
}

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	
	exit(1);
}


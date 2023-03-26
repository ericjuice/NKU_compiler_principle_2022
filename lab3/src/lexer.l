%option noyywrap
%{
// #include "parser.h"
#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
#include <iomanip>
using namespace std;

int linenum=1;
int yycolumn=0;
struct var//符号表项
{
	string Name;//对应符号表名字，值，类型，下一个的指针
	void *Value;
	int Type;
	struct var *Next;
};

class Var_list
{
public:
	struct var *head;
	int max;//符号表项数
	struct var *temp;
	Var_list()
	{
		max = 0;
	}
	int set_var(char* name)
	{
		string s_name = name;
		this->temp = this->head;
		int i = max;
		//查看该变量是否已经存在
		while( this->temp != NULL)
		{
			i--;
			if( temp->Name == s_name )
			{
				return i;
			}
			temp = temp->Next;//遍历符号表，如果已经存在，就返回位置索引
		}
		this->temp = this->head;//在头部挂上一个新的项
		this->head = new struct var;
		this->head->Name = s_name;
		this->head->Next = temp;
		max++;
		
		return max-1;
	}
}m_list;

static void print_token(string token, char* text)
{
	// 分号
	// if(token == "SEMICOLON")
	// 	cout<<token<<"\t\t"<<text<<"\t\t";
	// else cout<<token<<"\t\t\t"<<text<<"\t\t";
	// if(token == "ID")
	// {
	// 	cout<<m_list.set_var(text)<<"\t";//在符号表中的位置
	// }
	// if(token == "NUMBER")
	// {
	// 	cout<<text<<"\t";
	// }
	// cout<<"\t"<<linenum<<"\t"<<endl;
	cout<<setw(10)<<linenum<<setw(10)<<token<<setw(10)<<text<<setw(10)<<yycolumn<<setw(10)<<0<<endl;
}    

static string oct_dec(string text)
{
	string a  = text;
    int len = a.length() - 1;
    int all = 0;
    for(int i = 0; i < len; i++)
    {
         int temp1 = (pow(8, (len - i - 1)));
        int temp2 = (a[i + 1] - '0');
        all = all + temp1 * temp2;         
    }
	string s=to_string(all);
    return s;  
}

static string hex_dec(string text)
{
	string a  = text;
    int len = a.length() - 2;
    int all = 0;
    for(int i = 0; i < len; i++)
    {
        int temp1 = (pow(16, (len - i - 1)));
        int temp2;
        if(a[i + 2] >= '0' && a[i + 2] <= '9'){
             temp2 = (a[i + 2] - '0');
        }
        else if(a[i + 2] >= 'A' && a[i + 2] <= 'F'){
            temp2 = a[i + 2] - 'A' + 10;
        }
        else if(a[i + 2] >= 'a' && a[i + 2] <= 'f'){
            temp2 = a[i + 2] - 'a' + 10;
        }
        all = all + temp1 * temp2;         
    }
	string s=to_string(all);
    return s; 
}

%}

%option yylineno

MAIN	"main"
INT 	"int"
IF 		"if"
ELSE 	"else"
WHILE 	"while"

ID		[_a-zA-Z][_a-zA-Z0-9]*

HEX (0x[1-9|A-F|a-f][0-9|A-F|a-f]*|0x0)
OCT (0[1-7][0-7]*|00)
NUMBER	([1-9][0-9]*|0)


LBRACE 	"{"
RBRACE 	"}"
LPAREN 	"("
RPAREN 	")"
LBRACKET "["
RBRACKET "]"

ASSIGN 	"="
ADD 	"+"
SUB 	"-"
MUL 	"*"
DIV 	"/"
MOD 	"%"
INC 	"++"
DEC 	"--"
EQ 		"=="

LT      "<"
GT      ">"

SEMICOLON 	";"

ADDEQU   "+="
SUBEQU   "-="
MULEQU   "*="
DIVEQU   "/="
MODEQU   "%="
LOGICNEGATION  "!"
AND      "&"
OR       "|"
NEGA     "~"
XOR      "^"
ANDAND   "&&"
OROR     "||"
ANDEQU   "&="
OREQU    "|="
XOREQU   "^="
REQU     ">="
LEQU     "<="
UEQP     "!="
COMMA    ","
COLON    ":"

linecomment (\/\/.*|\/\/.*)
commentbegin "/*"
commentelement .|\n
commentend "*/"

%x BLOCKCOMMENT

/* rule */
%%
" "			{yycolumn++;}
"\n"    	{linenum++;yycolumn=0;}
"\t"		{}
""

{linecomment} {print_token("LINECMT",yytext);yycolumn=0;}

{commentbegin} {
    BEGIN BLOCKCOMMENT;
    string a = yytext;
    while(a.find('\n') != a.npos)
    {
        linenum++;
        a.replace(a.find('\n'),1,"");
    }
	char t[3]="/*";
    print_token("CMTBG",t);
}

<BLOCKCOMMENT>{commentend} {
    string a = yytext;
    if(a.find("\n") != a.npos)
    {
        linenum++;
        a.replace(a.find("\n"),1,"");
    }
	char t[3]="*/";
    print_token("CMTEND",t);
    BEGIN INITIAL;
}

<BLOCKCOMMENT>{commentelement} {
    string a = yytext;
    if(a.find('\n') != a.npos)
    {
        linenum++;
        a.replace(a.find('\n'),1,"");
    }
	// char c[a.length()];
	// strcpy(c,a.data()); 
    // print_token("CMT",c);
}


{MAIN}		{print_token("MAIN", yytext);yycolumn+=yyleng;}
{INT}		{print_token("INT", yytext);yycolumn+=yyleng;}
{IF} 		{print_token("IF", yytext);yycolumn+=yyleng;}
{ELSE}		{print_token("ELSE", yytext);yycolumn+=yyleng;}
{WHILE} 	{print_token("WHILE", yytext);yycolumn+=yyleng;}
{ID}		{print_token("ID", yytext);yycolumn+=yyleng;}

{NUMBER}	{print_token("NUMBER", yytext);yycolumn+=yyleng;}
{OCT} 		{
			string s=oct_dec(yytext);
			char c[s.length()];
			strcpy(c,s.data());
			print_token("OCT",c);
			yycolumn+=yyleng;
			} 
{HEX} 		{
			string s=hex_dec(yytext);
			char c[s.length()];
			strcpy(c,s.data());
			print_token("HEX",c);
			yycolumn+=yyleng;
			}

{LBRACE} 	{print_token("LBRACE", yytext);yycolumn+=yyleng;}
{RBRACE} 	{print_token("RBRACE", yytext);yycolumn+=yyleng;}
{LPAREN} 	{print_token("LPAREN", yytext);yycolumn+=yyleng;}
{RPAREN} 	{print_token("RPAREN", yytext);yycolumn+=yyleng;}
{LBRACKET} 	{print_token("LBRACKET", yytext);yycolumn+=yyleng;}
{RBRACKET} 	{print_token("RBRACKET", yytext);yycolumn+=yyleng;}

{ASSIGN}	{print_token("ASSIGN", yytext);yycolumn+=yyleng;}
{ADD} 		{print_token("ADD", yytext);yycolumn+=yyleng;}
{SUB} 		{print_token("SUB", yytext);yycolumn+=yyleng;}
{MUL} 		{print_token("MUL", yytext);yycolumn+=yyleng;}
{DIV} 		{print_token("DIV", yytext);yycolumn+=yyleng;}
{MOD} 		{print_token("MOD", yytext);yycolumn+=yyleng;}
{INC} 		{print_token("INC", yytext);yycolumn+=yyleng;}
{DEC} 		{print_token("DEC", yytext);yycolumn+=yyleng;}
{EQ}		{print_token("EQ", yytext);yycolumn+=yyleng;}
{LT}        {print_token("LT", yytext);yycolumn+=yyleng;}
{GT}        {print_token("GT", yytext);yycolumn+=yyleng;}

{SEMICOLON} {print_token("SEMICOLON", yytext);yycolumn+=yyleng;}

{ADDEQU}     {print_token("ADDEQU", yytext);yycolumn+=yyleng;}
{SUBEQU}     {print_token("SUBEQU", yytext);yycolumn+=yyleng;}
{MULEQU}     {print_token("MULEQU", yytext);yycolumn+=yyleng;}
{DIVEQU}     {print_token("DIVEQU", yytext);yycolumn+=yyleng;}
{MODEQU}     {print_token("MODEQU", yytext);yycolumn+=yyleng;}
{LOGICNEGATION}      {print_token("LOGICNEGATION", yytext);yycolumn+=yyleng;}
{AND}      {print_token("AND", yytext);yycolumn+=yyleng;}
{OR}      {print_token("OR", yytext);yycolumn+=yyleng;}
{NEGA}      {print_token("NEGA", yytext);yycolumn+=yyleng;}
{XOR}      {print_token("XOR", yytext);yycolumn+=yyleng;}
{ANDAND}     {print_token("ANDAND", yytext);yycolumn+=yyleng;}
{OROR}     {print_token("OROR", yytext);yycolumn+=yyleng;}
{ANDEQU}     {print_token("ANDEQU", yytext);yycolumn+=yyleng;}
{OREQU}     {print_token("OREQU", yytext);yycolumn+=yyleng;}
{XOREQU}     {print_token("XOREQU", yytext);yycolumn+=yyleng;}
{REQU}     {print_token("REQU", yytext);yycolumn+=yyleng;}
{LEQU}     {print_token("LEQU", yytext);yycolumn+=yyleng;}
{UEQP}     {print_token("UEQP", yytext);yycolumn+=yyleng;}
{COMMA}      {print_token("COMMA", yytext);yycolumn+=yyleng;}
{COLON}      {print_token("COLON", yytext);yycolumn+=yyleng;}

.			{printf("Error type A :Mysterious character \"%s\"\n\t at Line %d\n",yytext,yylineno);}
%%

int main(){
	int n = 1;
	yyFlexLexer lexer;
    char myfile[2];
    cout<<"请输入你要测试的文件(只需要输入序号)\n";
    cin>>myfile;
    char testfile[20]="./test/";
    strcat(testfile,myfile);
    strcat(testfile,".sy");

	freopen(testfile,"r",stdin);
	cout.setf(std::ios::left);
	cout<<setw(10)<<"LINES"<<setw(10)<<"TOKEN"<<setw(10)<<"LEXEME"<<setw(10)<<"OFFSET"<<setw(10)<<"PTR"<<endl;
	n = lexer.yylex();
	return n;
}

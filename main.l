%{
#include<string.h>
%}

keyw "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"

%%
{keyw}  {printf("%s : Keyword\n", yytext);}

{keyw}\s*[(]	{
		int size=strlen(yytext);
		char strr[size];
        strcpy(strr, yytext);
        strr[size - 1] = '\0';
		printf("%s : Keyword\n", strr);
		printf("( : Other Symbol\n");
	}

([_a-zA-Z][_a-zA-Z0-9]*\s*[(]) {
				int size=strlen(yytext);
				char strr[size];
                strcpy(strr, yytext);
                strr[size - 1] = '\0';
				printf("%s : Function Name\n", strr);
				printf("( : Other Symbol\n");
			}

(\"([^\\\"]|\\.)*\")  {printf("%s : String\n",yytext);}
([_a-zA-Z][_a-zA-Z0-9]*)  {printf("%s : Valid Identifier\n",yytext); }
([0-9]+|[0-9]+[.][0-9]+) {printf("%s : Valid Number\n",yytext);}

([*+/-]|[+|-]{2}) {printf("%s :Arithmatic Operator\n",yytext);}
([<>]=?|[!=]=) {printf("%s : Relational Operator\n",yytext);}
([&]{2}|[|]{2}|[!]=?) {printf("%s : Logical Operator\n",yytext);}
("="|"+="|"-="|"/="|"*=") {printf("%s : Assignment Operator\n",yytext);}

([\n]|[\t]|[ ]) {}
. {printf("%s : Other Symbol\n",yytext);}

%%

int yywrap(){} //wraps the rule section
int main(){
	FILE *fp;
	fp = fopen("input2.txt","r");
	yyin = fp; // yyin->takes the file pointer containing input

	yylex(); // main flex function, runs the Rule Section

	return 0;
}

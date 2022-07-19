%{
  /*error check for website not responding*/

#  include <stdio.h>
#  include <stdlib.h>

int yylex();
void yyerror(char *s);
int values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
char* numerals[] = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
void toNumeral(int num){
  if (num==0) {
    printf("Z\n");
  } else {
    if (num < 0) {
      printf("-");
      num *= -1;
    }
    while (num != 0)
    {
      int i=0;
      while (num < values[i]){
        i++;
      }
      printf(numerals[i]);
      num -= values[i];
      i=0;

    }
    printf("\n");
  }
  



}
%}

%token I II III IV V VI VII VIII IX X XX XXX XL L LX LXX LXXX XC C CC CCC CD D DC DCC DCCC CM M MM MMM
%token ADD SUB MUL DIV
%token OP CP
%token EOL
%token ERROR


%%

eval: /* nothing */
 | eval exp EOL { toNumeral($2); }
 ; 

exp: factor {$$ = $1;}
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: val {$$ = $1;}
 | factor MUL val { $$ = $1 * $3; }
 | factor DIV val { $$ = $1 / $3; }
 ;

val: numeral {$$ = $1;}
 | val numeral {$$ = $1 + $2;}
 | OP exp CP {$$ = $2;}
 | OP exp {yyerror("syntax error");} 
 ;

numeral: I {$$ = $1;}
  |II {$$ = $1;}
  |III {$$ = $1;}
  |IV {$$ = $1;}
  |V {$$ = $1;}
  |VI {$$ = $1;}
  |VII {$$ = $1;}
  |VIII {$$ = $1;}
  |IX {$$ = $1;}
  |X {$$ = $1;}
  |XX {$$ = $1;}
  |XXX {$$ = $1;}
  |XL  {$$ = $1;}
  |L {$$ = $1;}
  |LX {$$ = $1;}
  |LXX {$$ = $1;}
  |LXXX {$$ = $1;}
  |XC {$$ = $1;}
  |C {$$ = $1;}
  |CC {$$ = $1;}
  |CCC {$$ = $1;}
  |CD {$$ = $1;}
  |D {$$ = $1;}
  |DC {$$ = $1;}
  |DCC {$$ = $1;}
  |DCCC {$$ = $1;}
  |CM {$$ = $1;}
  |M {$$ = $1;}
  |MM {$$ = $1;}
  |MMM {$$ = $1;}
  |ERROR {yyerror("syntax error\n"); return 0;}
;

%%
int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
  exit(0);
}


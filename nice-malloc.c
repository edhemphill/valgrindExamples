#include <stdio.h>
#include <stdlib.h>

int main()
{
  char *p;

  p = (char *) malloc(20);

  char *s = p;
  for(int n=0;n<20;n++) {
  	*s = '\0';
  	s++;
  }		

  free(p);
}

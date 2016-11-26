#include <stdio.h>
#include <stdlib.h>

int main()
{
  char *p;

  // Allocation #1 of 19 bytes
  p = (char *) malloc(20); // this is leaked (no free)

  char *s = p;
  for(int n=0;n<20;n++) {
  	*s = '\0';
  	s++;
  }	

  for(int n=0;n<30;n++) {
  	*s = 'A'; // might cause a SIGFAULT also
  	s++;
  }	



  // Allocation #2 of 12 bytes
}

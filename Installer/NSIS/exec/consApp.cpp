#include <windows.h>
#include <stdio.h>

int main( int argc, char **argv)
{
   char b[1024] = "";
   printf("This is test console application for ExecCmd NSIS plugin\n");
   printf("Written by Takhir Bedertdinov\n\n");
   printf("Login: ");
   fflush(NULL);
//   fgets(b, sizeof(b), stdin);// generates error in msvcrt
   gets(b);
   printf("%s\n", b);
/*MessageBox(NULL, "Login received", b, 0);*/
   printf("Passowrd: ");
   fflush(NULL);
   *b = 0;
//   fgets(b, sizeof(b), stdin);
   gets(b);
   printf("%s\n", b);
   Sleep(1000);
/*MessageBox(NULL, "Password received", b, 0);*/
   printf("\nThanks\nBla-bla-bla\nBye\n");
   fflush(NULL);
	return 5;
}


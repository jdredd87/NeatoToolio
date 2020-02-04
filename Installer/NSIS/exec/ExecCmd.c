/***************************************************
* FILE NAME: ExecCmd.c
*
* PURPOSE:
*    NSIS plugin for DOS (console) applications.
*    Sends input using WM_CHAR
*
* CHANGE HISTORY
*
* $LOG$
*
* Author              Date          Modifications
* Takhir Bedertdinov  Jan 24 2006   Original
*        Moscow, Russia, ineum@narod.ru
**************************************************/

#include <windows.h>
#include <Tlhelp32.h>
#include <fcntl.h>
#include <stdio.h>
#include <io.h>
#include <sys\stat.h>
#include "..\ExDll\exdll.h"

enum ERROR_CODES {
   ERR_CREATEPROC = -5,
   ERR_TERMINATED,
   ERR_CREATETHREAD,
   ERR_GETEXITCODE
};

#define SLEEP_MS 50
#define T_O "/TIMEOUT"
#define N_W "/ASYNC"
#define TEST "/TEST"

typedef struct _threadParams {
   char *cmdLine;
   char *stdIn;
   DWORD timeout;
   HWND consWnd;
   DWORD ProcessID;
} threadParams, *pthreadParams;


WORD cpFlags = SW_HIDE;


/*****************************************************
 * FUNCTION NAME: msvcrt replacements
 * PURPOSE: 
 *    early Win95 compat.
 * SPECIAL CONSIDERATIONS:
 *    
 *****************************************************/
char *my_strchr(char *s, char c)
{
   while(*s != 0)
   {
      if(*s == c)
         return s;
      s++;
   }
   return NULL;
}

DWORD my_atoui(char *s)
{
  unsigned int v=0;
  char m=10;
  char t='9';

  if (*s == '0')
  {
    s++; // skip over 0
    if (s[0] >= '0' && s[0] <= '7')
    {
      m=8; // octal
      t='7';
    }
    if ((s[0] & ~0x20) == 'X')
    {
      m=16; // hex
      s++; // advance over 'x'
    }
  }

  for (;;)
  {
    int c=*s++;
    if (c >= '0' && c <= t) c-='0';
    else if (m==16 && (c & ~0x20) >= 'A' && (c & ~0x20) <= 'F') c = (c & 7) + 9;
    else break;
    v*=m;
    v+=c;
  }
  return v;
}

/*****************************************************
 * FUNCTION NAME: win98Check()
 * PURPOSE: 
 *    searches for process whoes parent is command.com
 *    we have started
 * SPECIAL CONSIDERATIONS:
 *    nsProcess plug-in code used.
 *    proc ID compare and may be file name (later)
 *****************************************************/
HANDLE win98Check(DWORD parProcID, HANDLE parProcHndl)
{
   BOOL bResult;
	HANDLE hProc, hSnapShot;
   OSVERSIONINFO osvi = {sizeof(OSVERSIONINFO)};
	HINSTANCE hInstLib;
   PROCESSENTRY32 procentry = {sizeof(PROCESSENTRY32)};  
// ToolHelp Function Pointers.
   HANDLE (WINAPI *lpfCreateToolhelp32Snapshot)(DWORD, DWORD);
   BOOL (WINAPI *lpfProcess32First)(HANDLE, LPPROCESSENTRY32);
   BOOL (WINAPI *lpfProcess32Next)(HANDLE, LPPROCESSENTRY32);


// First check what version of Windows we're in
	if (!GetVersionEx(&osvi) ||
		osvi.dwPlatformId != VER_PLATFORM_WIN32_WINDOWS ||
      (hInstLib = LoadLibraryA("Kernel32.DLL")) == NULL)
      return parProcHndl;

// Get procedure addresses and procs snapshot
   lpfCreateToolhelp32Snapshot=(HANDLE(WINAPI *)(DWORD, DWORD)) GetProcAddress(hInstLib, "CreateToolhelp32Snapshot");
   lpfProcess32First=(BOOL(WINAPI *)(HANDLE, LPPROCESSENTRY32)) GetProcAddress(hInstLib, "Process32First");
   lpfProcess32Next=(BOOL(WINAPI *)(HANDLE, LPPROCESSENTRY32)) GetProcAddress(hInstLib, "Process32Next");

   if(lpfCreateToolhelp32Snapshot == NULL ||
      lpfProcess32Next == NULL ||
      lpfProcess32First == NULL ||
      (hSnapShot = lpfCreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)) == INVALID_HANDLE_VALUE)
   {
			FreeLibrary(hInstLib);
			return parProcHndl;
   }

// Get the first process information and loop checking for parent process ID
// works correct if console is visibe. very strange. sync problems?
   bResult=lpfProcess32First(hSnapShot, &procentry);
   while (bResult)
   {
      if(procentry.th32ParentProcessID == parProcID)
      {
			if(hProc = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, procentry.th32ProcessID))
         {
            CloseHandle(parProcHndl);
            parProcHndl = hProc;
			}
         break;
		}
//Keep looking
		procentry.dwSize=sizeof(PROCESSENTRY32);
		bResult=lpfProcess32Next(hSnapShot, &procentry);
	}
	CloseHandle(hSnapShot);
	FreeLibrary(hInstLib);
   return parProcHndl;
}


/*****************************************************
 * FUNCTION NAME: winCheck() callback
 * PURPOSE: 
 *    checks enumerated windows process ID
 * SPECIAL CONSIDERATIONS:
 *    
 *****************************************************/
BOOL CALLBACK winCheck(HWND hWnd, LPARAM lParam)
{
   pthreadParams ptp = (pthreadParams)lParam;
   DWORD iProcess;

   GetWindowThreadProcessId(hWnd, &iProcess);
   if(ptp->ProcessID == iProcess)
   {  ptp->consWnd = hWnd; return FALSE;  }
   return TRUE;
}

/*****************************************************
 * FUNCTION NAME: sendChars()
 * PURPOSE: 
 *    thread procedure. Creates child process and sends
 *    chars to it's window
 * SPECIAL CONSIDERATIONS:
 *    bad exit code on W9x looks like a sync problem...
 *****************************************************/
DWORD __stdcall sendChars(void *pp)
{
   PROCESS_INFORMATION pi;
   STARTUPINFO *psi = GlobalAlloc(GPTR, sizeof(STARTUPINFO));
   DWORD rslt = ERR_CREATEPROC;
   pthreadParams ptp = (pthreadParams)pp;
	char *pstdin = ptp->stdIn;
   HANDLE chp;

   while(1)
   {
// run process
      psi->cb = sizeof(STARTUPINFO);
      psi->dwFlags = STARTF_USESHOWWINDOW;
      psi->wShowWindow = cpFlags;
// who will be suspended? command.com or our process?
// Not suspends on Win98, not Resumes on XP :-((
      if(!CreateProcess(NULL, ptp->cmdLine, NULL, NULL, TRUE, 0,//CREATE_SUSPENDED,
         NULL, NULL, psi, &pi))
         break;
// wait a little, not finds child process otherwise.
      Sleep(200);
// on Win9x we get command.com process ID, so let's find it's child for correct exit code
      chp = win98Check(pi.dwProcessId, pi.hProcess);
// if stdin is string (not <file), process can wait while we search for window
//      ResumeThread(pi.hThread);
      CloseHandle(pi.hThread);
      WaitForInputIdle(pi.hProcess, 200);
      ptp->ProcessID = pi.dwProcessId;
// returns ptp->consWnd
      EnumWindows(winCheck, (LPARAM)ptp);
      pi.hProcess = chp;
// let's send our string. not required for <stdin.file. WM_CHAR not works on Win9x
      while(ptp->consWnd != NULL && *pstdin != 0)
      {
         if(*pstdin == '\n') Sleep(100);
//         SendMessage(ptp->consWnd, WM_KEYDOWN, MapVirtualKey(*pstdin, 1), 0);
         SendMessage(ptp->consWnd, WM_CHAR, *pstdin, 0);
         pstdin++;
      } 
      WaitForSingleObject(pi.hProcess, ptp->timeout);

      if(GetExitCodeProcess(pi.hProcess, &rslt))
      {
         if(rslt == STILL_ACTIVE)
         {
            TerminateProcess(pi.hProcess, -1);
		      rslt = ERR_TERMINATED;
         }
      }
      else rslt = ERR_GETEXITCODE;
      break;
   }

   if(pi.hProcess)
      CloseHandle(pi.hProcess);
   GlobalFree(psi);
   GlobalFree(ptp->cmdLine);
   GlobalFree(ptp->stdIn);
   GlobalFree(ptp);
   return (DWORD)rslt;
}


/*****************************************************
 * FUNCTION NAME: wait()
 * PURPOSE: 
 *    takes handle from stack and waits for thread exit,
 *    then closes handle
 * SPECIAL CONSIDERATIONS:
 *    tested with my consApp.exe, gpg.exe and others
 *****************************************************/
void __declspec(dllexport) wait(HWND hwndParent,
										  int string_size,
										  char *variables,
										  stack_t **stacktop)
{
   int rslt = ERR_CREATETHREAD;
   char exitCode[16];
   HANDLE hThread;

   popstring(exitCode);
   hThread = (HANDLE)my_atoui(exitCode);
// push to stack application' exit code or -1 or "still_running"
   if(hThread != NULL)
   {
      WaitForSingleObject(hThread, INFINITE);
      GetExitCodeThread(hThread, &rslt);
      CloseHandle(hThread);
      hThread = NULL;
   }
   wsprintf(exitCode,"%d", rslt);
   pushstring(exitCode);

}

/*****************************************************
 * FUNCTION NAME: exec()
 * PURPOSE: 
 *    C dll entry point for hidden DOS process execution
 * SPECIAL CONSIDERATIONS:
 *    tested with my consApp.exe
 *****************************************************/
void __declspec(dllexport) exec(HWND hwndParent,
										  int string_size,
										  char *variables,
										  stack_t **stacktop)
{
   DWORD dwThreadId;
   HANDLE hThread;
   BOOL fWait = TRUE;
   pthreadParams ptp = GlobalAlloc(GPTR, sizeof(threadParams));
   char s[16], *pvalue;

   EXDLL_INIT();

   ptp->cmdLine = GlobalAlloc(GPTR, string_size);
   ptp->stdIn = GlobalAlloc(GPTR, string_size);
   ptp->timeout = 0xffffff;

   while(!popstring(ptp->stdIn) &&
      *(ptp->stdIn) == '/')
   {
      pvalue = my_strchr(ptp->stdIn, '=');
      if(pvalue != NULL)
         *pvalue++ = 0;
      if(lstrcmpi(ptp->stdIn, T_O) == 0)
      {
         ptp->timeout = my_atoui(pvalue);
      }
      else if(lstrcmpi(ptp->stdIn, N_W) == 0)
      {
         fWait = FALSE;
      }
      else if(lstrcmpi(ptp->stdIn, TEST) == 0)
      {
         cpFlags = SW_NORMAL;
      }
   }

   GetEnvironmentVariable("ComSpec", ptp->cmdLine, string_size);
   lstrcat(ptp->cmdLine, " /C ");
   lstrcat(ptp->cmdLine, ptp->stdIn);
   popstring(ptp->stdIn);
//   MessageBox(hwndParent, ptp->stdIn, ptp->cmdLine, 0);

   hThread = CreateThread(NULL, 0, sendChars, (void*)ptp, 0, &dwThreadId);
   wsprintf(s, "%u", hThread);
   pushstring(s);
   if(fWait) wait(hwndParent, string_size, variables, stacktop);
}

/*****************************************************
 * FUNCTION NAME: DllMain()
 * PURPOSE: 
 *    Dll main entry point
 * SPECIAL CONSIDERATIONS:
 *    
 *****************************************************/
BOOL WINAPI DllMain(HANDLE hInst,
						  ULONG ul_reason_for_call,
						  LPVOID lpReserved)
{
	return TRUE;
}

/*      while((hw=FindWindowEx(NULL, hw, NULL, NULL)) != NULL && winCheck(hw,(LPARAM)ptp))
      {
//nothing
      }*/


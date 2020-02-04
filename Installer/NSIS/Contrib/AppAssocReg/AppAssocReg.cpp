/**
 * Set Application Association Registration NSIS plug-in
 * for Windows Vista and above
 * http://msdn2.microsoft.com/en-us/library/ms647176.aspx
 *
 * Version: 0.4
 * Date   : 10th December 2008
 * Author : Robert Strong
 */

// Uncomment to force Unicode support
//#define UNICODE
//#define _UNICODE

#include <windows.h>
#include "..\ExDll\exdll.h"
#include "shlobj.h"

#define TYPE_FILE              TEXT("file")
#define TYPE_PROTOCOL          TEXT("protocol")
#define TYPE_STARTMENU         TEXT("startMenu")
#define TYPE_MIME              TEXT("mime")

#define LEVEL_MACHINE          TEXT("machine")
#define LEVEL_EFFECTIVE        TEXT("effective")
#define LEVEL_USER             TEXT("user")

#define OUT_SUCCESS            TEXT("success")
#define OUT_ERR_NOT_AVAILABLE  TEXT("method not available")
#define OUT_ERR_CALL_FAILED    TEXT("method failed")
#define OUT_ERR_INVALID_PARAM  TEXT("invalid parameter")

#define MAX_REG_KEY_NAME 255

// Support compiling without shlobj.h from the Vista SDK
#if !defined(IApplicationAssociationRegistration)

typedef enum tagASSOCIATIONLEVEL
{
  AL_MACHINE,
  AL_EFFECTIVE,
  AL_USER
} ASSOCIATIONLEVEL;

typedef enum tagASSOCIATIONTYPE
{
  AT_FILEEXTENSION,
  AT_URLPROTOCOL,
  AT_STARTMENUCLIENT,
  AT_MIMETYPE
} ASSOCIATIONTYPE;

MIDL_INTERFACE("4e530b0a-e611-4c77-a3ac-9031d022281b")
IApplicationAssociationRegistration : public IUnknown
{
  public:
    virtual HRESULT STDMETHODCALLTYPE QueryCurrentDefault(LPCWSTR pszQuery,
                                                          ASSOCIATIONTYPE atQueryType,
                                                          ASSOCIATIONLEVEL alQueryLevel,
                                                          LPWSTR *ppszAssociation) = 0;
    virtual HRESULT STDMETHODCALLTYPE QueryAppIsDefault(LPCWSTR pszQuery,
                                                        ASSOCIATIONTYPE atQueryType,
                                                        ASSOCIATIONLEVEL alQueryLevel,
                                                        LPCWSTR pszAppRegistryName,
                                                        BOOL *pfDefault) = 0;
    virtual HRESULT STDMETHODCALLTYPE QueryAppIsDefaultAll(ASSOCIATIONLEVEL alQueryLevel,
                                                           LPCWSTR pszAppRegistryName,
                                                           BOOL *pfDefault) = 0;
    virtual HRESULT STDMETHODCALLTYPE SetAppAsDefault(LPCWSTR pszAppRegistryName,
                                                      LPCWSTR pszSet,
                                                      ASSOCIATIONTYPE atSetType) = 0;
    virtual HRESULT STDMETHODCALLTYPE SetAppAsDefaultAll(LPCWSTR pszAppRegistryName) = 0;
    virtual HRESULT STDMETHODCALLTYPE ClearUserAssociations(void) = 0;
};

#endif

static const CLSID CLSID_ApplicationAssociationReg = {0x591209C7,0x767B,0x42B2,{0x9F,0xBA,0x44,0xEE,0x46,0x15,0xF2,0xC7}};
static const IID   IID_IApplicationAssociationReg  = {0x4e530b0a,0xe611,0x4c77,{0xa3,0xac,0x90,0x31,0xd0,0x22,0x28,0x1b}};

BOOL GetAssocType(TCHAR *aInType, tagASSOCIATIONTYPE* aOutType)
{
  if (lstrcmpi(aInType, TYPE_FILE) == 0)
  {
    *aOutType = AT_FILEEXTENSION;
    return TRUE;
  }

  if (lstrcmpi(aInType, TYPE_PROTOCOL) == 0)
  {
    *aOutType = AT_URLPROTOCOL;
    return TRUE;
  }

  if (lstrcmpi(aInType, TYPE_STARTMENU) == 0)
  {
    *aOutType = AT_STARTMENUCLIENT;
    return TRUE;
  }

  if (lstrcmpi(aInType, TYPE_MIME) == 0)
  {
    *aOutType = AT_MIMETYPE;
    return TRUE;
  }

  return FALSE;
}

BOOL GetAssocLevel(TCHAR *aInLevel, tagASSOCIATIONLEVEL* aOutLevel)
{
  if (lstrcmpi(aInLevel, LEVEL_MACHINE) == 0)
  {
    *aOutLevel = AL_MACHINE;
    return TRUE;
  }

  if (lstrcmpi(aInLevel, LEVEL_EFFECTIVE) == 0)
  {
    *aOutLevel = AL_EFFECTIVE;
    return TRUE;
  }

  if (lstrcmpi(aInLevel, LEVEL_USER) == 0)
  {
    *aOutLevel = AL_USER;
    return TRUE;
  }

  return FALSE;
}

extern "C"
void __declspec(dllexport) QueryCurrentDefault(HWND hWndParent, int string_size,
                                               TCHAR *variables, stack_t **stacktop,
                                               extra_parameters *extra)
{
  EXDLL_INIT();
  {
    TCHAR szAssoc[MAX_REG_KEY_NAME];
    TCHAR szAssocType[10];
    TCHAR szAssocLevel[10];

    if (popstring(szAssoc) == 0 && popstring(szAssocType) == 0 &&
        popstring(szAssocLevel) == 0)
    {
      IApplicationAssociationRegistration* pAAR;

      HRESULT hr = CoCreateInstance(CLSID_ApplicationAssociationReg,
                                    NULL,
                                    CLSCTX_INPROC,
                                    IID_IApplicationAssociationReg,
                                    (void**)&pAAR);

      if (SUCCEEDED(hr))
      {
        tagASSOCIATIONTYPE assocType;
        if (!GetAssocType(szAssocType, &assocType)) {
          pushstring(OUT_ERR_INVALID_PARAM);
          return;
        }

        tagASSOCIATIONLEVEL assocLevel;
        if (!GetAssocLevel(szAssocLevel, &assocLevel)) {
          pushstring(OUT_ERR_INVALID_PARAM);
          return;
        }

        WCHAR* ppszAssoc = NULL;

#ifdef _UNICODE
        hr = pAAR->QueryCurrentDefault(szAssoc, assocType, assocLevel, &ppszAssoc);
#else
        WCHAR wszAssoc[MAX_REG_KEY_NAME * 2];
        MultiByteToWideChar(CP_ACP, 0, szAssoc, lstrlen(szAssoc) + 1,
                            wszAssoc, sizeof(wszAssoc) / sizeof(wszAssoc[0]));

        hr = pAAR->QueryCurrentDefault(wszAssoc, assocType, assocLevel, &ppszAssoc);
#endif

        pAAR->Release();

        if (SUCCEEDED(hr) && ppszAssoc != NULL)
        {
        }

        if (SUCCEEDED(hr) && ppszAssoc != NULL)
        {
#ifdef _UNICODE
          pushstring(ppszAssoc);
          CoTaskMemFree(ppszAssoc);
          return;
#else
          TCHAR szResult[MAX_REG_KEY_NAME];
          int iRet = 0;
          iRet = WideCharToMultiByte(CP_ACP, 0, ppszAssoc, -1, szResult, 256, NULL, NULL);
          CoTaskMemFree(ppszAssoc);
          if (iRet > 0)
          {
            pushstring(szResult);
            return;
          }
#endif
        }

        pushstring(OUT_ERR_CALL_FAILED);
        return;
      }
    }

    pushstring(OUT_ERR_NOT_AVAILABLE);
  }
}

extern "C"
void __declspec(dllexport) QueryAppIsDefault(HWND hWndParent, int string_size, 
                                             TCHAR *variables, stack_t **stacktop,
                                             extra_parameters *extra)
{
  EXDLL_INIT();
  {
    TCHAR szAppRegName[MAX_REG_KEY_NAME];
    TCHAR szAssoc[MAX_REG_KEY_NAME];
    TCHAR szAssocType[10];
    TCHAR szAssocLevel[10];

    if (popstring(szAppRegName) == 0 && popstring(szAssoc) == 0 &&
        popstring(szAssocType) == 0 && popstring(szAssocLevel) == 0)
    {
      IApplicationAssociationRegistration* pAAR;

      HRESULT hr = CoCreateInstance(CLSID_ApplicationAssociationReg,
                                    NULL,
                                    CLSCTX_INPROC,
                                    IID_IApplicationAssociationReg,
                                    (void**)&pAAR);

      if (SUCCEEDED(hr))
      {
        tagASSOCIATIONTYPE assocType;
        if (!GetAssocType(szAssocType, &assocType))
        {
          pushstring(OUT_ERR_INVALID_PARAM);
          return;
        }

        tagASSOCIATIONLEVEL assocLevel;
        if (!GetAssocLevel(szAssocLevel, &assocLevel))
        {
          pushstring(OUT_ERR_INVALID_PARAM);
          return;
        }

        BOOL bIsDefault;

#ifdef _UNICODE
        hr = pAAR->QueryAppIsDefault(szAssoc, assocType, assocLevel, szAppRegName, &bIsDefault);
#else
        WCHAR wszAppRegName[MAX_REG_KEY_NAME * 2];
        MultiByteToWideChar(CP_ACP, 0, szAppRegName, lstrlen(szAppRegName) + 1,
                            wszAppRegName, sizeof(wszAppRegName) / sizeof(wszAppRegName[0]));

        WCHAR wszAssoc[MAX_REG_KEY_NAME * 2];
        MultiByteToWideChar(CP_ACP, 0, szAssoc, lstrlen(szAssoc) + 1,
                            wszAssoc, sizeof(wszAssoc) / sizeof(wszAssoc[0]));

        hr = pAAR->QueryAppIsDefault(wszAssoc, assocType, assocLevel, wszAppRegName, &bIsDefault);
#endif

        pAAR->Release();

        if (SUCCEEDED(hr))
        {
          TCHAR szResult[1];
          wsprintf(szResult, TEXT("%i"), bIsDefault);
          pushstring(szResult);
          return;
        }

        pushstring(OUT_ERR_CALL_FAILED);
        return;
      }
    }

    pushstring(OUT_ERR_NOT_AVAILABLE);
  }
}

extern "C"
void __declspec(dllexport) QueryAppIsDefaultAll(HWND hWndParent, int string_size, 
                                                TCHAR *variables, stack_t **stacktop,
                                                extra_parameters *extra)
{
  EXDLL_INIT();
  {
    TCHAR szAppRegName[MAX_REG_KEY_NAME];
    TCHAR szAssocLevel[10];

    if (popstring(szAppRegName) == 0 && popstring(szAssocLevel) == 0)
    {
      IApplicationAssociationRegistration* pAAR;

      HRESULT hr = CoCreateInstance(CLSID_ApplicationAssociationReg,
                                    NULL,
                                    CLSCTX_INPROC,
                                    IID_IApplicationAssociationReg,
                                    (void**)&pAAR);

      if (SUCCEEDED(hr))
      {
        tagASSOCIATIONLEVEL assocLevel;
        if (!GetAssocLevel(szAssocLevel, &assocLevel)) {
          pushstring(OUT_ERR_INVALID_PARAM);
          return;
        }

        BOOL bIsDefault;

#ifdef _UNICODE
        hr = pAAR->QueryAppIsDefaultAll(assocLevel, szAppRegName, &bIsDefault);
#else
        WCHAR wszAppRegName[MAX_REG_KEY_NAME * 2];
        MultiByteToWideChar(CP_ACP, 0, szAppRegName, lstrlen(szAppRegName) + 1,
                            wszAppRegName, sizeof(wszAppRegName) / sizeof(wszAppRegName[0]));

        hr = pAAR->QueryAppIsDefaultAll(assocLevel, wszAppRegName, &bIsDefault);
#endif

        pAAR->Release();

        if (SUCCEEDED(hr))
        {
          TCHAR szResult[1];
          wsprintf(szResult, TEXT("%i"), bIsDefault);
          pushstring(szResult);
          return;
        }

        pushstring(OUT_ERR_CALL_FAILED);
        return;
      }
    }

    pushstring(OUT_ERR_NOT_AVAILABLE);
  }
}

extern "C"
void __declspec(dllexport) SetAppAsDefault(HWND hWndParent, int string_size, 
                                           TCHAR *variables, stack_t **stacktop,
                                           extra_parameters *extra)
{
  EXDLL_INIT();
  {
    TCHAR szAppRegName[MAX_REG_KEY_NAME];
    TCHAR szSet[MAX_REG_KEY_NAME];
    TCHAR szAssocType[10];

    if (popstring(szAppRegName) == 0 && popstring(szSet) == 0 &&
        popstring(szAssocType) == 0)
    {
      IApplicationAssociationRegistration* pAAR;
  
      HRESULT hr = CoCreateInstance (CLSID_ApplicationAssociationReg,
                                     NULL, CLSCTX_INPROC,
                                     IID_IApplicationAssociationReg,
                                     (void**)&pAAR);

      if (SUCCEEDED(hr))
      {
        tagASSOCIATIONTYPE assocType;
        if (!GetAssocType(szAssocType, &assocType)) {
          pushstring(OUT_ERR_INVALID_PARAM);
          return;
        }


#ifdef _UNICODE
        hr = pAAR->SetAppAsDefault(szAppRegName, szSet, assocType);
#else
        WCHAR wszAppRegName[MAX_REG_KEY_NAME * 2];
        MultiByteToWideChar(CP_ACP, 0, szAppRegName, lstrlen(szAppRegName) + 1,
                            wszAppRegName, sizeof(wszAppRegName) / sizeof(wszAppRegName[0]));
        WCHAR wszSet[MAX_REG_KEY_NAME * 2];
        MultiByteToWideChar(CP_ACP, 0, szSet, lstrlen(szSet) + 1,
                            wszSet, sizeof(wszSet) / sizeof(wszSet[0]));

        hr = pAAR->SetAppAsDefault(wszAppRegName, wszSet, assocType);
#endif

        pAAR->Release();

        if (SUCCEEDED(hr))
        {
          pushstring(OUT_SUCCESS);
          return;
        }

        pushstring(OUT_ERR_CALL_FAILED);
        return;
      }
    }

    pushstring(OUT_ERR_NOT_AVAILABLE);
  }
}

extern "C"
void __declspec(dllexport) SetAppAsDefaultAll(HWND hWndParent, int string_size, 
                                              TCHAR *variables, stack_t **stacktop,
                                              extra_parameters *extra)
{
  EXDLL_INIT();
  {
    TCHAR szAppRegName[MAX_REG_KEY_NAME];

    // Attempt to get a parameter.
    if (popstring(szAppRegName) == 0)
    {
      IApplicationAssociationRegistration* pAAR;
  
      HRESULT hr = CoCreateInstance (CLSID_ApplicationAssociationReg,
                                     NULL, CLSCTX_INPROC,
                                     IID_IApplicationAssociationReg,
                                     (void**)&pAAR);

      if (SUCCEEDED(hr))
      {

#ifdef _UNICODE
        hr = pAAR->SetAppAsDefaultAll(szAppRegName);
#else
        WCHAR wszAppRegName[MAX_REG_KEY_NAME * 2];
        MultiByteToWideChar(CP_ACP, 0, szAppRegName, lstrlen(szAppRegName) + 1,
                            wszAppRegName, sizeof(wszAppRegName) / sizeof(wszAppRegName[0]));
        hr = pAAR->SetAppAsDefaultAll(wszAppRegName);
#endif

        pAAR->Release();

        if (SUCCEEDED(hr))
        {
          pushstring(OUT_SUCCESS);
          return;
        }

        pushstring(OUT_ERR_CALL_FAILED);
        return;
      }
    }

    pushstring(OUT_ERR_NOT_AVAILABLE);
  }
}

extern "C"
void __declspec(dllexport) ClearUserAssociations(HWND hWndParent, int string_size, 
                                                 TCHAR *variables, stack_t **stacktop,
                                                 extra_parameters *extra)
{
  EXDLL_INIT();
  {
    IApplicationAssociationRegistration* pAAR;
  
    HRESULT hr = CoCreateInstance (CLSID_ApplicationAssociationReg,
                                   NULL, CLSCTX_INPROC,
                                   IID_IApplicationAssociationReg,
                                   (void**)&pAAR);

    if (SUCCEEDED(hr))
    {
      hr = pAAR->ClearUserAssociations();
      pAAR->Release();

      if (SUCCEEDED(hr))
      {
        pushstring(OUT_SUCCESS);
        return;
      }

      pushstring(OUT_ERR_CALL_FAILED);
      return;
    }

    pushstring(OUT_ERR_NOT_AVAILABLE);
  }
}

BOOL WINAPI DllMain(HANDLE hInstNew,
                    ULONG ul_reason_for_call,
                    LPVOID lpReserved)
{
    return TRUE;
}

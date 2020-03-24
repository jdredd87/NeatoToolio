unit Android.JNI.PowerManager;

interface

function AcquireWakeLock: Boolean;
procedure ReleaseWakeLock;

implementation

uses
  System.SysUtils,
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.Os, // added in Berlin
  FMX.Helpers.Android;

//type
  // *** this is in Androidapi.JNI.Os
  // JPowerManager = interface;
  // JWakeLock = interface;

  // *** this is in Androidapi.JNI.Os
  // JWakeLockClass = interface(JObjectClass)
  // ['{918E171F-CDB8-4464-9507-F49272CE7636}']
  // end;

  // *** this is in Androidapi.JNI.Os
  // [JavaSignature('android/os/PowerManager$WakeLock')]
  // JWakeLock = interface(JObject)
  // ['{D17B1136-FA15-4AEB-85B1-2D490F0FD320}']
  // { Methods }
  // procedure acquire; cdecl;
  // procedure release; cdecl;
  // function isHeld: Boolean; cdecl;
  // end;
  // TJWakeLock = class(TJavaGenericImport<JWakeLockClass, JWakeLock>)
  // end;

  // *** this is in Androidapi.JNI.Os
  // JPowerManagerClass = interface(JObjectClass)
  // ['{7D0696A2-ADEA-4158-AE1F-5E720DEDBCF9}']
  // { Property methods }
  // function _GetFULL_WAKE_LOCK: Integer; cdecl;
  // function _GetSCREEN_BRIGHT_WAKE_LOCK: Integer; cdecl;
  // function _GetSCREEN_DIM_WAKE_LOCK: Integer; cdecl;
  // function _GetPARTIAL_WAKE_LOCK: Integer; cdecl;
  // { Properties }
  // // Keep screen on bright & keyboard on
  // // Deprecated in API level 17 - Jelly Bean MR1
  // property FULL_WAKE_LOCK: Integer read _GetFULL_WAKE_LOCK;
  // // Keep screen on bright
  // // Deprecated in API level 13 - Honeycomb MR2
  // property SCREEN_BRIGHT_WAKE_LOCK: Integer read _GetSCREEN_BRIGHT_WAKE_LOCK;
  // // Keep screen on dim
  // // Deprecated in API level 17 - Jelly Bean MR1
  // property SCREEN_DIM_WAKE_LOCK: Integer read _GetSCREEN_DIM_WAKE_LOCK;
  // // Keep CPU running, screen & keyboard can go off
  // property PARTIAL_WAKE_LOCK: Integer read _GetPARTIAL_WAKE_LOCK;
  // end;

  // *** this is in Androidapi.JNI.Os
  // [JavaSignature('android/os/PowerManager')]
  // JPowerManager = interface(JObject)
  // ['{DEAED658-4353-4D17-B0A3-8179E48BE87F}']
  // { Methods }
  // function newWakeLock(levelAndFlags: Integer; tag: JString): JWakeLock; cdecl;
  // end;
  // TJPowerManager = class(TJavaGenericImport<JPowerManagerClass, JPowerManager>)
  // end;

function GetPowerManager: JPowerManager;
var
  PowerServiceNative: JObject;
begin
  PowerServiceNative := TAndroidHelper.Context.getSystemService(TJContext.JavaClass.POWER_SERVICE);
  if not Assigned(PowerServiceNative) then
    raise Exception.Create('Could not locate Power Service');
  Result := TJPowerManager.Wrap((PowerServiceNative as ILocalObject).GetObjectID);
  if not Assigned(Result) then
    raise Exception.Create('Could not access Power Manager');
end;

var
  // *** this is in Androidapi.JNI.Os
  // WakeLock: JWakeLock = nil;
  WakeLock: JPowerManager_WakeLock = nil;

function AcquireWakeLock: Boolean;
var
  PowerManager: JPowerManager;
begin
  Result := Assigned(WakeLock);
  if not Result then
  begin
    PowerManager := GetPowerManager;
    WakeLock := PowerManager.newWakeLock(TJPowerManager.JavaClass.SCREEN_BRIGHT_WAKE_LOCK,
      StringToJString('Delphi'));
    Result := Assigned(WakeLock);
  end;
  if Result then
  begin
    if not WakeLock.isHeld then
    begin
      WakeLock.acquire;
      Result := WakeLock.isHeld
    end;
  end;
end;

procedure ReleaseWakeLock;
begin
  if Assigned(WakeLock) then
  begin
    WakeLock.release;
    WakeLock := nil
  end;
end;

end.

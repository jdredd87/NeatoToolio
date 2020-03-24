unit mobileIO;

interface

uses
  IdURI,

{$IFDEF WIN32}
  Winapi.ShellAPI, Winapi.Windows,
{$ENDIF WIN32}
{$IFDEF ANDROID}
  AndroidAPI.Helpers,
  FMX.Platform.Android,
  AndroidAPI.jni.app,
  FMX.Helpers.Android,
  AndroidAPI.jni.GraphicsContentViewText,
  AndroidAPI.jni.Net,
  AndroidAPI.jni.JavaTypes,

  AndroidAPI.jni.media,
  AndroidAPI.JNIBridge,
  AndroidAPI.jni,
  Androidapi.JNI.Provider,
  Androidapi.JNI.Os,
  {$ENDIF}
{$IFDEF IOS}
  iOSapi.Foundation,
  IOSapi.MediaPlayer,
  FMX.Helpers.iOS,
  Posix.Base,
  Posix.NetIf,
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.Helpers,
  iOSapi.UIKit,
  iOSapi.QuartzCore,
  iOSapi.CocoaTypes,
  iOSapi.Helpers,
  {$ENDIF IOS}
  System.IOUtils,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,
  System.NetEncoding,

  FMX.VirtualKeyboard,
  FMX.Consts,
  FMX.Surfaces,
  FMX.Platform,
  FMX.MediaLibrary,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Objects,
  FMX.ActnList,
  FMX.StdActns,
  System.ZLib;

{$IFDEF IOS}
Const
  libAudioToolbox        = '/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox';
  kSystemSoundID_vibrate = $FFF;

Procedure AudioServicesPlaySystemSound( inSystemSoundID: integer ); Cdecl; External libAudioToolbox Name _PU + 'AudioServicesPlaySystemSound';
{$ENDIF}

procedure StreamFromBase64(Base64: string; Bitmap: tmemorystream);
/// send a base64 image string, get back a memory stream
procedure CompressStream(inpStream, outStream: TStream);
/// compress a stream wit zlib
procedure DecompressStream(inpStream, outStream: TStream);
/// decompress a stream with zlib

procedure hideKeyboard;
//hide the virtual keyboard
procedure showKeyboard(obj: TFMXObject);
//show the virtual keyboard, pass it the input field
procedure vibrateDevice(millis: Integer);
//vibrates the device for a given number of milliseconds

function Base64JPGFromStream(Bitmap: tmemorystream): string;

function BooleanToString(b: Boolean): string;
/// boolean to string, True False
function StrToBool(Value: String; const Default: Boolean = false): Boolean;
/// convert a number of values into true/false boolean, can set a defalt if bad string passsed
function BoolStringToInteger(b: String): integer;
/// convert a number of values into 0 or 1 (false true)
function BoolToIntString(Value: Boolean): string;
/// convert a boolean into string value of 0 or 1 (false true)
function Base64FromStream(Bitmap: tmemorystream): string;
/// convert a tmemorystream into base64 string encoding
function Base64FromFile(fn: string): string;
/// supply a filename and convert its contents to base64 string encoding
function CreateThumbNail(Source: TBitmap): TBitmap;
/// create a thumbnail bitmap from bitmap source
function CreateWebImage(Source: TBitmap): TBitmap;
/// create a web image from bitmap source
function ResizeBitmap(b: TBitmap; Width, Height: integer): TBitmap;
/// resize/scall a bitmap

// Create A Scaled image cap
Function CreateScaledImage(Source: TBitmap; Width: integer): TBitmap;

function GetAppVersionStr: string;

function OpenURL(const URL: string; const DisplayError: Boolean = false): Boolean;
/// open a URL to device browswer (all platforms)
function IsAppInstalled(const AAppName: string): Boolean;
/// is app installed (used for only android currently)

{$IFDEF ANDROID}
//function Android_CameraHasFocus(ACameraReady: TACamera): Boolean;
// function Android_GetCameraFocusMode: TFocusMode;
//function Android_GetCameraFocusMode(ACamera: TACamera): TFocusMode;
{$ENDIF}
Procedure Form_Orientation_Set(const orientSet: TScreenOrientations);
{$IFDEF IOS}
procedure ChangeiOSorientation(toOrientation: UIInterfaceOrientation; possibleOrientations: TScreenOrientations);
{$ENDIF IOS}
{$IFDEF ANDROID}
function Android_isMuted: Boolean;
{$ENDIF}
{$IFDEF IOS}

const
  cWifiInterfaceName = 'awdl0'; // That's a small L (l), not a one (1)
function getifaddrs(var ifap: pifaddrs): integer; cdecl; external libc name _PU + 'getifaddrs';
procedure freeifaddrs(ifap: pifaddrs); cdecl; external libc name _PU + 'freeifaddrs';
{$ENDIF}

function GetDeviceID: String;

implementation

function IsAppInstalled(const AAppName: string): Boolean;
{$IFDEF IOS}
begin
  result := false;
end;
{$ENDIF IOS}
{$IFDEF Android}

var
  PackageManager: JPackageManager;
begin
  PackageManager := SharedActivity.getPackageManager;
  try
    PackageManager.getPackageInfo(StringToJString(AAppName), TJPackageManager.JavaClass.GET_ACTIVITIES);
    result := True;
  except
    on Ex: Exception do
      result := false;
  end;
end;
{$ENDIF}
{$IFDEF win32}
begin
  result := false;
end;
{$ENDIF}

procedure CompressStream(inpStream, outStream: TStream);
var
  LZip: TZCompressionStream;
begin
  LZip := TZCompressionStream.Create(outStream); // ,zcDefault);
  inpStream.Position := 0;
  LZip.CopyFrom(inpStream, inpStream.Size);
  LZip.DisposeOf;
end;

procedure DecompressStream(inpStream, outStream: TStream);
var
  LUnZip: TZDecompressionStream;
begin
  inpStream.Position := 0;
  LUnZip := TZDecompressionStream.Create(inpStream);
  outStream.CopyFrom(LUnZip, 0);
  LUnZip.Free;
end;

function BoolToIntString(Value: Boolean): string;
begin
  case Value of
    True:
      result := '1';
    false:
      result := '0';
  end;
end;

function ResizeBitmap(b: TBitmap; Width, Height: integer): TBitmap;
begin
  result := TBitmap.Create(Width, Height);
  result.Clear(0);
  if result.Canvas.BeginScene then
    try
      result.Canvas.DrawBitmap(b, RectF(0, 0, b.Width, b.Height), RectF(0, 0, Width, Height), 1);
    finally
      result.Canvas.EndScene;
    end;
end;

Function CreateThumbNail(Source: TBitmap): TBitmap;
var
  H, W: real;
begin
  W := Source.Height / Source.Width * 100;
  H := Source.Width / Source.Height * W;
  // Result := TBitmap.create;
  result := ResizeBitmap(Source, round(H), round(W));
end;

Function CreateWebImage(Source: TBitmap): TBitmap;
var
  H, W: real;
begin
  W := Source.Height / Source.Width * 800;
  H := Source.Width / Source.Height * W;
  // Result := TBitmap.create;
  result := ResizeBitmap(Source, round(H), round(W));
end;

Function CreateScaledImage(Source: TBitmap; Width: integer): TBitmap;
var
  H, W: real;
begin
  if Source.Width < Width then
  begin
    result := TBitmap.Create(Source.Width, Source.Height);
    result.Clear(0);
    if result.Canvas.BeginScene then
      try
        result.Canvas.DrawBitmap(Source, RectF(0, 0, Source.Width, Source.Height), RectF(0, 0, Source.Width, Source.Height), 1);
      finally
        result.Canvas.EndScene;
      end;
  end
  else
  begin
    W := Source.Height / Source.Width * Width;
    H := Source.Width / Source.Height * W;
    result := ResizeBitmap(Source, round(H), round(W));
  end;
end;

function StrToBool(Value: String; const Default: Boolean = false): Boolean;
begin
  result := false;
  Value := uppercase(trim(Value));
  if (Value = '') then
  begin
    result := default;
    Exit;
  end
  else if (Value[1] = 'Y') or (Value[1] = '1') then
  begin
    result := True;
    Exit;
  end
  else if (Value[1]) = 'N' then
  begin
    result := false;
    Exit;
  end
  else if (Value = 'TRUE') then
  begin
    result := True;
    Exit
  end
  else if (Value = 'FALSE') then
  begin
    result := false;
    Exit;
  end
  else if (Value = '0') then
  begin
    result := false;
    Exit
  end
  else if (Value = '1') then
  begin
    result := True;
    Exit;
  end;

  try
    result := System.SysUtils.StrToBool(Value);
    // this is useless as ts on a bull
  except
    on e: EConvertError do
    begin
      result := Default;
    end;
  end;
end;

function BoolStringToInteger(b: String): integer;
begin
  b := uppercase(b);
  b := trim(b);
  if b = 'T' then
    result := 1
  else if b = 'TRUE' then
    result := 1
  else if b = 'F' then
    result := 0
  else if b = 'FALSE' then
    result := 0;
end;

function BooleanToString(b: Boolean): string;
begin
  if b then
    result := 'True'
  else
    result := 'False';
end;

function Base64FromFile(fn: string): string;
var
  Input: tmemorystream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
  try
    Input := tmemorystream.Create;
    Input.LoadFromFile(fn);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      Encoding := TBase64Encoding.Create(0);
      try
        Encoding.Encode(Input, Output);
        result := Output.DataString;
      finally
        Encoding.Free;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

function Base64JPGFromStream(Bitmap: tmemorystream): string;
var
  Stream: tmemorystream;
  Surf: TBitmapSurface;
  aBitmap: TBitmap;
  Params: TBitmapCodecSaveParams;
begin
  // Comparison save file as BMP
  Stream := tmemorystream.Create;
  aBitmap := TBitmap.CreateFromStream(Bitmap);
  try
    Stream.Position := 0;
    Surf := TBitmapSurface.Create;
    try
      Surf.Assign(aBitmap);
      Params.Quality := 75;
      // use the codec to save Surface to stream
      if not TBitmapCodecManager.SaveToStream(Stream, Surf, '.jpg', @Params) then
        raise EBitmapSavingFailed.Create('Error saving Bitmap to jpg');
    finally
      Surf.Free;
    end;
    Stream.Position := 0;
    result := Base64FromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function Base64FromStream(Bitmap: tmemorystream): string;
var
  Input: TBytesStream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
  Input := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      Encoding := TBase64Encoding.Create(0);
      try
        Encoding.Encode(Input, Output);
        result := Output.DataString;
      finally
        Encoding.Free;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

procedure StreamFromBase64(Base64: string; Bitmap: tmemorystream);
var
  Input: TStringStream;
  Output: TBytesStream;
  Encoding: TBase64Encoding;
begin
  Input := TStringStream.Create(Base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      Encoding := TBase64Encoding.Create(0);
      try
        Encoding.Decode(Input, Output);
        Output.Position := 0;
        Bitmap.LoadFromStream(Output);
      finally
        Encoding.Free;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

function OpenURL(const URL: string; const DisplayError: Boolean = false): Boolean;
{$IFDEF ANDROID}
var
  Intent: JIntent;
begin
  // There may be an issue with the geo: prefix and URLEncode.
  // will need to research
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW, TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(URL))));
  try
    SharedActivity.startActivity(Intent);
    Exit(True);
  except
    on e: Exception do
    begin
      if DisplayError then
        ShowMessage('Error: ' + e.Message);
      Exit(false);
    end;
  end;
end;
{$ENDIF ANDROID}
{$IFDEF IOS}

var
  app: UIApplication;
  NSU: NSurl;
begin
  app := TUIApplication.Wrap(TUIApplication.OCClass.sharedApplication);
  NSU := TNSURL.Wrap(TNSURL.OCClass.URLWithString(StrToNSStr(URL)));
  if app.canopenURL(NSU) then
    // Check if there is a default App that can open the URL
    app.OpenURL(NSU)
  else
    ShowMessage('Can not open URL');
end;
{
  var
  NSU: NSUrl;
  begin
  // iOS doesn't like spaces, so URL encode is important.
  // NSU := StrToNSUrl(TIdURI.URLEncode(URL));
  if SharedApplication.canOpenURL(NSU) then
  Exit(SharedApplication.OpenURL(NSU))
  else
  begin
  if DisplayError then
  ShowMessage('Error: Opening "' + URL + '" not supported.');
  Exit(false);
  end;
  end;
}

{$ENDIF IOS}
{$IFDEF WIN32}
begin
  Winapi.ShellAPI.ShellExecute(0, 'OPEN', PChar(URL), '', '', SW_SHOWNORMAL);
end;
{$ENDIF WIN32}
{$IFDEF ios}

function StrToNSStringPtr(const AValue: string): Pointer;
begin
  result := (StrToNSStr(AValue) as ILocalObject).GetObjectID;
end;

function IsWifiEnabled: Boolean;
var
  LAddrList, LAddrInfo: pifaddrs;
  LSet: NSCountedSet;
begin
  result := false;
  if getifaddrs(LAddrList) = 0 then
    try
      LSet := TNSCountedSet.Create;
      LAddrInfo := LAddrList;
      repeat
        if (LAddrInfo.ifa_flags and IFF_UP) = IFF_UP then
          LSet.addObject(TNSString.OCClass.stringWithUTF8String(LAddrInfo.ifa_name));
        LAddrInfo := LAddrInfo^.ifa_next;
      until LAddrInfo = nil;
      result := LSet.countForObject(StrToNSStringPtr(cWifiInterfaceName)) > 1;
    finally
      freeifaddrs(LAddrList);
    end;
end;
{$ENDIF}
{$IFDEF ANDROID}

Function GetAppVersionStr: String;
begin
  //
end;

{
function Android_CameraHasFocus(ACameraReady: TACamera): Boolean;
var
  ACamera: TACamera;
  FocusMode: Winsoft.Android.Camera.TFocusMode;
begin
  result := false;
  if assigned(ACameraReady) then
  begin
    for FocusMode in ACameraReady.SupportedFocusModes do
      if (FocusMode = foContinuousPicture) OR (FocusMode = foAuto) then
        result := True;
  end
  else
  begin
    ACamera := TACamera.Create(nil);
    ACamera.Start;
    for FocusMode in ACamera.SupportedFocusModes do
      if (FocusMode = foContinuousPicture) OR (FocusMode = foAuto) then
        result := True;
    ACamera.Stop;
    ACamera.active := false;
    ACamera.DisposeOf;
    ACamera := nil;
  end;
end;

function Android_GetCameraFocusMode(ACamera: TACamera): TFocusMode;
var
  FocusMode: Winsoft.Android.Camera.TFocusMode;
begin
  result := foAuto;
  // ACamera := TACamera.Create(nil);
  // ACamera.Start;
  for FocusMode in ACamera.SupportedFocusModes do
    if (FocusMode = foContinuousPicture) then
      result := foContinuousPicture;
  // ACamera.Stop;
  // ACamera.active := false;
  // ACamera.DisposeOf;
  // Acamera := nil;
end;
}

{$ENDIF}
{$IFDEF IOS}

Function GetAppVersionStr: String;
Var
  NSB: NSBundle;
  NSDic: NSDictionary;
  NS: NSString;
Begin
  NSB := TNSBundle.Wrap(TNSBundle.OCClass.MainBundle);
  NSDic := NSB.InfoDictionary;
  NS := TNSString.Wrap(NSDic.ValueForKey(NSStr('CFBundleVersion')));
  result := NS.UTF8String;
  NS := Nil;
  NSB := Nil;
End;
{$ENDIF}
{$IFDEF WIN32}

function GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  result := Format('%d.%d.%d.%d', [LongRec(FixedPtr.dwFileVersionMS).Hi,
    // major
    LongRec(FixedPtr.dwFileVersionMS).Lo, // minor
    LongRec(FixedPtr.dwFileVersionLS).Hi, // release
    LongRec(FixedPtr.dwFileVersionLS).Lo]) // build
end;
{$ENDIF}

Procedure Update_FormFactor(FormFactor: TFormFactor; const orientSet: TScreenOrientations);
Begin
  FormFactor.Orientations := orientSet;
end;

Procedure Form_Orientation_Set(const orientSet: TScreenOrientations);
Var
  ScreenService: IFMXScreenService;
Begin
{$IFDEF IOS}
  Update_FormFactor(Application.FormFactor, orientSet);
{$ELSE IOS}
  If TPlatformServices.Current.SupportsPlatformService(IFMXScreenService) then
  Begin
    ScreenService := TPlatformServices.Current.GetPlatformService(IFMXScreenService) as IFMXScreenService;
    ScreenService.SetScreenOrientation(orientSet);
  end;
{$ENDIF IOS}
end;

{$IFDEF IOS}

procedure ChangeiOSorientation(toOrientation: UIInterfaceOrientation; possibleOrientations: TScreenOrientations);
var
  win: UIWindow;
  app: UIApplication;
  viewController: UIViewController;
  oucon: UIViewController;
begin
  Application.FormFactor.Orientations := []; // Change supported orientations
  app := TUIApplication.Wrap(TUIApplication.OCClass.sharedApplication);
  win := TUIWindow.Wrap(app.Windows.objectAtIndex(0)); // The first Windows is always the main Window

  app.setStatusBarOrientation(toOrientation);
  { After you have changed your statusbar orientation set the
    Supported orientation/orientations to whatever you need }
  Application.FormFactor.Orientations := possibleOrientations;
  viewController := TUIViewController.Wrap(TUIViewController.alloc.init); // dummy ViewController
  oucon := TUIViewController.Wrap(TUIViewController.alloc.init);
  { Now we are creating a new Viewcontroller now when it is created
    it will have to check what is the supported orientations }
  oucon := win.rootViewController; // we store all our current content to the new ViewController
  win.setRootViewController(viewController);
  win.makeKeyAndVisible; // We display the Dummy viewcontroller

  win.setRootViewController(oucon);
  win.makeKeyAndVisible;
  { And now we Display our original Content in a new Viewcontroller
    with our new Supported orientations }
end;
{$ENDIF IOS}
{$IFDEF ANDROID}

function Android_isMuted: Boolean;
var
  AudioService: JObject;
  AudioManager: JAudioManager;
  RingerMode: integer;
begin
  result := false;
  AudioService := TAndroidHelper.Activity.getSystemService(TJContext.JavaClass.AUDIO_SERVICE);
  if AudioService <> nil then
    AudioManager := TJAudioManager.Wrap((AudioService as ILocalObject).GetObjectID);
  if AudioManager <> nil then
    result := AudioManager.getRingerMode <> 2; // RINGER_MODE_NORMAL
end;
{$ENDIF}

function GetDeviceID: String;
{$IFDEF ANDROID}
 var
    LName: JString;
  begin
    LName := TJSettings_Secure.JavaClass.ANDROID_ID;
    Result := JStringToString(TJSettings_Secure.JavaClass.getString
      (TAndroidHelper.ContentResolver, LName));
  end;
{$endif}
{$IFDEF IOS}
 begin
  Result := NSStrToStr(TiOSHelper.CurrentDevice.identifierForVendor.UUIDString);
 end;
{$endif}
{$IFDEF WIN32}
  begin
   result := GetEnvironmentVariable('COMPUTERNAME');
  end;
{$endif}

procedure hideKeyboard;
var
  FService: IFMXVirtualKeyboardService;
begin
{$IFNDEF WIN32}
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
  begin
    FService.HideVirtualKeyboard;
  end;
{$ENDIF}
end;

procedure showKeyboard(obj: TFMXObject);
var
  FService: IFMXVirtualKeyboardService;
begin
{$IFNDEF WIN32}
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
    begin
      FService.ShowVirtualKeyboard(obj);
    end;
{$ENDIF}
end;

procedure vibrateDevice(millis: Integer);
{$IFDEF ANDROID}
Var
  Vibrator:JVibrator;
{$ENDIF}
begin
{$IFDEF ANDROID}
  Vibrator:=TJVibrator.Wrap((SharedActivityContext.getSystemService(TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID);
  Vibrator.vibrate(millis);
{$ENDIF}
{$IFDEF IOS}
  AudioServicesPlaySystemSound( kSystemSoundID_vibrate );
{$ENDIF}
end;

end.

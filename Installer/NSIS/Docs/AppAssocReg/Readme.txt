~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~ SetVistaDefaultApp.dll  v0.3 (5.0 KB)
~ Written by Robert Strong

~ NSIS C++ plugin to read / set application association registration
~ for Windows Vista and greater.

~   Last build: 10th September 2008, Microsoft Visual C++ 6


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plugin Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Details on function parameters:

app_name
The value for app_name is the name for the application under
HKLM\Software\RegisteredApplications

assoc_name
The value for assoc_name can be one of the following:
1. For type equals protocol it should be the protocol name
   (e.g. http, mms, etc.).
2. For type equals file it should be the file extension
   (e.g. .html, .txt, etc.)
3. For type equals startmenu it should be the registry subkey name
   under the HKLM\Software\clients subkey (e.g. StartMenuInternet,
   mail, etc.)
4. For type equals mime it should be the MIME type name
   (e.g. audio/mp3, text/html, etc.)

type
Possible values for type map to ASSOCIATIONTYPE as follows
file      = AT_FILEEXTENSION
protocol  = AT_URLPROTOCOL
startMenu = AT_STARTMENUCLIENT
mime      = AT_MIMETYPE

level
Possible values for level map to ASSOCIATIONLEVEL as follows
machine   = AL_MACHINE
effective = AL_EFFECTIVE
user      = AL_USER


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 AppAssocReg::QueryCurrentDefault assoc_name type level
 Pop $Var

  Determines the default application for a given association type.
  This is the default application launched by ShellExecute for that
  type.

  Returns:
  'ProgID' that identifies the current default association. 
  'method failed' if the call failed.
  'method not available' if IApplicationAssociationRegistration is
                         not available on the system.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 AppAssocReg::QueryAppIsDefault app_name assoc_name type level
 Pop $Var

  Determines whether an application owns the registered default
  assocation for a given application level and type.

  Returns:
  '1' if the application is the default.
  '0' if the application is NOT the default.
  'method failed' if the call failed.
  'method not available' if IApplicationAssociationRegistration is
                         not available on the system.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 AppAssocReg::QueryAppIsDefaultAll app_name level
 Pop $Var

  Determines whether an application owns all of the registered
  default associations for a given application level.

  Returns:
  '1' if the application is the default.
  '0' if the application is NOT the default.
  'method failed' if the call failed.
  'method not available' if IApplicationAssociationRegistration is
                         not available on the system.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 AppAssocReg::SetAppAsDefault app_name assoc_name type
 Pop $Var

  Sets an application as the default for a given type.

  Returns:
  'success' if the call was successful.
  'method failed' if the call failed.
  'method not available' if IApplicationAssociationRegistration is
                         not available on the system.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 AppAssocReg::SetAppAsDefaultAll app_name
 Pop $Var

  Sets an application as the default for all of the registered
  associations of any type for that application.

  Returns:
  'success' if the call was successful.
  'method failed' if the call failed.
  'method not available' if IApplicationAssociationRegistration is
                         not available on the system.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 AppAssocReg::ClearUserAssociations
 Pop $Var

  Removes all per-user associations for the current user. This
  results in a reversion to machine defaults, if they exist.

  Returns:
  'success' if the call was successful.
  'method failed' if the call failed.
  'method not available' if IApplicationAssociationRegistration is
                         not available on the system.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Examples
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 See Examples\AppAssocReg\Example.nsi


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Change Log
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
v0.4
* Added Unicode support (initial patch by Ehsan Akhgari).

v0.3
* Renamed plugin from SetVistaDefaultApp to AppAssocReg.
* Added all IApplicationAssociationRegistration methods available.

v0.2
* Minor cleanup.

v0.1
* First release.

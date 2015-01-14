:: creates ..\eidmw_revision and eidmw_revision.h

@SET BASE_VERSION1=4
@SET BASE_VERSION2=1
@SET BASE_VERSION3=0

@FOR /F "tokens=1" %%i in ('"C:\Program Files (x86)\Git\bin\git.exe" rev-list --count HEAD') do @SET EIDMW_REVISION=%%i
::"C:\Program Files (x86)\Git\bin\git.exe" describe

@IF NOT DEFINED EIDMW_REVISION GOTO writedummy
@IF "%EIDMW_REVISION%"=="" GOTO writedummy
@IF EIDMW_REVISION==exported GOTO writedummy

:writesvn_revision
@echo %EIDMW_REVISION%>"%~dp0\eidmw_revision"
@echo [INFO] \eidmw_revision set to %EIDMW_REVISION%
@GOTO write_eidmw_revision_h

:writedummy
@IF EXIST "%~dp0\eidmw_revision" GOTO set_eidmw_revision
@echo 000>"%~dp0\eidmw_revision"
@echo [INFO] \eidmw_revision set to 000

:set_eidmw_revision
@FOR /F "tokens=1" %%i in (%~dp0..\eidmw_revision) do @SET EIDMW_REVISION=%%i

:write_eidmw_revision_h
:: create eidmw_revision.h file
@echo #ifndef __EIDMW_REVISION_H__                 >  "%~dp0\eidmw_revision.h"
@echo #define __EIDMW_REVISION_H__                 >> "%~dp0\eidmw_revision.h"
@echo #define EIDMW_REVISION %EIDMW_REVISION%        >> "%~dp0\eidmw_revision.h"
@echo #define EIDMW_REVISION_STR "%EIDMW_REVISION%"  >> "%~dp0\eidmw_revision.h"
@echo #endif //__EIDMW_REVISION_H__                >> "%~dp0\eidmw_revision.h"

:write_eidmw_revision_wix
@echo ^<Include^> > "%~dp0\eidmw_revision.wxs"
@echo ^<?define RevisionNumber=%EIDMW_REVISION%?^> >>"%~dp0\eidmw_revision.wxs"
@echo ^</Include^> >>"%~dp0\eidmw_revision.wxs"

:write_eidmw_version.nsh
@echo !define EIDMW_VERSION ^"%BASE_VERSION1%.%BASE_VERSION2%.%BASE_VERSION3%.%EIDMW_REVISION%^" > "%~dp0\eidmw_version.nsh"
@echo !define EIDMW_VERSION_SHORT ^"%BASE_VERSION1%.%BASE_VERSION2%.%BASE_VERSION3%^" >> "%~dp0\eidmw_version.nsh"

:write_beidversions.h
@echo #ifndef __BEID_VERSION_H__ > "%~dp0\beidversions.h"
@echo #define __BEID_VERSION_H__ >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo /**                                                                         >> "%~dp0\beidversions.h"																					
@echo  * Versions for the Windows binaries                                        >> "%~dp0\beidversions.h"
@echo  */                                                                         >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo #include "./eidmw_revision.h"                                               >> "%~dp0\beidversions.h"
@echo // To specified in the .rc files                                            >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo #define BEID_COMPANY_NAME    	"Belgian Government"                          >> "%~dp0\beidversions.h"
@echo #define BEID_COPYRIGHT    	"Copyright (C) 2015"                          >> "%~dp0\beidversions.h"
@echo #define BEID_PRODUCT_NAME    	"Belgium eID MiddleWare"                      >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo #define BEID_PRODUCT_VERSION    "%BASE_VERSION1%.%BASE_VERSION2%.%BASE_VERSION3%" >> "%~dp0\beidversions.h"
@echo #define BASE_VERSION_STRING    "%BASE_VERSION1%, %BASE_VERSION2%, %BASE_VERSION3%, " >> "%~dp0\beidversions.h"
@echo #define BASE_VERSION1          %BASE_VERSION1%                              >> "%~dp0\beidversions.h"
@echo #define BASE_VERSION2          %BASE_VERSION2%                              >> "%~dp0\beidversions.h"
@echo #define BASE_VERSION3          %BASE_VERSION3%                              >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // Common Lib                                                               >> "%~dp0\beidversions.h"
@echo #define WIN_CL_VERSION_STRING    BASE_VERSION_STRING EIDMW_REVISION_STR     >> "%~dp0\beidversions.h"
@echo #define WIN_CL_VERSION1          BASE_VERSION1                              >> "%~dp0\beidversions.h"
@echo #define WIN_CL_VERSION2          BASE_VERSION2                              >> "%~dp0\beidversions.h"
@echo #define WIN_CL_VERSION3          BASE_VERSION3                              >> "%~dp0\beidversions.h"
@echo #define WIN_CL_VERSION4          EIDMW_REVISION                             >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // Card Abstraction                                                         >> "%~dp0\beidversions.h"
@echo #define WIN_CAL_VERSION_STRING   BASE_VERSION_STRING EIDMW_REVISION_STR     >> "%~dp0\beidversions.h"
@echo #define WIN_CAL_VERSION1         BASE_VERSION1                              >> "%~dp0\beidversions.h"
@echo #define WIN_CAL_VERSION2         BASE_VERSION2                              >> "%~dp0\beidversions.h"
@echo #define WIN_CAL_VERSION3         BASE_VERSION3                              >> "%~dp0\beidversions.h"
@echo #define WIN_CAL_VERSION4         EIDMW_REVISION                             >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // Dialogs                                                                  >> "%~dp0\beidversions.h"
@echo #define WIN_DLG_VERSION_STRING   BASE_VERSION_STRING EIDMW_REVISION_STR     >> "%~dp0\beidversions.h"
@echo #define WIN_DLG_VERSION1         BASE_VERSION1                              >> "%~dp0\beidversions.h"
@echo #define WIN_DLG_VERSION2         BASE_VERSION2                              >> "%~dp0\beidversions.h"
@echo #define WIN_DLG_VERSION3         BASE_VERSION3                              >> "%~dp0\beidversions.h"
@echo #define WIN_DLG_VERSION4         EIDMW_REVISION                             >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // CSP                                                                      >> "%~dp0\beidversions.h"
@echo #define WIN_CSP_VERSION_STRING    BASE_VERSION_STRING EIDMW_REVISION_STR    >> "%~dp0\beidversions.h"
@echo #define WIN_CSP_VERSION1          BASE_VERSION1                             >> "%~dp0\beidversions.h"
@echo #define WIN_CSP_VERSION2          BASE_VERSION2                             >> "%~dp0\beidversions.h"
@echo #define WIN_CSP_VERSION3          BASE_VERSION3                             >> "%~dp0\beidversions.h"
@echo #define WIN_CSP_VERSION4          EIDMW_REVISION                            >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // MDRV                                                                     >> "%~dp0\beidversions.h"
@echo #define WIN_MDRV_VERSION_STRING    BASE_VERSION_STRING EIDMW_REVISION_STR   >> "%~dp0\beidversions.h"
@echo #define WIN_MDRV_VERSION1          BASE_VERSION1                            >> "%~dp0\beidversions.h"
@echo #define WIN_MDRV_VERSION2          BASE_VERSION2                            >> "%~dp0\beidversions.h"
@echo #define WIN_MDRV_VERSION3          BASE_VERSION3                            >> "%~dp0\beidversions.h"
@echo #define WIN_MDRV_VERSION4          EIDMW_REVISION                           >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // cardplugin BEID                                                          >> "%~dp0\beidversions.h"
@echo #define WIN_CPBEID_VERSION_STRING    BASE_VERSION_STRING EIDMW_REVISION_STR >> "%~dp0\beidversions.h"
@echo #define WIN_CPBEID_VERSION1          BASE_VERSION1                          >> "%~dp0\beidversions.h"
@echo #define WIN_CPBEID_VERSION2          BASE_VERSION2                          >> "%~dp0\beidversions.h"
@echo #define WIN_CPBEID_VERSION3          BASE_VERSION3                          >> "%~dp0\beidversions.h"
@echo #define WIN_CPBEID_VERSION4          EIDMW_REVISION                         >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // PKCS11                                                                   >> "%~dp0\beidversions.h"
@echo #define WIN_PKCS11_VERSION_STRING    BASE_VERSION_STRING EIDMW_REVISION_STR >> "%~dp0\beidversions.h"
@echo #define WIN_PKCS11_VERSION1          BASE_VERSION1                          >> "%~dp0\beidversions.h"
@echo #define WIN_PKCS11_VERSION2          BASE_VERSION2                          >> "%~dp0\beidversions.h"
@echo #define WIN_PKCS11_VERSION3          BASE_VERSION3                          >> "%~dp0\beidversions.h"
@echo #define WIN_PKCS11_VERSION4          EIDMW_REVISION                         >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // CLEANUPTOOL                                                              >> "%~dp0\beidversions.h"
@echo #define WIN_CLEAN_VERSION_STRING    BASE_VERSION_STRING EIDMW_REVISION_STR  >> "%~dp0\beidversions.h"
@echo #define WIN_CLEAN_VERSION1          BASE_VERSION1                           >> "%~dp0\beidversions.h"
@echo #define WIN_CLEAN_VERSION2          BASE_VERSION2                           >> "%~dp0\beidversions.h"
@echo #define WIN_CLEAN_VERSION3          BASE_VERSION3                           >> "%~dp0\beidversions.h"
@echo #define WIN_CLEAN_VERSION4          EIDMW_REVISION                          >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo // SCCERTPROP                                                               >> "%~dp0\beidversions.h"
@echo #define WIN_SCCERT_VERSION_STRING    BASE_VERSION_STRING EIDMW_REVISION_STR >> "%~dp0\beidversions.h"
@echo #define WIN_SCCERT_VERSION1          BASE_VERSION1                          >> "%~dp0\beidversions.h"
@echo #define WIN_SCCERT_VERSION2          BASE_VERSION2                          >> "%~dp0\beidversions.h"
@echo #define WIN_SCCERT_VERSION3          BASE_VERSION3                          >> "%~dp0\beidversions.h"
@echo #define WIN_SCCERT_VERSION4          EIDMW_REVISION                         >> "%~dp0\beidversions.h"
@echo: >> "%~dp0\beidversions.h"
@echo #endif //__BEID_VERSION_H__                                                 >> "%~dp0\beidversions.h"
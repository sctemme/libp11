#define OPENSSL_STATIC if you have visual studio compatible with OpenSSL's static binaries
#OPENSSL_STATIC_DIR = static

!IF "$(DEBUG)" != ""
DEBUG_SUFFIX = d
DEBUG_COMPILE = /DDEBUG /Zi /Od
DEBUG_LINK = /DEBUG
!ENDIF

!IF "$(BUILD_FOR)" == "WIN64"
MACHINE = /MACHINE:X64
!IF "$(OPENSSL_DIR)" == ""
OPENSSL_DIR = C:\OpenSSL-Win64
!ENDIF
!ELSE
MACHINE = /MACHINE:X86
!IF "$(OPENSSL_DIR)" == ""
OPENSSL_DIR = C:\OpenSSL-Win32
!ENDIF
!ENDIF

!IF "$(OPENSSL_INC)" == ""
OPENSSL_INC = /I$(OPENSSL_DIR)\include
!ENDIF

!IF "$(OPENSSL_STATIC_DIR)" == ""
OPENSSL_LIB = $(OPENSSL_DIR)\lib\libeay32.lib
!ELSE
OPENSSL_LIB = $(OPENSSL_DIR)\lib\VC\static\libeay32MT$(DEBUG_SUFFIX).lib
!ENDIF

LIBS = $(OPENSSL_LIB) user32.lib advapi32.lib crypt32.lib gdi32.lib

CFLAGS =  /nologo /GS /W3 /D_CRT_SECURE_NO_DEPRECATE /MT$(DEBUG_SUFFIX) $(OPENSSL_INC) /D_WIN32_WINNT=0x0502 /DWIN32_LEAN_AND_MEAN $(DEBUG_COMPILE)

LINKFLAGS = /NOLOGO /INCREMENTAL:NO $(MACHINE) /MANIFEST:NO /NXCOMPAT /DYNAMICBASE $(DEBUG_LINK)

LIBFLAGS =  /NOLOGO $(MACHINE)


include windows.inc ;libraries and files we need to include for our program.
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc

includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib

;Functions and paramaters used that we have declared.
DlgProc			PROTO	:HWND,:UINT,:WPARAM,:LPARAM
Generate  		PROTO 	:DWORD


;constants, here dialogue compononets
.const
IDD_DIALOG1			equ 101
IDC_SERIAL			equ 1001 ;id of second edit box
IDC_NAME			equ 1002 ;id of first edit box
IDC_OK				equ 1003 ;id of ok button
IDC_EXT				equ 1004 ;id of exit button
OUR_ICON			equ 102 ;id of our icon
;data we initialized
.data
fmat        		db "%s",0 ;formatting style, here is %s string.
;#########################################################################

;variables
.data?
newText				dd ? ;declare a 4-byte uninitialized value, referred to as location newText. DD stands for Define double word.
hInstance			dd ? ;declare a 4-byte uninitialized value, referred to as location hInstance.
text				dd ? ;declare a 4-byte uninitialized value, referred to as location text.
;#########################################################################

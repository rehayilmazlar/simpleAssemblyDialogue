.386 ;80386 processor instruction for 32-bit MASM
.model flat, stdcall  ;32 bit memory model
option casemap :none  ;case sensitive

include TestDialogue.inc ;includes our include file which has all necessary libraries for our program to run.

.code ;code section starts

start: ;our program starts here

	invoke GetModuleHandle,NULL ;get a handle for our program
	mov hInstance,eax

    	invoke InitCommonControls
	invoke DialogBoxParam,hInstance,IDD_DIALOG1,NULL,addr DlgProc,NULL ;show the dialogue
	invoke ExitProcess,0

;########################################################################
;This is where our dialogue window is created.
DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	mov eax,uMsg
	.if eax==WM_INITDIALOG
		invoke	 LoadIcon, hInstance, OUR_ICON ;load icon into program
		invoke	 SendMessage, hWin, WM_SETICON, ICON_BIG, eax ;Also add the icon to the dialogue
	.elseif eax==WM_COMMAND
		mov eax, wParam
		.if eax==1003 ;if button with id 1003 is clicked, invoke generate proc
			invoke Generate,hWin
		.elseif eax==1004 ;else if button with id 1004 is clicked, end the dialouge
			invoke EndDialog,hWin,0
		.endif
	.elseif eax==WM_CLOSE ;if close button is clicked, end the dialogue
		invoke EndDialog,hWin,0
	.else
		mov eax,FALSE
		ret
	.endif
	mov eax,TRUE
	ret

DlgProc endp

;This is where our generate function runs.
Generate PROC	USES ebx ecx edx esi edi, hWin:DWORD
	invoke GetDlgItemText,hWin,1002,addr text, 255 ;get text out of component with id 1002 and write it into text variable
	mov ecx, eax ;after GetDlgItemText eax holds the length, here we copy the length to ecx
	lea eax, text ;assign address of text variable to eax
	xor ebx,ebx ; set ebx=0
	xor edx, edx; set edx=0
@loop:
	movzx ebx, byte ptr ds:[eax + edx] ;move the first bye that eax holds to ebx
	add ebx,1h ;add 1h to ebx, that way if our letter was a it turns into b
	mov [eax+edx], bl ; move the new letter and overwrite the old letter. (note that here we use the same memory location so e.g. if we write "test" it will overwrite "uftu" on itself one by one)
	inc edx ; edx=edx+1 so we move to the next char in the string
	loop @loop ;loop until ecx=0(it goes back to @loop)


	invoke wsprintf,addr newText, addr fmat, eax ;format what eax holds according to fmat and write it into newText. Where fmat is defined as %s, so it formats it into a string.
	
	invoke SetDlgItemText,hWin, 1001, addr newText ; set edit box with id 1001 to newText (newText holds our new converted text)
	ret

Generate endp ;end of generate function


end start ;end of program start

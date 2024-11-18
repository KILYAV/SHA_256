.data
;string db 01h,02h,03h,04h,05h,06h,07h,08h,09h,10h
;	db 11h,12h,13h,14h,15h,16h,17h,18h,19h,20h
;	db 21h,22h,23h,24h,25h,26h,27h,28h,29h,30h
;	db 31h,32h,33h,34h,35h,36h,37h,38h,39h,40h
;	db 41h,42h,43h,44h,45h,46h,47h,48h,49h,50h
;	db 51h,52h,53h,54h,55h,56h;,57h,58h,59h,60h
;	db 61h,62h,63h,64h,65h,66h,67h,68h,69h,70h

string db "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123"

count db 0

.code
Debug proc
	sub rsp,40h
	mov rcx,rsp
	lea rdx,[string]
	mov r8,count - string
	
	call Bin
Debug endp
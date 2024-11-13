include Bin.asm

.code
Debug proc
	sub rsp,40h
	
	mov rcx,rsp
	lea rdx,messang
	mov r8,count - messang
	call Bin
	ret
Debug endp

.const
messang db 01h;,02h,03h,04h,05h,06h,07h,08h,09h,10h
;	db 11h,12h,13h,14h,15h,16h,17h,18h,19h,20h
;	db 21h,22h,23h,24h,25h,26h,27h,28h,29h,30h
;	db 31h,32h,33h,34h,35h,36h,37h,38h,39h,40h
;	db 41h,42h,43h,44h,45h,46h,47h,48h,49h,50h
;	db 51h,52h,53h,54h,55h;,56h;,57h;,58h,59h,60h
;	db 61h,62h,63h;,64h;,65h
	
;messang db "hello world"
count dq 0ffffffffffffffffh

.const
const dd 0428a2f98h, 071374491h, 0b5c0fbcfh, 0e9b5dba5h
	dd 03956c25bh, 059f111f1h, 0923f82a4h, 0ab1c5ed5h
	dd 0d807aa98h, 012835b01h, 0243185beh, 0550c7dc3h
	dd 072be5d74h, 080deb1feh, 09bdc06a7h, 0c19bf174h

end
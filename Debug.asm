.const
align xmmword
;messang	db 01h,02h,03h,04h,05h,06h,07h,08h
;	db 09h,10h,11h,12h,13h,14h,15h,16h
;	db 17h,18h,19h,20h,21h,22h,23h,24h
;	db 25h,26h,27h,28h,29h,30h,31h,32h
;	db 33h,34h,35h,36h,37h,38h,39h,40h
;	db 41h,42h,43h,44h,45h,46h,47h,48h
;	db 49h,50h,51h,52h,53h,54h,55h;,56h
;	db 57h,58h,59h,60h,61h,62h,63h,64h;,65h

;align xmmword
messang db "hello world"
count dq 0ffffffffffffffffh

.code
Debug proc
;	mov r15,00h
;@@:	lea rsi,[messang]
;	mov rdx,r15
;	lea rcx,[rdx * 8]
;	call LoadData
;	add r15,1h
;jmp	@b

	sub rsp,40h
	
	mov rcx,rsp
	lea rdx,messang
	mov r8,count - messang
	call Hex
	ret
Debug endp
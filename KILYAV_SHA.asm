;.const
;messang db "hello world"

;messang db 01h;,02h,03h,04h,05h,06h,07h,08h,09h,10h
	;db 11h,12h,13h,14h,15h,16h,17h,18h,19h,20h
	;db 21h,22h,23h,24h,25h,26h,27h,28h,29h,30h
	;db 31h,32h,33h,34h,35h,36h,37h,38h,39h,40h
	;db 41h,42h,43h,44h,45h,46h,47h,48h,49h,50h
	;db 51h,52h,53h,54h,55h;,56h,57h,58h,59h,60h
	;db 61h,62h,63h;,64h;,65h,66h,67h,68h,69h,70h

;count dq 0ffffffffffffffffh

.code
;Start proc
;	sub rsp,40h
;	
;	mov rcx,rsp
;	lea rdx,messang
;	mov r8,count - messang
;	call Hex
;	ret
;Start endp

?ImplHex@SHA256@KILYAV@@CA?AV?$array@D$0EA@@std@@PEBDI@Z proc
?ImplHex@SHA256@KILYAV@@CA?AV?$array@D$0EA@@std@@PEBDI@Z endp

align xmmword
Hex:
	call Bin
	mov rcx,rax
	
	mov rax,303009090707h
	movd xmm5,rax
	punpcklwd xmm5,xmm5
	pshufd xmm3,xmm5,0
	pshufd xmm4,xmm5,01010101b
	pshufd xmm5,xmm5,10101010b
	movd rax,xmm0
	movd rdx,xmm1
	
	pxor xmm2,xmm2
	punpckhbw xmm1,xmm2
	call SplitLine
		movdqu [rcx + 30h],xmm1
		
	movd xmm1,rdx
	punpcklbw xmm1,xmm2
	call SplitLine
		movdqu [rcx + 20h],xmm1
		
	movdqa xmm1,xmm0
	punpckhbw xmm1,xmm2
	call SplitLine
		movdqu [rcx + 10h],xmm1
	
	movd xmm1,rax
	punpcklbw xmm1,xmm2
	call SplitLine
		movdqu [rcx + 00h],xmm1
		
	mov rax,rcx
	ret
	
	align xmmword
	SplitLine:
		movdqa xmm2,xmm1
		psrlw xmm1,4
		psllw xmm2,12
		psrlw xmm2,4
		por xmm1,xmm2
		
		movdqa xmm2,xmm1
		pcmpgtb xmm2,xmm4
		pand xmm2,xmm3
		paddd xmm1,xmm2
		paddd xmm1,xmm5
		
		pxor xmm2,xmm2
		ret

align xmmword
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z proc
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z endp
	
Bin:
	mov rax,rsp
	sub rsp,8
	btr rsp,3
	mov [rsp],rax
	
	mov r9,rbp
	mov r10,rsi
	mov r11,rdi
	
	mov rdi,rcx
	mov rcx,r8
	lea rbp,[r8 * 8]
	ror rbp,20h
	mov rsi,rdx
	
	sub rsp,60h
		
	movdqa [rsp + 00h],xmm6
	movdqa [rsp + 10h],xmm7
	movdqa [rsp + 20h],xmm8
	movdqa [rsp + 30h],xmm9
	movdqa [rsp + 40h],xmm10
	
	mov rax,0bb67ae856a09e667h
	movd xmm0,rax
	mov rax,0a54ff53a3c6ef372h
	movd xmm1,rax
	punpcklqdq xmm0,xmm1
	mov rax,09b05688c510e527fh
	movd xmm1,rax
	mov rax,05be0cd191f83d9abh
	movd xmm2,rax
	punpcklqdq xmm1,xmm2
	
	movdqa xmm8,xmm0
	movdqa xmm9,xmm1

	cmp rcx,38h
		jge LoadDataOrDataPlug
	cmp rcx,0
		jg LoadDataPlugSize
		jle LoadPlugSizeOrSize

	Return:
	; 01
		mov rax,071374491428a2f98h
		mov rdx,0e9b5dba5b5c0fbcfh
		call HeadRound
	; 02
		mov rax,059f111f13956c25bh
		mov rdx,0ab1c5ed5923f82a4h
		call HeadRound
	; 03
		mov rax,012835b01d807aa98h
		mov rdx,0550c7dc3243185beh
		call HeadRound
	; 04
		mov rax,080deb1fe72be5d74h
		mov rdx,0c19bf1749bdc06a7h
		call HeadRound		
	; 05
		mov rax,0efbe4786e49b69c1h
		mov rdx,0240ca1cc0fc19dc6h
		call HeadRound
	; 06
		mov rax,04a7484aa2de92c6fh
		mov rdx,076f988da5cb0a9dch
		call HeadRound
	; 07
		mov rax,0a831c66d983e5152h
		mov rdx,0bf597fc7b00327c8h
		call HeadRound
	; 08
		mov rax,0d5a79147c6e00bf3h
		mov rdx,01429296706ca6351h
		call HeadRound
	; 09
		mov rax,02e1b213827b70a85h
		mov rdx,053380d134d2c6dfch
		call HeadRound
	; 10
		mov rax,0766a0abb650a7354h
		mov rdx,092722c8581c2c92eh
		call HeadRound
	; 11
		mov rax,0a81a664ba2bfe8a1h
		mov rdx,0c76c51a3c24b8b70h
		call HeadRound
	; 12
		mov rax,0d6990624d192e819h
		mov rdx,0106aa070f40e3585h
		call HeadRound

	; 01
		mov rax,01e376c0819a4c116h
		mov rdx,034b0bcb52748774ch
		call TailRound
	; 02
		mov rax,04ed8aa4a391c0cb3h
		mov rdx,0682e6ff35b9cca4fh
		movdqa xmm2,xmm3
		call TailRound
	; 03
		mov rax,078a5636f748f82eeh
		mov rdx,08cc7020884c87814h
		movdqa xmm2,xmm4
		call TailRound
	; 04
		mov rax,0a4506ceb90befffah
		mov rdx,0c67178f2bef9a3f7h
		movdqa xmm2,xmm5
		call TailRound

	paddd xmm0,xmm8
	paddd xmm1,xmm9
	
	call StoreHesh
	mov rax,rdi
	
	movdqa xmm6,[rsp + 00h]
	movdqa xmm7,[rsp + 10h]
	movdqa xmm8,[rsp + 20h]
	movdqa xmm9,[rsp + 30h]
	movdqa xmm10,[rsp + 40h]
	
	mov rsp,[rsp + 60h + qword * 0]
	mov rbx,r8
	mov rbp,r9
	mov rsi,r10
	mov rdi,r11
	ret
	
	align xmmword
	LoadDataOrDataPlug:
		call LoadLine
		movdqa xmm2,xmm7
		call LoadLine
		movdqa xmm3,xmm7
		call LoadLine
		movdqa xmm4,xmm7
		call LoadLine
		movdqa xmm5,xmm7
		
			sub rcx,40h
		jge Return
		
			mov rax,[rsi - 8]
			shl rcx,3
			shrd rdx,rax,cl
			xor eax,eax
			mov al,80h
			shld rax,rdx,cl
			shr rcx,3
			bswap rax
			ror rax,20h
			movd xmm6,rax
			punpcklqdq xmm5,xmm6
		jmp Return
		
	align xmmword
	LoadLine:
		movdqu xmm7,[rsi]
		movdqa xmm6,xmm7
		psllw xmm7,8
		psrlw xmm6,8
		por xmm7,xmm6
		pshufhw xmm7,xmm7,10110001b
		pshuflw xmm7,xmm7,10110001b
		add rsi,10h
		ret

	align xmmword
	LoadDataPlugSize:
		mov rax,[rsi + rcx - 8]
		shl rcx,3
		mov edx,80h
		shld rdx,rax,cl
		shr rcx,3
		
		call Quarter
		movd xmm2,rax
		call Quarter
		movd xmm6,rax
		shufpd xmm2,xmm6,0
		call Quarter
		movd xmm3,rax
		call Quarter
		movd xmm6,rax
		shufpd xmm3,xmm6,0
		call Quarter
		movd xmm4,rax
		call Quarter
		movd xmm6,rax
		shufpd xmm4,xmm6,0
		call Quarter
		movd xmm5,rax
		
		sub rcx,8
		movd xmm6,rbp
		punpcklqdq xmm5,xmm6
		jmp Return
		
	align xmmword
	Quarter:
		xor eax,eax
		cmp rcx,0
		cmovle rdx,rax
		mov rax,rdx
		sub rcx,8
		cmovge rax,[rsi]
		bswap rax
		ror rax,20h
		add rsi,8
		ret

	align xmmword
	LoadPlugSizeOrSize:
		pxor xmm2,xmm2
		pxor xmm3,xmm3
		pxor xmm4,xmm4
		pxor xmm5,xmm5
		
		mov eax,80h
		shr eax,cl
		movd xmm2,eax
		
		movd xmm6,rbp
		punpcklqdq xmm5,xmm6
			
		sub rcx,40h
		jmp Return

	align xmmword
	HeadRound:
		movd xmm10,rax
		movd xmm7,rdx
		punpcklqdq xmm10,xmm7
		paddd xmm10,xmm2
		
		call Decompres4
		call Compres1
		call Compres1
		call Compres1
		call Compres1
		ret
		
	align xmmword
	TailRound:
		movd xmm10,rax
		movd xmm7,rdx
		punpcklqdq xmm10,xmm7
		paddd xmm10,xmm2
		
		call Compres1
		call Compres1
		call Compres1
		call Compres1
		ret	
	
	align xmmword
	Decompres4:
		call HalfLine
		psrldq xmm7,8
		movd rax,xmm7
		
		movd rdx,xmm2
		movss xmm2,xmm3
		pshufd xmm2,xmm2,00111001b
		
		movdqa xmm6,xmm2
		movdqa xmm7,xmm2
		psrld xmm6,00 + 7
		pslld xmm7,32 - 7
		pxor xmm6,xmm7
		
		movdqa xmm7,xmm2
		psrld xmm7,00 + 18
		pxor xmm6,xmm7
		
		movdqa xmm7,xmm2
		pslld xmm7,32 - 18
		pxor xmm7,xmm6
		
		movdqa xmm6,xmm2
		psrld xmm6,00 + 3
		pxor xmm7,xmm6
		
		movd xmm6,rdx
		shufps xmm6,xmm2,10010100b
		paddd xmm7,xmm6
		
		movdqa xmm2,xmm3
		movdqa xmm3,xmm4
		movss xmm4,xmm5
		pshufd xmm4,xmm4,00111001b
		paddd xmm7,xmm4
		
		movdqa xmm4,xmm5
		movd xmm5,rax
		paddd xmm5,xmm7
		
		call HalfLine
		pslldq xmm7,8
		paddd xmm5,xmm7
		ret
	
	align xmmword
	HalfLine:
		movdqa xmm6,xmm5
		movdqa xmm7,xmm5
		psrld xmm6,00 + 17
		pslld xmm7,32 - 17
		pxor xmm6,xmm7
					
		movdqa xmm7,xmm5
		psrld xmm7,00 + 19
		pxor xmm6,xmm7
								
		movdqa xmm7,xmm5
		pslld xmm7,32 - 19
		pxor xmm6,xmm7
			
		movdqa xmm7,xmm5	
		psrld xmm7,00 + 10
		pxor xmm7,xmm6
		ret

	align xmmword
	Compres1:
	; s1
		movd eax,xmm1
		ror eax,6
		mov edx,eax
		ror eax,5
		xor edx,eax
		ror eax,14
		xor eax,edx		; s1	
	; ch
		pshufd xmm7,xmm1,11100110b	; g
		movdqa xmm6,xmm1			; e
		pandn xmm6,xmm7
		pshufd xmm7,xmm1,11100101b	; f
		pand xmm7,xmm1
		pxor xmm7,xmm6	; ch
	; temp_1
		pshufd xmm1,xmm1,10010011b	; h
		paddd xmm7,xmm1				; h + ch
		paddd xmm7,xmm10			; h + ch + k + w
		movss xmm1,xmm7
		movd xmm7,eax				; s1
		paddd xmm1,xmm7				; temp_1
	; maj
		pshufd xmm6,xmm0,11100101b
		pshufd xmm7,xmm0,11100110b
			
		pand xmm6,xmm7
		pand xmm7,xmm0
		pxor xmm6,xmm7
			
		pshufd xmm7,xmm0,11100101b
		pand xmm7,xmm0
		pxor xmm7,xmm6
	; s0
		movd eax,xmm0
		ror eax,2
		mov edx,eax
		ror eax,11
		xor edx,eax
		ror eax,9
		xor eax,edx
	; temp_2 = s0 + maj
		movd xmm6,eax
		paddd xmm7,xmm6
	;
		pshufd xmm0,xmm0,10010011b
		movss xmm6,xmm0
		movss xmm0,xmm1
		paddd xmm1,xmm6
		movss xmm6,xmm7
		paddd xmm0,xmm6
			
		psrldq xmm10,4
		ret
	
	align xmmword
	StoreHesh:
		movdqa xmm6,xmm0
		call SwapLine
		movdqa xmm0,xmm7
		movdqu [rdi + 00h],xmm0
		
		movdqa xmm6,xmm1
		call SwapLine
		movdqa xmm1,xmm7
		movdqu [rdi + 10h],xmm1
		ret
		
		align xmmword
		SwapLine:
			movdqa xmm7,xmm6
			psllw xmm7,8
			psrlw xmm6,8
			por xmm7,xmm6
			pshufhw xmm7,xmm7,10110001b
			pshuflw xmm7,xmm7,10110001b
			ret
end
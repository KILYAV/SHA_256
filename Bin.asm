.code
align xmmword
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z proc
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z endp

Bin:
	lea r9,[const]
	mov r10,rcx
	mov r11,rdx

	lea rcx,[r8 * 8]
	mov rdx,r8

	mov rax,0bb67ae856a09e667h
	movd mm0,rax
	mov rax,03c6ef372a54ff53ah ; 0a54ff53a3c6ef372h
	movd mm1,rax
	mov rax,09b05688c510e527fh
	movd mm2,rax
	mov rax,01f83d9ab5be0cd19h ; 05be0cd191f83d9abh
	movd mm3,rax
	
align xmmword
Block:
	movd qword ptr[r10 + 00h],mm0
	movd qword ptr[r10 + 08h],mm1
	movd qword ptr[r10 + 10h],mm2
	movd qword ptr[r10 + 18h],mm3
		
	call Load
	
	mov eax,18h
	align xmmword
	@@:	call Head
		dec eax
	jnz	@b
		
	mov eax,08h
	align xmmword
	@@: movdq2q mm7,xmm0
		paddd mm7,qword ptr[r9]
		paddd mm7,mm3
		
		shufps xmm0,xmm1,01001110b
		shufps xmm1,xmm2,01001110b
		shufps xmm2,xmm3,01001110b
		psrldq xmm3,8
			
		call Tail
		dec eax
	jnz	@b
	
	paddd mm0,qword ptr[r10 + 00h]
	paddd mm1,qword ptr[r10 + 08h]
	paddd mm2,qword ptr[r10 + 10h]
	paddd mm3,qword ptr[r10 + 18h]
		
	cmp rdx,-8
jge	Block
	
	movq2dq xmm1,mm0
	movq2dq xmm2,mm1
	call Store
	movdqa xmm0,xmm1
	movq2dq xmm1,mm2
	movq2dq xmm2,mm3
	call Store
	
	movdqu [r10 + 00h],xmm0
	movdqu [r10 + 10h],xmm1
	
	mov rax,r10
ret
	
Store:
	pshuflw xmm1,xmm1,10110001b
	pshuflw xmm2,xmm2,00011011b
	punpcklqdq xmm1,xmm2

	movdqa xmm2,xmm1
	psllw xmm1,8
	psrlw xmm2,8
	por xmm1,xmm2	
ret
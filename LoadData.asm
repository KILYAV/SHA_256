.code
align xmmword
LoadData:
	pxor xmm1,xmm1
	pxor xmm2,xmm2

	cmp rdx,0
jle	LoadPlugData

	mov eax,40h
	cmp edx,40h
jge	LoadDataLine
	
	and edx,038h
	mov rax,[rsi + rdx]
	mov r8,80h
	ror rax,cl
	shld r8,rax,cl
	
	xor rax,rax
	btr edx,3
	cmovc rax,r8
	cmovc r8,[rsi + rdx]
	
	bswap rax
	bswap r8
	movd xmm0,r8
	movd xmm4,rax
	shufps xmm0,xmm4,00010001b
	sub rdx,40h
	add rdx,rax
	
	cmp eax,0
jg	jg_LoadDataLine

align xmmword
rg_LoadDataLine:	
	pshufd xmm4,xmm3,11101110b
	movd rax,xmm4
	cmp rdx,-8
	cmovle rax,rcx
	movd xmm4,rax
	shufps xmm3,xmm4,00010100b
ret

align xmmword
jg_LoadDataLine:
	call LoadDataLine
jmp rg_LoadDataLine

align xmmword
LoadDataLine:
	movdqa xmm0,xmm1
	movdqa xmm1,xmm2
	movdqa xmm2,xmm3
	
	movdqu xmm3,xmmword ptr[rsi]
	movdqa xmm4,xmm3
	psllw xmm3,8
	psrlw xmm4,8
	por xmm3,xmm4
	pshufhw xmm3,xmm3,10110001b
	pshuflw xmm3,xmm3,10110001b
	
	add rsi,10h
	sub rdx,10h
	sub eax,10h
jnz	LoadDataLine
ret

align xmmword
LoadPlugData:
	setz al
	movzx eax,al
	shl eax,7
	movd xmm0,eax
	movd xmm3,rcx
	pshufd xmm3,xmm3,00011110b
ret
.code
align xmmword
Load:
	cmp rdx,0
jle	LoadPlugData

	mov eax,40h
	cmp rdx,10h
jge	LoadDataLine

ret_LoadDataLine:
	movd xmm5,eax
	mov rax,[r11]
	bt edx,3
	cmovc rax,[r11 + 8]
	mov r8,80h
	ror rax,cl
	shld r8,rax,cl
	
	xor rax,rax
	bt edx,3
	cmovc rax,r8
	cmovc r8,[r11]
	
	bswap rax
	bswap r8
	movd xmm3,r8
	movd xmm4,rax
	shufps xmm3,xmm4,00010001b
	
	movd eax,xmm5
	sub rdx,10h
	sub eax,10h
	
	cmp eax,0
jg	LoadZeroLine
	
ret_LoadZeroLine:
	pshufd xmm4,xmm3,10111011b
	movd rax,xmm4
	cmp rdx,-9
	cmovle rax,rcx
	movd xmm4,rax
	shufps xmm3,xmm4,00010100b
ret

align xmmword
@@:	pxor xmm3,xmm3
	sub rdx,10h
	sub eax,10h
jle	ret_LoadZeroLine

align xmmword
LoadZeroLine:
	movdqa xmm0,xmm1
	movdqa xmm1,xmm2
	movdqa xmm2,xmm3
	cmp rdx,0
jl	@b
	cmp rdx,10h
jl	ret_LoadDataLine
	
align xmmword
LoadDataLine:
	movdqu xmm3,xmmword ptr[r11]
	movdqa xmm4,xmm3
	psllw xmm3,8
	psrlw xmm4,8
	por xmm3,xmm4
	pshufhw xmm3,xmm3,10110001b
	pshuflw xmm3,xmm3,10110001b
	
	add r11,10h
	sub rdx,10h
	sub eax,10h
	cmp eax,0
jg	LoadZeroLine
	ret

align xmmword
LoadPlugData:
	setz al
	movzx eax,al
	shl eax,31
	movd xmm0,eax
	
	pxor xmm1,xmm1
	pxor xmm2,xmm2

	movd xmm3,rcx
	pshufd xmm3,xmm3,00011110b
	sub rdx,40h
ret
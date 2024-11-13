.code
LoadData:
	pxor xmm1,xmm1
	pxor xmm2,xmm2

	cmp rcx,0
jle	LoadPlugData

	mov eax,40h
	cmp rax,rcx
	cmovg eax,ecx
	cmp eax,40h
je	LoadDataLine
	
	and eax,038h
	mov r8,[r11 + rax]
	mov r9,80h
	shl ecx,3
	ror r8,cl
	shld r9,r8,cl
	shr ecx,3
	
	xor r8,r8
	btr eax,3
	cmovc r8,r9
	cmovc r9,[r11 + rax]
	
	bswap r8
	bswap r9
	ror r8,20h
	ror r9,20h
	movd xmm0,r9
	movd xmm4,r8
	unpcklpd xmm0,xmm4
	sub rcx,10h
	
	cmp eax,0
jg	jg_LoadDataLine

rg_LoadDataLine:	
	pshufd xmm4,xmm3,11101110b
	movd rax,xmm4
	cmp rcx,-8
	cmovle rax,rdx
	movd xmm4,rax
	shufps xmm3,xmm4,00010100b
ret

align xmmword
jg_LoadDataLine:
	call LoadDataLine
jmp rg_LoadDataLine

align xmmword
LoadDataLine:
	movdqa xmm3,xmm2
	movdqa xmm2,xmm1
	movdqa xmm1,xmm0
	
	movdqu xmm4,xmmword ptr[r11]
	movdqa xmm5,xmm4
	psllw xmm4,8
	psrlw xmm5,8
	por xmm4,xmm5
	pshufhw xmm4,xmm4,10110001b
	pshuflw xmm0,xmm4,10110001b	
	add r11,10h
	sub rcx,10h
	sub eax,10h
jnz	LoadDataLine
ret

align xmmword
LoadPlugData:
	setz al
	movzx eax,al
	shl eax,7
	movd xmm0,eax
	movd xmm3,rdx
	pshufd xmm3,xmm3,00011110b
ret
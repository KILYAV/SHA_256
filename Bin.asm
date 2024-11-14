.code
align xmmword
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z proc
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z endp
	
Bin:
	mov r9, rbp
	mov r10,rsi
	mov r11,rdi
	
	lea rbp,[const]
	mov rsi,rdx
	mov rdi,rcx
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
	
	movd qword ptr[rdi + 00h],mm0
	movd qword ptr[rdi + 08h],mm1
	movd qword ptr[rdi + 10h],mm2
	movd qword ptr[rdi + 18h],mm3
	
	call LoadData
	align xmmword
	@@:	mov eax,30h
		call CompHeadHesh
		add rbp,10h
		dec eax
	jnz	@b
	
	align xmmword
	@@: mov eax,10h
		call CompTailHesh
		
		shufps xmm0,xmm1,01001110b
		shufps xmm1,xmm2,01001110b
		shufps xmm2,xmm3,01001110b
		
		add rbp,10h
		dec eax
	jnz	@b
	
	paddd mm0,qword ptr[rdi + 00h]
	paddd mm1,qword ptr[rdi + 08h]
	paddd mm2,qword ptr[rdi + 10h]
	paddd mm3,qword ptr[rdi + 18h]
	
	
	include LoadData.asm
	include CompHeadHesh.asm
	include CompTailHesh.asm
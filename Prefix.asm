.code
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
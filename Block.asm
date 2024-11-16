align xmmword
Block:
	movd qword ptr[r10 + 00h],mm0
	movd qword ptr[r10 + 08h],mm1
	movd qword ptr[r10 + 10h],mm2
	movd qword ptr[r10 + 18h],mm3
		
	call LoadData
	mov eax,18h
	align xmmword
	@@:	call HeadHesh
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
			
		call TailHesh
		dec eax
	jnz	@b
	
	paddd mm0,qword ptr[r10 + 00h]
	paddd mm1,qword ptr[r10 + 08h]
	paddd mm2,qword ptr[r10 + 10h]
	paddd mm3,qword ptr[r10 + 18h]
		
	cmp rdx,-8
jge	Block

	movq2dq xmm0,mm0
	movq2dq xmm1,mm1
	shufps xmm0,xmm1,00010100b
	
	movq2dq xmm1,mm2
	movq2dq xmm2,mm3
	shufps xmm1,xmm2,00010100b
	
	movdqu [r10 + 00h],xmm0
	movdqu [r10 + 10h],xmm1
ret

	
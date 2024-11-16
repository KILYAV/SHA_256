.code
align xmmword
HeadHesh:
; s0
	pshufd xmm4,xmm0,10100101b
	movdqa xmm5,xmm4
	psrld xmm5,3
	psrlq xmm4,7
	pxor xmm5,xmm4
	psrlq xmm4,11
	pxor xmm5,xmm4
; s0 + w[0]
	pshufd xmm5,xmm5,10001000b
	paddd xmm5,xmm0
; s0 + w[0] + w[9]
	pshufd xmm4,xmm2,10011001b
	paddd xmm5,xmm4
; w[i] + k[i] + h
	movdq2q mm7,xmm0
	paddd mm7,qword ptr[r9]
	paddd mm7,mm3
	shufps xmm0,xmm1,01001110b
	shufps xmm1,xmm2,01001110b
	shufps xmm2,xmm3,01001110b
	shufps xmm3,xmm5,01001110b
; s1
	pshufd xmm4,xmm3,01010000b
	movdqa xmm5,xmm4
	psrld xmm5,10
	psrlq xmm4,17
	pxor xmm5,xmm4
	psrlq xmm4,2
	pxor xmm5,xmm4
	pshufd xmm5,xmm5,10001000b
; s1 + s0 + w[0] + w[9]
	pslldq xmm5,8
	paddd xmm3,xmm5
	
.code
Hex:
	call Bin
	
	mov rdx,303007070909h
	movd xmm5,rdx
	punpcklbw xmm5,xmm5
	
	call HexDuoLine
	movdqu [rax + 30h],xmm2
	movdqa xmm2,xmm1
	call HexLine
	movdqu [rax + 20h],xmm2
	
	movdqa xmm1,xmm0
	call HexDuoLine
	movdqu [rax + 10h],xmm2
	movdqa xmm2,xmm1
	call HexLine
	movdqu [rax + 00h],xmm2
ret
	
align xmmword
HexDuoLine:
	movdqa xmm2,xmm1
	pxor xmm3,xmm3
	punpckhbw xmm2,xmm3
	punpcklbw xmm1,xmm3
	
align xmmword
HexLine:
	movdqa xmm3,xmm2
	psrlw xmm2,4
	psllw xmm3,12
	psrlw xmm3,4
	por xmm2,xmm3
	
	movdqa xmm3,xmm2
	pshufd xmm4,xmm5,0
	pcmpgtb xmm3,xmm4
	
	pshufd xmm4,xmm5,01010101b
	pand xmm3,xmm4
	paddb xmm2,xmm3
	
	pshufd xmm4,xmm5,10101010b
	paddb xmm2,xmm4
ret
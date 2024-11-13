.code
align xmmword
CompHesh:
; s1
	pshufw mm4,mm2,01000100b
	psrlq mm4,6
	pshufw mm5,mm4,11100100b
	psrlq mm4,5
	pxor mm5,mm4
	psrlq mm4,14
	pxor mm4,mm5
; ch
	punpckhdq mm3,mm2
	pshufw mm5,mm2,11101110b
	pand mm5,mm2
	pshufw mm6,mm2,01000100b
	pandn mm6,mm3
	pxor mm5,mm6
; t1
	paddd mm5,mm7
	paddd mm4,mm5
; d + t1
	psllq mm4,20h
	punpckldq mm2,mm1
	paddd mm2,mm4
	pshufw mm2,mm2,01001110b
; s0
	pshufw mm5,mm0,01000100b
	psrlq mm5,2
	pshufw mm6,mm5,11100100b
	psrlq mm5,11
	pxor mm6,mm5
	psrlq mm5,9
	pxor mm5,mm6	
; t1 + s0
	punpckhdq mm1,mm0
	punpckldq mm0,mm5
	paddd mm0,mm4
; maj
	pshufw mm4,mm0,01000100b
	pand mm4,mm1
	pshufw mm5,mm4,11101110b
	pxor mm4,mm5
	pshufw mm5,mm1,01001110b
	pand mm5,mm1
	pxor mm4,mm5 	; maj
; t1 + t2
	psllq mm4,20h
	paddd mm0,mm4	
	pshufw mm0,mm0,01001110b
ret

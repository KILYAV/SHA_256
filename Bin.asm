.code
align xmmword
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z proc
?ImplBin@SHA256@KILYAV@@CA?AV?$array@E$0CA@@std@@PEBDI@Z endp
	
Bin:
	include Prefix.asm
	include Block.asm
ret

include Const.asm
include LoadData.asm
include HeadHesh.asm
include TailHesh.asm
	
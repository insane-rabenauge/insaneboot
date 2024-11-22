  ifnd	inc_get_cookie
inc_get_cookie=1
	text

get_cookie:	;enter with d0=cookie; returns with d0=1 if found and d1=cookie value, else d0=0 and d1=0
	ifd	__mcoldfire__
	move.l	a0,-(sp)
	move.l	d7,-(sp)
	else
	movem.l	a0/d7,-(sp)
	endif
	move.l	ptr_cookiejar,d1
	beq.s	.notfound
	move.l	d1,a0

	moveq.l	#127,d7
.search:
	tst.l	(a0)
	beq.s	.notfound

	cmp.l	(a0),d0
	beq.s	.found
	addq.l	#8,a0
	m_dbra	d7,.search
.notfound:
	moveq	#0,d1
	ifd	__mcoldfire__
	move.l	(sp)+,d7
	move.l	(sp)+,a0
	else
	movem.l	(sp)+,a0/d7
	endif
	moveq	#0,d0
	rts
.found:	
	move.l	4(a0),d1
	ifd	__mcoldfire__
	move.l	(sp)+,d7
	move.l	(sp)+,a0
	else
	movem.l	(sp)+,a0/d7
	endif
	moveq	#1,d0
	rts
  endc

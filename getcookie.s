  ifnd	inc_get_cookie
inc_get_cookie=1
	text

get_cookie:	;enter with d0=cookie; returns with d0=1 if found and d1=cookie value, else d0=0 and d1=0
	movem.l	a0/d7,-(sp)
	move.l	ptr_cookiejar,d1
	beq.s	.notfound
	move.l	d1,a0

	moveq	#127,d7
.search:
	tst.l	(a0)
	beq.s	.notfound

	cmp.l	(a0),d0
	beq.s	.found
	addq.l	#8,a0
	dbra	d7,.search
.notfound:
	moveq	#0,d1
	movem.l	(sp)+,a0/d7
	moveq	#0,d0
	rts
.found:	
	move.l	4(a0),d1
	movem.l	(sp)+,a0/d7
	moveq	#1,d0
	rts
  endc

	section	code
domenu
		bsr	getoshz200
		move.l	d0,d5
		moveq	#0,d4
		move.b	v_timeout,d4
		beq	.notimeout
		mulu.w	#200,d4
		bra	.waitmenu
.notimeout
		move.w	#0,do_timeout

.waitmenu
		tst.w	do_timeout
		beq	.skiptimeout
		bsr	getoshz200
		move.l	d0,d6
		sub.l	d5,d6
		cmp.l	d4,d6
		bcc	.endmenu
		move.l	d4,d7
		sub.l	d6,d7
		divu.w	#200,d7
	ifd	__mcoldfire__
		or.l	#$30,d7
	else
		or.w	#$30,d7
	endif
		cmp.w	#$39,d7
		blt	.skipmod
		move.w	#$39,d7
.skipmod	move.b	d7,cur_time+1
		tos_cconws cur_time
		
.skiptimeout
		tos_cconis
		tst.w	d0
		beq	.waitmenu
		move.w	#0,do_timeout
		tos_crawcin
		cmp.w	#" ",d0
		beq	.endmenu
		cmp.w	#13,d0
		beq	.endmenu
		cmp.w	#27,d0
		beq	.abortmenu
		swap	d0
		cmp.w	#$48,d0	;up
		beq	.doup
		cmp.w	#$50,d0 ;dn
		beq	.dodn
		cmp.w	#$4d,d0 ;right
		beq	.endmenu
		cmp.w	#$62,d0
		beq	.dohelp
		move.w	#$3b,d1
		cmp.w	d1,d0
		blo	.waitmenu
	ifd	__mcoldfire__
		m_mvzw	menucnt,d5
		add.l	d5,d1
	else
		add.w	menucnt,d1
	endif
		cmp.w	d1,d0
		bhs	.waitmenu
	ifd	__mcoldfire__
		sub.l	#$3a,d0
	else
		sub.w	#$3a,d0
	endif
		move.w	d0,forcemenupos
.endmenu	bsr	savemenupos
		tos_cconws cur_clr
		tos_cconws v_selectch
		rts
.abortmenu	move.w	#DORUN_ABORT,dorun
		rts
.dohelp
	ifd	__mcoldfire__
		move.w	#DORUN_HELP,d5
		move.w	d5,dorun
	else
		move.w	#DORUN_HELP,dorun
	endif
		rts
.dodn
		move.w	menucnt,d0
	ifd	__mcoldfire__
		subq.l	#1,d0
	else
		subq.w	#1,d0
	endif
		cmp.w	menupos,d0
		bls	.waitmenu
	ifd	__mcoldfire__
		move.w	menupos,d5
		addq.l	#1,d5
		move.w	d5,menupos
	else
		add.w	#1,menupos
	endif
		tos_cconws cur_clr
		tos_cconws cur_dn
		tos_cconws v_selectch
		bra	.waitmenu

.doup		tst.w	menupos
		beq	.waitmenu
	ifd	__mcoldfire__
		move.w	menupos,d5
		subq.l	#1,d5
		move.w	d5,menupos
	else
		sub.w	#1,menupos
	endif
		tos_cconws cur_clr
		tos_cconws cur_up
		tos_cconws v_selectch
		bra	.waitmenu

	section	data
do_timeout		dc.w	0
cur_upclr		dc.b	27,"A",13,27,"l",0
cur_up			dc.b	27,"A",13,0
cur_dn			dc.b	27,"B",13,0
cur_clr			dc.b	13," ",13,0
cur_time		dc.b	13,"0",0

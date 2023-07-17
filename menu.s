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
		or.w	#$30,d7
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
		add.w	menucnt,d1
		cmp.w	d1,d0
		bhs	.waitmenu
		sub.w	#$3a,d0
		move.w	d0,forcemenupos
.endmenu	bsr	savemenupos
		tos_cconws cur_clr
		tos_cconws v_selectch
		rts
.abortmenu	move.w	#DORUN_ABORT,dorun
		rts
.dohelp		move.w	#DORUN_HELP,dorun
		rts
.dodn
		move.w	menucnt,d0
		subq	#1,d0
		cmp.w	menupos,d0
		bls	.waitmenu
		add.w	#1,menupos
		tos_cconws cur_clr
		tos_cconws cur_dn
		tos_cconws v_selectch
		bra	.waitmenu

.doup		tst.w	menupos
		beq	.waitmenu
		sub.w	#1,menupos
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

	include	"tosmacros.asm"
INDEV=0
DORUN_ABORT=0
DORUN_RUN=1
DORUN_HELP=2
MAXITEMS=24
LOWRAM=$378
	comment	head=7
	section	code

		bsr	getcmdline
		tos_mshrinkinit	#1024
		bsr	readconfig
		bsr	setdefaults
		bsr	getcookies
		bsr	parseconfig
		bsr	dofpatch
		bsr	keyclickm

runloop
		cmp.w	#1,menucnt
		beq	.skipmenu
		bsr	domenu
.skipmenu

runauto
		move.w	menupos,d0
		bsr	indexptrs
		move.l	(a0),d0
		beq	.skiprun
		movem.l	a0-a3/d0-d3,-(sp)
		move.w	menucnt,d4
		sub.w	menupos,d4
.lpdn		tos_cconws cur_dn
		dbra	d4,.lpdn
		movem.l	(sp)+,a0-a3/d0-d3

		move.w	forcemenupos,d4
		beq	.skipforce
		subq	#1,d4
		move.w	d4,d0
		bsr	indexptrs
		move.l	(a0),d0
.skipforce
		cmp.w	#DORUN_HELP,dorun
		bne	.skipclr
		movem.l	a0-a3/d0-d3,-(sp)
		move.w	menucnt,d4
;		subq	#1,d4
.lpclr		tos_cconws cur_upclr
		dbra	d4,.lpclr
		tos_cconws msg_newline
		movem.l	(sp)+,a0-a3/d0-d3

.skipclr
		tst.w	dorun
		beq	.skiprun
		
		move.l	d0,configtxtpos
		moveq	#0,d0
		move.w	d0,configtxtdone
		bsr	cfg_readline
		cmp.w	#DORUN_HELP,dorun
		bne	.skipshow
		tos_cconwsm	a0
		tos_cconws	msg_newline
.skipshow
		tst.w	configtxtdone
		bne	.done
.lp
		bsr	cfg_readline
		tst.w	configtxtdone
		bne	.done
		cmp.b	#";",(a0)	; skip comment lines
		beq	.lp
		cmp.b	#0,(a0)		; skip empty lines
		beq	.lp
		cmp.b	#'.',(a0)
		beq	.done
		bsr	cfg_gettoken
		moveq	#0,d0
		move.l	a1,a2
.cnt		tst.b	(a2)+
		beq	.cntdone
		addq.l	#1,d0
		bra	.cnt
.cntdone	
		move.b	d0,-(a1)

		movem.l	a0-a6/d0-d7,-(sp)
		cmp.w	#DORUN_RUN,dorun
		beq	.dopexec
		tos_cconwsm a0
		tos_cconws msg_newline
		bra	.pexecdone
.dopexec
	ifeq	INDEV
		tos_pexecm #0,a0,a1,#0
	endc
.pexecdone
		movem.l	(sp)+,a0-a6/d0-d7
		bra	.lp
.done
		cmp.w	#DORUN_HELP,dorun
		bne	.skiprun
		tos_cconws msg_newline
		move.l	menuptrs,configtxtpos
		move.w	#0,configtxtdone
		bsr	parseconfig
		bra	runloop
.skiprun
		bsr	keyclickt

terminate
		tos_pterm0

getcmdline
		move.l	8(sp),a0
		lea	$80(a0),a0
		lea	tmpfilename,a1
		moveq	#0,d0
		move.b	(a0)+,d0
		beq	.usefile
		subq.l	#1,d0
.cmdcp		move.b	(a0)+,(a1)+
		dbra	d0,.cmdcp
		move.b	#0,(a1)
		move.b	#0,v_savelast
		rts
.usefile
		lea	menuname,a0
		m_strcpy a0,a1
		rts


		include	"menu.s"
		include	"parser.s"
		include	"supcode.s"
		include	"getcookie.s"

	section	data
msg_notfound	dc.b	"Can't open "
	ifne	INDEV
filename	dc.b	"C:\AUTO\AUTOEXEC.CFG",0
	else
filename	dc.b	"\AUTO\AUTOEXEC.CFG",0
	endc
menuname	dc.b	"MENU.CFG",0
menuver		dc.b	27,"w",27,"p"," insaneBOOT v1.0 b"
	include	release.inc
		dc.b	" ",27,"q",13,10,0
msg_mallocerr	dc.b	"Error allocating memory",13,10,0
	even

	even

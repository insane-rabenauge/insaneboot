	include	"tosmacros.asm"
INDEV=0
DORUN_ABORT=0
DORUN_RUN=1
DORUN_HELP=2
MAXITEMS=24
LOWRAM=$378
	comment	head=7
	section	code	;125f8
		bsr	getcmdline
		tos_mshrinkinit	#1024
		bsr	readconfig
		bsr	setdefaults
		bsr	getcookies
		bsr	parseconfig
		bsr	dofpatch
		bsr	keyclickm

runloop
	ifd	__mcoldfire__
	  	move.w	menucnt,d0
		cmp.w	#1,d0
	else
		cmp.w	#1,menucnt
	endif
		beq	.skipmenu
		bsr	domenu
.skipmenu

runauto
		move.w	menupos,d0
		bsr	indexptrs
		move.l	(a0),d0
		beq	.skiprun
		m_pusha
	ifd	__mcoldfire__
		m_mvzw	menucnt,d4
	  	m_mvzw	menupos,d5
		sub.l	d5,d4
	else
		move.w	menucnt,d4
		sub.w	menupos,d4
	endif
.lpdn		tos_cconws cur_dn
		m_dbra	d4,.lpdn
		m_popa

		move.w	forcemenupos,d4
		beq	.skipforce
	ifd	__mcoldfire__
		subq.l	#1,d4
	else
		subq.w	#1,d4
	endif
		move.w	d4,d0
		bsr	indexptrs
		move.l	(a0),d0
.skipforce
	ifd	__mcoldfire__
		move.w	dorun,d5
		cmp.w	#DORUN_HELP,d5
	else
		cmp.w	#DORUN_HELP,dorun
	endif
		bne	.skipclr
		m_pusha
	ifd	__mcoldfire__
		move.l	menucnt,d4
	else
		move.w	menucnt,d4
	endif
.lpclr		tos_cconws cur_upclr
		m_dbra	d4,.lpclr
		tos_cconws msg_newline
		m_popa

.skipclr
		tst.w	dorun
		beq	.skiprun
		
		move.l	d0,configtxtpos
		moveq	#0,d0
		move.w	d0,configtxtdone
		bsr	cfg_readline
	ifd	__mcoldfire__
		move.w	dorun,d5
		cmp.w	#DORUN_HELP,d5
	else
		cmp.w	#DORUN_HELP,dorun
	endif
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
	ifd	__mcoldfire__
		move.b	(a0),d5
		cmp.b	#";",d5	; skip comment lines
		beq	.lp
		cmp.b	#0,d5		; skip empty lines
		beq	.lp
		cmp.b	#'.',d5
	else
		cmp.b	#";",(a0)	; skip comment lines
		beq	.lp
		cmp.b	#0,(a0)		; skip empty lines
		beq	.lp
		cmp.b	#'.',(a0)
	endif
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

		m_pusha
	ifd	__mcoldfire__
		move.w	dorun,d5
		cmp.w	#DORUN_RUN,d5
	else
		cmp.w	#DORUN_RUN,dorun
	endif
		beq	.dopexec
		tos_cconwsm a0
		tos_cconws msg_newline
		bra	.pexecdone
.dopexec
	ifeq	INDEV
		tos_pexecm #0,a0,a1,#0
	endc
.pexecdone
		m_popa
		bra	.lp
.done
	ifd	__mcoldfire__
		move.w	dorun,d5
		cmp.w	#DORUN_HELP,d5
	else
		cmp.w	#DORUN_HELP,dorun
	endif
		bne	.skiprun
		tos_cconws msg_newline
	ifd	__mcoldfire__
		move.l	menuptrs,d5
		move.l	d5,configtxtpos
	else
		move.l	menuptrs,configtxtpos
	endif
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
		m_dbra	d0,.cmdcp
		move.b	#0,(a1)
		move.b	#0,v_savelast
		rts
.usefile
		lea	menuname,a0
		bsr	strcpy
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
menuver		dc.b	27,"w",27,"p"," insaneBOOT v1.01 b"
	include	release.inc
		dc.b	" ",27,"q",13,10,0
msg_mallocerr	dc.b	"Error allocating memory",13,10,0
	even

	even

		section	code

chktoken	macro   proc
		lea     tok_\1,a2
		bsr     strcmptok
		beq     handle_\1
		ifne    \#!=1
		fail    wrong number of args: \#
		endc
		endm

readconfig
		tos_fsfirst	tmpfilename,#0
		tst.l	d0
		beq.s	.skipnotfound
		lea	filename,a0
		lea	tmpfilename,a1
		m_strcpy a0,a1
		tos_fsfirst	tmpfilename,#0
		tst.l	d0
		beq.s	.skipnotfound
		tos_cconws	menuver
		tos_cconws	msg_notfound
		tos_cconws	msg_newlinekey
		tos_cnecin
		bra	terminate
.skipnotfound
		tos_fgetdta
		move.l	d0,a0
		move.l	26(a0),d0
		move.l	d0,configlen
		add.l	#31,d0
		and.l	#$fffffff0,d0
		tos_malloc	d0
		tst.l	d0
		bne	.skipmemerr
		tos_cconws	menuver
		tos_cconws	msg_mallocerr
		tos_cnecin
		bra	terminate
.skipmemerr
		move.l	d0,configptr
		tos_fopen	tmpfilename,#0
		move.w	d0,fhandle
		tos_freadm	fhandle,configlen,configptr
		tos_fclose	fhandle
		move.l	configptr,a1
		move.l	a1,configtxtpos
		add.l	configlen,a1
		move.b	#$a,(a1)+
		lea	tok_end,a0
		m_strcpy a0,a1
		rts

setdefaults
;set bss vars to defaults
		moveq	#0,d0
		move.w	d0,configtxtdone
		move.w	d0,menucnt
		move.w	d0,menupos
		move.w	d0,forcemenupos
		move.w	d0,dorun
		move.w	#1,do_timeout
		lea	menuptrs,a0
		move.w	#MAXITEMS-1,d1
.clrlp		move.l	d0,(a0)+
		dbra	d1,.clrlp
		rts
parseconfig
parseloop
.lp
		bsr	cfg_readline
		tst.w	configtxtdone
		bne	parsedone
		cmp.b	#";",(a0)	; skip comment lines
		beq	.lp
		cmp.b	#0,(a0)		; skip empty lines
		beq	.lp
		cmp.b	#".",(a0)	
		beq	parsecommands
		bra	abortunknown
parsedone
		cmp.w	#DORUN_HELP,dorun
		beq	.skipload
		bsr	loadmenupos
.skipload
		move.w	menucnt,d4
		beq	.skipup
		cmp.w	menupos,d4
		bhi	.skipmax
		subq	#1,d4
		move.w	d4,menupos
.skipmax
		move.w	menucnt,d4
		beq	.skipup
		sub.w	menupos,d4
		subq	#1,d4
.lpup		tos_cconws cur_up
		dbra	d4,.lpup
.skipup
		tos_cconws v_selectch
		move.w	#DORUN_RUN,dorun
		rts

abortunknown
		tos_cconws	menuver
		tos_cconws	msg_configerr
		tos_cconws	configline
		tos_cconws	msg_newlinekey
		tos_cnecin
		bra	terminate

parsecommands
		bsr	cfg_gettoken
		bsr	cfg_tokentoupper
		chktoken fpatch
		chktoken magic
;		chktoken keepmem
		chktoken keyclick
		chktoken timeout
		chktoken selectch
		chktoken savelast
		chktoken default
		chktoken item
		chktoken item000
		chktoken item010
		chktoken item020
		chktoken item030
		chktoken item040
		chktoken item060
		chktoken msg
		chktoken msgln
		chktoken ver
		chktoken end
		bra	abortunknown

handle_fpatch
		bsr	cfg_gettoken
		beq	.done

		bsr	cfg_getnum
		move.b	d0,v_fpatch
.done
		bra	parseloop

handle_magic
		bsr	cfg_gettoken
		beq	.done

		bsr	cfg_getnum
		tst.b	d0
		beq	.done
		tst.l	magxfound
		beq	.done
		bra	terminate
.done
		bra	parseloop

;handle_keepmem
;		bsr	cfg_gettoken
;		beq	.done
;
;		bsr	cfg_getnum
;		move.b	d0,v_keepmem
;.done
;		bra	parseloop

handle_keyclick
		bsr	cfg_gettoken
		beq	.done

		bsr	cfg_getnum
		move.b	d0,v_keyclickm

		bsr	cfg_gettoken
		beq	.done

		bsr	cfg_getnum
		move.b	d0,v_keyclickt
.done
		bra	parseloop

handle_timeout
		bsr	cfg_gettoken
		beq	.done

		bsr	cfg_getnum
		move.b	d0,v_timeout
.done
		bra	parseloop

handle_savelast
		bsr	cfg_gettoken
		beq	.done

		bsr	cfg_getnum
		move.b	d0,v_savelast
.done
		bra	parseloop

handle_selectch
		move.b	(a1),v_selectch
.done
		bra	parseloop

handle_default
		bsr	cfg_gettoken
		beq	.done

		bsr	cfg_getnum
		tst.w	d0
		beq	.done
		cmp.w	#DORUN_HELP,dorun
		beq	.done
		subq	#1,d0
		move.w	d0,menupos
.done
		bra	parseloop

handle_item000
		cmp.b	#000,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item010
		cmp.b	#010,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item020
		cmp.b	#020,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item030
		cmp.b	#030,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item040
		cmp.b	#040,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item060
		cmp.b	#060,c_cpu+3
		bne	skipitem
handle_item
		subq.l	#1,a1
		tos_cconwsm a1
		tos_cconws msg_newline
		cmp.w	#DORUN_HELP,dorun
		beq	skipitem
		move.w	menucnt,d0
		bsr	indexptrs
		move.l	configcurlinepos,(a0)
		move.w	menucnt,d0
		cmp.w	#MAXITEMS,d0
		beq	abortunknown
		addq.w	#1,d0
		move.w	d0,menucnt
skipitem
.lp
		bsr	cfg_readline
		tst.w	configtxtdone
		bne	.done
		cmp.b	#'.',(a0)
		bne	.lp
.done
		bra	parsecommands

handle_msg
		tos_cconwsm a1
		bra	parseloop
	
handle_msgln
		tos_cconwsm a1
		tos_cconws msg_newline
		bra	parseloop

handle_ver
		tos_cconws menuver
		bra	parseloop

handle_end
		move.w	#1,configtxtdone
		bra	parseloop

indexptrs
		lea	menuptrs,a0
		lsl.w	#2,d0
		add.w	d0,a0
		rts

cfg_getnum
;reads decimal number from a0 into d0
		movem.l	a0/d1-d2,-(sp)
		moveq	#0,d0
		moveq	#0,d1
.lp		move.b	(a0)+,d1
		cmp.b	#$30,d1
		blo	.done
		cmp.b	#$39,d1
		bhi	.done
		add.l	d0,d0	;*2,    4=8
		move.l	d0,d2
		add.l	d0,d0	;*2=*4, 4=16
		add.l	d0,d0	;*2=*8,	4=32
		add.l	d2,d0	;=*10	4=40
;		mulu.l	#10,d0
		and.b	#$f,d1
		add.l	d1,d0
		bra	.lp
.done		
		movem.l	(sp)+,a0/d1-d2
		rts


cfg_gettoken
;reads from configline to configtoken until space,tab or eol
;strings are enclosed inside "", and copied until the closing "
;a0=configtoken, updates configpos, modifies a1
		move.l	cfglinepos,a1
		lea	configtoken,a0
.lp		cmp.b	#'"',(a1)
		beq	.copystring
		cmp.b	#32,(a1)
		bls	.done
		move.b	(a1)+,(a0)+
		bra	.lp

.copystring
		addq	#1,a1
.cslp
		cmp.b	#0,(a1)
		beq	.copydone
		cmp.b	#'"',(a1)
		beq	.copydoneskipend
		move.b	(a1)+,(a0)+
		bra	.cslp
.copydoneskipend
		addq	#1,a1
.copydone
.done
		move.b	#0,(a0)
		lea	configtoken,a0
.removespaces
		cmp.b	#0,(a1)
		beq	.removespacesdone
		cmp.b	#27,(a1)
		beq	.removespacesdone
		cmp.b	#32,(a1)
		bhi	.removespacesdone
		addq	#1,a1
		bra	.removespaces
.removespacesdone
		move.l	a1,cfglinepos
		cmp.b	#0,(a0)
		rts

cfg_tokentoupper
;uppercases token
		lea	configtoken,a0
.lp		move.b	(a0),d0
		beq	.done
		cmp.b   #$61,d0
		blo     .skipupper
		eor.b   #$20,d0
.skipupper
		move.b	d0,(a0)+
		bra	.lp
.done
		lea	configtoken,a0
		rts

cfg_readline
;reads a line into configline until eof (=0) or eol
;a0=configline, updates configpos, modifies a1
		lea	configline,a0
		move.l	configtxtpos,a1
		move.l	a1,configcurlinepos
.lp		cmp.l	#configline+255,a0
		beq	.done10
		cmp.b	#0,(a1)
		beq	.doneconfig
		cmp.b	#13,(a1)
		beq	.skip13
		cmp.b	#10,(a1)
		beq	.done10
		cmp.b	#"^",(a1)
		beq	.modesc
		move.b	(a1)+,(a0)+
		bra	.lp
.modesc		move.b	#27,(a0)+
.skip13		addq	#1,a1
		bra	.lp

.doneconfig
		move.w	#1,configtxtdone
		bra	.done
.done10		addq	#1,a1
.done		move.b	#0,(a0)
		lea	configline,a0
		move.l	a1,configtxtpos
		move.l	a0,cfglinepos
		rts

strcpy
		movem.l	a0/a1,-(sp)
.cp
		move.b	(a0)+,(a1)+
		bne	.cp
		movem.l	(sp)+,a0/a1
		rts

strcmptok
		lea	configtoken,a3
.docmp
		cmp.b	(a2)+,(a3)+
		bne	.done
		tst.b	-1(a2)
		bne	.docmp
.done
		rts

		section	data
msg_newlinekey		dc.b	13,10
			dc.b	"Press any key to terminate the program"
msg_newline		dc.b	13,10,0
msg_configerr		dc.b	"Error inside config line:",13,10,0
tok_msg			dc.b	".MSG!",0
tok_msgln		dc.b	".MSG",0
tok_ver			dc.b	".SHOWVERSION",0
tok_fpatch		dc.b	".FPATCH",0
tok_magic		dc.b	".MAGICQUIT",0
;tok_keepmem		dc.b	".KEEPMEM",0
tok_keyclick		dc.b	".KEYCLICK",0
tok_timeout		dc.b	".TIMEOUT",0
tok_savelast		dc.b	".SAVELAST",0
tok_default		dc.b	".DEFAULTITEM",0
tok_selectch		dc.b	".SELECTCHAR",0
tok_item		dc.b	".ITEM",0
tok_item000		dc.b	".ITEM000",0
tok_item010		dc.b	".ITEM010",0
tok_item020		dc.b	".ITEM020",0
tok_item030		dc.b	".ITEM030",0
tok_item040		dc.b	".ITEM040",0
tok_item060		dc.b	".ITEM060",0
tok_end			dc.b	".END",0
			even
v_savelast		dc.b	1
v_fpatch		dc.b	1
;v_keepmem		dc.b	1
v_keyclickm		dc.b	1
v_keyclickt		dc.b	1
v_timeout		dc.b	5
v_selectch		dc.b	">",0
			even

		section	bss
c_mch			ds.l	1	;0x00030000=Falcon030 (compare hi-word only!)
c_cpu			ds.l	1	;00=68000, 60=68060 etc.
magxfound		ds.l	1
fhandle			ds.w	1
configlen		ds.l	1
configptr		ds.l	1
configtxtdone		ds.w	1
menucnt			ds.w	1
menupos			ds.w	1
forcemenupos		ds.w	1
dorun			ds.w	1
menuptrs		ds.l	MAXITEMS
cfglinepos		ds.l	1
configtxtpos		ds.l	1
configcurlinepos	ds.l	1
tmpfilename
configline		ds.b	256
configtoken		ds.b	256

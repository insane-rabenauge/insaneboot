		section	code

chktoken	macro   proc
		lea     tok_\1,a2
		bsr     strcmptok
		beq     handle_\1
		ifne    \#!=1
		fail    wrong number of args: \#
		endc
		endm

m_cmpb		macro
	ifd	__mcoldfire__
		move.b	\2,d5
		cmp.b	\1,d5
	else
		cmp.b	\1,\2
	endif
		endm

readconfig
		tos_fsfirst	tmpfilename,#0
		tst.l	d0
		beq.s	.skipnotfound
		lea	filename,a0
		lea	tmpfilename,a1
		bsr	strcpy
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
		bsr	strcpy
		rts

setdefaults
;set bss vars to defaults
		moveq	#0,d0
		move.w	d0,configtxtdone
		move.w	d0,menucnt
		move.w	d0,menupos
		move.w	d0,forcemenupos
		move.w	d0,dorun
	ifd	__mcoldfire__
		move.w	#1,d5
		move.w	d5,do_timeout
	else
		move.w	#1,do_timeout
	endif
		lea	menuptrs,a0
	ifd	__mcoldfire__
		move.l	#MAXITEMS-1,d1
	else
		move.w	#MAXITEMS-1,d1
	endif
.clrlp		move.l	d0,(a0)+
		m_dbra	d1,.clrlp
		rts
parseconfig
parseloop
.lp
		bsr	cfg_readline
		tst.w	configtxtdone
		bne	parsedone
	ifd	__mcoldfire__
		move.b	(a0),d5
		cmp.b	#";",d5	; skip comment lines
		beq	.lp
		cmp.b	#0,d5		; skip empty lines
		beq	.lp
		cmp.b	#".",d5
	else
		cmp.b	#";",(a0)	; skip comment lines
		beq	.lp
		cmp.b	#0,(a0)		; skip empty lines
		beq	.lp
		cmp.b	#".",(a0)
	endif
		beq	parsecommands
		bra	abortunknown
parsedone
	ifd	__mcoldfire__
		moveq	#0,d4
		move.w	dorun,d5
		cmp.w	#DORUN_HELP,d5
	else
		cmp.w	#DORUN_HELP,dorun
	endif
		beq	.skipload
		bsr	loadmenupos
.skipload
		move.w	menucnt,d4
		beq	.skipup
		cmp.w	menupos,d4
		bhi	.skipmax
	ifd	__mcoldfire__
		subq.l	#1,d4
	else
		subq.w	#1,d4
	endif
		move.w	d4,menupos
.skipmax
		move.w	menucnt,d4
		beq	.skipup
	ifd	__mcoldfire__
		m_mvzw	menupos,d5
		sub.l	d5,d4
		subq.l	#1,d4
	else
		sub.w	menupos,d4
		subq.w	#1,d4
	endif
.lpup		tos_cconws cur_up
		m_dbra	d4,.lpup
.skipup
		tos_cconws v_selectch
	ifd	__mcoldfire__
		move.w	#DORUN_RUN,d5
		move.w	d5,dorun
	else
		move.w	#DORUN_RUN,dorun
	endif
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
		chktoken itemstc
		chktoken itemstm
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
	ifd	__mcoldfire__
		move.w	dorun,d5
		cmp.w	#DORUN_HELP,d5
	else
		cmp.w	#DORUN_HELP,dorun
	endif
		beq	.done
	ifd	__mcoldfire__
		subq.l	#1,d0
	else
		subq.w	#1,d0
	endif
		move.w	d0,menupos
.done
		bra	parseloop

handle_item000
		m_cmpb	#000,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item010
		m_cmpb	#010,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item020
		m_cmpb	#020,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item030
		m_cmpb	#030,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item040
		m_cmpb	#040,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_item060
		m_cmpb	#060,c_cpu+3
		bne	skipitem
		bra	handle_item
handle_itemstc
		m_cmpb	#2,shiftres
		beq	skipitem
		bra	handle_item
handle_itemstm
		m_cmpb	#2,shiftres
		bne	skipitem
handle_item
		subq.l	#1,a1
		tos_cconwsm a1
		tos_cconws msg_newline
	ifd	__mcoldfire__
		move.w	dorun,d5
		cmp.w	#DORUN_HELP,d5
	else
		cmp.w	#DORUN_HELP,dorun
	endif
		beq	skipitem
		move.w	menucnt,d0
		bsr	indexptrs
		move.l	configcurlinepos,(a0)
		move.w	menucnt,d0
		cmp.w	#MAXITEMS,d0
		beq	abortunknown
	ifd	__mcoldfire__
		addq.l	#1,d0
	else
		addq.w	#1,d0
	endif
		move.w	d0,menucnt
skipitem
.lp
		bsr	cfg_readline
		tst.w	configtxtdone
		bne	.done
	ifd	__mcoldfire__
		move.b	(a0),d5
		cmp.b	#'.',d5
	else
		cmp.b	#'.',(a0)
	endif
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
	ifd	__mcoldfire__
		move.w	#1,d5
		move.w	d5,configtxtdone
	else
		move.w	#1,configtxtdone
	endif
		bra	parseloop

indexptrs
		lea	menuptrs,a0
	ifd	__mcoldfire__
		ext.l	d0
		lsl.l	#2,d0
		add.l	d0,a0
	else
		lsl.w	#2,d0
		add.w	d0,a0
	endif
		rts

cfg_getnum
;reads decimal number from a0 into d0
		m_push	a0/d1-d2
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
	ifd	__mcoldfire__
		and.l	#$f,d1
	else
		and.b	#$f,d1
	endif
		add.l	d1,d0
		bra	.lp
.done		
		m_pop	a0/d1-d2
		rts


cfg_gettoken
;reads from configline to configtoken until space,tab or eol
;strings are enclosed inside "", and copied until the closing "
;a0=configtoken, updates configpos, modifies a1
		move.l	cfglinepos,a1
		lea	configtoken,a0
.lp		
	ifd	__mcoldfire__
		move.b	(a1),d5
		cmp.b	#'"',d5
		beq	.copystring
		cmp.b	#32,d5
	else
		cmp.b	#'"',(a1)
		beq	.copystring
		cmp.b	#32,(a1)
	endif
		bls	.done
		move.b	(a1)+,(a0)+
		bra	.lp

.copystring
		addq	#1,a1
.cslp
	ifd	__mcoldfire__
		move.b	(a1),d5
		cmp.b	#0,d5
		beq	.copydone
		cmp.b	#'"',d5
	else
		cmp.b	#0,(a1)
		beq	.copydone
		cmp.b	#'"',(a1)
	endif
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
	ifd	__mcoldfire__
		move.b	(a1),d5
		cmp.b	#0,d5
		beq	.removespacesdone
		cmp.b	#27,d5
		beq	.removespacesdone
		cmp.b	#32,d5
	else
		cmp.b	#0,(a1)
		beq	.removespacesdone
		cmp.b	#27,(a1)
		beq	.removespacesdone
		cmp.b	#32,(a1)
	endif
		bhi	.removespacesdone
		addq	#1,a1
		bra	.removespaces
.removespacesdone
		move.l	a1,cfglinepos
		tst.b	(a0)
		rts

cfg_tokentoupper
;uppercases token
		lea	configtoken,a0
.lp		move.b	(a0),d0
		beq	.done
		cmp.b   #$61,d0
		blo     .skipupper
	ifd	__mcoldfire__
		eor.l   #$20,d0
	else
		eor.b   #$20,d0
	endif
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
	ifd	__mcoldfire__
		move.b	(a1),d5
		cmp.b	#0,d5
		beq	.doneconfig
		cmp.b	#13,d5
		beq	.skip13
		cmp.b	#10,d5
		beq	.done10
		cmp.b	#"^",d5
	else
		cmp.b	#0,(a1)
		beq	.doneconfig
		cmp.b	#13,(a1)
		beq	.skip13
		cmp.b	#10,(a1)
		beq	.done10
		cmp.b	#"^",(a1)
	endif
		beq	.modesc
		move.b	(a1)+,(a0)+
		bra	.lp
.modesc		move.b	#27,(a0)+
.skip13		addq	#1,a1
		bra	.lp

.doneconfig
	ifd	__mcoldfire__
		move.w	#1,d5
		move.w	d5,configtxtdone
	else
		move.w	#1,configtxtdone
	endif
		bra	.done
.done10		addq	#1,a1
.done		move.b	#0,(a0)
		lea	configline,a0
		move.l	a1,configtxtpos
		move.l	a0,cfglinepos
		rts

strcpy
.cp
		move.b	(a0)+,(a1)+
		bne	.cp
		rts

strcmptok
		lea	configtoken,a3
.docmp
	ifd	__mcoldfire__
		move.b	(a3)+,d5
		cmp.b	(a2)+,d5
	else
		cmp.b	(a2)+,(a3)+
	endif
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
tok_itemstc		dc.b	".ITEMSTC",0
tok_itemstm		dc.b	".ITEMSTM",0
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
shiftres		ds.w	1
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

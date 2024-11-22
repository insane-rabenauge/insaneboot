	section	code
getoshz200
		pea	getoshz200_sup
		bra	supexec_common
getcookies
		pea	getcookies_sup
		bra	supexec_common
keyclickm
		pea	keyclickm_sup
		bra	supexec_common
keyclickt
		pea	keyclickt_sup
		bra	supexec_common
loadmenupos
		pea	loadmenupos_sup
		bra	supexec_common
savemenupos
		pea	savemenupos_sup

supexec_common
		move.w	#38,-(sp)
		trap	#14
		addq.l	#6,sp
		rts

getoshz200_sup
		move.l	os_hz200,d0
		rts

getcookies_sup
		move.l	#"_MCH",d0
		bsr	get_cookie
		move.l	d1,c_mch
		move.l	#"_CPU",d0
		bsr	get_cookie
		move.l	d1,c_cpu
		move.l	#"MagX",d0
		bsr	get_cookie
		move.l	d0,magxfound
	ifnd	__mcoldfire__
		move.b	$ffff8260.w,d0
		and.b	#%11,d0
		move.b	d0,shiftres
	endif
		rts

keyclickm_sup
		move.b	v_keyclickm,d0
keyclick
	ifd	__mcoldfire__
		move.w	ptr_conterm.w,d5
		bset	#0,d5
		tst.b	d0
		bne	.skipclr
		bclr	#0,d5
.skipclr
		move.w	d5,ptr_conterm.w
	else
		bset	#0,ptr_conterm.w
		tst.b	d0
		bne	.skipclr
		bclr	#0,ptr_conterm.w
.skipclr
	endif
		rts

keyclickt_sup
		move.b	v_keyclickt,d0
		bra	keyclick

dofpatch
	ifnd	__mcoldfire__
		tst.b	v_fpatch
		beq	.skip
		cmp.w	#3,c_mch
		bne	.skip

		tos_devconnect	#0,#8,#0,#0,#1
		tos_setmode	#0
		tos_soundcmd	#2,#$40
		tos_soundcmd	#3,#$40
		tos_soundcmd	#6,#3
		tos_soundcmd	#4,#3
		tos_soundcmd	#5,#3
.patch_maptabsize		
		tos_bconmap	#-2
		move.l	d0,a0		; ptr to bconmap struct
		cmp.w	#1,4(a0)	; only patch if maptabsize=1
		bne.w	.skip_patchmaptabsize
		move.w	#3,4(a0)	; set to 3
.skip_patchmaptabsize
		move.l	(a0),a0		;get address of Bconmap 6 defaults
		lea	24(a0),a0	;point to Bconmap 7 defaults
		movem.l	(a0),d0-d5
		movem.l	d0-d5,-(a0)	;copy Bconmap 7 over Bconmap 6
.skip
	endif
		rts


loadmenupos_sup
		tst.b	v_savelast
		beq	.skip
		lea	LOWRAM,a0
	ifd	__mcoldfire__
		move.l	(a0)+,d5
		cmp.l	#"BOOT",d5
	else
		cmp.l	#"BOOT",(a0)+
	endif
		bne	.skip
		moveq	#0,d0
		move.b	(a0)+,d0
		cmp.b	(a0)+,d0
		bne	.skip
		move.w	d0,menupos
.skip		rts

savemenupos_sup
		tst.b	v_savelast
		beq	.skip
		lea	LOWRAM,a0
		move.l	#"BOOT",(a0)+
		move.w	menupos,d0
		move.b	d0,(a0)+
		move.b	d0,(a0)+
.skip		rts
	

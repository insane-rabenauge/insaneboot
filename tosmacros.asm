; macro list by insane/tSCc - insane.tscc.de
		ifnd    _tos_macros
_tos_macros		set     1
		nolist
ptr_hbl		equ $68
ptr_vbl		equ $70
ptr_timera		equ $134
ptr_timerb		equ $120
ptr_timerc		equ $114
ptr_timerd		equ $110
os_vblcnt		equ $462
dat_vbclock		equ $462
os_vbclock		equ $462
dat_frclock		equ $466
os_frclock		equ $466
ptr_conterm		equ $484
dat_hz200		equ $4ba
os_hz200		equ $4ba
ptr_sysbase		equ $4f2
ptr_cookiejar	equ $5a0
set_timerb_event_count	equ 8
vt_C_UP            	equ "A"	 ; cursor one line up
vt_C_DOWN          	equ "B"	 ;   "     "    "  down		
vt_C_RIGHT         	equ "C"	 ;   "     "  column right	
vt_C_LEFT          	equ "D"	 ;   "     "     "   left		
vt_CLEAR_HOME      	equ "E"	 ; clear screen, cursor home	
vt_HOME            	equ "H"	 ; cursor home
vt_SCROLL_UP       	equ "I"	 ; cursor one line up; when already
vt_CLEAR_DOWN      	equ "J"	 ; clear screen from cursor position
vt_DEL_EOL         	equ "K"	 ; clear screen until end of line
vt_INS_LINE        	equ "L"	 ; insert line			
vt_DEL_LINE        	equ "M"	 ; delete line			
vt_CURS_LOC        	equ "Y"	 ; set cursor to position x, y	
vt_CHAR_COLOR      	equ "b"	 ; select the character color
vt_BG_COLOR        	equ "c"	 ; as above for back ground color
vt_DEL_BOP  	equ "d"	 ; erase to start of page inc. cur
vt_C_ON            	equ "e"	 ; switch cursor on		
vt_C_OFF           	equ "f"	 ; switch cursor off
vt_C_SAVE          	equ "j"	 ; store cursor position
vt_C_RESTORE       	equ "k"	 ; restore cursor position
vt_ERASE_L         	equ "l"	 ; erase cursor line
vt_DEL_BOL         	equ "o"	 ; erase to beginning of line
vt_REV_ON          	equ "p"	 ; inverse on
vt_REV_OFF         	equ "q"	 ; inverse off
vt_WRAP_ON         	equ "v"	 ; automatic line wrap on	
vt_WRAP_OFF        	equ "w"	 ; automatic line wrap off
io_ym2149_reg	equ $ffff8800
io_ym2149_dat	equ $ffff8802
io_timera_ctrl	equ $fffffa19
io_timerb_ctrl	equ $fffffa1b
io_timera_data	equ $fffffa1f
io_timerb_data	equ $fffffa21
io_timercd_ctrl	equ $fffffa1d
io_timerc_data	equ $fffffa23
io_timerd_data	equ $fffffa25
io_timerab_ier	equ $fffffa07 ;interrupt enable
io_timerab_iis	equ $fffffa0f ;interrupt in service
io_timerab_imr	equ $fffffa13 ;interrupt mask
io_timercd_ier	equ $fffffa09 ;interrupt enable
io_timercd_iis	equ $fffffa11 ;interrupt in service
io_timercd_imr	equ $fffffa15 ;interrupt mask
io_xbar		equ $ffff8930
io_xbar_src		equ $ffff8930
io_xbar_dst		equ $ffff8932
io_freqdiv		equ $ffff8934
io_freqdiv_xclk	equ $ffff8934
io_freqdiv_iclk	equ $ffff8935
io_snd_chnvol	equ $ffff893a
io_dsp_hostport	equ $ffffa204
io_dsp_isr		equ $ffffa202
io_dsp_statusreg	equ $ffffa202
io_dsp_commandvec	equ $ffffa201
io_screenpos	equ $ffff8200
io_videopos_h	equ $ffff8205
io_videopos_m	equ $ffff8207
io_videopos_l	equ $ffff8209
io_screenpos_l	equ $ffff820d
io_pal_f030		equ $ffff9800
io_pal_st		equ $ffff8240
io_parport		equ $fffffa01
io_dma_ctrl		equ $ffff8901
io_dma_start	equ $ffff8902
io_dma_start_l	equ $ffff8907
io_dma_end		equ $ffff890e
io_dma_end_l	equ $ffff8913
io_kbd_ctrl 	equ $fffffc00
io_kbd_data		equ $fffffc02
io_shifter_res	equ $ffff8260
io_blit_halftone	equ $ffff8a00
io_blit_srcxinc	equ $ffff8a20
io_blit_srcyinc	equ $ffff8a22
io_blit_srcaddr	equ $ffff8a24
io_blit_endmsk1	equ $ffff8a28
io_blit_endmsk2	equ $ffff8a2a
io_blit_endmsk3	equ $ffff8a2c
io_blit_dstxinc	equ $ffff8a2e
io_blit_dstyinc	equ $ffff8a30
io_blit_dstaddr	equ $ffff8a32
io_blit_xcount	equ $ffff8a36
io_blit_ycount	equ $ffff8a38
io_blit_hop		equ $ffff8a3a
io_blit_lop		equ $ffff8a3b
io_blit_mode	equ $ffff8a3c
io_blit_skew	equ $ffff8a3d
ikbd_cmd_joy_off	equ $1a
ikbd_cmd_joy_on	equ $14
ikbd_cmd_mouse_off	equ $12
ikbd_cmd_mouse_on	equ $8

tos_vm_enquire	equ -1
tos_vm_vertflag  	equ $0100  ;/* interlace aktivieren          */
tos_vm_stmodes   	equ $0080  ;/* st-kompatible grafik          */
tos_vm_overscan  	equ $0040  ;/* overscan aktivieren           */
tos_vm_pal       	equ $0020  ;/* pal-modus                     */
tos_vm_falc_vga  	equ $0010  ;/* vga-modus                     */
tos_vm_tv        	equ $0000  ;/* tv-modus                      */
tos_vm_col80     	equ $0008  ;/* bildbreite mind. 640 pixel    */
tos_vm_col40     	equ $0000  ;/* bildbreite 320 pixel          */
tos_vm_bps16     	equ 4      ;/* 16 farbebenen: 65536 farben   */
tos_vm_bps8      	equ 3      ;/*  8 farbebenen:   256 farben   */
tos_vm_bps4      	equ 2      ;/*  4 farbebenen:    16 farben   */
tos_vm_bps2      	equ 1      ;/*  2 farbebenen:     4 farben   */
tos_vm_bps1      	equ 0      ;/*  1 farbebenen:     2 farben   */

tos_snd_sr_play	equ 0	;/* set playback registers */
tos_snd_sr_record	equ 1	;/* set record registers */
tos_snd_ltatten	equ 0	;/* left-channel output attenuation */
tos_snd_rtatten	equ 1	;/* right channel atten */
tos_snd_ltgain	equ 2	;/* left input gain */
tos_snd_rtgain	equ 3	;/* right channel gain */
tos_snd_adderin	equ 4	;/* select inputs to adder 0=off, 1=on */
tos_snd_adcin	equ 1	;/* input from adc */
tos_snd_matin	equ 2	;/* input from connection matrix */
tos_snd_adcinput	equ 5	;/* select input to adc, 0=mic, 1=psg */
tos_snd_adcrt	equ 1	;/* right channel input */
tos_snd_adclt	equ 2	;/* left input */
tos_snd_setprescale	equ 6	;/* set tt compatibility prescaler */
tos_snd_premute	equ 0	;/* was /1280, now is invalid, mutes */
tos_snd_pre1280	equ 0
tos_snd_pre640	equ 1	;/* divide by 640 */
tos_snd_pre320	equ 2	;/* / 320 */
tos_snd_pre160	equ 3	;/* / 160 */
tos_snd_stereo8	equ 0	;/* 8 bit stereo */
tos_snd_stereo16	equ 1	;/* 16 bit stereo */
tos_snd_mono8	equ 2	;/* 8 bit mono */
tos_snd_si_timera	equ 0	;/* timer a interrupt */
tos_snd_si_mfpi7	equ 1	;/* mfp interrupt 7 */
tos_snd_si_none	equ 0	;/* no interrupts */
tos_snd_si_play	equ 1	;/* intr at end of play buffer */
tos_snd_si_record	equ 2	;/* intr at end of record buffer */
tos_snd_si_both	equ 3	;/* interrupt for either play or record */
tos_snd_sb_pla_ena	equ 1	;/* play enable */
tos_snd_sb_pla_rpt	equ 2	;/* play repeat (continuous loop mode) */
tos_snd_sb_rec_ena	equ 4	;/* record enable */
tos_snd_sb_rec_rpt	equ 8	;/* record repeat */
tos_snd_dmaplay	equ 0	;/* dma playback */
tos_snd_dspxmit	equ 1	;/* dsp transmit */
tos_snd_extinp	equ 2	;/* external input */
tos_snd_adc		equ 3	;/* microphone/psg, see soundcmd(adcinput) */
tos_snd_dmarec	equ 1	;/* dma record */
tos_snd_dsprecv	equ 2	;/* dsp receive */
tos_snd_extout	equ 4	;/* external output */
tos_snd_dac		equ 8	;/* headphone, internal speaker, monitor */
tos_snd_clk25m	equ 0	;/* internal 25.175 mhz clock */
tos_snd_clkext	equ 1	;/* external clock */
tos_snd_clk32m	equ 2	;/* internal 32 mhz. invalid for codec */
tos_snd_clkold	equ 0	;/* tt compatible, see soundcmd(setprescale) */
tos_snd_clk50k	equ 1	;/* 49170 hz */
tos_snd_clk49k	equ 1	;/* 49170 hz */
tos_snd_clk33k	equ 2	;/* 32780 hz */
tos_snd_clk25k	equ 3	;/* 24585 hz */
tos_snd_clk20k	equ 4	;/* 19668 hz */
tos_snd_clk16k	equ 5	;/* 16390 hz */
tos_snd_clk12k	equ 7	;/* 12292 hz */
tos_snd_clk10k	equ 9	;/* 9834 hz */
tos_snd_clk8k	equ 11	;/* 8195 hz */
tos_snd_check	equ 0	;/* check current status */
tos_snd_reset	equ 1	;/* reset sound system */
tos_snd_ss_ok	equ 0	;/* no errors */
tos_snd_ss_ctrl	equ 1	;/* invalid control field (data assumed ok) */
tos_snd_ss_sync	equ 2	;/* invalid sync format (mutes) */
tos_snd_ss_sclk	equ 3	;/* serial clock out of valid range (mutes) */
tos_snd_ss_rtclip	equ $10	;/* right channel is clipping */
tos_snd_ss_ltclip	equ $20	;/* left channel is clipping */
tos_snd_ss_error	equ $f
tos_snd_left_mic	equ $00
tos_snd_left_psg	equ $02
tos_snd_right_mic	equ $00
tos_snd_right_psg	equ $01
tos_snd_inquire	equ -1
tos_snd_locked	equ -129
tos_snd_notlock	equ -128
tos_snd_mode_stereo8	equ 0
tos_snd_mode_stereo16	equ 1
tos_snd_mode_mono	equ 2
tos_snd_dsp_tristate	equ 0
tos_snd_dsp_enable 	equ 1
tos_snd_handshake 	equ 0
tos_snd_no_shake 	equ 1

tos_file_read	equ 0
tos_file_write	equ 1
tos_file_readwrite	equ 2
tos_seek_beg	equ 0
tos_seek_cur	equ 1
tos_seek_end	equ 2
tos_dp_iopen	equ 0
tos_dp_maxlinks	equ 1
tos_dp_pathmax	equ 2
tos_dp_namemax	equ 3
tos_dp_atomic	equ 4
tos_dp_trunc	equ 5
tos_dp_case		equ 6
tos_dp_modeattr	equ 7
tos_dp_xattrfields	equ 8
tos_dp_volnamemax	equ 9

tos_hidemouse macro
	dc.w	$A00A
endm
tos_showmouse macro
	dc.w	$A009
endm	
tos_initmouse macro	mtype mparamptr mmousevec
	pea   	\3
	pea   	\2
	move.w	\1,-(sp)
	move.w	#0,-(sp)
	trap  	#14
	lea   	12(sp),sp
	endm
tos_bconstat macro 	dev
	if	\#!=2
	move.w	#2,-(sp)
	else
	move.w	\1,-(sp)
	endc
	move.w	#1,-(sp)
	trap  	#13
	addq.l	#4,sp
	endm
tos_bconin	macro 	dev
	if	\#!=2
	move.w	#2,-(sp)
	else
	move.w	\1,-(sp)
	endc
	move.w	#2,-(sp)
	trap  	#13
	addq.l	#4,sp
	endm
tos_bconout	macro	dev,char
	if	\#!=2
	move.w	\1,-(sp)
	move.w	#2,-(sp)
	else
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	endc
	move.w	#3,-(sp)
	trap	#13
	addq.l	#6,sp
	endm
tos_brawout	macro	dev,char
	move.w	\1,-(sp)
	move.w	#5,-(sp)
	move.w	#3,-(sp)
	trap	#13
	addq.l	#6,sp
	endm
tos_bconmap	macro 	dev
	move.w	\1,-(sp)
	move.w	#44,-(sp)
	trap  	#14
	addq.l	#4,sp
	endm
tos_kbshift macro	mode
	move.w	\1,-(sp)
	move.w	#$b,-(sp)
	trap  	#13
	addq.l	#4,sp
	endm
tos_random	macro
	move.w 	#17,-(sp)
	trap   	#14
	addq.l 	#2,sp
	endm
tos_pterm macro	retcode
	move.w	\1,-(sp)
	move.w	#76,-(sp)
	trap	#1
	endm
tos_pterm0	macro
	clr.w	-(sp)
	trap	#1
	endm
tos_pexec	macro	mode,name,cmdline,env
	move.l	\4,-(sp)
	pea	\3
	pea	\2
	move.w	\1,-(sp)
	move.w	#75,-(sp)
	trap	#1
	lea	$10(sp),sp
	endm
tos_pexecm	macro	mode,name,cmdline,env
	move.l	\4,-(sp)
	move.l	\3,-(sp)
	move.l	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#75,-(sp)
	trap	#1
	lea	$10(sp),sp
	endm
tos_ptermres macro	keepcnt,retcode
	move.w	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#49,-(sp)
	trap	#1
	endm
tos_malloc	macro	number
	move.l	\1,-(sp)
	move.w	#72,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_mxalloc	macro	amount,mode
	move.w 	\2,-(sp)
	move.l 	\1,-(sp)
	move.w 	#68,-(sp)
	trap   	#1
	addq.l 	#8,sp
	endm
tos_mfree	macro	block
	pea	\1
	move.w	#73,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_mfreem	macro	block
	move.l	\1,-(sp)
	move.w	#73,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_mshrink	macro	block,newsize
	move.l	\2,-(sp)
	move.l	\1,-(sp)
	clr.w	-(sp)
	move.w	#$4a,-(sp)
	trap	#1
	lea	12(sp),sp
	endm
tos_mshrinkinit macro	stack
	move.l	4(sp),a5	        ;address to basepage
	move.l	$0c(a5),d0	        ;length of text segment
	add.l	$14(a5),d0	        ;length of data segment
	add.l	$1c(a5),d0	        ;length of bss segment
	add.l	#$100,d0	        ;length of basepage
	ifne	\#!=1
	add.l	#$1000,d0           ;length of stackpointer
	else
	add.l	\1,d0               ;length of stackpointer
	endc
	move.l	a5,d1	        ;address to basepage
	add.l	d0,d1	        ;end of program
	and.l	#-4,d1	        ;make address even, dword
	move.l	d1,sp	        ;new stackspace
	move.l	d0,-(sp)	        ;mshrink()
	move.l	a5,-(sp)
	move.w	d0,-(sp)
	move.w	#$4a,-(sp)
	trap	#1
	lea	12(sp),sp
	endm
tos_sversion macro
	move.w	#48,-(sp)
	trap	#1
	addq.l	#2,sp
	endm
tos_vsetmode macro	mode
	move.w	\1,-(sp)
	move.w	#88,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
tos_vgetmonitor macro
	move.w	#89,-(sp)
	trap	#14
	addq.l	#2,sp
	endm
tos_vsync	macro
	move.w	#37,-(sp)
	trap  	#14
	addq.l	#2,sp
	endm
tos_vsetrgbm macro	index,count,arrptr
	move.l	\3,-(sp)
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#93,-(sp)
	trap  	#14
	lea   	$A(sp),sp
	endm
tos_vgetrgbm macro	index,count,arrptr
	move.l	\3,-(sp)
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#94,-(sp)
	trap  	#14
	lea   	$A(sp),sp
	endm
tos_vsetrgb macro	index,count,arrptr
	pea	\3
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#93,-(sp)
	trap  	#14
	lea   	$A(sp),sp
	endm
tos_vgetrgb macro	index,count,arrptr
	pea	\3
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#94,-(sp)
	trap  	#14
	lea   	$A(sp),sp
	endm
tos_setpalette macro	palptr
	pea	\1
	move.w	#6,-(sp)
	trap	#14
	addq.l	#6,sp
	endm
tos_super	macro	newstack
	ifne	\#!=1
	clr.l	-(sp)
	else
	move.l	\1,-(sp)
	endc
	move.w	#32,-(sp)
	trap  	#1
	addq.l	#6,sp
	endm
tos_logbase macro
	move.w	#3,-(sp)
	trap	#14
	addq.l	#2,sp
	endm
tos_physbase macro
	move.w	#2,-(sp)
	trap	#14
	addq.l	#2,sp
	endm
tos_getrez	macro
	move.w	#4,-(sp)
	trap	#14
	addq.l	#2,sp
	endm
tos_supexec	macro	proc
	pea	\1
	move.w	#38,-(sp)
	trap	#14
	addq.l	#6,sp
	endm
tos_cconws	macro	address
	pea	\1
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_cconrs	macro	address
	pea	\1
	move.w	#$a,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_cconwsm	macro	address
	move.l	\1,-(sp)
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_cconis	macro
	move.w	#11,-(sp)
	trap	#1
	addq.l	#2,sp
	endm

tos_crawcin	macro
	move.w	#7,-(sp)
	trap 	#1
	addq.l	#2,sp
	endm

tos_cconin	macro
	move.w	#1,-(sp)
	trap	#1
	addq.l	#2,sp
	endm
tos_cconout	macro	char
	move.w	\1,-(sp)
	move.w	#2,-(sp)
	trap	#1
	addq.l	#4,sp
	endm
tos_cnecin	macro
	move.w	#8,-(sp)
	trap	#1
	addq.l	#2,sp
	endm

tos_dsp_blkunpacked macro pl_data_in,l_size_in,pl_data_out,l_size_out
	move.l	\4,-(sp)
	move.l	\3,-(sp)
	move.l	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#98,-(sp)
	trap	#14
	lea	$12(sp),sp
	endm
tos_buffoper macro	mode
	move.w	\1,-(sp)
	move.w	#136,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
tos_buffptr macro	ptr
	pea	\1
	move.w	#141,-(sp)
	trap	#14
	addq.l	#6,sp
	endm
tos_buffptrm macro	ptr
	move.l	\1,-(sp)
	move.w	#141,-(sp)
	trap	#14
	addq.l	#6,sp
	endm
tos_devconnect macro	src,dst,srcclk,prescale,protocol	
	move.w	\5,-(sp)
	move.w	\4,-(sp)
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#139,-(sp)
	trap  	#14
	lea   	$C(sp),sp
	endm
tos_locksnd	macro
	move.w	#128,-(sp)
	trap	#14
	addq.l	#2,sp
	endm
tos_unlocksnd macro
	move.w	#129,-(sp)
	trap	#14
	addq.l	#2,sp
	endm

tos_dsptristate macro	dspxmit,dsprec
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#137,-(sp)
	trap  	#14
	addq.l	#6,sp
	endm

tos_setbuffer macro	reg,startptr,endptr
	pea   	\3
	pea   	\2
	move.w	\1,-(sp)
	move.w	#131,-(sp)
	trap  	#14
	lea   	$C(sp),sp 
	endm
tos_setbufferm macro	reg,startptr,endptr
	move.l	\3,-(sp)
	move.l	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#131,-(sp)
	trap  	#14
	lea   	$C(sp),sp 
	endm
tos_setinterrupt macro	src_int,cause
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#135,-(sp)
	trap  	#14
	addq.l	#6,sp
	endm
tos_setmode macro	mode
	move.w	\1,-(sp)
	move.w	#132,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
tos_setmontracks macro	montrack
	move.w	\1,-(sp)
	move.w	#134,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
tos_settracks macro	playtracks,rectracks
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#133,-(sp)
	trap  	#14
	addq.l	#6,sp
	endm
tos_sndstatus macro	reset
	move.w	\1,-(sp)
	move.w	#140,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
tos_soundcmd macro	mode,data
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#130,-(sp)
	trap  	#14
	addq.l	#6,sp
	endm
tos_vsetscreen macro	laddr,paddr,rez,mode
	move.w	\4,-(sp)
	move.w	\3,-(sp)
	move.l	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#5,-(sp)
	trap	#14
	lea	14(sp),sp
	endm
tos_setscreen macro	laddr,paddr,rez
	move.w	\3,-(sp)
	move.l	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#5,-(sp)
	trap	#14
	lea	$c(sp),sp
	endm
tos_xbtimerm macro	timer,control,data,vector
	move.l	\4,-(sp)
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#31,-(sp)
	trap	#14
	lea	$C(sp),sp
	endm
tos_fcreate	macro	fname,attr	;d0.l=handle
	move.w	\2,-(sp)
	pea	\1
	move.w	#60,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_fcreatem macro	fname,attr	;d0.l=handle
	move.w	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#60,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_fopen	macro	fname,mode	;d0.l=handle
	move.w	\2,-(sp)
	pea	\1
	move.w	#61,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_fopenm	macro	fname,mode	;d0.l=handle
	move.w	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#61,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_fread	macro	handle,count,buf ;d0.l=bytes read
	pea    	\3
	move.l 	\2,-(sp)
	move.w 	\1,-(sp)
	move.w 	#63,-(sp)
	trap   	#1
	lea    	$C(sp),sp
	endm
tos_freadm	macro	handle,count,buf ;d0.l=bytes read
	move.l    	\3,-(sp)
	move.l 	\2,-(sp)
	move.w 	\1,-(sp)
	move.w 	#63,-(sp)
	trap   	#1
	lea    	$C(sp),sp
	endm
tos_fwrite	macro	handle,count,buf ;d0.l=bytes written
	pea    	\3
	move.l 	\2,-(sp)
	move.w 	\1,-(sp)
	move.w 	#64,-(sp)
	trap   	#1
	lea    	$C(sp),sp
	endm
tos_fwritem	macro	handle,count,buf ;d0.l=bytes written
	move.l    	\3,-(sp)
	move.l 	\2,-(sp)
	move.w 	\1,-(sp)
	move.w 	#64,-(sp)
	trap   	#1
	lea    	$C(sp),sp
	endm
tos_fattrib macro	filename,wflag,attrib
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	pea	\1
	move.w	#67,-(sp)
	trap	#1
	lea	$a(sp),sp
	endm
tos_fattribm macro	filename,wflag,attrib
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#67,-(sp)
	trap	#1
	lea	$a(sp),sp
	endm
tos_fforce	macro	stdh,nonstdh
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#70,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_fseek	macro	offset,handle,seekmode	;d0.l=newpos; mode=0:start;1:cur;2:end
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#66,-(sp)
	trap	#1
	lea	$a(sp),sp
	endm
tos_fclose	macro	handle
	move.w	\1,-(sp)
	move.w	#62,-(sp)
	trap	#1
	addq.l	#4,sp
	endm
tos_drvmap	macro
	move.w	#$a,-(sp)
	trap	#13
	addq.l	#2,sp
	endm
tos_dgetdrv macro
	move.w	#25,-(sp)
	trap	#1
	addq.l	#2,sp
	endm
tos_dgetdrive macro
	move.w	#25,-(sp)
	trap	#1
	addq.l	#2,sp
	endm
tos_dsetdrv	macro	drive
	move.w	\1,-(sp)
	move.w	#14,-(sp)
	trap	#1
	addq.l	#4,sp
	endm
tos_dgetpath macro	pathptr,drive
	move.w	\2,-(sp)
	pea	\1
	move.w	#71,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_dsetpath macro	path
	pea	\1
	move.w	#59,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_dsetpathm macro	path
	move.l	\1,-(sp)
	move.w	#59,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_dpathconf macro	fname,mode
	move.w	\2,-(sp)
	pea	\1
	move.w	#292,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_fsfirst	macro	name,attr
	move.w	\2,-(sp)
	pea	\1
	move.w	#78,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_fsfirstm macro	name,attr
	move.w	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#78,-(sp)
	trap	#1
	addq.l	#8,sp
	endm
tos_fsnext	macro
	move.w	#79,-(sp)
	trap	#1
	addq.l	#2,sp
	endm
tos_fgetdta	macro	;d0.l=dtaptr
	move.w	#47,-(sp)
	trap	#1
	addq.l	#2,sp
	endm
tos_fsetdta	macro	buf
	pea	\1
	move.w	#26,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_fsetdtam macro	buf
	move.l	\1,-(sp)
	move.w	#26,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_floprd	macro	buf,devno,sectno,trackno,sideno,count
	move.w	\6,-(sp)
	move.w	\5,-(sp)
	move.w	\4,-(sp)
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	clr.l	-(sp)
	pea	\1
	move.w	#8,-(sp)
	trap	#14
	lea	$14(sp),sp
	endm
tos_floprdm	macro	buf,devno,sectno,trackno,sideno,count
	move.w	\6,-(sp)
	move.w	\5,-(sp)
	move.w	\4,-(sp)
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	clr.l	-(sp)
	move.l	\1,-(sp)
	move.w	#8,-(sp)
	trap	#14
	lea	$14(sp),sp
	endm
tos_keytbl	macro	unshift,shift,capslock
	move.l	\3,-(sp)
	move.l	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#16,-(sp)
	trap	#14
	lea	$e(sp),sp
	endm
tos_dlock	macro	mode,drv
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#309,-(sp)
	trap	#1
	addq.l	#6,sp
	endm
tos_jdisint macro	int
	move.w	\1,-(sp)
	move.w	#26,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
tos_jenabint macro	int
	move.w	\1,-(sp)
	move.w	#27,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
tos_xbtimer macro	timer,control,data,vector
	pea	\4
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#31,-(sp)
	trap	#14
	lea	$c(sp),sp
	endm
tos_ct60_cache	macro	cacheon
	move.w	\1,-(sp)
	move.w	#$c60c,-(sp)
	trap	#14
	addq.l	#4,sp
	endm
m_writeln	macro	string
	movem.l	a0-a6/d0-d7,-(sp)
	pea	.\@s
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
	movem.l	(sp)+,a0-a6/d0-d7
	bra	.\@x
.\@s	dc.b	\1,$d,$a,0
.\@x	even
	endm
m_write	macro	string
	pea	.\@s
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
	bra	.\@x
.\@s	dc.b	\1,0
.\@x	even
	endm
m_writehd	macro	hexd
	move.l	\1,d0
	move.w	#7,d2
	lea	.\@s+1,a0
	lea	hexstring,a1
.\@lp
	rol.l	#4,d0
	move.w	d0,d1
	and.w	#$f,d1
	move.b	(a1,d1),(a0)+
	dbra	d2,.\@lp

	pea	.\@s
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
	bra	.\@x
.\@s	dc.b	'$######## ',0
.\@x	even
	endm
m_hostcmd	macro	\1
	move.b	#$80+(\1>>1),$ffffa201.w
.\@lp	tst.b	$ffffa201.w
	bmi.s	.\@lp
	endm
m_waithrx	macro
.\@lp	btst.b	#0,$ffffa202.w
	beq.s	.\@lp
	endm
m_waithtx	macro
.\@lp	btst.b	#1,$ffffa202.w
	beq.s	.\@lp
	endm
m_writehost	macro	\1
	m_waithtx
	move.l	\1,io_dsp_hostport
	endm
m_readhost	macro	\1
	m_waithrx
	move.l	io_dsp_hostport,\1
	endm
m_loadfile	macro	\1,\2,\3	;nameptr,size,buf
	tos_fopen	\1,#0
	move.l	d0,-(sp)
	tos_fread 	d0,\2,\3
	move.l	(sp)+,d0
	tos_fclose 	d0
	endm
m_setscrptrfd0 macro
	ror.w	#8,d0
	move.l	d0,$ffff8200.w
	ror.w	#8,d0
	move.b	d0,$ffff820d.w
	endm
m_setscrptrf macro reg
	ror.w	#8,\1
	move.l	\1,$ffff8200.w
	ror.w	#8,\1
	move.b	\1,$ffff820d.w
	endm
m_setscrptr macro reg
	ror.w	#8,\1
	move.l	\1,$ffff8200.w
	endm
m_strcpy	macro	src dst
.\@c	move.b 	(\1)+,(\2)+
	bne	.\@c
	lea	-1(a1),a1
	endm
m_hexstring	macro
hexstring	dc.b	'0123456789ABCDEF'
	endm
tos_init	macro
	tos_mshrinkinit
	endm
tos_halt	macro
	tos_pterm0
	endm
hcall	macro 	string
	pea	\1
	move.w 	#255,-(sp)
	trap   	#14          ; Call XBIOS
	addq.l 	#6,sp        ; Correct stack
	endm
m_pusha	macro
	movem.l	d0-d7/a0-a6,-(sp)
	endm
m_popa	macro
	movem.l	(sp)+,d0-d7/a0-a6
	endm
m_intsoff	macro
	move.w	#$2700,sr
	endm
m_intson	macro
	move.w	#$2300,sr
	endm
m_hblon	macro
	move.w	#$2100,sr
	endm
m_hblwait	macro
	stop	#$2100
	endm
m_strobehi	macro
	move.l	#$0e002700,$ffff8800.w
	endm
m_strobelo	macro
	move.l	#$0e000700,$ffff8800.w
	endm
m_waitscreen macro
.sync\@:	move.b	$ffff8209.w,d0
	beq.s	.sync\@
	not.b	d0
	lsl.b	d0,d0
	endm
m_waitrbordraw	macro
	move.b	$fffffa21.w,d0
.wait\@:	cmp.b	$fffffa21.w,d0	;wait for right border
	beq.s	.wait\@
	endm
m_waitrbordnop	macro
	m_waitrbordraw
	dcb.w	10,$4e71
	endm
m_loadpalfast	macro	pal
  	move.l	a0,-(sp)
  	move.l	a1,-(sp)
	lea	\1,a0
	lea	$ffff8240.w,a1
	rept	8
	move.l	(a0)+,(a1)+
	endr
	move.l	(sp)+,a1
	move.l	(sp)+,a0
	endm
	
m_bswap	macro	register
	rol.w	#8,\1
	swap	\1
	rol.w	#8,\1
	endm
	endif
		list
; vim:ts=12:syntax=asmremark:

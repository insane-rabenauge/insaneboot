SRC=autoexec.s
PRG=$(SRC:.s=.prg)
PCF=auto_cf.prg
LST=$(SRC:.s=.lst)
LCF=$(PCF:.prg=.lst)

.PHONY:	all
all:	$(SRC)
	vasmm68k_mot $(SRC) -opt-allbra -nosym -Ftos -L $(LST) -o $(PRG)

.PHONY:	cf
cf:	$(SRC)
	vasmm68k_mot -mcf5474 $(SRC) -opt-allbra -nosym -D__mcoldfire__ -Ftos -L $(LCF) -o $(PCF)
	#vasmm68k_mot $(SRC) -opt-allbra -nosym -D__mcoldfire__ -Ftos -L $(LCF) -o $(PCF)

.PHONY: run
run:
	hatari $(PRG)

.PHONY: release
release:
	date +" dc.b \"%Y%m%d\"" > release.inc

.PHONY: zip
zip:
	-rm autoexec.zip
	-zip autoexec.zip autoexec.cfg autoexec.prg README.md auto_cf.prg

.PHONY:	backup
backup:
	find . -maxdepth 1 -type f -print0 | tar cfz `date +old/v%Y%m%d%H%M.tar.gz` --null -T -

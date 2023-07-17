SRC=autoexec.s
PRG=$(SRC:.s=.prg)
LST=$(SRC:.s=.lst)

.PHONY:	all
all:	$(SRC)
	vasm $(SRC) -opt-allbra -nosym -Ftos -o $(PRG)

.PHONY: release
release:
	date +" dc.b \"%Y%m%d\"" > release.inc
	date +"build_date=%Y%m%d" >> release.inc
	date +"build_time=%H%M" >> release.inc

.PHONY:	backup
backup:
	find . -maxdepth 1 -type f -print0 | tar cfz `date +old/v%Y%m%d%H%M.tar.gz` --null -T -

##
# target [target...] : [dependent ....]
# [ command ...]
##

SHELL:=/bin/zsh

.DEFAULT_GOAL := main

all: 
	latexmk -pdf -bibtex

main-msc:
	@echo compiling msc pdf
	latexmk -pdf -bibtex main-msc.tex

main-bsc:
	@echo compiling bsc pdf
	latexmk -pdf -bibtex main-bsc.tex

main:
	@echo compiling main pdf
	latexmk -pdf -bibtex main.tex

authors:
	cat bib/*.bib | grep -v '^%%' | grep author | cut -d= -f2 | sed -e 's/ and /\n/g' | sed 's/\\textbf{//g' | sed 's/\\bf{}//g' | sed 's/{//g' | sed 's/}//g' | sed 's/,$$//g' | sed 's/^ *//g' | sed 's/ *$$//g' | perl -F, -lanE 'print("$$F[1] $$F[0]")' | sort | uniq -c | sort -rnk1,1 -rsk2,2

authors-first:
	cat bib/*.bib | grep -v '^%%' | grep author | cut -d= -f2 | sed -e 's/ and .*$$//g' | sed 's/\\textbf{//g' | sed 's/\\bf{}//g' | sed 's/{//g' | sed 's/}//g' | sed 's/,$$//g' | sed 's/^ *//g' | sed 's/ *$$//g' | perl -F, -lanE 'print("$$F[1] $$F[0]")' | sort | uniq -c | sort -rnk1,1 -rsk2,2

clean:
	@echo cleaning generated files
	latexmk -pdf -bibtex -c

cleanall:
	@echo cleaning all generated files
	latexmk -pdf -bibtex -C

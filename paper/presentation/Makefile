all: apertiumlangs.pdf
	xelatex lekcija.tex

apertiumlangs.pdf: apertiumlangs.svg
	convert apertiumlangs.svg apertiumlangs.pdf

#apertiumlangs.svg: apertiumlangs.dot
#	dot -Tsvg apertiumlangs.dot -oapertiumlangs.svg

bib: apertiumlangs.pdf
	xelatex lekcija.tex
	bibtex lekcija
	xelatex lekcija.tex
	xelatex lekcija.tex



clean: 
	rm *.aux *.log *.nav *.toc *.snm 

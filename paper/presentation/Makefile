all: apertiumlangs.pdf architecture-ap.pdf architecture-ko.pdf
	xelatex lekcija.tex

apertiumlangs.pdf: apertiumlangs.svg
	convert apertiumlangs.svg apertiumlangs.pdf

architecture-ap.pdf: architecture-ap.obj
	tgif -print -eps architecture-ap.obj
	epstopdf architecture-ap.eps

architecture-ko.pdf: architecture-ko.obj
	tgif -print -eps architecture-ko.obj
	epstopdf architecture-ko.eps



#apertiumlangs.svg: apertiumlangs.dot
#	dot -Tsvg apertiumlangs.dot -oapertiumlangs.svg

bib: apertiumlangs.pdf
	xelatex lekcija.tex
	bibtex lekcija
	xelatex lekcija.tex
	xelatex lekcija.tex



clean: 
	rm *.aux *.log *.nav *.toc *.snm 

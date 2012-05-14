all: apertiumlangs.pdf
	xelatex lekcija.tex

apertiumlangs.pdf: apertiumlangs.svg
	convert apertiumlangs.svg apertiumlangs.pdf

#apertiumlangs.svg: apertiumlangs.dot
#	dot -Tsvg apertiumlangs.dot -oapertiumlangs.svg


clean: 
	rm *.aux *.log *.nav *.toc *.snm 

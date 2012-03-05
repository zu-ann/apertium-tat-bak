all: architecture.pdf
	xelatex -papersize a4 tt-ba.tex
	bibtex tt-ba
	xelatex -papersize a4 tt-ba.tex
	xelatex -papersize a4 tt-ba.tex

architecture.pdf: architecture.obj
	tgif -print -eps architecture.obj
	epstopdf architecture.eps


clean:
	rm -rf tt-ba.aux tt-ba.bbl tt-ba.blg tt-ba.log tt-ba.pdf

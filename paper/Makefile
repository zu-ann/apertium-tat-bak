all:
	xelatex -papersize a4 tt-ba.tex
	bibtex tt-ba
	xelatex -papersize a4 tt-ba.tex
	xelatex -papersize a4 tt-ba.tex

clean:
	rm -rf tt-ba.aux tt-ba.bbl tt-ba.blg tt-ba.log tt-ba.pdf

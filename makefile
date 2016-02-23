TEX=pdflatex
GLO=makeglossaries
BIB=biber
ETEX=etex

all: generate_dates preamble 
	latexmk -pdf -r .latexmkrc main

preamble:
	$(TEX) -ini -shell-escape -interaction=nonstopmode -jobname="preamble" "&pdflatex" mylatexformat.ltx """main.tex"""

main: generate_dates
	$(TEX) -synctex=1 -interaction=nonstopmode -halt-on-error -shell-escape main.tex

protocols:
	cd content/projektmanagement/sitzungsprotokolle/ && \
	find . -name "protokoll-*.tex" -exec $(TEX) -interaction=nonstopmode -halt-on-error -shell-escape {} \;

no-output:
	$(TEX) -draftmode -interaction=nonstopmode -halt-on-error -shell-escape main.tex

glo:
	$(GLO) main

bib:
	$(BIB) main

clean:
	rm -rf main.pdf _minted-* *.aux *.bbl *.bcf *.blg *.decisions *.fdb_latexmk *.fls *.fmt *.glg *.glo *.gls *.ist *.listing *.lof *.log *.lot *.minted *.mw *.out *.pseudocode *.run.xml *.sta *.synctex.gz *.toc

generate_dates:
	echo "running date generation"; \
	./create_change_date.sh > version_time.tex; \
	git log --oneline | wc -l > version.tex; \
	git rev-parse HEAD > version_hash.tex

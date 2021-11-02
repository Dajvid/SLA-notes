PROJ=notes

pdf:
	latex $(PROJ).tex
	if grep "\\citation" ./bin/$(*F).aux > /dev/null; then   if bibtex -terse ./bin/$(*F).aux; then     echo "bibtex:  OK"; else echo "bibtex:  Failed";   fi; fi
	latex $(PROJ).tex
	latex $(PROJ).tex
	dvips $(PROJ).dvi
	ps2pdf -sPAPERSIZE=a4 $(PROJ).ps

clean:
	rm -f *.dvi *.log $(PROJ).blg $(PROJ).bbl $(PROJ).toc *.aux $(PROJ).out $(PROJ).lof $(PROJ).ptc $(PROJ).fdb_latexmk $(PROJ).fls $(PROJ).synctex.gz
	rm -f $(PROJ).pdf
	rm -f *~

vlna:
	vlna -l $(PROJ)-*.tex

normostrany:
	echo "scale=2; `detex -n $(PROJ).tex | sed s/"^ *"/""/ | sed s/"^	*"/""/ | wc -c`/1800;" | bc
.PHONY: all clean wordcount

LATEX    :=$(wildcard *.tex)
PDF      :=$(patsubst %.tex,%.pdf, $(LATEX))
MARKDOWN :=$(patsubst %.tex,%.markdown,  $(LATEX))
PNG      :=$(patsubst %.pdf,%.png, $(PDF))
ZIP      :=simple.zip

all : $(PNG) $(PDF) $(MARKDOWN)
	xsel -b < post.md

%.pdf : %.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<

%.markdown : %.tex
	sed 's/^/    /' $< > $@

%.png : %.pdf
	convert -density 300 $< -quality 90 -flatten $@

$(ZIP) : Makefile $(LATEX) .gitignore
	zip $@ $^

wordcount : $(LATEX)
	texcount $(LATEX)

clean :
	latexmk -C
	rm -f -- $(ZIP) $(PNG) $(MARKDOWN) example.dat

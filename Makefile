.PHONY: all clean wordcount

LATEX    :=$(wildcard *.tex)
PDF      :=$(patsubst %.tex,%.pdf, $(LATEX))
DAT      :=$(patsubst %.tex,%.dat, $(LATEX))
MARKDOWN :=$(patsubst %.tex,%.markdown,  $(LATEX))
PNG      :=$(patsubst %.pdf,%.png, $(PDF))
MOREPNG  :=example-2-red.png composite.png comparison.png
ZIP      :=simple.zip

all : $(PNG) $(MOREPNG) $(PDF) $(MARKDOWN)
	xsel -b < post.md

%.pdf : %.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<

%.markdown : %.tex
	sed 's/^/    /' $< > $@

%.png : %.pdf
	convert -transparent white -density 300 $< -quality 90 $@

example-2-red.png : example-2.png Makefile
	convert $< -fuzz '50%' -fill red -opaque black $@

.PHONY : composite.png
composite.png : example-1.png example-2-red.png
	convert -composite $^ $@

comparison.png : composite.png Makefile
	convert -background white -alpha remove $< $@

$(ZIP) : Makefile $(LATEX) .gitignore
	zip $@ $^

wordcount : $(LATEX)
	texcount $(LATEX)

clean :
	latexmk -C
	rm -f -- $(ZIP) $(PNG) $(MOREPNG) $(MARKDOWN) $(DAT)

PY=python
#PANDOC=$(BASEDIR)/../bin/pandoc
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/sections
MAINMATTER=$(INPUTDIR)/mainmatter
FRONTMATTER=$(INPUTDIR)/frontmatter
BACKMATTER=$(INPUTDIR)/backmatter
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(BASEDIR)/templates
STYLEDIR=$(BASEDIR)
HEADERDIR=$(BASEDIR)/header

BIBFILE=$(BASEDIR)/thesis.bib

MKDIR_P = mkdir -p

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        generate a web version             '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make docx	                       generate a Docx file 			  '
	@echo '   make tex	                       generate a Latex file 			  '
	@echo '                                                                       '
	@echo ' 																	  '
	@echo ' 																	  '
	@echo 'get local templates with: $(PANDOC) -D latex/html/etc	  				  '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates		  '

dirs: 
	${MKDIR_P} ${OUTPUTDIR}

pdf: dirs
	$(PANDOC) "$(MAINMATTER)"/*.md "$(BASEDIR)"/*.yaml \
	-F pandoc-crossref \
	-F pandoc-citeproc \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--template="$(TEMPLATEDIR)/template.tex" \
	--highlight-style pygments \
	--latex-engine=xelatex \
	-N

tex: dirs
	$(PANDOC) "$(MAINMATTER)"/*.md  "$(BASEDIR)"/*.yaml \
	-o "$(OUTPUTDIR)/thesis.tex" \
	--bibliography="$(BIBFILE)" \
	-N \
	--latex-engine=xelatex 

docx: dirs
	$(PANDOC) "$(MAINMATTER)"/*.md "$(INPUTDIR)"/*.yaml \
	-F pandoc-crossref \
	-F pandoc-citeproc \
	-o "$(OUTPUTDIR)/thesis.docx" \
	-H "$(HEADERDIR)/header.tex" \
	-B "$(FRONTMATTER)"/*.md \
	-A "$(BACKMATTER)"/*.md \
	--bibliography="$(BIBFILE)" \
	--toc

html: dirs
	$(PANDOC) "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.html" \
	--standalone \
	--template="$(STYLEDIR)/template.html" \
	--bibliography="$(BIBFILE)" \
	--csl="$(STYLEDIR)/ref_format.csl" \
	--include-in-header="$(STYLEDIR)/style.css" \
	--toc \
	--number-sections
	rm -rf "$(OUTPUTDIR)/source"
	mkdir "$(OUTPUTDIR)/source"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)/source/figures"

.PHONY: help pdf docx html tex dirs

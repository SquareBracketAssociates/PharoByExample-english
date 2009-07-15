
# $Id: Makefile 14612 2007-12-22 18:31:43Z oscar $
# --------------------------------------------------------------------------------
# NB: There is no separate rule for running bibtex, though perhaps there should be.
# The idea is that there should be only very few references, so bibtex can be run
# manually.  The generated .bbl file should be part of the subversion repository,
# so it will always be up-to-date, and bibtex should not need to be run unless
# new references are added.
# The source bib file is in a separate repository, as described in the README file.
# --------------------------------------------------------------------------------

# export TEXINPUTS:=.:local
export TEXINPUTS:=./local//:../local//:

EG1 = Preface QuickTour FirstApp Syntax Messages \
	Model Environment SUnit BasicClasses Collections Streams Morphic \
	Metaclasses

EG2 = Seaside

PDFLATEX = pdflatex -file-line-error

# TO-DO: add rules for BOOK1?

BOOK1=PBE1
BOOK2=PBE2
OMNIBUS=PBE-Omnibus

# --------------------------------------------------------------------------------
all : OMNIBUS

# NB: be sure to use texlive and to set the TEXINPUTS variable accordingly
# See README.txt

OMNIBUS : clean examples examples2
	time ${PDFLATEX} ${OMNIBUS}
	time ${PDFLATEX} ${OMNIBUS} | tee warnings.txt
	# Filter out blank lines and bogus warnings
	perl -pi \
		-e '$$/ = "";' \
		-e 's/[\n\r]+/\n/g;' \
		-e 's/LaTeX Warning: Label `\w*:defaultlabel'\'' multiply defined.[\n\r]*//g;' \
		-e 's/Package wrapfig Warning: wrapfigure used inside a conflicting environment[\n\r]*//g;' \
		warnings.txt

BOOK1 : clean examples
	time ${PDFLATEX} ${BOOK1}
	time ${PDFLATEX} ${BOOK1} | tee warnings.txt
	# Filter out blank lines and bogus warnings
	perl -pi \
		-e '$$/ = "";' \
		-e 's/[\n\r]+/\n/g;' \
		-e 's/LaTeX Warning: Label `\w*:defaultlabel'\'' multiply defined.[\n\r]*//g;' \
		-e 's/Package wrapfig Warning: wrapfigure used inside a conflicting environment[\n\r]*//g;' \
		warnings.txt

BOOK2 : clean examples2
	time ${PDFLATEX} ${BOOK2}
	time ${PDFLATEX} ${BOOK2} | tee warnings.txt
	# Filter out blank lines and bogus warnings
	perl -pi \
		-e '$$/ = "";' \
		-e 's/[\n\r]+/\n/g;' \
		-e 's/LaTeX Warning: Label `\w*:defaultlabel'\'' multiply defined.[\n\r]*//g;' \
		-e 's/Package wrapfig Warning: wrapfigure used inside a conflicting environment[\n\r]*//g;' \
		warnings.txt



# We need a makefile rule to generate the index as well ...
index :
	makeindex ${OMNIBUS}

complete : OMNIBUS index
	time ${PDFLATEX} ${OMNIBUS}

examples :
	./examples.rb ${EG1} > ../$@.txt

examples2 :
	./examples.rb ${EG2} > ../$@.txt

fun :
	time ./examples.rb $C > $@1.txt
	# Requires Gnu Smalltalk 2.95c with scripting support:
	time ./examples.st $C > $@2.txt
	-diff $@1.txt $@2.txt

# --------------------------------------------------------------------------------
# MAINTENANCE

graffleDirs :
	find . -name \*.graffle -type d

# To do items are tags that look like this "%:===> ...."
todo :
	fgrep '%:=' *.tex */*.tex

# report tex files missing HISTORY
history :
	find . -name \*.tex | \
	xargs fgrep -L HISTORY

# Adapt this rule to find anything (such as duplicate labels)
find :
	find . -name \*.tex | \
	xargs egrep '\\atsign'

# Search for any figure files with non-unique names
duplicates :
	ls figures */figures | sort | uniq -d

# look for bad usages of see index (with ! in second arg)
badsee :
	find . -name \*.tex | \
	xargs egrep '\\seeindex\{.*}{.*!.*}'

badindex :
	find . -name \*.tex | \
	xargs egrep '\\index\{.*}{'

# Check for duplicate labels
checkLabels :
	find . -name \*.tex | \
	xargs perl -p -e 's/\%.*//;' | \
	fgrep '\label' | \
	perl -p -e 's/.*\\label{([^}]*)}.*/$$1/;' | \
	sort | uniq -d

# Count deprecated stuff:
deprecated :
	# @ echo "OLDscript:"
	# @find . -name \*.tex | xargs fgrep '{OLDscript}' | sed 's/:.*//' | sort | uniq -c
	@ echo "doublebox:"
	@find . -name \*.tex | xargs fgrep 'doublebox' | sed 's/:.*//' | sort | uniq -c

munge :
	find . -name \*.tex | \
	xargs perl -pi \
	-e 's/{Chapter summary}/{Chapter Summary}/g;'

keys :
	find . -name \*.tex -or -name \*.txt | \
	xargs svn propset svn:keywords "Date Author Id Log"

# Fix the mime types of all pdf files
ps :
	find . -name \*.pdf | \
	xargs svn ps svn:mime-type application/octet-stream

# --------------------------------------------------------------------------------
clean :
	-rm -f *.aux *.log *.out *.glo *.toc *.ilg *.blg *.idx
	-rm -f */*.aux */*.log */*.out
	-rm -f .DS_Store */.DS_Store
	-rm -f common*.url common*.pdf SBE.url
	-rm -f test.*

bare : clean
	mv figures/squeak-logo.pdf figures/squeak-logo.pdfSAVE
	-rm -f ${BOOK2}.pdf */*.pdf
	mv figures/squeak-logo.pdfSAVE figures/squeak-logo.pdf

# --------------------------------------------------------------------------------

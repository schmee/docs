#
# Makefile for the Vim documentation on Unix
#
# If you get "don't know how to make scratch", first run make in the source
# directory.  Or remove the include below.

AWK = awk

# Set to $(VIMTARGET) when executed from src/Makefile.
VIMEXE = vim

DOCS = \
	arabic.txt \
	autocmd.txt \
	change.txt \
	cmdline.txt \
	debug.txt \
	debugger.txt \
	develop.txt \
	diff.txt \
	digraph.txt \
	editing.txt \
	eval.txt \
	farsi.txt \
	filetype.txt \
	fold.txt \
	ft_ada.txt \
	ft_sql.txt \
	hebrew.txt \
	help.txt \
	helphelp.txt \
	howto.txt \
	indent.txt \
	index.txt \
	insert.txt \
	intro.txt \
	map.txt \
	mbyte.txt \
	message.txt \
	mlang.txt \
	motion.txt \
	options.txt \
	os_unix.txt \
	pattern.txt \
	print.txt \
	quickfix.txt \
	quickref.txt \
	recover.txt \
	remote.txt \
	repeat.txt \
	rileft.txt \
	russian.txt \
	scroll.txt \
	sign.txt \
	spell.txt \
	starting.txt \
	syntax.txt \
	tabpage.txt \
	tagsrch.txt \
	term.txt \
	tips.txt \
	todo.txt \
	uganda.txt \
	undo.txt \
	usr_01.txt \
	usr_02.txt \
	usr_03.txt \
	usr_04.txt \
	usr_05.txt \
	usr_06.txt \
	usr_07.txt \
	usr_08.txt \
	usr_09.txt \
	usr_10.txt \
	usr_11.txt \
	usr_12.txt \
	usr_20.txt \
	usr_21.txt \
	usr_22.txt \
	usr_23.txt \
	usr_24.txt \
	usr_25.txt \
	usr_26.txt \
	usr_27.txt \
	usr_28.txt \
	usr_29.txt \
	usr_30.txt \
	usr_31.txt \
	usr_32.txt \
	usr_40.txt \
	usr_41.txt \
	usr_42.txt \
	usr_43.txt \
	usr_44.txt \
	usr_45.txt \
	usr_90.txt \
	usr_toc.txt \
	various.txt \
	visual.txt \
	windows.txt \

HTMLS = \
	arabic.html \
	autocmd.html \
	change.html \
	cmdline.html \
	debug.html \
	debugger.html \
	develop.html \
	diff.html \
	digraph.html \
	editing.html \
	eval.html \
	farsi.html \
	filetype.html \
	fold.html \
	ft_ada.html \
	ft_sql.html \
	hebrew.html \
	helphelp.html \
	howto.html \
	indent.html \
	index.html \
	insert.html \
	intro.html \
	map.html \
	mbyte.html \
	message.html \
	mlang.html \
	motion.html \
	options.html \
	os_unix.html \
	pattern.html \
	print.html \
	quickfix.html \
	quickref.html \
	quotes.html \
	recover.html \
	remote.html \
	repeat.html \
	rileft.html \
	russian.html \
	scroll.html \
	sign.html \
	spell.html \
	sponsor.html \
	starting.html \
	syntax.html \
	tabpage.html \
	tags.html \
	tagsrch.html \
	term.html \
	tips.html \
	todo.html \
	uganda.html \
	undo.html \
	usr_01.html \
	usr_02.html \
	usr_03.html \
	usr_04.html \
	usr_05.html \
	usr_06.html \
	usr_07.html \
	usr_08.html \
	usr_09.html \
	usr_10.html \
	usr_11.html \
	usr_12.html \
	usr_20.html \
	usr_21.html \
	usr_22.html \
	usr_23.html \
	usr_24.html \
	usr_25.html \
	usr_26.html \
	usr_27.html \
	usr_28.html \
	usr_29.html \
	usr_30.html \
	usr_31.html \
	usr_32.html \
	usr_40.html \
	usr_41.html \
	usr_42.html \
	usr_43.html \
	usr_44.html \
	usr_45.html \
	usr_90.html \
	usr_toc.html \
	various.html \
	vimindex.html \
	visual.html \
	windows.html \

CONVERTED = \
	vim-fr.UTF-8.1 \
	evim-fr.UTF-8.1 \
	vimdiff-fr.UTF-8.1 \
	vimtutor-fr.UTF-8.1 \
	vim-it.UTF-8.1 \
	evim-it.UTF-8.1 \
	vimdiff-it.UTF-8.1 \
	vimtutor-it.UTF-8.1 \
	vim-pl.UTF-8.1 \
	evim-pl.UTF-8.1 \
	vimdiff-pl.UTF-8.1 \
	vimtutor-pl.UTF-8.1 \
	vim-ru.UTF-8.1 \
	evim-ru.UTF-8.1 \
	vimdiff-ru.UTF-8.1 \
	vimtutor-ru.UTF-8.1 \

.SUFFIXES:
.SUFFIXES: .c .o .txt .html

all: tags vim.man evim.man vimdiff.man vimtutor.man $(CONVERTED)

# Use Vim to generate the tags file.  Can only be used when Vim has been
# compiled and installed.  Supports multiple languages.
vimtags: $(DOCS)
	$(VIMEXE) -u NONE -esX -c "helptags ++t ." -c quit

# Use "doctags" to generate the tags file.  Only works for English!
tags: doctags $(DOCS)
	./doctags $(DOCS) | LANG=C LC_ALL=C sort >tags
	uniq -d -2 tags

doctags: doctags.c
	$(CC) doctags.c -o doctags

vim.man: vim.1
	nroff -man vim.1 | sed -e s/.//g > vim.man

evim.man: evim.1
	nroff -man evim.1 | sed -e s/.//g > evim.man

vimdiff.man: vimdiff.1
	nroff -man vimdiff.1 | sed -e s/.//g > vimdiff.man

vimtutor.man: vimtutor.1
	nroff -man vimtutor.1 | sed -e s/.//g > vimtutor.man

uganda.nsis.txt: uganda.txt
	sed -e 's/[ 	]*\*[-a-zA-Z0-9.]*\*//g' -e 's/vim:tw=78://' \
		uganda.txt | uniq >uganda.nsis.txt

# Awk version of .txt to .html conversion.
html: noerrors tags $(HTMLS)
	@if test -f errors.log; then more errors.log; fi

noerrors:
	-rm -f errors.log

$(HTMLS): tags.ref

.txt.html:
	$(AWK) -f makehtml.awk $< >$@

# index.html is the starting point for HTML, but for the help files it is
# help.txt.  Therefore use vimindex.html for index.txt.
index.html: help.txt
	$(AWK) -f makehtml.awk help.txt >index.html

vimindex.html: index.txt
	$(AWK) -f makehtml.awk index.txt >vimindex.html

tags.ref tags.html: tags
	$(AWK) -f maketags.awk tags >tags.html

# Perl version of .txt to .html conversion.
# There can't be two rules to produce a .html from a .txt file.
# Just run over all .txt files each time one changes.  It's fast anyway.
perlhtml: tags $(DOCS)
	./vim2html.pl tags $(DOCS)

clean:
	-rm doctags *.html tags.ref

# These files are in the extra archive, skip if not present

arabic.txt:
	touch arabic.txt

farsi.txt:
	touch farsi.txt

hebrew.txt:
	touch hebrew.txt

russian.txt:
	touch russian.txt

if_ole.txt:
	touch if_ole.txt

# Note that $< works with GNU make while $> works for BSD make.
# Is there a solution that works for both??
vim-fr.UTF-8.1: vim-fr.1
	iconv -f latin1 -t utf-8 $< >$@

evim-fr.UTF-8.1: evim-fr.1
	iconv -f latin1 -t utf-8 $< >$@

vimdiff-fr.UTF-8.1: vimdiff-fr.1
	iconv -f latin1 -t utf-8 $< >$@

vimtutor-fr.UTF-8.1: vimtutor-fr.1
	iconv -f latin1 -t utf-8 $< >$@

vim-it.UTF-8.1: vim-it.1
	iconv -f latin1 -t utf-8 $< >$@

evim-it.UTF-8.1: evim-it.1
	iconv -f latin1 -t utf-8 $< >$@

vimdiff-it.UTF-8.1: vimdiff-it.1
	iconv -f latin1 -t utf-8 $< >$@

vimtutor-it.UTF-8.1: vimtutor-it.1
	iconv -f latin1 -t utf-8 $< >$@

vim-pl.UTF-8.1: vim-pl.1
	iconv -f latin2 -t utf-8 $< >$@

evim-pl.UTF-8.1: evim-pl.1
	iconv -f latin2 -t utf-8 $< >$@

vimdiff-pl.UTF-8.1: vimdiff-pl.1
	iconv -f latin2 -t utf-8 $< >$@

vimtutor-pl.UTF-8.1: vimtutor-pl.1
	iconv -f latin2 -t utf-8 $< >$@

vim-ru.UTF-8.1: vim-ru.1
	iconv -f KOI8-R -t utf-8 $< >$@

evim-ru.UTF-8.1: evim-ru.1
	iconv -f KOI8-R -t utf-8 $< >$@

vimdiff-ru.UTF-8.1: vimdiff-ru.1
	iconv -f KOI8-R -t utf-8 $< >$@

vimtutor-ru.UTF-8.1: vimtutor-ru.1
	iconv -f KOI8-R -t utf-8 $< >$@

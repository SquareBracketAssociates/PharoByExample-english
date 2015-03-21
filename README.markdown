# Pharo by Example
**Note:** This book is currently being revised and updated for Pharo 4 at **[Updated Pharo By Example](https://github.com/SquareBracketAssociates/UpdatedPharoByExample)** ([latest PDF](https://ci.inria.fr/pharo-contribution/view/Books/job/UpdatedPharoByExample/lastSuccessfulBuild/artifact/book-result/UpdatedPharoByExample.pdf)).

*Pharo by Example (vol 1)* is a practical introduction for Pharo, a Smalltalk-inspired programming language, IDE and live coding enviroment. 

This is the original LaTeX source repository of the [Pharo by Example](http://pharobyexample.org/) book, created for Pharo 1.4, and inspired by [Squeak By Example](http://www.squeakbyexample.org/) ([source code](https://github.com/SquareBracketAssociates/SqueakByExample-english)).

## Translations
There are translations PBE for the following languages (in various stages of completeness):

* French: [PharoByExample-french](https://github.com/SquareBracketAssociates/PharoByExample-french)
* Spanish: [PharoByExample-spanish](https://github.com/SquareBracketAssociates/PharoByExample-spanish)
* Russian: [pharo-by-example-ru](https://github.com/SquareBracketAssociates/pharo-by-example-ru)
* Japanese: [PharoByExample-japanese](https://github.com/SquareBracketAssociates/PharoByExample-japanese)
* German: [PharoByExample-german](https://github.com/SquareBracketAssociates/PharoByExample-german)
* Portuguese: [PharoByExample-portuguese](https://github.com/SquareBracketAssociates/PharoByExample-portuguese)
* Korean: [PharoByExample-korean](https://github.com/SquareBracketAssociates/PharoByExample-korean)

## Deep Into Pharo (Pharo By Example vol 2)
[Deep into Pharo](http://www.deepintopharo.com/) ([source code](https://gforge.inria.fr/scm/viewvc.php/PharoByExampleTwo-Eng/?root=pharobooks)) is the second volume of a series of books covering Pharo. Whereas the first volume is intended for newcomers, this second volume covers deeper topics.

## Contributing to Pharo by Example
**Note:** This book is no longer under active development. Please consider contributing to **[Updated Pharo By Example](https://github.com/SquareBracketAssociates/UpdatedPharoByExample)**, instead.

To contribute to the book or to a translation project, please:

- subscribe to the [[sbe-discussion](https://www.iam.unibe.ch/mailman/listinfo/sbe-discussion)] mailing list;
- clone the relevant repository and contact the lead person responsible;
- if you are unsure who is in charge, ask on the list;
- publish changes to your copy of the the repo and inform the lead to pull changes.

To start a new translation project:

- announce the start of the translation effort on sbe-discussion;
- people then will react and you find others who want to help;
- we will then add a repository to [SquareBracketAssociates](http://github.com/squarebracketassociates);
- we will list it on [PharoByExample.org](http://pharobyexample.org/).

See [PBE-TO-DO.txt](PBE-TO-DO.txt) for status of tasks for PBE 1.

## Contributing to Deep Into Pharo (Pharo by Example vol 2)
The source code for Deep Into Pharo is currently managed by SVN, and can be found at the Inria Forge [Pharo By Example Two](https://gforge.inria.fr/scm/viewvc.php/PharoByExampleTwo-Eng/?root=pharobooks) repository.

To contribute to the book or to a translation project (we should finish it first), please:

- subscribe to the [[sbe-discussion](https://www.iam.unibe.ch/mailman/listinfo/sbe-discussion)] mailing list;
- [register](https://gforge.inria.fr/account/register.php) for [Inria Forge](https://gforge.inria.fr) (use RMOD as team) and send an email to `sbe-discussion` (we will add you to the PharoBooks project)
- if you are unsure who is in charge, ask on the list;
- checkout what you want: `svn co https://xxxx@scm.gforge.inria.fr/svn/pharobooks/PharoByExampleTwo-Eng`
- publish the changes and notify the list. 

See [PBE-TO-DO.txt](PBE-TO-DO.txt) for status of tasks for PBE 2.

# File structure

The main file is [PBE1.tex](PBE1.tex). Chapters are in subdirectories.
You can latex either the entire book, or each individual chapter.
Each chapter file starts and ends with the same incantation
which will optionally include macros or end the document if it is
latexed individually.

Use the `\ct{}` macro for in-line code.
Use the `{method}`, `{classdef}`, `{example}` and `{script}` environments for
multi-line code.

If you add a new chapter: 
-	please be sure to include it from PBE1.tex.
-	Remember to include its /figures/ subdirectory in the graphicspath,
	   which is set in the preamble to PBE1.tex.  Don't forget the trailing /
-	Please make sure the chapter compiles with latex both from the main book
	and as a separate chapter.  
-	Set the svn:ignore property on the chapter's directory.  The command to do
	this is `svn propset svn:ignore -F .svnignore <directory name>`

IMPORTANT: Please check out a fresh copy of the book and compile the book
to verify that you have added all the dependent files (e.g., figures).

## Makefile

To build the PDF of the book, simply run `make` in the Book folder.
Be sure you have texlive installed (see below).

## Printing

The book has been reformatted to 6"x9" (for Lulu). If you want to print any
part of the book, you will find that printing 2 up at 140% works well.


---

# Testing

Tests are automatically generated from the LaTeX sources.

Grab a recent Pharo image and move it to the folder Pharo book folder.  Do *not* use a 1-click image, since the actual image should be located at the same level as the PBE1.tex file.

To run the tests, load the package PBE-Testing from the following SqueakSource project:

	MCHttpRepository
	    location: 'http://www.squeaksource.com/PharoByExample'
	    user: ''
	    password: ''

Then evaluate the following expression in a workspace:

	PBEmain new runTests

For PBE2, instead run:

	PBE2main new runTests

This will automatically extract and run the tests in the LaTeX sources of the Pharo by Example book.  It will also load the hands-on exercises, and check that they are working. (Some tests may also be included from the dependent hands-on packages.)

This will parse (using Regex) the PBE1.tex (resp. PBE2.tex) to locate the included chapter files, parse each chapter file to search for @TEST annotations, generate test case classes for each chapter with tests in a new category PBE-GeneratedTests, and generate a test method (numbered by the line number in the chapter) for each test found.  (NB: Any old generated tests are removed before new ones are generated.) Finally, by sending "runTests", a TestRunner is opened on the new category, and all those tests are run.

## How to write tests in LaTeX

A sample test in the BasicClasses looks like this:

	=\begin{code}{@TEST}
	=a1 := { { 'harry' } } .
	=a2 := a1 shallowCopy.
	=(a1 at: 1) at: 1 put: 'sally'.
	=(a2 at: 1) at: 1 --> 'sally'
	=\end{code}

The "print it" invocation (-->) will generate an assertion.

The generated source code looks like this:

	=test204
	=	a1 := { { 'harry' } } .
	=	a2 := a1 shallowCopy.
	=	(a1 at: 1) at: 1 put: 'sally'.
	=	self assert: [ (a2 at: 1) at: 1  ] value printString = '''sally'''

You may also silently declare or initialize variables immediately after @TEST,
and you may now place comments after the test string:

	=\begin{code}{@TEST |a b|}
	=a := b := 'hello'.
	=a == b --> true "two variables but one object"
	=\end{code}

The generated testCase subclass is PBEBasicClassesTestCase.

The generated tests can be removed by evaluating "PBEmain removeOldTestCategory". This is done automatically whenever you do "PBEmain new runTests".

---

# LaTeX version

Please use at least texlive 2005.
http://www.tug.org/texlive/
If you are using TeXshop or another GUI, be sure to set the path to the tex executables.  E.g., in TeXShop>Preferences>Engine set the path to:
/usr/local/texlive/2005/bin/powerpc-darwin

For intel macs you will need texlive 2007.  The path should be
/usr/local/texlive/2007/bin/i386-darwin

## OmniGraffle files

Please be sure to use Lucida Sans, not Helvetica, or you may have problems
uploading the PDF to Lulu.  See the font embedding FAQ on lulu.com
See more detailed instructions in Cover/README.txt

## Style files

To inform latex about the location of local style files, set the following environment variable (tcsh):

	setenv TEXINPUTS ./local//:../local//:
		or (bash):
	export TEXINPUTS=./local//:../local//:

If you are using a GUI like TeXshop, you must set the environment variable in ~/.MacOSX/environment.plist :

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
		<key>TEXINPUTS</key>
		<string>./local//:../local//:</string>
	</dict>
	</plist>
 
NB: You may need to logout and login again after creating or modifying this file.
Note colon at end of TEXINPUTS that means "append current value here"
(eg local has higher priority). Double slash means search recursively.

# Bibliography

The bibliography file scg.bib is available from a separate git repository:

	git clone git@scg.unibe.ch:scgbib

Alternatively, you can check out a read-only version as follows:

	git clone git://scg.unibe.ch/scgbib

You should separately check out this file and link it in wherever it is needed.

---

# License

This work is licensed under Creative Commons Attribution-ShareAlike 3.0 Unported
	<http://creativecommons.org/licenses/by-sa/3.0/>

You are free:

- to Share -- to copy, distribute and transmit the work
- to Remix -- to adapt the work

Under the following conditions:

Attribution. You must attribute the work in the manner specified by the author or
licensor (but not in any way that suggests that they endorse you or your use of the work).
Share Alike. If you alter, transform, or build upon this work, you may distribute
the resulting work only under the same, similar or a compatible license.
For any reuse or distribution, you must make clear to others the license terms of
this work. The best way to do this is with a link to this web page.
Any of the above conditions can be waived if you get permission from the copyright holder.
Nothing in this license impairs or restricts the author's moral rights.

## Disclaimer
Your fair dealing and other rights are in no way affected by the above.
This is a human-readable summary of the Legal Code (the full license).

---
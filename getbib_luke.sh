#!/bin/bash
# Modified and annotated by Able Chow
#
# contained within [] are conditional expressions
# https://www.gnu.org/software/bash/manual/bash.html#Bash-Conditional-Expressions
[ -z "$1" ] && echo "Give either a pdf file or a DOI as an argument." && exit
# && is AND , || is OR, in other words...
# 'command1 && command2' command2 is only executed if command 1 has an exit status of zero (success)

# [-f ] if file exists and is a regular file
if [ -f "$1" ]; then
	# Try to get DOI from pdfinfo or pdftotext output.
    # grep -i, ignore case, grep -o, print only matching
	doi=$(pdfinfo "$1" | grep -io "doi:.*") ||
    # 'command 1 || command2' command 2 is only executed if command 1 has an exit status of 1 (failure)
	# doi=$(pdftotext "$1" 2>/dev/null - | sed -n '/[dD][oO][iI]:/{s/.*[dD][oO][iI]:\s*\(\S\+[[:alnum:]]\).*/\1/p;q}') ||
	exit 1
else
	doi="$1"
fi

# Check crossref.org for the bib citation.
curl -s "https://api.crossref.org/works/$doi/transform/application/x-bibtex" -w "\\n"

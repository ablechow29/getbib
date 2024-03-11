#!/bin/bash
[ -z "$1" ] && echo "Give either a pdf file or a DOI as an argument." && exit

# First, make sure filenames do not include spaces
# spaces before doi seems to be tolerated
if [ -f "$1" ]; then
	# Try to get DOI from pdfinfo or pdftotext output.
    # the || operator `man bash` `/\|\|`
    # command following || is excecuted if and only if preceding command has exit not zero
	doi=$(pdfinfo "$1" | grep -ioP "doi:\K.*") ||
    # Luke's addition
    doi=$(pdftotext "$1" 2>/dev/null - | sed -n '/[dD][oO][iI]:/{s/.*[dD][oO][iI]:\s*\(\S\+[[:alnum:]]\).*/\1/p;q}') ||
 # The pdftotext -l option limits transcribe to the first page, greatly increasing speed and preventing conversion issues, improving grep reliability
    doi=$(pdftotext -l 1 "$1" 2>/dev/null - | grep -ioP "/dx.doi.org/\K.*" -m 1) ||
    doi=$(pdftotext -l 1 "$1" 2>/dev/null - | grep -ioP "/doi.org/\K.*" -m 1) ||
    doi=$(pdftotext -l 1 "$1" 2>/dev/null - | grep -ioP "doi:\K.*" -m 1) ||
    exit 1
else
	doi="$1"
    # sometimes when grep fails to find the doi it plugs in the file name
    # sometimes grep pulls strings following the doi when the doi is not its own independent line
fi

# Test line
# echo "file name:$1 doi:$doi"

# Why does the script work for individual files but causes errors in some files when run in for loop? I think it is because of space in the filenames
# Offer ranger bulk rename solution for naming convention problems
# a bash script for removing space in names...

# Need to write this into a file and grep again to check

# Check crossref.org for the bib citation.
curl -s "https://api.crossref.org/works/$doi/transform/application/x-bibtex" -w "\\n"
# Use DOI's native reference archive
# curl -LH "Accept: text/bibliography; style=bibtex" "doi.org/$doi"

# for file in *pdf; do ~/Learn_Bash/getbib/getbibtest.sh $file >> bibliography.bib; done


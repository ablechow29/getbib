#!/bin/bash
[ -z "$1" ] && echo "Give either a pdf file or a DOI as an argument." && exit

if [ -f "$1" ]; then
	# Try to get DOI from pdfinfo or pdftotext output.
	doi=$(pdfinfo "$1" | grep -ioP "/doi.org/\K.*") ||
	doi=$(pdfinfo "$1" | grep -ioP "doi: \K.*") ||
doi=$(pdftotext "$1" 2>/dev/null - | grep -ioP "/dx.doi.org/\K.*" -m 1) ||
doi=$(pdftotext "$1" 2>/dev/null - | grep -ioP "/doi.org/\K.*" -m 1) ||
doi=$(pdftotext "$1" 2>/dev/null - | grep -ioP "doi: \K.*" -m 1) ||
doi=$(pdftotext "$1" 2>/dev/null - | grep -ioP "doi:\K.*" -m 1) ||
doi=$(pdftotext "$1" 2>/dev/null - | grep -ioP "doi \K.*" -m 1) ||
	exit 1
else
	doi="$1"
fi

# Check crossref.org for the bib citation.
#curl -s "https://api.crossref.org/works/$doi/transform/application/x-bibtex" -w "\\n"

# Use DOI's native reference archive
curl -LH "Accept: text/bibliography; style=bibtex" "doi.org/$doi"

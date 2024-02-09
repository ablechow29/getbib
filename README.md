# getbib
This is a bash script adopted from [LukeSmith](https://github.com/LukeSmithxyz)'s [personal script](https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/getbib).

The getbib script intends to take advantage of [LaTeX's bibliography management](https://en.wikibooks.org/wiki/LaTeX/Bibliography_Management) (e.g., BibTeX), which calls forward a .bib file containing all relevant bibliographic information.

Each bibliographic entry looks like this:
```
@article{greenwade93,
    author  = "George D. Greenwade",
    title   = "The {C}omprehensive {T}ex {A}rchive {N}etwork ({CTAN})",
    year    = "1993",
    journal = "TUGBoat",
    volume  = "14",
    number  = "3",
    pages   = "342--351"
}
```
I used a version of this script while writing my M.S. thesis to create my LaTeX bibliography. However, this scrip was (and still) does not reliably extract DOI strings from PDF files. 

The primary reason being:
1. DOI only being included in the PDF metadata in rare cases.
2. DOI written in different formats with different prefixes
3. DOI being written in different areas of the document

The goal is to be able to fill out bib files by running the getbib scrip in a for loop like this:
`for file in *pdf; do ~/Learn_Bash/getbib/getbibtest.sh $file >> bibliography.bib; done`
And for rare cases of DOI not being found, the script will prompt the user to enter the DOI string manually.

## Development Strategy
I am approaching this script as a long term project in which I will learn and excercise basic BASH scripting skills.

Testing strategies

### Goals
1. The script needs to reliably obtain DOI strings from PDF files, except in rare cases where the DOI is actually not present, or formatted in a strange way.
2. The script needs to echo "grep failed" when the DOI strong could not be found.
3. The script needs to integrate input for bibliography management, such as the example entry will automatically have `greenwade93` as its code name or give the user an opportunity to input.

## To Do
Add test files for different file scenarios
Explain how to manage bibliography from the command line.
Scientific writing using Vim and LaTeX.


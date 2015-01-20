# define the simplemath-filter:
SIMPLEMATH="/home/niels/pandoc/simplemath/simplemath"
PANDOC_SED="/home/niels/pandoc/align.sed"
TEMPLATE="/home/niels/pandoc/latex/template.tex"

# convert one Markdown file to pdf
md2pdf () {
  pandoc --filter=$SIMPLEMATH -s --toc -o $1:t:r.pdf $1
}

md2tex () {
  pandoc --filter=$SIMPLEMATH -t latex $1 | \
    sed 's/\[/\begin{align*}/g;s/\]/\end{align*}/g'> $1:t:r.tex
}  

# convert all Markdown files in directory to pdf
alias all2pdf="cat *.md | pandoc --filter=$SIMPLEMATH -s --toc -o script.pdf --template=$TEMPLATE "

alias all2tex="cat *.md | pandoc --filter=$SIMPLEMATH -s --toc -o script.tex  "


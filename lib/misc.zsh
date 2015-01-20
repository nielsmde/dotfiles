## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER=less
export LC_CTYPE=$LANG

## function to convert PEFs to jpg (runs on alle PEF files in a folder)

function pef2jpg() {
	for IMG in *.PEF; do
	IMGJPG=$(echo $IMG|sed "s/PEF/jpg/")
	if [[ ! -a $IMGJPG ]]; then 
		gimp -i -b "(pef2jpg \"$IMG\" \"$IMGJPG\" )" -b '(gimp-quit 0)'
	fi
	done
}


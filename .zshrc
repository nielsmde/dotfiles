export ZSH=~/.zsh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i

# conda completion
fpath+=/home/phd/.zsh/conda-zsh-completion

compinit conda
source ~/gromacs-2016/local/bin/GMXRC
if [[ -o interactive ]]; then # only do this when shell is interactive
    # anaconda3 bin directory
    export PATH=/home/phd/miniconda3/bin:$PATH

    # haskell binaries
    export PATH=/home/phd/.cabal/bin:$PATH
fi

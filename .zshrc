export ZSH=~/.zsh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i

# anaconda3 bin directory
export PATH=/home/niels/anaconda3/bin:$PATH

# haskell binaries
export PATH=/home/niels/.cabal/bin:$PATH

export PYTHONPATH=/home/niels/Masterarbeit/python_scripts:$PYTHONPATH

export ZSH=~/.zsh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i

# conda completion
fpath+=/home/niels/.zsh/lib/conda-zsh-completion

compinit conda

# anaconda3 bin directory
export PATH=/home/niels/anaconda3/bin:$PATH

# haskell binaries
export PATH=/home/niels/.cabal/bin:$PATH

export PYTHONPATH=/home/niels/Masterarbeit/python_scripts:$PYTHONPATH

# System Python Stuff
#export PYTHONPATH=/usr/lib64/python34.zip:/usr/lib64/python3.4:/usr/lib64/python3.4/plat-linux:/usr/lib64/python3.4/lib-dynload:/usr/lib64/python3.4/site-packages:/usr/lib/python3.4/site-packages:$PYTHONPATH

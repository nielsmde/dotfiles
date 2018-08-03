#if [[ -o interactive ]];then # Only define aliases when the shell is interactive...

alias ll='ls -la'
alias lh='ls -lah'
alias ...='cd ../..'

#Alias for creating LVM Snapshots
alias snapshot_root='sudo lvcreate -L 10G -s -n root_$(date +%d_%m_%G__%H_%M) /dev/fedora_ipnm/root'
alias snapshot_home='sudo lvcreate -L 10G -s -n home_$(date +%d_%m_%G__%H_%M) /dev/fedora_ipnm/home'

# commoand too increase volume above 100%
#alias volume-up='pactl set-sink-volume 1 +5%'

# backup function...
sysbackup() {
  if [ -d /run/media/niels/e7615fa0-bfea-4da6-9247-bf93bd360ba5 ]; then
	rsync -au --progress /* /run/media/niels/e7615fa0-bfea-4da6-9247-bf93bd360ba5/backup/ --exclude-from=/home/niels/rsync.excl
  else
	echo 'Backup Volume not present!'
  fi
}

update() {
    sudo dnf update
    conda update
}


module () {
	_moduleraw "$@" 2>&1
	export LD_LIBRARY_PATH="${${LD_LIBRARY_PATH}/TwentyEight/jessie}"
}



QUACK=niels@quack.fkp.physik.tu-darmstadt.de
if host linux-master.cluster &>/dev/null
then
    DOZOR=niels@linux-master.cluster
    if ! timeout 1 ssh $DOZOR echo > /dev/null
    then
        DOZOR=niels@linux-01.cluster
    fi
else
    DOZOR="-p 2222 niels@hide.fkp.physik.tu-darmstadt.de"
fi
NAS1=niels@nas1.fkp.physik.tu-darmstadt.de
NAS2=niels@nas2.fkp.physik.tu-darmstadt.de
ELEMENT=niels@element.fkp.physik.tu-darmstadt.de

alias vpnquack='sshuttle -r $QUACK 0.0.0.0/0'
alias quack='ssh -t $QUACK "cd $(pwd); bash -l"'
alias dozor='ssh $=DOZOR'

printfile() {
    if [ $# -ge 1 ]
    then
        echo "Print: $1"
        cat $1 | ssh $QUACK "lp -"
    fi
}

timeoutmsg() {
    if ! timeout $argv[2,-1]
            then
                echo "$1: Timeout"
            fi
}


sshmount() {
    HOST=$QUACK
    
    timeoutmsg 'data' 10 sshfs $HOST:/data   /data 
    timeoutmsg 'autohome' 10 sshfs $HOST:/autohome   /autohome
    timeoutmsg 'share' 10 sshfs $ELEMENT:/share     /share
    timeoutmsg 'nfsopt' 10 sshfs webapp@db.cluster:/nfsopt    /nfsopt
    date +%c>>$HOME/punch-in
}

export  MODULEPATH=/nfsopt/modulefiles:$MODULEPATH

alias sshumount='fusermount -u /data; fusermount -u /autohome; fusermount -u /nfsopt; fusermount -u /share;date +%c>>$HOME/punch-out'

alias sinfo="ssh ${DOZOR} sinfo"
alias scancel="ssh $DOZOR scancel"
alias scontrol="ssh $DOZOR scontrol"

alias squeue="ssh ${DOZOR} squeue -o '%.7i\ %.7P\ %.20j\ %.6u\ %.2t\ %.10M\ %.6D\ %.6Q\ %.8R'"

# alias sbatch='ssh $=DOZOR "cd $PWD; sbatch"'
alias srun='ssh $DOZOR "cd $PWD; srun"'

sbatch() {
    SFILE=$(realpath $1)
    if grep "#SBATCH --partition=local" $SFILE &>/dev/null
    then
        ssh $QUACK "/autohome/niels/slurm/bin/sbatch $SFILE"
    else
        ssh $=DOZOR "sbatch $2 $3 $4 $SFILE"
    fi
}

#alias queue="squeue | egrep --color '^.*niels.*|$'"
queue() {
    squeue | egrep --color '^.*niels.*|$'
    echo
    ssh $QUACK /autohome/niels/slurm/bin/squeue -o '%.7i\ %.7P\ %.20j\ %.6u\ %.2t\ %.10M\ %.6D\ %.6Q\ %.8R'
}
alias nodes="squeue -p nodes | egrep --color '^.*niels.*|$'"

#alias seval="sbatch /autohome/niels/Projects/store/analyse/run.slurm"
alias gpu-nodes="squeue -p gpu-nodes | egrep --color '^.*niels.*|$'"

biwater="/data/niels/sim/mix/biwater"
alias evallog="cat /data/niels/sim/logs/latest; ls -l /data/niels/sim/logs/latest"

seval() {
    sbatch $@ /autohome/niels/Projects/store/analyse/run.slurm
}

slurmlog() {
    cat $(scontrol show job $1 | grep StdOut | sed 's/StdOut=//')
}

slurmeval() {
    ssh ${DOZOR} sbatch /autohome/niels/Projects/run/run.slurm $(pwd)
}

# Fix for missing module file nvml/8.0.61
mkdir -p /tmp/modulefiles/nvml
echo "#%Module1.0">/tmp/modulefiles/nvml/8.0.61
export MODULEPATH=$MODULEPATH:/tmp/modulefiles
#fi # let this be the last line


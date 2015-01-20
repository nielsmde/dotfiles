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


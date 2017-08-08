

lsblk

sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
sudo mkdir -p /mnt/disks/200gb-dir
#sudo mount -o discard,defaults /dev/[DEVICE_ID] /mnt/disks/[MNT_DIR]
sudo mount -o discard,defaults /dev/sdb /mnt/disks/200gb-dir

# Mounting 300GB

sudo mkdir -p /mnt/disks/300gb-dir
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sde
sudo mount -o discard,defaults /dev/sde /mnt/disks/300gb-dir





echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdb
mkdir /var/backup
chmod -R 0777 /var/backup
mkfs -t ext4 /dev/sdb1
mount -t ext4 /dev/sdb1 /var/backup/
yum install -y mc wget
wget https://github.com/borgbackup/borg/releases/download/1.1.6/borg-linux64 -O /usr/local/bin/borg
chmod +x /usr/local/bin/borg
useradd -m borg
mkdir /home/borg/.ssh
chmod 0700 /home/borg/.ssh/
cp /vagrant/authorized_keys /home/borg/.ssh
chown borg:borg -R /home/borg
chmod 0600 /home/borg/.ssh/authorized_keys
yum install -y mc wget
wget https://github.com/borgbackup/borg/releases/download/1.1.6/borg-linux64 -O /usr/local/bin/borg
chmod +x /usr/local/bin/borg
cp /vagrant/id_rsa /root/.ssh
cp /vagrant/id_rsa.pub /root/.ssh
#borg init --encryption=repokey borg@192.168.11.101:/var/backup
#borg create --stats --list  borg@192.168.11.101:/var/backup/::"MyBackup-{now:%Y-%m-%d_%H:%M:%S}" /etc
mkdir -p /var/log/borg
cp /vagrant/backup.sh /usr/local/bin/backup.sh
chmod u+x /usr/local/bin/backup.sh
cp /vagrant/borg /etc/logrotate.d/
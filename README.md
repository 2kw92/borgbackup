# borgbackup
Дз по теме бэкапирование

В рамках дз были развернуты 2 сервера. backupserver и client.       
На оба серера была установлена утилита borg.
```wget https://github.com/borgbackup/borg/releases/download/1.1.6/borg-linux64 -O /usr/local/bin/borg```       
На серваке бэкапов был создан юзер borg:       
```useradd -m borg```      
На клиенте генерим ssh-ключ       
```ssh-keygen```       
И пробрасываем его серверу backupserver для юзера borg.       
Далее иницализируем репо на backupserver с client        
```borg init --encryption=repokey borg@192.168.11.101:/var/backup```      
Используем пароль admin, так в дальнейшем он будет использоваться в скрипте         
Далее запускаем бэкап:          
```borg create --stats --list  borg@192.168.11.101:/var/backup/::"MyBackup-{now:%Y-%m-%d_%H:%M:%S}" /etc```       
Теперь проверяем репо с backupserver:       
```borg list /var/backup```    
```
[root@backupserver backup]# borg list /var/backup
Enter passphrase for key /var/backup:
MyBackup-2020-12-29_16:08:14         Tue, 2020-12-29 16:08:23 [6e12979405166eed185ebadc70a0d75460f33a7909b2793b1da3f2ae8b403af4]
[root@backupserver backup]#
```     

Видим что все ок.          
Далее на сереврр cleint устанавливаем crontab cо скриптом (backup.sh),который описывает необходимые параметры       
описанные в требования дз. Скрипт копируется в директорию (/usr/local/bin/backup.sh) во время        
развертки так же как и файл для ротации логов borg, который копируется в директорию (/etc/logrotate.d/).      
```
crontab -e
*/5 0 * * * /usr/local/bin/backup.sh > /dev/null 2>&1
```       

Теперь чтобы проверить работоспособность, удалим файл /etc/hostname и восстановим его командой:       
```borg extract borg@192.168.11.101:/var/backup::Mybackup-2020-12-29_16:12 etc/hostname
Enter passphrase for key ssh://borg@192.168.11.101/var/backup:
```

Все успешно восстановлено
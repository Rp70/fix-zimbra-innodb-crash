# Fix Zimbra MySQL/Mariadb InnoDB Crash
This repo get commands from https://wiki.zimbra.com/wiki/Mysql_Crash_Recovery
* Date Modified: 2021-12-01
* Verified Against: Zimbra Collaboration Suite 8.5, 8.0, 7.0
* Tested on Zimbra 8.8.15_GA_4481

# Instruction
* Clone this repo
```
su - zimbra
git clone https://github.com/Rp70/fix-zimbra-innodb-crash fix-zimbra-innodb-crash
```
* Take a backup of your current database for just in case
    * eg: for BTRFS file system, a quick and readonly snapshot may be useful
    ```
    sudo btrfs sub snapshot -r /data /data/.snapshots/data-`date +%Y-%m-%d-%H%M`-before-fixing-mysql-crash
    sudo btrfs sub show /data # verify
    ```
* Enable recovery mode:
    * Edit the file /opt/zimbra/conf/my.cnf and add a line like innodb_force_recovery = 1 under the [mysqld] section (Note that it may be necessary to increase the recovery level depending on the extent of the database corruption, as shown at the end of the database dump step)
    ```
    nano /opt/zimbra/conf/my.cnf
    ```
    * Save the file and restart mysqld server
    ```
    mysql.server restart
    ```
* Backup all databases
```
cd ~/fix-zimbra-innodb-crash
./backup.all.sh
```
* Take the last chance to take a backup of `/opt/zimbra/db/data` if you didn't do it so far.
* If everything goes well, drop all existing databases
```
cd ~/fix-zimbra-innodb-crash
./drop.all.sh
```
* If everything goes well, disable recover mode
    * Remove / Comment out the innodb_force_recovery line from /opt/zimbra/conf/my.cnf
    ```
    nano /opt/zimbra/conf/my.cnf
    ```
    * Save the file and restart mysqld server
    ```
    mysql.server restart
    ```
* Then, load all dumped databases
```
cd ~/fix-zimbra-innodb-crash
./restore.all.sh
```
* Take a backup after everything works fine
    * eg: for BTRFS file system, a quick and readonly snapshot may be useful
    ```
    sudo btrfs sub snapshot -r /data /data/.snapshots/data-`date +%Y-%m-%d-%H%M`-after-fixing-mysql-crash
    sudo btrfs sub show /data # verify
    ```

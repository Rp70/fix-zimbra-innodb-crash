# Fix Zimbra MySQL/Mariadb InnoDB Crash
This repo get commands from https://wiki.zimbra.com/wiki/Mysql_Crash_Recovery
* Date Modified: 2021-12-01
* Verified Against: Zimbra Collaboration Suite 8.5, 8.0, 7.0
* Tested on Zimbra 8.8.15_GA_4481

# Instruction
* Clone this repo
```
git clone 
cd ~/sdsdsd
```
* Edit the file /opt/zimbra/conf/my.cnf and add a line like innodb_force_recovery = 1 under the [mysqld] section (Note that it may be necessary to increase the recovery level depending on the extent of the database corruption, as shown at the end of the database dump step)
* Backup all databases
```
cd ~/dsfdsf

```
* If everything goes well, drop all existing databases
```
```
* If everything goes well, disable recover mode
    * Remove the innodb_force_recovery line from /opt/zimbra/conf/my.cnf
    * Save the file and restart mysqld `mysql.server restart`
* Then, load all dumped dadtabases
```
Remove the innodb_force_recovery line from /opt/zimbra/conf/my.cnf
Save the file and restart mysqld

```


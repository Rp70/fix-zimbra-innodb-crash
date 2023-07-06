#!/usr/bin/env bash

# Remove the # below for debugging
set -e

#grep -e ^innodb_force_recovery /opt/zimbra/conf/my.cnf
RECOVER_MODE=`awk '/^innodb_force_recovery/ {print $1; exit}' /opt/zimbra/conf/my.cnf | awk -F= '{print $2}'`

if [ "$RECOVER_MODE" != "" ]; then
    echo "Please edit /opt/zimbra/conf/my.cnf, remove/comment innodb_force_recovery under section [mysqld], save file and restart mysql: mysql.server restart"
    exit
fi

source ~/bin/zmshutil ; zmsetvars

echo "Creating databases"
for db in `cat /tmp/mysql.db.list`
do
    mysql -e "create database $db character set utf8"
    echo "Created $db"
done


echo "Restoring databases"
mysql zimbra < /tmp/mysql.sql/zimbra.sql
echo -e "Updated zimbra \n"
for sql in /tmp/mysql.sql/mbox*
do
    mysql `basename $sql .sql` < $sql
    echo -e "Updated `basename $sql .sql` \n"
done
if [ -f "/tmp/mysql.sql/chat.sql" ]; then
    mysql chat < /tmp/mysql.sql/chat.sql
    echo -e "Updated chat \n"
fi


echo "Verifying the restoration"
mysql zimbra -e "select * from mailbox order by id desc limit 1"

zmcontrol start

echo "Everything done! Check the mail server!"

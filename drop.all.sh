#!/usr/bin/env bash

source ./_include.all.sh

echo "This will sleep for 9 seconds before start dropping all databases. If you want to stop it, cancel it now by pressing Ctrl + c"
sleep 9

echo "Droping all databases"
for db in `cat /tmp/mysql.db.list | grep mbox`
do
    mysql -u root --password=$mysql_root_password -e "DROP DATABASE $db"
    echo -e "Dropped $db"
done
mysql -u root --password=$mysql_root_password -e "DROP DATABASE IF EXISTS chat"
echo "Dropped chat (if exists)"
mysql -u root --password=$mysql_root_password -e "DROP DATABASE zimbra"
echo "Dropped zimbra"
rm -rf /opt/zimbra/db/data/ib*

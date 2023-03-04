#!/usr/bin/env bash

source ./_include.all.sh

echo "This will sleep for 45 seconds before start dropping all databases. If you want to stop it, cancel it now by pressing Ctrl + c"
sleep 45

echo "Droping all databases"
for db in `cat /tmp/mysql.db.list |grep mbox`
do
    mysql -u root --password=$mysql_root_password -e "drop database $db"
    echo -e "Dropped $db"
done
mysql -u root --password=$mysql_root_password -e "drop database zimbra"
echo "Dropped zimbra"
rm -rf /opt/zimbra/db/data/ib*

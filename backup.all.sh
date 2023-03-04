#!/usr/bin/env bash

source ./_include.all.sh

echo "Note: If you encounter any mysql errors while dumping the databases, start over by re-editing /opt/zimbra/conf/my.cnf, incrementing the value for innodb_force_recovery by one, and restarting mysqld. It is critical to update this incrementally - 1, 2, 3, and only if needed 4. 4 and above can cause DB corruption."
echo ""
echo "Some errors for example: mysqldump: Got error: 1932: Table mboxgroup1.imap_folder doesnt exist in engine when using LOCK TABLES"
echo "==> Increase innodb_force_recovery by 1, restart mysql and try again"

echo "Start dumping databases"
mysql --batch --skip-column-names -e "show databases" | grep -e mbox -e zimbra -e chat > /tmp/mysql.db.list
mkdir -p /tmp/mysql.sql
for db in `cat /tmp/mysql.db.list`; do
    mysqldump $db -S $mysql_socket -u root --password=$mysql_root_password > /tmp/mysql.sql/$db.sql
    echo error code $?
    echo "Dumped $db"
    sleep 10
done

echo "Check for failed dumps"
FAILED_DUMPS=`grep -L "Dump completed" /tmp/mysql.sql/*.sql`
if [ "$FAILED_DUMPS" != "" ]; then
    echo "There are some failed dumps you may need to check. Exit."
    echo -e "$FAILED_DUMPS"
    exit
fi
echo "All database dumps are good!"

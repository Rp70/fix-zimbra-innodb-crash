#!/usr/bin/env bash

# Remove the # below for debugging
set -e

#grep -e ^innodb_force_recovery /opt/zimbra/conf/my.cnf
RECOVER_MODE=`awk '/^innodb_force_recovery/ {print $1; exit}' /opt/zimbra/conf/my.cnf | awk -F= '{print $2}'`

if [ "$RECOVER_MODE" == "" ]; then
    echo "No recover mode specified! Edit the file /opt/zimbra/conf/my.cnf and add a line like innodb_force_recovery=1 under the [mysqld] section (Note that it may be necessary to increase the recovery level depending on the extent of the database corruption, as shown at the end of the database dump step)"
    echo ""
    exit
fi

source ~/bin/zmshutil ; zmsetvars

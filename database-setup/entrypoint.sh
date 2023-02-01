#!/bin/sh

set -xe

while ! ( echo "SELECT true;" |  mysql -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE")
do
  sleep 1;
  echo "wating for service '$MYSQL_HOST' to become ready"
done

echo "now adding the database"
zcat /db.sql.gz | mysql -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE" 
echo "exit code of mysql import $? done"
echo "output of current tables in database '$MYSQL_DATABASE'"
mysqldump -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE"  | grep CREATE 

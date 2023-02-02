# docker-compose setup for redmine vanilla

Run the setup via:

    docker-compose up --build

logs of run found at [docker-compose-redmine-vanilla-empty-database.html](docker-compose-redmine-vanilla-empty-database.html) (best to be downloaded and viewed in browser)

used database dump was [/database-setup/db.sql.gz](./database-setup/db.sql.gz)

output was: 
    
    
    [?2004h[alex@bobox redmine.docker-compose]$ find | grep -v .git
    [?2004l
    .
    ./docker-compose.yml
    ./database-setup
    ./database-setup/entrypoint.sh
    ./database-setup/db.sql.gz
    ./database-setup/Dockerfile
    [?2004h[alex@bobox redmine.docker-compose]$ grep -I . * database-setup/*
    [?2004l
    grep: database-setup: Is a directory
    docker-compose.yml:version: "2.4"
    docker-compose.yml:services:
    docker-compose.yml:  mysql:
    docker-compose.yml:    image: mysql:5.7.41-oracle
    docker-compose.yml:    environment:
    docker-compose.yml:      MYSQL_USER: &MYSQL_USER projectino
    docker-compose.yml:      MYSQL_HOST: &MYSQL_HOST mysql 
    docker-compose.yml:      MYSQL_PASSWORD: &MYSQL_PASSWORD 'pass'
    docker-compose.yml:      MYSQL_DATABASE: &MYSQL_DATABASE projectino
    docker-compose.yml:      MYSQL_RANDOM_ROOT_PASSWORD: "1"
    docker-compose.yml:  redmine:
    docker-compose.yml:    image: redmine
    docker-compose.yml:    depends_on:
    docker-compose.yml:      database-setup:
    docker-compose.yml:        condition: service_completed_successfully
    docker-compose.yml:    environment:
    docker-compose.yml:      REDMINE_DB_MYSQL: *MYSQL_HOST
    docker-compose.yml:      REDMINE_DB_USERNAME: *MYSQL_USER 
    docker-compose.yml:      REDMINE_DB_PASSWORD: *MYSQL_PASSWORD
    docker-compose.yml:      REDMINE_DB_DATABASE: *MYSQL_DATABASE
    docker-compose.yml:    ports:
    docker-compose.yml:      - "3001:3000"
    docker-compose.yml:  database-setup:
    docker-compose.yml:    pull_policy: build
    docker-compose.yml:    build: database-setup
    docker-compose.yml:    environment:
    docker-compose.yml:      MYSQL_USER: *MYSQL_USER
    docker-compose.yml:      MYSQL_HOST: *MYSQL_HOST 
    docker-compose.yml:      MYSQL_PASSWORD: *MYSQL_PASSWORD
    docker-compose.yml:      MYSQL_DATABASE: *MYSQL_DATABASE
    docker-compose.yml:      MYSQL_RANDOM_ROOT_PASSWORD: "1"
    docker-compose.yml:    depends_on: 
    docker-compose.yml:      - mysql
    database-setup/Dockerfile:From alpine
    database-setup/Dockerfile:RUN apk update
    database-setup/Dockerfile:RUN apk add mariadb-client
    database-setup/Dockerfile:RUN echo hallo
    database-setup/Dockerfile:COPY db.sql.gz /
    database-setup/Dockerfile:COPY entrypoint.sh /
    database-setup/Dockerfile:RUN apk add vim
    database-setup/Dockerfile:CMD cat /entrypoint.sh; sh /entrypoint.sh 
    database-setup/entrypoint.sh:#!/bin/sh
    database-setup/entrypoint.sh:set -xe
    database-setup/entrypoint.sh:while ! ( echo "SELECT true;" |  mysql -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE")
    database-setup/entrypoint.sh:do
    database-setup/entrypoint.sh:  sleep 1;
    database-setup/entrypoint.sh:  echo "wating for service '$MYSQL_HOST' to become ready"
    database-setup/entrypoint.sh:done
    database-setup/entrypoint.sh:echo "now adding the database"
    database-setup/entrypoint.sh:zcat /db.sql.gz | mysql -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE" 
    database-setup/entrypoint.sh:echo "exit code of mysql import $? done"
    database-setup/entrypoint.sh:echo "output of current tables in database '$MYSQL_DATABASE'"
    database-setup/entrypoint.sh:mysqldump -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE"  | grep CREATE 
    [?2004h[alex@bobox redmine.docker-compose]$ docer
    Creating redminedocker-compose_mysql_1 ... done
    
    Creating redminedocker-compose_database-setup_1 ... done
    
    Creating redminedocker-compose_redmine_1        ... done
    Attaching to redminedocker-compose_mysql_1, redminedocker-compose_database-setup_1, redminedocker-compose_redmine_1
    mysql_1           | 2023-02-01 23:32:30+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 5.7.41-1.el7 started.
    database-setup_1  | #!/bin/sh
    database-setup_1  | 
    database-setup_1  | set -xe
    database-setup_1  | 
    database-setup_1  | while ! ( echo "SELECT true;" |  mysql -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE")
    database-setup_1  | do
    database-setup_1  |   sleep 1;
    database-setup_1  |   echo "wating for service '$MYSQL_HOST' to become ready"
    database-setup_1  | done
    database-setup_1  | 
    database-setup_1  | echo "now adding the database"
    database-setup_1  | zcat /db.sql.gz | mysql -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE" 
    database-setup_1  | echo "exit code of mysql import $? done"
    database-setup_1  | echo "output of current tables in database '$MYSQL_DATABASE'"
    database-setup_1  | mysqldump -h "$MYSQL_HOST" -p"$MYSQL_PASSWORD" -u"$MYSQL_USER" "$MYSQL_DATABASE"  | grep CREATE 
    mysql_1           | 2023-02-01 23:32:30+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
    mysql_1           | 2023-02-01 23:32:30+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 5.7.41-1.el7 started.
    mysql_1           | 2023-02-01 23:32:31+00:00 [Note] [Entrypoint]: Initializing database files
    database-setup_1  | + echo 'SELECT true;'
    mysql_1           | 2023-02-01T23:32:31.091758Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
    mysql_1           | 2023-02-01T23:32:31.204625Z 0 [Warning] InnoDB: New log files created, LSN=45790
    mysql_1           | 2023-02-01T23:32:31.227761Z 0 [Warning] InnoDB: Creating foreign key constraint system tables.
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    mysql_1           | 2023-02-01T23:32:31.231492Z 0 [Warning] No existing UUID has been found, so we assume that this is the first time that this server has been started. Generating a new UUID: b27fa3d4-a288-11ed-a595-0242c0a8d002.
    database-setup_1  | ERROR 2002 (HY000): Can't connect to server on 'mysql' (115)
    mysql_1           | 2023-02-01T23:32:31.232329Z 0 [Warning] Gtid table is not ready to be used. Table 'mysql.gtid_executed' cannot be opened.
    mysql_1           | 2023-02-01T23:32:31.313791Z 0 [Warning] A deprecated TLS version TLSv1 is enabled. Please use TLSv1.2 or higher.
    mysql_1           | 2023-02-01T23:32:31.313802Z 0 [Warning] A deprecated TLS version TLSv1.1 is enabled. Please use TLSv1.2 or higher.
    mysql_1           | 2023-02-01T23:32:31.314084Z 0 [Warning] CA certificate ca.pem is self signed.
    mysql_1           | 2023-02-01T23:32:31.327831Z 1 [Warning] root@localhost is created with an empty password ! Please consider switching off the --initialize-insecure option.
    database-setup_1  | + sleep 1
    mysql_1           | 2023-02-01 23:32:33+00:00 [Note] [Entrypoint]: Database files initialized
    mysql_1           | 2023-02-01 23:32:33+00:00 [Note] [Entrypoint]: Starting temporary server
    database-setup_1  | + echo 'wating for service '"'"'mysql'"'"' to become ready'
    mysql_1           | 2023-02-01 23:32:33+00:00 [Note] [Entrypoint]: Waiting for server startup
    database-setup_1  | wating for service 'mysql' to become ready
    database-setup_1  | + echo 'SELECT true;'
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    mysql_1           | 2023-02-01T23:32:33.291398Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
    mysql_1           | 2023-02-01T23:32:33.292209Z 0 [Note] mysqld (mysqld 5.7.41) starting as process 125 ...
    mysql_1           | 2023-02-01T23:32:33.293942Z 0 [Note] InnoDB: PUNCH HOLE support available
    mysql_1           | 2023-02-01T23:32:33.293954Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
    mysql_1           | 2023-02-01T23:32:33.293957Z 0 [Note] InnoDB: Uses event mutexes
    mysql_1           | 2023-02-01T23:32:33.293958Z 0 [Note] InnoDB: GCC builtin __atomic_thread_fence() is used for memory barrier
    mysql_1           | 2023-02-01T23:32:33.293961Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.12
    mysql_1           | 2023-02-01T23:32:33.293964Z 0 [Note] InnoDB: Using Linux native AIO
    database-setup_1  | ERROR 2002 (HY000): Can't connect to server on 'mysql' (115)
    database-setup_1  | + sleep 1
    mysql_1           | 2023-02-01T23:32:33.294119Z 0 [Note] InnoDB: Number of pools: 1
    mysql_1           | 2023-02-01T23:32:33.294195Z 0 [Note] InnoDB: Using CPU crc32 instructions
    database-setup_1  | wating for service 'mysql' to become ready
    database-setup_1  | + echo 'wating for service '"'"'mysql'"'"' to become ready'
    mysql_1           | 2023-02-01T23:32:33.295073Z 0 [Note] InnoDB: Initializing buffer pool, total size = 128M, instances = 1, chunk size = 128M
    database-setup_1  | + echo 'SELECT true;'
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    mysql_1           | 2023-02-01T23:32:33.298834Z 0 [Note] InnoDB: Completed initialization of buffer pool
    database-setup_1  | ERROR 2002 (HY000): Can't connect to server on 'mysql' (115)
    mysql_1           | 2023-02-01T23:32:33.299914Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
    database-setup_1  | + sleep 1
    mysql_1           | 2023-02-01T23:32:33.311042Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
    database-setup_1  | wating for service 'mysql' to become ready
    mysql_1           | 2023-02-01T23:32:33.325075Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
    mysql_1           | 2023-02-01T23:32:33.325103Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
    database-setup_1  | + echo 'wating for service '"'"'mysql'"'"' to become ready'
    database-setup_1  | + echo 'SELECT true;'
    mysql_1           | 2023-02-01T23:32:33.348806Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    database-setup_1  | ERROR 2002 (HY000): Can't connect to server on 'mysql' (115)
    mysql_1           | 2023-02-01T23:32:33.349348Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
    mysql_1           | 2023-02-01T23:32:33.349354Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
    database-setup_1  | + sleep 1
    mysql_1           | 2023-02-01T23:32:33.349613Z 0 [Note] InnoDB: Waiting for purge to start
    mysql_1           | 2023-02-01T23:32:33.399894Z 0 [Note] InnoDB: 5.7.41 started; log sequence number 2762314
    mysql_1           | 2023-02-01T23:32:33.400316Z 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
    database-setup_1  | wating for service 'mysql' to become ready
    mysql_1           | 2023-02-01T23:32:33.400484Z 0 [Note] Plugin 'FEDERATED' is disabled.
    mysql_1           | 2023-02-01T23:32:33.401334Z 0 [Note] InnoDB: Buffer pool(s) load completed at 230201 23:32:33
    database-setup_1  | + echo 'wating for service '"'"'mysql'"'"' to become ready'
    mysql_1           | 2023-02-01T23:32:33.403348Z 0 [Note] Found ca.pem, server-cert.pem and server-key.pem in data directory. Trying to enable SSL support using them.
    mysql_1           | 2023-02-01T23:32:33.403355Z 0 [Note] Skipping generation of SSL certificates as certificate files are present in data directory.
    mysql_1           | 2023-02-01T23:32:33.403358Z 0 [Warning] A deprecated TLS version TLSv1 is enabled. Please use TLSv1.2 or higher.
    mysql_1           | 2023-02-01T23:32:33.403360Z 0 [Warning] A deprecated TLS version TLSv1.1 is enabled. Please use TLSv1.2 or higher.
    database-setup_1  | + echo 'SELECT true;'
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    database-setup_1  | ERROR 2002 (HY000): Can't connect to server on 'mysql' (115)
    mysql_1           | 2023-02-01T23:32:33.403729Z 0 [Warning] CA certificate ca.pem is self signed.
    mysql_1           | 2023-02-01T23:32:33.403749Z 0 [Note] Skipping generation of RSA key pair as key files are present in data directory.
    database-setup_1  | + sleep 1
    database-setup_1  | wating for service 'mysql' to become ready
    database-setup_1  | + echo 'wating for service '"'"'mysql'"'"' to become ready'
    mysql_1           | 2023-02-01T23:32:33.404963Z 0 [Warning] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
    database-setup_1  | + echo 'SELECT true;'
    mysql_1           | 2023-02-01T23:32:33.409153Z 0 [Note] Event Scheduler: Loaded 0 events
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    database-setup_1  | ERROR 2002 (HY000): Can't connect to server on 'mysql' (115)
    mysql_1           | 2023-02-01T23:32:33.409282Z 0 [Note] mysqld: ready for connections.
    mysql_1           | Version: '5.7.41'  socket: '/var/run/mysqld/mysqld.sock'  port: 0  MySQL Community Server (GPL)
    database-setup_1  | + sleep 1
    mysql_1           | 2023-02-01 23:32:34+00:00 [Note] [Entrypoint]: Temporary server started.
    database-setup_1  | + echo 'wating for service '"'"'mysql'"'"' to become ready'
    mysql_1           | '/var/lib/mysql/mysql.sock' -> '/var/run/mysqld/mysqld.sock'
    database-setup_1  | wating for service 'mysql' to become ready
    database-setup_1  | + echo 'SELECT true;'
    mysql_1           | 2023-02-01T23:32:34.156464Z 3 [Note] InnoDB: Stopping purge
    mysql_1           | 2023-02-01T23:32:34.168005Z 3 [Note] InnoDB: Resuming purge
    mysql_1           | 2023-02-01T23:32:34.168829Z 3 [Note] InnoDB: Stopping purge
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    mysql_1           | 2023-02-01T23:32:34.170386Z 3 [Note] InnoDB: Resuming purge
    mysql_1           | 2023-02-01T23:32:34.170853Z 3 [Note] InnoDB: Stopping purge
    database-setup_1  | TRUE
    mysql_1           | 2023-02-01T23:32:34.173312Z 3 [Note] InnoDB: Resuming purge
    mysql_1           | 2023-02-01T23:32:34.174259Z 3 [Note] InnoDB: Stopping purge
    database-setup_1  | 1
    mysql_1           | 2023-02-01T23:32:34.175892Z 3 [Note] InnoDB: Resuming purge
    mysql_1           | Warning: Unable to load '/usr/share/zoneinfo/iso3166.tab' as time zone. Skipping it.
    mysql_1           | Warning: Unable to load '/usr/share/zoneinfo/leapseconds' as time zone. Skipping it.
    database-setup_1  | + echo 'now adding the database'
    database-setup_1  | now adding the database
    mysql_1           | Warning: Unable to load '/usr/share/zoneinfo/tzdata.zi' as time zone. Skipping it.
    mysql_1           | Warning: Unable to load '/usr/share/zoneinfo/zone.tab' as time zone. Skipping it.
    mysql_1           | Warning: Unable to load '/usr/share/zoneinfo/zone1970.tab' as time zone. Skipping it.
    database-setup_1  | + zcat /db.sql.gz
    mysql_1           | 2023-02-01 23:32:34+00:00 [Note] [Entrypoint]: GENERATED ROOT PASSWORD: i9AgVd7YCaGRGBaQBRZx15CdapiXhKZM
    mysql_1           | 2023-02-01 23:32:34+00:00 [Note] [Entrypoint]: Creating database projectino
    database-setup_1  | + mysql -h mysql -ppass -uprojectino projectino
    database-setup_1  | exit code of mysql import 0 done
    database-setup_1  | output of current tables in database 'projectino'
    database-setup_1  | + echo 'exit code of mysql import 0 done'
    database-setup_1  | + echo 'output of current tables in database '"'"'projectino'"'"
    mysql_1           | 2023-02-01 23:32:34+00:00 [Note] [Entrypoint]: Creating user projectino
    mysql_1           | 2023-02-01 23:32:34+00:00 [Note] [Entrypoint]: Giving user projectino access to schema projectino
    database-setup_1  | + mysqldump -h mysql -ppass -uprojectino projectino
    mysql_1           | 
    mysql_1           | 2023-02-01 23:32:34+00:00 [Note] [Entrypoint]: Stopping temporary server
    database-setup_1  | + grep CREATE
    mysql_1           | 2023-02-01T23:32:34.948736Z 0 [Note] Giving 0 client threads a chance to die gracefully
    mysql_1           | 2023-02-01T23:32:34.948750Z 0 [Note] Shutting down slave threads
    mysql_1           | 2023-02-01T23:32:34.948753Z 0 [Note] Forcefully disconnecting 0 remaining clients
    mysql_1           | 2023-02-01T23:32:34.948758Z 0 [Note] Event Scheduler: Purging the queue. 0 events
    database-setup_1  | mysqldump: Error: 'Access denied; you need (at least one of) the PROCESS privilege(s) for this operation' when trying to dump tablespaces
    mysql_1           | 2023-02-01T23:32:34.948786Z 0 [Note] Binlog end
    database-setup_1  | CREATE TABLE `ar_internal_metadata` (
    mysql_1           | 2023-02-01T23:32:34.949227Z 0 [Note] Shutting down plugin 'ngram'
    mysql_1           | 2023-02-01T23:32:34.949232Z 0 [Note] Shutting down plugin 'partition'
    mysql_1           | 2023-02-01T23:32:34.949236Z 0 [Note] Shutting down plugin 'BLACKHOLE'
    mysql_1           | 2023-02-01T23:32:34.949239Z 0 [Note] Shutting down plugin 'ARCHIVE'
    mysql_1           | 2023-02-01T23:32:34.949242Z 0 [Note] Shutting down plugin 'PERFORMANCE_SCHEMA'
    database-setup_1  | CREATE TABLE `attachments` (
    database-setup_1  | CREATE TABLE `auth_sources` (
    database-setup_1  | CREATE TABLE `boards` (
    database-setup_1  | CREATE TABLE `changes` (
    database-setup_1  | CREATE TABLE `changeset_parents` (
    database-setup_1  | CREATE TABLE `changesets` (
    database-setup_1  | CREATE TABLE `changesets_issues` (
    database-setup_1  | CREATE TABLE `comments` (
    database-setup_1  | CREATE TABLE `custom_field_enumerations` (
    database-setup_1  | CREATE TABLE `custom_fields` (
    database-setup_1  | CREATE TABLE `custom_fields_projects` (
    database-setup_1  | CREATE TABLE `custom_fields_roles` (
    database-setup_1  | CREATE TABLE `custom_fields_trackers` (
    database-setup_1  | CREATE TABLE `custom_values` (
    database-setup_1  | CREATE TABLE `documents` (
    database-setup_1  | CREATE TABLE `email_addresses` (
    database-setup_1  | CREATE TABLE `enabled_modules` (
    database-setup_1  | CREATE TABLE `enumerations` (
    database-setup_1  | CREATE TABLE `groups_users` (
    database-setup_1  | CREATE TABLE `import_items` (
    database-setup_1  | CREATE TABLE `imports` (
    database-setup_1  | CREATE TABLE `issue_categories` (
    database-setup_1  | CREATE TABLE `issue_relations` (
    database-setup_1  | CREATE TABLE `issue_statuses` (
    database-setup_1  | CREATE TABLE `issues` (
    database-setup_1  | CREATE TABLE `journal_details` (
    database-setup_1  | CREATE TABLE `journals` (
    database-setup_1  | CREATE TABLE `member_roles` (
    database-setup_1  | CREATE TABLE `members` (
    database-setup_1  | CREATE TABLE `messages` (
    database-setup_1  | CREATE TABLE `news` (
    database-setup_1  | CREATE TABLE `projects` (
    database-setup_1  | CREATE TABLE `projects_trackers` (
    database-setup_1  | CREATE TABLE `queries` (
    database-setup_1  | CREATE TABLE `queries_roles` (
    database-setup_1  | CREATE TABLE `repositories` (
    database-setup_1  | CREATE TABLE `roles` (
    database-setup_1  | CREATE TABLE `roles_managed_roles` (
    database-setup_1  | CREATE TABLE `schema_migrations` (
    database-setup_1  | CREATE TABLE `settings` (
    database-setup_1  | CREATE TABLE `time_entries` (
    database-setup_1  | CREATE TABLE `tokens` (
    database-setup_1  | CREATE TABLE `trackers` (
    database-setup_1  | CREATE TABLE `user_preferences` (
    database-setup_1  | CREATE TABLE `users` (
    database-setup_1  | CREATE TABLE `versions` (
    database-setup_1  | CREATE TABLE `watchers` (
    database-setup_1  | CREATE TABLE `wiki_content_versions` (
    database-setup_1  | CREATE TABLE `wiki_contents` (
    database-setup_1  | CREATE TABLE `wiki_pages` (
    database-setup_1  | CREATE TABLE `wiki_redirects` (
    database-setup_1  | CREATE TABLE `wikis` (
    database-setup_1  | CREATE TABLE `workflows` (
    mysql_1           | 2023-02-01T23:32:34.949274Z 0 [Note] Shutting down plugin 'MRG_MYISAM'
    mysql_1           | 2023-02-01T23:32:34.949278Z 0 [Note] Shutting down plugin 'MyISAM'
    mysql_1           | 2023-02-01T23:32:34.949283Z 0 [Note] Shutting down plugin 'INNODB_SYS_VIRTUAL'
    mysql_1           | 2023-02-01T23:32:34.949286Z 0 [Note] Shutting down plugin 'INNODB_SYS_DATAFILES'
    mysql_1           | 2023-02-01T23:32:34.949288Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESPACES'
    mysql_1           | 2023-02-01T23:32:34.949290Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN_COLS'
    mysql_1           | 2023-02-01T23:32:34.949291Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN'
    mysql_1           | 2023-02-01T23:32:34.949294Z 0 [Note] Shutting down plugin 'INNODB_SYS_FIELDS'
    mysql_1           | 2023-02-01T23:32:34.949296Z 0 [Note] Shutting down plugin 'INNODB_SYS_COLUMNS'
    mysql_1           | 2023-02-01T23:32:34.949299Z 0 [Note] Shutting down plugin 'INNODB_SYS_INDEXES'
    mysql_1           | 2023-02-01T23:32:34.949301Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESTATS'
    mysql_1           | 2023-02-01T23:32:34.949302Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLES'
    mysql_1           | 2023-02-01T23:32:34.949303Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_TABLE'
    mysql_1           | 2023-02-01T23:32:34.949306Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_CACHE'
    mysql_1           | 2023-02-01T23:32:34.949307Z 0 [Note] Shutting down plugin 'INNODB_FT_CONFIG'
    mysql_1           | 2023-02-01T23:32:34.949309Z 0 [Note] Shutting down plugin 'INNODB_FT_BEING_DELETED'
    mysql_1           | 2023-02-01T23:32:34.949311Z 0 [Note] Shutting down plugin 'INNODB_FT_DELETED'
    mysql_1           | 2023-02-01T23:32:34.949313Z 0 [Note] Shutting down plugin 'INNODB_FT_DEFAULT_STOPWORD'
    redminedocker-compose_database-setup_1 exited with code 0
    mysql_1           | 2023-02-01T23:32:34.949315Z 0 [Note] Shutting down plugin 'INNODB_METRICS'
    mysql_1           | 2023-02-01T23:32:34.949318Z 0 [Note] Shutting down plugin 'INNODB_TEMP_TABLE_INFO'
    mysql_1           | 2023-02-01T23:32:34.949321Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_POOL_STATS'
    mysql_1           | 2023-02-01T23:32:34.949323Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE_LRU'
    mysql_1           | 2023-02-01T23:32:34.949325Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE'
    mysql_1           | 2023-02-01T23:32:34.949328Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX_RESET'
    mysql_1           | 2023-02-01T23:32:34.949330Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX'
    mysql_1           | 2023-02-01T23:32:34.949331Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM_RESET'
    mysql_1           | 2023-02-01T23:32:34.949333Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM'
    mysql_1           | 2023-02-01T23:32:34.949336Z 0 [Note] Shutting down plugin 'INNODB_CMP_RESET'
    mysql_1           | 2023-02-01T23:32:34.949338Z 0 [Note] Shutting down plugin 'INNODB_CMP'
    mysql_1           | 2023-02-01T23:32:34.949339Z 0 [Note] Shutting down plugin 'INNODB_LOCK_WAITS'
    mysql_1           | 2023-02-01T23:32:34.949341Z 0 [Note] Shutting down plugin 'INNODB_LOCKS'
    mysql_1           | 2023-02-01T23:32:34.949343Z 0 [Note] Shutting down plugin 'INNODB_TRX'
    mysql_1           | 2023-02-01T23:32:34.949345Z 0 [Note] Shutting down plugin 'InnoDB'
    mysql_1           | 2023-02-01T23:32:34.949380Z 0 [Note] InnoDB: FTS optimize thread exiting.
    mysql_1           | 2023-02-01T23:32:34.949426Z 0 [Note] InnoDB: Starting shutdown...
    mysql_1           | 2023-02-01T23:32:35.049565Z 0 [Note] InnoDB: Dumping buffer pool(s) to /var/lib/mysql/ib_buffer_pool
    mysql_1           | 2023-02-01T23:32:35.049805Z 0 [Note] InnoDB: Buffer pool(s) dump completed at 230201 23:32:35
    mysql_1           | 2023-02-01T23:32:36.256663Z 0 [Note] InnoDB: Shutdown completed; log sequence number 12184404
    mysql_1           | 2023-02-01T23:32:36.257825Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
    mysql_1           | 2023-02-01T23:32:36.257834Z 0 [Note] Shutting down plugin 'MEMORY'
    mysql_1           | 2023-02-01T23:32:36.257838Z 0 [Note] Shutting down plugin 'CSV'
    mysql_1           | 2023-02-01T23:32:36.257842Z 0 [Note] Shutting down plugin 'sha256_password'
    mysql_1           | 2023-02-01T23:32:36.257844Z 0 [Note] Shutting down plugin 'mysql_native_password'
    mysql_1           | 2023-02-01T23:32:36.257958Z 0 [Note] Shutting down plugin 'binlog'
    mysql_1           | 2023-02-01T23:32:36.259512Z 0 [Note] mysqld: Shutdown complete
    mysql_1           | 
    mysql_1           | 2023-02-01 23:32:36+00:00 [Note] [Entrypoint]: Temporary server stopped
    mysql_1           | 
    mysql_1           | 2023-02-01 23:32:36+00:00 [Note] [Entrypoint]: MySQL init process done. Ready for start up.
    mysql_1           | 
    mysql_1           | 2023-02-01T23:32:37.113317Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
    mysql_1           | 2023-02-01T23:32:37.114085Z 0 [Note] mysqld (mysqld 5.7.41) starting as process 1 ...
    mysql_1           | 2023-02-01T23:32:37.115903Z 0 [Note] InnoDB: PUNCH HOLE support available
    mysql_1           | 2023-02-01T23:32:37.115916Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
    mysql_1           | 2023-02-01T23:32:37.115919Z 0 [Note] InnoDB: Uses event mutexes
    mysql_1           | 2023-02-01T23:32:37.115922Z 0 [Note] InnoDB: GCC builtin __atomic_thread_fence() is used for memory barrier
    mysql_1           | 2023-02-01T23:32:37.115923Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.12
    mysql_1           | 2023-02-01T23:32:37.115926Z 0 [Note] InnoDB: Using Linux native AIO
    mysql_1           | 2023-02-01T23:32:37.116075Z 0 [Note] InnoDB: Number of pools: 1
    mysql_1           | 2023-02-01T23:32:37.116140Z 0 [Note] InnoDB: Using CPU crc32 instructions
    mysql_1           | 2023-02-01T23:32:37.117182Z 0 [Note] InnoDB: Initializing buffer pool, total size = 128M, instances = 1, chunk size = 128M
    mysql_1           | 2023-02-01T23:32:37.120954Z 0 [Note] InnoDB: Completed initialization of buffer pool
    mysql_1           | 2023-02-01T23:32:37.122014Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
    mysql_1           | 2023-02-01T23:32:37.133457Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
    mysql_1           | 2023-02-01T23:32:37.147693Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
    mysql_1           | 2023-02-01T23:32:37.147721Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
    mysql_1           | 2023-02-01T23:32:37.160621Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
    mysql_1           | 2023-02-01T23:32:37.161175Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
    mysql_1           | 2023-02-01T23:32:37.161180Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
    mysql_1           | 2023-02-01T23:32:37.161459Z 0 [Note] InnoDB: Waiting for purge to start
    mysql_1           | 2023-02-01T23:32:37.211868Z 0 [Note] InnoDB: 5.7.41 started; log sequence number 12184404
    mysql_1           | 2023-02-01T23:32:37.212372Z 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
    mysql_1           | 2023-02-01T23:32:37.212549Z 0 [Note] Plugin 'FEDERATED' is disabled.
    mysql_1           | 2023-02-01T23:32:37.214470Z 0 [Note] InnoDB: Buffer pool(s) load completed at 230201 23:32:37
    mysql_1           | 2023-02-01T23:32:37.215552Z 0 [Note] Found ca.pem, server-cert.pem and server-key.pem in data directory. Trying to enable SSL support using them.
    mysql_1           | 2023-02-01T23:32:37.215558Z 0 [Note] Skipping generation of SSL certificates as certificate files are present in data directory.
    mysql_1           | 2023-02-01T23:32:37.215569Z 0 [Warning] A deprecated TLS version TLSv1 is enabled. Please use TLSv1.2 or higher.
    mysql_1           | 2023-02-01T23:32:37.215572Z 0 [Warning] A deprecated TLS version TLSv1.1 is enabled. Please use TLSv1.2 or higher.
    mysql_1           | 2023-02-01T23:32:37.215912Z 0 [Warning] CA certificate ca.pem is self signed.
    mysql_1           | 2023-02-01T23:32:37.215931Z 0 [Note] Skipping generation of RSA key pair as key files are present in data directory.
    mysql_1           | 2023-02-01T23:32:37.216087Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
    mysql_1           | 2023-02-01T23:32:37.216110Z 0 [Note] IPv6 is available.
    mysql_1           | 2023-02-01T23:32:37.216117Z 0 [Note]   - '::' resolves to '::';
    mysql_1           | 2023-02-01T23:32:37.216127Z 0 [Note] Server socket created on IP: '::'.
    mysql_1           | 2023-02-01T23:32:37.217139Z 0 [Warning] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
    mysql_1           | 2023-02-01T23:32:37.221483Z 0 [Note] Event Scheduler: Loaded 0 events
    mysql_1           | 2023-02-01T23:32:37.221652Z 0 [Note] mysqld: ready for connections.
    mysql_1           | Version: '5.7.41'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)
    redmine_1         | Your Gemfile lists the gem puma (< 6.0.0) more than once.
    redmine_1         | You should probably keep only one of them.
    redmine_1         | Remove any duplicate entries and specify the gem only once.
    redmine_1         | While it's not a problem now, it could cause errors if you change the version of one of them later.
    redmine_1         | The Gemfile's dependencies are satisfied
    redmine_1         | => Booting Puma
    redmine_1         | => Rails 6.1.7 application starting in production 
    redmine_1         | => Run `bin/rails server --help` for more startup options
    redmine_1         | W, [2023-02-01T23:32:42.522656 #1]  WARN -- : Creating scope :system. Overwriting existing method Enumeration.system.
    redmine_1         | W, [2023-02-01T23:32:42.617047 #1]  WARN -- : Creating scope :sorted. Overwriting existing method User.sorted.
    redmine_1         | W, [2023-02-01T23:32:42.728019 #1]  WARN -- : Creating scope :sorted. Overwriting existing method Group.sorted.
    redmine_1         | Puma starting in single mode...
    redmine_1         | * Puma version: 5.6.5 (ruby 3.1.3-p185) ("Birdie's Version")
    redmine_1         | *  Min threads: 0
    redmine_1         | *  Max threads: 5
    redmine_1         | *  Environment: production
    redmine_1         | *          PID: 1
    redmine_1         | * Listening on http://0.0.0.0:3000
    redmine_1         | Use Ctrl-C to stop
    ^Z
    [1]+  Stopped                 docker-compose up --build
    [?2004h[alex@bobox redmine.docker-compose]$ bg
    [?2004l
    [1]+ docker-compose up --build &
    [?2004h[alex@bobox redmine.docker-compose]$ crul url http://0.0.0.0:3001 | head
    [?2004l
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    
      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0redmine_1         | I, [2023-02-01T23:33:40.777936 #1]  INFO -- : Started GET "/" for 192.168.208.1 at 2023-02-01 23:33:40 +0000
    redmine_1         | I, [2023-02-01T23:33:40.779396 #1]  INFO -- : Processing by WelcomeController#index as */*
    redmine_1         | I, [2023-02-01T23:33:40.814261 #1]  INFO -- :   Current user: anonymous
    redmine_1         | I, [2023-02-01T23:33:40.857759 #1]  INFO -- :   Rendered welcome/index.html.erb within layouts/base (Duration: 3.4ms | Allocations: 4328)
    redmine_1         | I, [2023-02-01T23:33:40.869286 #1]  INFO -- :   Rendered layout layouts/base.html.erb (Duration: 15.8ms | Allocations: 14050)
    redmine_1         | I, [2023-02-01T23:33:40.869564 #1]  INFO -- : Completed 200 OK in 90ms (Views: 15.1ms | ActiveRecord: 8.1ms | Allocations: 89060)
    
    100  4922  100  4922    0     <!DOCTYPE html>
    0<html lang="en">
     <head>
     <meta charset="utf-8" />
    4<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    8<title>Redmine</title>
    4<meta name="viewport" content="width=device-width, initial-scale=1">
    9<meta name="description" content="Redmine" />
    4<meta name="keywords" content="issue,bug,tracker" />
     <meta name="csrf-param" content="authenticity_token" />
         0 --:--:-- --:--:-- --:--:-- 48254
    100  4922  100  4922    0     0  48469      0 --:--:-- --:--:-- --:--:-- 48254
    curl: (23) Failed writing body
    [?2004h[alex@bobox redmine.docker-compose]$ curl http://0.0.0.0:3001 | headgheadrheadeheadphead headrheadeheaddheadmheadiheadnhead head Mhead
    
    Mehead M
    
    [?2004l
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    
      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0redmine_1         | I, [2023-02-01T23:33:50.300546 #1]  INFO -- : Started GET "/" for 192.168.208.1 at 2023-02-01 23:33:50 +0000
    redmine_1         | I, [2023-02-01T23:33:50.301391 #1]  INFO -- : Processing by WelcomeController#index as */*
    redmine_1         | I, [2023-02-01T23:33:50.303334 #1]  INFO -- :   Current user: anonymous
    redmine_1         | I, [2023-02-01T23:33:50.307019 #1]  INFO -- :   Rendered welcome/index.html.erb within layouts/base (Duration: 0.4ms | Allocations: 356)
    redmine_1         | I, [2023-02-01T23:33:50.310784 #1]  INFO -- :   Rendered layout layouts/base.html.erb (Duration: 4.2ms | Allocations: 4009)
    redmine_1         | I, [2023-02-01T23:33:50.310920 #1]  INFO -- : Completed 200 OK in 9ms (Views: 4.4ms | ActiveRecord: 1.7ms | Allocations: 5937)
    
    100  4922  100  4922    0     0   392k      0 --:--:-- --:--:-- --:--:--  400k
    [?2004h[alex@bobox redmine.docker-compose]$ exi
    Stopping redminedocker-compose_redmine_1        ... 
    Stopping redminedocker-compose_mysql_1          ... done
    [?2004h[alex@bobox redmine.docker-compose]$ exit
    [?2004l
    exit
    

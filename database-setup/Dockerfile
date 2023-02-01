From alpine
RUN apk update
RUN apk add mariadb-client
RUN echo hallo
COPY db.sql.gz /
COPY entrypoint.sh /
RUN apk add vim
CMD cat /entrypoint.sh; sh /entrypoint.sh 

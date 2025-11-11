FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=appdb
ENV MYSQL_USER=appuser
ENV MYSQL_PASSWORD=apppass

#should be placed in the loc " /docker-entrypoint-initdb.d/" for startup script automatically run
COPY init-db.sql /docker-entrypoint-initdb.d/

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

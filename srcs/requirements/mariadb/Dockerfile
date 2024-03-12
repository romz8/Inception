FROM	debian:bullseye

RUN		apt update && apt upgrade -y

RUN 	apt install mariadb-server -y

COPY 	conf/50-server.cnf etc/mysql/mariadb.conf.d/50-server.cnf

COPY	tools/mariadb_conf_script.sh /tmp/container_maria_setup.sh

RUN 	chmod 755  /tmp/container_maria_setup.sh

RUN		mkdir -p /var/run/mysqld

RUN		chown -R mysql:mysql /var/run/mysqld \
		&& chmod 777 /var/run/mysqld

EXPOSE	3306

ENTRYPOINT	[ "bash", "/tmp/container_maria_setup.sh" ]

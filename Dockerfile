FROM ubuntu

RUN apt-get -y update 
RUN apt-get -y install wget
RUN apt-get install -y gnupg2
RUN apt-get -y install openjdk-8-jre
RUN apt-get -y install tmux

# nano

RUN apt-get install nano

# Postgres

#RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
ARG DEBIAN_FRONTEND=noninteractive

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get -y update
RUN apt-get -y install postgresql
RUN apt-get -y install postgresql-contrib
RUN sed -i 's/peer/trust/g'  /etc/postgresql/12/main/pg_hba.conf

# Python
RUN apt-get -y install python3
RUN apt-get -y install python3-pip

# DBT
RUN pip3 install dbt

# Kafka
RUN wget https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz
RUN gzip -d kafka_2.13-3.0.0.tgz
RUN tar -xf kafka_2.13-3.0.0.tar

# Clickhouse

RUN apt-get -y install apt-transport-https ca-certificates dirmngr
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4
RUN echo "deb https://repo.clickhouse.com/deb/stable/ main/" | tee /etc/apt/sources.list.d/clickhouse.list
RUN apt-get -y update
RUN apt-get -y install -y clickhouse-server clickhouse-client
RUN service  clickhouse-server start
RUN chown root /var/lib/clickhouse

#RUN    /etc/init.d/postgresql start &&\
#    psql --user postgres --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
#    createdb -O docker docker

# Snowflake

RUN apt-get -y install curl
RUN curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.20-linux_x86_64.bash
RUN chmod ugo+x ./snowsql-1.2.20-linux_x86_64.bash
#RUN ./snowsql-linux_x86_64.bash

CMD bash


FROM opencpu/ubuntu-18.04
LABEL maintainer "Gustavo Muniz do Carmo <gmunizcarmo@aubay.com>"

ENV MYSQL_CONNECTOR mysql-connector-odbc-8.0.15-linux-ubuntu18.04-x86-64bit

RUN apt-get install -y unixodbc unixodbc-dev odbcinst \
 && wget -c https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/$MYSQL_CONNECTOR.tar.gz -O - | tar -xvzC /tmp \
 && cp /tmp/$MYSQL_CONNECTOR/bin/* /usr/local/bin \
 && cp /tmp/$MYSQL_CONNECTOR/lib/* /usr/local/lib \
 && rm -rf /tmp/$MYSQL_CONNECTOR \
 && myodbc-installer -a -d -n "MySQL ODBC 8.0 Driver" -t "Driver=/usr/local/lib/libmyodbc8w.so" \
 && Rscript -e 'install.packages("RODBC")'

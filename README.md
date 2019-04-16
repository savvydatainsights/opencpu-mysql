# opencpu-mysql

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Docker Build status](https://img.shields.io/docker/cloud/build/savvydatainsights/opencpu-mysql.svg)](https://hub.docker.com/r/savvydatainsights/opencpu-mysql/builds) [![Docker Pulls](https://img.shields.io/docker/pulls/savvydatainsights/opencpu-mysql.svg)](https://hub.docker.com/r/savvydatainsights/opencpu-mysql)

Custom OpenCPU Docker image prepared for connecting to a MySQL database instance.

## Build command

`docker build -t savvydatainsights/opencpu-mysql .`

## Requirements

[Bind mount](https://docs.docker.com/storage/bind-mounts) an [odbc.ini](odbc.ini) like the example:

```ini
[DSN]
Description=MySQL database
Driver=MySQL ODBC 8.0 Driver
SERVER=mysql
PORT=3306
DATABASE=data_analysis
UID=root
PWD=root
```

The **Driver** key must have the value **MySQL ODBC 8.0 Driver**, the name defined during the MySQL connection driver installation.

The other values must be set according to the connection parameters of your MySQL instance.

## Test

Run a MySQL Docker image:

`docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=data_analysis -p 3306:3306 -d mysql:8.0.15`

Run the custom OpenCPU Docker image:

`docker run --name opencpu --link mysql:mysql -v $(pwd)/odbc.ini:/etc/odbc.ini -p 8004:8004 -d savvydatainsights/opencpu-mysql`

Enter into the OpenCPU container:

`docker exec -it opencpu bash`

Execute the command (if your odbc.ini section is other than DSN, replace it accordingly):

`isql -v DSN`

The output must be something like:

```
+---------------------------------------+
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+---------------------------------------+
SQL>
```

## Compose

An alternative to run each Docker image separatedly is executing:

`docker-compose up -d`

If the Docker image doesn't exist locally, it will be built automatically. If you prefer to download it from [Docker Hub](https://hub.docker.com/r/savvydatainsights/opencpu-mysql), run before:

`docker pull savvydatainsights/opencpu-mysql`

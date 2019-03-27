#!/bin/sh
getPort() {
    echo $1 | cut -d : -f 3 | xargs basename
}

echo "********************************************************"
echo "Waiting for the database server to start on port $DATABASESERVER_PORT"
echo "********************************************************"
while ! `nc -z mongodb $DATABASESERVER_PORT`; do sleep 3; done
echo "******** Database Server has started "

echo "********************************************************"
echo "Waiting for the configuration server to start on port $CONFIGSERVER_PORT"
echo "********************************************************"
while ! `nc -z configserver $CONFIGSERVER_PORT`; do sleep 3; done
echo "*******  Configuration Server has started"


echo "********************************************************"
echo "Starting the Eureka Server"
echo "********************************************************"
java  -Dspring.profiles.active=$PROFILE -Dspring.cloud.config.uri=$CONFIGSERVER_URI -Djava.security.egd=file:/dev/./urandom -jar /usr/local/eurekaservice/@project.build.finalName@.jar